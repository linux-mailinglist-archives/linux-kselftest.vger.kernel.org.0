Return-Path: <linux-kselftest+bounces-42633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B943BACFF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799D2176E4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41E2FC895;
	Tue, 30 Sep 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcDZcM0L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AB2F5301
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238212; cv=none; b=kPkcn5LDJOEBbsQ2m4BN28FxaBNeqQQnoOkTTSzpDPcXWJHoJgIm/btrXGj3ZstWyB1ZlrlHDvQ8aja5eQWOXV0ziILX/EUCGmQh4lTOQzUc2IE08Y+a9RSK+AA7+zKF84WwYdwXKLU7Gk1G4SnPxc16ioF9oJ0AMHbzKDNxcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238212; c=relaxed/simple;
	bh=JQdYQFztlTixlakaP0CYLnqIVCCuwGWr20KPxAr+N/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igx7JznTCx0m10Gms2p1eYlSDXQtNU3Spte6aPxqJShoneAj7uqfZD/nf5LbwRNdubu060Ub3k+qInFF+9rl3AjHPZoqPUBRJOqbFxLTeiJM3bZcLYJ96kMVrDK5NeH5auqILdYFssAJHRImOvNgw+wtKN1j7QJU9EtL3vFmZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcDZcM0L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759238209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQoDjKHqpRXNqsixILAYa6PmTwHHRUnWjoBb2MDJWeA=;
	b=KcDZcM0L+kQIuUDEjXtE0M/c5gvLv3kbdmYHmYBODCVIckrKlNsw10MwyzOu6viWVDLQsD
	YehUjsTbK/OFpUT//AzdVXaafBy8WhjAGWKCvi8pLjTdHPtZ/Ci33EPfv0iwIGgmjC9y1y
	uvzvlQB2MgNUZm+JCgmgiB3PYyKoq0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-pQ5qhXPTOECpyHojWwHvUw-1; Tue, 30 Sep 2025 09:16:47 -0400
X-MC-Unique: pQ5qhXPTOECpyHojWwHvUw-1
X-Mimecast-MFC-AGG-ID: pQ5qhXPTOECpyHojWwHvUw_1759238206
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e39567579so29284795e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 06:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238206; x=1759843006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQoDjKHqpRXNqsixILAYa6PmTwHHRUnWjoBb2MDJWeA=;
        b=U4mIkKEXAxoJkIyujLyicYsSOHBUZbBgeSKyuhJUUz+bcFvrrAQH7XOo4vZUNjFhZ+
         2o1DqZVwb/DYq8my7+qQvy8fyU2u3WeOO+UHX3aG5ujlHulHpKt8h4AYgtRHeEYTCc8Q
         BgsTUlVHUbQuP8SmkWqLjx+wZdZIRSTYIk1gILK8/E9BQnDaPsLWUvHsEDVs/dHUKxxs
         gN9NqSHmF/JFJCUhDRbS05czaIHD7YLKJyxSzcspdHlSSkNA1i7ztN0dWnGCCX43yzw7
         itnnXVZUnl3I0yrHk8uT/R1c9/GBjOGncP2gD1Z1EOtwqZXrPtSAMGGHcpmFR2h5EMFK
         0jHw==
X-Forwarded-Encrypted: i=1; AJvYcCXDPcnQFdRBdH4awUJrVutkD+z5ojIEN0hszVHZXQbgw4l6ET8BYexldSheshkzQ0ufxb9AiNzHwjXI6f/uGUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyL7TMs+l7qXsNcTHNlvCMzUHwb8QsWFdO8nrROApN7mpUYGMY
	RoZGQdTXzRQtfJOTr6K+6z1eU8GGdA85VPBD7gAjdLpE46jZ8yyUXJvgL7A3E+FsjWwakP/CI1Y
	Q8M5CUbDbsgFs3yJZF+LkogDcectYCAcg2VjvmqIr817RMfuJEabjjX3c7Iadl0bFthwiXQ==
X-Gm-Gg: ASbGnctvsNdzebNHDzFnH5Vm/FzqSdnj1NrsoeNMZ10eTOJwvNmdx2ey/yoIt+xmN0f
	Hj8g75KZvj76jHRIk8DxEp2hYYZg3qwh7DCv40ktfVOKI1W//sTVykSHouvGlKIJSmspop4JQmi
	MtFGWNmcIld4GYmK+tvk21dFnndBvj4w0UIj+vyM3Fh9hvs2JCm+ZeJg0oLOVwBulBLld6eVWD4
	7mBtwQLXwxKEkgJZLKEnm8RrUkNe3erBa/joZD9qmgy8fTAxJrBFjWh34KB8Dj1M+ABQMk98GlF
	ei5hr7b95gJrXGUse2fq7Vo/7teKZbsuNCPtXBIFe/Lb3pENkgNtdZgcprYje6utCPNj6CEat5t
	C5zu2z1RN9V4bIMvTNQ==
X-Received: by 2002:a05:600c:1d12:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46e4246ca96mr135448865e9.11.1759238205797;
        Tue, 30 Sep 2025 06:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu4P6oMDuFdG/0zr30Eb3WqTPE7tzXx6ivKJ9I6+IyFkjRGoowgd2u3GDdgMwD3iM2gvpqRA==
X-Received: by 2002:a05:600c:1d12:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46e4246ca96mr135448615e9.11.1759238205387;
        Tue, 30 Sep 2025 06:16:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c1d8f36sm13788155e9.2.2025.09.30.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:16:44 -0700 (PDT)
Message-ID: <9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com>
Date: Tue, 30 Sep 2025 15:16:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/8] selftests: drv-net: base device access
 API test
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, willemb@google.com, shuah@kernel.org,
 daniel.zahka@gmail.com, linux-kselftest@vger.kernel.org
References: <20250927225420.1443468-1-kuba@kernel.org>
 <20250927225420.1443468-3-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927225420.1443468-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/25 12:54 AM, Jakub Kicinski wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> index 1462a339a74b..559c572e296a 100644
> --- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> @@ -13,7 +13,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
>  
>      # Import one by one to avoid pylint false positives
>      from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
> -        NlError, RtnlFamily, DevlinkFamily
> +        NlError, RtnlFamily, DevlinkFamily, PSPFamily

Side question:
There is a consistent false positive ruff check about this kind of
change (with the added import being labeled as unused even in a __init__
file.

I'm wondering if is possible to explicitly disable such warnings?

/P


