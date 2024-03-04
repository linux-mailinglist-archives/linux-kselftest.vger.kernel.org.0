Return-Path: <linux-kselftest+bounces-5842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B0870833
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F7C1C21108
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBF60276;
	Mon,  4 Mar 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVO9AwN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58B6026A
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572995; cv=none; b=KF9j067VQ1/e36kZiTTj0E6iZHRv7FPXW+wfWat85RDtsv7N7hShnde6+Vt6M7+WuP9xTHPexyfyRD8+plZKDTdxJkI+9LTGM5+KCfGidnLiA43ZSQfCj30Rp4r5svFoUV/z61UmDX0ogyag4sYWh3E82FGzokPocf5zgvdjvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572995; c=relaxed/simple;
	bh=2AXGixQ7Gc8HjdKyBY3Whs9KBXsRK1tfn6h6cRM619Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlgSlA4UzQQq1OhVlqblWtzC26hPc16HfyKfrqNKN9Uh14dxQWpmg4jjnJnWj+WrOZu1oDPc/eeeRoK46vwjgJXuNPNRcdj+1tg7LzlBlbPsbc5HVqU6LIrsSNjin7Hp/we5EvLePpWH7ziTMb+Z7KjTbdPj04hp3VhbEXeNE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVO9AwN1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcd07252d9so431205ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709572993; x=1710177793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AXGixQ7Gc8HjdKyBY3Whs9KBXsRK1tfn6h6cRM619Y=;
        b=kVO9AwN1XqBKB6TtW+wnexVeMilsO598kfJ2GZlwYrhhVREP6ovuGlyPm/6bOfAv4j
         +HEjj31gHdvX2npn7St/3KMhmWpWt0YKJF0PbX7V+WBDdEW3/31FlgkYKLOCS5vIXeDh
         bGXIik1bISsahBvUH5oUcJkHXvnZDT7PrUVDh4cPotLEr0iwjstCfu9xo+Hfd18ihrG5
         W3yYCq+T8tPPUElF937uZI/itK2VTtDySU1+3/hbZBeCV+ZMebl0erlfz9Qy8eK4ScLn
         gBpuzE/wqgbUPgfZPBlR0Um7TImuOFsK+npW7NIJRHq9DP3OjlDrE8GHSVOaw8nd1A8l
         FVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572993; x=1710177793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AXGixQ7Gc8HjdKyBY3Whs9KBXsRK1tfn6h6cRM619Y=;
        b=EnXhUFNZJoQraE3RW94wNqy/O1LqfaUVSuAQ1S1JjIJptJgDh/pUMJSf7V2PZ8Vi2R
         617CTxZe5yzUCJhYCYtzD/pQWgpdsp1APHu4Yubwpbb+gC7do7ef01JbE9FlgyNqAYuK
         fHwk2CClCQE2TrwwOSsh3Dz49tEKngHvxjAYLIw2xRt+h/zl3ZaHIv15JpOvVWKaLVCo
         oxpiotjPznwlmfbD7bnOwKcD9ucW9eOY84PppJQ+IH17pFYbUuP6MVN023quMDIDCU9U
         J4ORJ5h8DkThZrYau36EO+yiNCt5CL95nEHZ/CDx5aEx1aF1yojw59ctdwUfqyt7oag2
         LAUg==
X-Forwarded-Encrypted: i=1; AJvYcCVeU7N7ZCvB6dvdFp53c85oAAwZ09IJrhiZZmhFN37QyJjF4aXeZbHm2ZWzYH0x2cp2zbLRA6eW7N1ZCWYabWUr0rxGnwqcpbeTExj7yOYa
X-Gm-Message-State: AOJu0YwTg9Vw/gyV9WOjJN3AJBo08WrrIAtTObgehL+ZGB9y4N2AUuFs
	30OmKtTzJAPDoiJ4QRM2EDvPkrqelSH1wjR9/7+b4rc050vkcNWeLZSw5WLselWIRWtQXjZ/l7u
	suJOQTYm6WCxXZKOT7imS+gc6va/QyYcsoFwS
X-Google-Smtp-Source: AGHT+IFKjskUOj6278amt+2i/iRaGbWnqwH8V8ARQXyWAa4I5jxF0hWUUBHSTDwJLrfzllQF5r4CeHTssO8S/qZNiYE=
X-Received: by 2002:a17:902:ecc5:b0:1dd:7db:69d0 with SMTP id
 a5-20020a170902ecc500b001dd07db69d0mr266118plh.11.1709572993014; Mon, 04 Mar
 2024 09:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <20240304-rigorous-silkworm-of-awe-4eee8f@houat> <CABXOdTc4MXcjwgGuJb4_69-4OFELD37x0B6oMr=4z=nxZ2HPXQ@mail.gmail.com>
 <20240304-ludicrous-grinning-goldfish-090aac@houat> <CABXOdTeDydWO9mf2yxWjjebHZ1bE=R2HPs1P4XYwNhzznNKxmw@mail.gmail.com>
 <20240304-benevolent-brawny-urchin-0af0ad@houat>
In-Reply-To: <20240304-benevolent-brawny-urchin-0af0ad@houat>
From: Guenter Roeck <groeck@google.com>
Date: Mon, 4 Mar 2024 09:22:59 -0800
Message-ID: <CABXOdTeza3ZJRO7eexp8evm8o1B81fw9cDQbE_nHwqhufMCfGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Maxime Ripard <mripard@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Nikolai Kondrashov <spbnick@gmail.com>, 
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:09=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:

> And singling out DRM because it regularly allegedly breaks things on
> xtensa or m68k and claiming we're not taking CI seriously because of it
> is completely ridiculous. If the all the subsystems were taking CI as
> seriously as DRM, we would be in a much better place.
>

The failure I reported as an example was on arm, not on xtensa or m68k
I'll disable CONFIG_DRM in my build tests for xtensa and m68k going
forward.

Thanks,
Guenter

