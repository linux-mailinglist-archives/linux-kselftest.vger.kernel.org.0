Return-Path: <linux-kselftest+bounces-16473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0698B9619E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 00:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9921C215AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022319754D;
	Tue, 27 Aug 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuFxoG8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CF3C08A;
	Tue, 27 Aug 2024 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796661; cv=none; b=iv9hQvIRmS1QwMpu+keAzaTZrPe9zIyEc6BwkYPxdhdCbJDRo/LBrmittJgxM1uE8rbxtKEw6r/GAvCnfr70rt6bwXnUsO28gMk4ltb1dsVpSD7Gvvhz1GRTL0TL+SxN6H1pUU8Rvdg6Cr4z3BawtJE6WvjBGVLyScQsyOq5ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796661; c=relaxed/simple;
	bh=aroLOKavUDzCVXxEGawFTqCx+03oSt09BdxWXcN7COY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIjf39T76G6LRQea5w75XzGrwOmuOx77HM10+cK6U7pjoV0QI95lANfW6UCiVlS3K678u8xQyOpBTuCZsP1PUXwXUHssI9JdlGthcqlECM/nzrYYDhlkhc4qDxXuA10BA51E/lDfocV1ZZU5iy7lKUuQrce0CbvtVNoY097lRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuFxoG8U; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso4282605a12.0;
        Tue, 27 Aug 2024 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724796659; x=1725401459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rewCyEf31R6WgjDbqaQ0TyTu1C/1OpbUO9G91fI9oWg=;
        b=AuFxoG8UeZGa4xfBG5uw1BllURaXteA6OQ4E9G4UNFtLuIZWpaW9/g2UCOKIMehAfL
         jwwZ7vbPmCC/8A/Jhf1qf1ta4Bppfju95dtqPwb4LMdLUAlvx0SKdT+flPxHmDqPRYIo
         +1YquwyaGPHvronftt9L3GcJiGmqbVm+4Kz+mWh4XEHoEUWhZiEl2l7JLDkHtkd/dLd9
         hnY0bFAZaXbdZi+ez+JoVVqbwlsxaA9gOU2ko9W5DWHbh6EjuWWWfzbGKLgWq0ov05RY
         1ikSrNYyC/NDZGeU2z9bcOZCSJjhvn8LmmMAorXaxDXTALlVsAf440lhCw74kEpxTJyF
         GVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724796659; x=1725401459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rewCyEf31R6WgjDbqaQ0TyTu1C/1OpbUO9G91fI9oWg=;
        b=ocOHdfVNICM7xE+JD7D7KnA4UIYbocDqKNJdb9oMxwO7/FPfDf/47+bnp35VEuzXPX
         OE4HbfyjbJ1Q5EPk35iowQercTI6SkxO5VvRIYY7GaeB9oyEtOEqs/OPY5cZC2C9Wo0m
         yxOPuFMLI9Xe6aj8m/E1bSPQ4gsbVIaU/5D3yVPeOSgsGEvVeB4q2azCLVB+ohzNI5zk
         BbcdoN2OckwDQFBNtFkmguR4JVbwn3RoxkssEjLRa0WgMXagvFeLKPq+cXf4wFeIcCmP
         Kuoze2FYKpkrq3T3X/QhyaRN46iC9lEdh6JTXfpJhVIZTESPxMOjoUJRcRv+CKC/Ikp4
         Hd7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFOMn4sycTV6Ba1QU4l7cP29uRol4uBVHK+hOLG+Ci16TVnCWowDSekayGi9nW+wgfjYjyl77P@vger.kernel.org, AJvYcCUwtCbeBveUO9zABnS9BsFdMG4RGXiYb+wIrbY9b/W2UceqENUqKSDRQ6BQWsmCnKVUjISC2NfGnCp8GaI=@vger.kernel.org, AJvYcCW+HZ+ugNKxDf3youufemLMPljzjJyFkc9o2XHzwuimd321JYZl7KCAnzjVRORzyQYfR6yFdDZXewpkZj5daLhu@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyBFqf09DjX5UW7gAcowGzrwIlHSvrfpcQLZZguXM0kO66cpK
	G467KtLVBgKHtlTNoFYFhmoFTWPvgPrlu05JV9E6Rd/yzph5euhIKn94ZKvUyGXwcp97IhQGbnV
	5uw4mpFKkyn8eGQBsDYEyLwCWH28=
X-Google-Smtp-Source: AGHT+IFkuMfe05C9X591qKCWKdS/cLeqqd3rIrpxHnchFEEKD6L+NP13/R/yGUSEhRdoT79VrfqDDUD/mmqRyTXDXMg=
X-Received: by 2002:a17:90a:b003:b0:2d3:dd48:992c with SMTP id
 98e67ed59e1d1-2d646c232ffmr15900319a91.23.1724796659077; Tue, 27 Aug 2024
 15:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com> <20240827141041.0c815dbd@kernel.org>
In-Reply-To: <20240827141041.0c815dbd@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 27 Aug 2024 23:10:47 +0100
Message-ID: <CAJwJo6Z662J4P-8rBpsMVmiCCO6oimStu9WTHNsBYqXQ0kcU=w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] net/selftests: TCP-AO selftests updates
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 22:17, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 23 Aug 2024 23:04:50 +0100 Dmitry Safonov via B4 Relay wrote:
> > First 3 patches are more-or-less cleanups/preparations.
> >
> > Patches 4/5 are fixes for netns file descriptors leaks/open.
> >
> > Patch 6 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> > kernels to run TCP-AO.
> >
> > Patch 7 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> > the issue, but I hope it will fix netdev flakes for connect-deny-*
> > tests.
> >
> > And the biggest change is adding TCP-AO tracepoints to selftests.
> > I think it's a good addition by the following reasons:
> > - The related tracepoints are now tested;
> > - It allows tcp-ao selftests to raise expectations on the kernel
> >   behavior - up from the syscalls exit statuses + net counters.
> > - Provides tracepoints usage samples.
>
> Looks like we got no flakes over the weekend, so applying, thanks! :)

Thanks, Jakub!

I think tcp-ao tests weren't particularly flaky before, but with these
patches, those "rarer" flakes should be eliminated now (fingers
crossed).
To my surprise, I figured out the issue in v3 correctly, which was
about the ftracer pthread that didn't have a chance to run during the
test. I couldn't reproduce it even once locally.
Yet, the newly added xfail with an unexpected tcp_hash_ao_required
trace event I'll have to investigate.

-- 
             Dmitry

