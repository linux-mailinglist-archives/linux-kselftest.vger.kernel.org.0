Return-Path: <linux-kselftest+bounces-5159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1885D797
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE481F22CD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B284D10A;
	Wed, 21 Feb 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goPm5zzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D638482DD
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517013; cv=none; b=AfUVDZLTpPCtArcDuXGTay04iKHxlqIoPTobu/3G5ZnHRL4+UIV7F7/H/lkmZ++FEOt+BPASfvCZzu5Wf6T6cVkVjZM+lB9dGj+snGlI7CzHCg7X2yNpFStSokTIvLXjfaWSpk7UTLhPTOANoR989dviiQWiOVfavjgeCdJiyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517013; c=relaxed/simple;
	bh=9QYzwrc0486wKCVBNA9kzltE6OKvRCjNeixUMKzjdCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FR2jsTzrvmy0tN1HLFMfAzYMhxDnGt+aDq89BHuq/+TPa+095Z4vyncttAiiLkwSICDmp1lr5k7OEB1mkyFgOjiroAZWIjDbJh8TEkrhIl4xmbeGVU/tCNAyMYdr7RKoZpEUPHDOfl8PRj3QIv/ipYLZsy+2kcqTkgpKBBIwQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goPm5zzH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708517011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Geb+XZVHvAWeEiO9S27iDrccBjAUX9P3SeMqmrHMMI=;
	b=goPm5zzHPEm72lll+rGwaxT2msoBaP3hCxklR4MXpsZiQ090JUjQykvQ4OqxYwTaXlRLcY
	Cv0iD+3Z8JvxQclwKPRX8msE6zwQjvsqpybs7VQjxRHaQilmkR42lm53/9C5coqdULMNA+
	uW6ugsSmKxvxpRrPoUxDS9qIuIZBG6k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-weos8jp7PKSxgiYghFzqpw-1; Wed, 21 Feb 2024 07:03:30 -0500
X-MC-Unique: weos8jp7PKSxgiYghFzqpw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d3757a367so224723f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 04:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708517008; x=1709121808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Geb+XZVHvAWeEiO9S27iDrccBjAUX9P3SeMqmrHMMI=;
        b=u/YsOSvXLLeC1YFL6xOC9h25DvK5s7OK9qUcE72I9LSNQyx6knEHne2QTh1KfnUvf5
         2JSdgJPilVJCrzqgRzcr6w/FoVCLaSTdiwFJWS42qigjlQg6I2/FT5WUjssqXCDSxQMT
         fkzhDXlNdgQIUc49ks4Q1MikJS0kYd8/HVWHPGIiHMybjj6jndL0oKzGu/aKDyYstKia
         G7mgcjAPW1qRtcA2IrE/cVErmZZzBPNU8PRMDxr0tmEzXPzP34XqpQEyCpjn2KK0VQu3
         k8i4TSJBGEou4Q6EMJZKpwO0sP70SC9o53ZMsptbJWBINNmmGa0hAAakvL7Je2XzBlH5
         kGdg==
X-Forwarded-Encrypted: i=1; AJvYcCXTOVijzmju9eEVbGZcP/Fs2hLWBwXZdqQhA5/3RTalMoS3UdMu5sVs2wio+IZ9yCh9Q4lT0S8sZ7Zsz68kioldiBw/0ONhe0Un2BwW06Vt
X-Gm-Message-State: AOJu0YwZJlMmyYq5RgZH98DtckLlGFuAPIuM6NNrZUb+g4qb1LQEPL2j
	DSS/bC0Cp01CFzh2nXSmURw2MEkesdrWYmoZgHtHUpGJAshV9r4MhdZuG7YyfLbrr3vUu3jhaBW
	8aDqJIU8fcgAKC0Dd+PcoJPS5EyNTLA3ffR4iPYkAR3jYplQ9fKjhaXRvK9WP3oVGAA==
X-Received: by 2002:a05:6000:1f09:b0:33b:88a0:a1e9 with SMTP id bv9-20020a0560001f0900b0033b88a0a1e9mr9700674wrb.4.1708517008690;
        Wed, 21 Feb 2024 04:03:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8tshSUyaeTgOwlMVlca+hvTKde6ukfXZH9kkw9Irbg8Wjb4ct5W4RFE1ffJtfMmIcgUQZag==
X-Received: by 2002:a05:6000:1f09:b0:33b:88a0:a1e9 with SMTP id bv9-20020a0560001f0900b0033b88a0a1e9mr9700635wrb.4.1708517008312;
        Wed, 21 Feb 2024 04:03:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-226.dyn.eolo.it. [146.241.230.226])
        by smtp.gmail.com with ESMTPSA id ck10-20020a5d5e8a000000b0033d4deb2356sm10572869wrb.56.2024.02.21.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:03:27 -0800 (PST)
Message-ID: <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
From: Paolo Abeni <pabeni@redhat.com>
To: shuah@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, mic@digikod.net, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	jakub@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Date: Wed, 21 Feb 2024 13:03:26 +0100
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 11:22 -0800, Jakub Kicinski wrote:
> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip.
>=20
> Clean up and support the use of the full range of ksft exit codes
> under kselftest_harness.
>=20
> Merge plan is to put it on top of -rc4 and merge into net-next.
> That way others should be able to pull the patches without
> any networking changes.
>=20
> v2: https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/
>  - fix alignment
> follow up RFC: https://lore.kernel.org/all/20240216004122.2004689-1-kuba@=
kernel.org/
> v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/

@Shuah: it's not clear to me if you prefer to take this series via the
kselftests tree or we can take it via the net-next tree. Could you
please advise?

thanks!

Paolo

p.s. if this was already clarified in the past, I'm sorry: I lost track
of it.


