Return-Path: <linux-kselftest+bounces-25013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A7A1A5E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B06B1886BC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23C21147C;
	Thu, 23 Jan 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bwPCPgYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590320F083
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643464; cv=none; b=MBw5471iz9N5lHzPk38QFZUPMBZ6mVqUBErly3qqs28nMT+NFhZf4yRwbpgpxvBgsU+vjx/7FC+IwRNNTm5562XkknRXTGeQY/j6Lun/IPzYXCwMbESwaC2gQCsK0K7W2KSc+xWWIOzaxu2uIM7qbvtjOsId3bSwh6qy0QdjlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643464; c=relaxed/simple;
	bh=97mFc1bfhOYsAFlqLiNffBTQY1b4ObSH5YQBwDHDbho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSCZhPr7JYFFWb+uT+mcfbNINHaZdpV6RiSje4ITxvsxbkCvoUaiTvq0Hh9xMK2vRMoJsEo9IfF1DCdt35r836iK/RKw+ZiWmasC9NctW0NXcsmzZqLhlrnS99OKG1FRXPB9WVQVGuU+6tCwXbpqdIVm/dNgmb/N26xySj+iE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bwPCPgYB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-304e4562516so10016001fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1737643461; x=1738248261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97mFc1bfhOYsAFlqLiNffBTQY1b4ObSH5YQBwDHDbho=;
        b=bwPCPgYBIr1i1D+uWkVuyktvynE1iVfe/fEVaq7618GWsU4GIZs0UsTgLRxwg5G0x8
         AIiOsspfUApFJawDk1blWWxS5TSD6/taKGMJ56K/I+bXocbFTRv6DmGPBm15pVLZVSc3
         hgBSk8v17igNzK0iu12gqr5uqr8H4zpSIZ3buGl9xBggHnzlz9w6PtBgMcL0m0lhG6rB
         Q2ZF/GFcOhErRJ+Xw45rcRhyvCCYvdINqPXHV/ilEyja3VJ2daytJSfKfM2Iafci18+2
         e5eHAuftYtYiooZBjtY52lHa8rBBTjXiUoSznNLHI0Klf5kEqF5+nuU5CnkqaxftvfVC
         o8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737643461; x=1738248261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97mFc1bfhOYsAFlqLiNffBTQY1b4ObSH5YQBwDHDbho=;
        b=PKGXgQkaHRXIr9wdaToRM41F2xpUNCVnnXflXGmxmbSmQbcc/SgMw+/SzVBw0sx0PQ
         mDvdENwXXLq5MGgzI99L/5Z30wXYIrdgmzuzwQPlAOOW4M//gpvB/GDpqF8A8kPzPinZ
         iZiwEnAHWr+AQsnvSRII9TWBp+UTcZPqfHDyyKrDrTcQN1NwPw7GX4GCLxxzA8JzUrfg
         yhfgGkE1rfM//ICwONiFopjLO+XB4nKCJsD5CE5QYyBIPFpbP98Tp9EOuEdbgkZd1h0c
         m2l6dwBz7mKbpebj0nPZEwQm54vxvDiIT+6JRxJguw38PHxjJfuZsdYoQEx3GEzyccG0
         klXw==
X-Gm-Message-State: AOJu0YzxweIoX6xnzetEUww1DtCJX3SZG9bgy7rPrRs9KwTT1z57/166
	W74Sviz8k4YqMEwWkQA1ouCh8yTgVOky4LlqPNhJ+1PiV9zdkla86RxpG4yF/6Ze0QsFPqOF0WA
	gAIW6UH3vKAXx35VG8uNskyC4DD9F2ZkvHTBccA==
X-Gm-Gg: ASbGncvItWhB3vh3dta/ye0woV9E4nwF6cnWIP3iNF5sWy4uuZ1nwxFYg6plQVXVs88
	r4zq3MLJQ8/wXMT5qVYe+ntDUAaQCAojQguaaCkkjdeyAFIgZvZlu/hxQ3/DHlu5mnQlI9KJwr7
	nR4MJYJvFfL5k6bIofmsW9Qn2Ip6Qb
X-Google-Smtp-Source: AGHT+IG7GrwR/B983ouCX5cekNNgB659x3tE/CPxN4qXwQi1fqY1tndv4W5+gmPBI4Xk9AgKg3ts8y/7hothDE8fdEQ=
X-Received: by 2002:a2e:bc83:0:b0:306:d69:904b with SMTP id
 38308e7fff4ca-30761bcb7ddmr15096701fa.8.1737643460462; Thu, 23 Jan 2025
 06:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122043309.304621-1-koichiro.den@canonical.com>
 <CAMRc=MfRm02TRJ52CU3iLhsvwd95CBhxmkbebCJ=riiXxsCkyg@mail.gmail.com> <iyraiattza5sogq4ysmmds2uvenlhnccrdw7vhoizgsu462db3@ouuwrbrznct6>
In-Reply-To: <iyraiattza5sogq4ysmmds2uvenlhnccrdw7vhoizgsu462db3@ouuwrbrznct6>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Jan 2025 15:44:09 +0100
X-Gm-Features: AbW1kva8MT3ORhxRkp2HOeRXNOn6lRgqgtjHUKmeJq4HTp8o3r6ABBT-ga-zhK4
Message-ID: <CAMRc=McWYf2-2nxiRKpMumzbp6irfi46873-KXxF5UbWXxU_Hw@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: gpio-sim: Fix missing chip disablements
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-kselftest@vger.kernel.org, linux-gpio@vger.kernel.org, 
	bamv2005@gmail.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> On Wed, Jan 22, 2025 at 10:26:27AM GMT, Bartosz Golaszewski wrote:
> >
> > Hi! Thanks for addressing it.
> >
> > Is there any place in this file where we'd call remove_chip() without
> > calling disable_chip() first? Maybe we can fold disable_chip() into
> > remove_chip() and make the patch much smaller?
>
> My aplogies for being late.
>
> Yes, there are five places where I intentionally omitted disable_chip()
> calls before remove_chip() because the chip wasn't enabled in thoses case=
s.
> I scattered disable_chip() calls only where truly necessary. I also think
> explicit enable_chip()/disable_chip() pairing look more clean and readabl=
e.
>
> That being said, I'm fine with your suggestion.
>
> -Koichiro Den
>
> >
> > Bart

No, that's fine, let me pick it up as is then.

Bartosz

