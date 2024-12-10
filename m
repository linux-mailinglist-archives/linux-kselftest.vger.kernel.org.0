Return-Path: <linux-kselftest+bounces-23115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C529EB7E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B37E283825
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9C2456D3;
	Tue, 10 Dec 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSfLOPPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AA2456C1
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850690; cv=none; b=top2ngNnsTqvWIXNJt+3DSyLWhJDwFZ/Uo2myB0rG/0uAuHsWQH0CPDXoj+YqqGaeImc25C+THX4NGmy1rc1ReB6vXU8p0XcTEdNqYnJK98bCgI7ErwhGDX6vQn+SC4xeaC6KmA7EAEyNlmmT1jTsi3YxEeDd3+yVgHlPBHH40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850690; c=relaxed/simple;
	bh=nwwrpQSjqsRsYiyq1mDRZl4XTxZG75aj+jpIV0sjklE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gz2G4/Z0of3bk3FRSZDDQrzPbezNSSXWProXYeD9UVSYAek9TEVn1bt8Yx+/dzkFgho3GCWCZXnC17wZrm6knnGgmG6EqSqiirjRe1oP+c1ysK8a3jjl90UwbNgHhYvXpz1BYVPS2R6HSOJnCzDkDC5nq8HvozW17VBHP8AHThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSfLOPPF; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3984b1db09so4790974276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733850688; x=1734455488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/LQuBGhgmo6NAUJm4yyKvyQBh2Y+fdiNz8hKFHi3JM=;
        b=fSfLOPPF/v63uYZebDuKrJxjrnP4nGts5hdiEm5JwmSAIwqWBUV6DMoOrXnkL3STiP
         Uih3vdvAZhqiA53s6Xh/bkPwLA5JaNhkOz79tPRuW4Bmt/1KIfY/d1hLKuK/xbop55Qp
         qo5c7Gfih2YLQpphCHpj77y8fypCR6O1kPUY7DjzWdHu/sf+NGglDJsAhosIzPk/Qun6
         Ula1M+SddWdIyTrILR9VqeWi6a3Ar/1K8BaKKLLEkyPvXeZppjS6V6rBGC1GptKaTAs7
         edC94eqLCENbaddxgValNQt3GWhL6MicwM2fiTFgC5JaTsxtsItOV2H7YUqAtYppFsdy
         wfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850688; x=1734455488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/LQuBGhgmo6NAUJm4yyKvyQBh2Y+fdiNz8hKFHi3JM=;
        b=uYrYPoSNsJ41k26AOr/XbdxkzVAAM7lqe8zdiARR6PRhrk7I20Lc3znWVjPNGXOz1J
         tZWgPpysuXN34mgbQxRnFbZq5uAWnPhaqcHhOE455WHZELyBGfxJSsdOH076A7tqmPhJ
         UX24kLh31C8btVvl94/fZEBY8duW4UMjErUFbJmToPVK3m5DY1q/DIZ6Ca+Oerx+ukYW
         SWjTw3ICTuKSm8xWX3UAoBJvdBz3EhsYjyl48wdTJHxEmbC+L9uhheiKgNHsis0J2OuL
         Jdfi5EDXuOcdhQ471bYDp4B37yzb9Q9D7jaYcU3c3Ulxg613fpkxyKgScrCuDxxkZJlq
         iwPw==
X-Forwarded-Encrypted: i=1; AJvYcCVZtbNaxo8JAQVSqbV2HwCS0sCSDQqcSE/gieA+bLnye7X6yLh3QILv7JzyjLTdWeAIIhIvT+GDrhKQjdGmplw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1j1C4VPqjSyf88u5jJeSZl6eS5C8tfb8wakZ9MOzznsslI83z
	EAfezHHWuBVvdy8PnZVU6JRqh9J7H/fQhPczc6uJk7fMePe/hucbj76QdgmtPH0sNOkEdtrSnzi
	m21EEfVfGUMeVL1T3kD9TZQ8OZJ8=
X-Gm-Gg: ASbGncv5By1FK5ZoAhDpN6hGgImHwMpkWbyw/rMbXgKpw2idnts6OnPBmjvBJw6axGO
	/I9xH9m4CwFtyuX2QiBciJU4WQyyf5OY=
X-Google-Smtp-Source: AGHT+IFY62ok5Mr1eT6hqoESmjmFdMKLop2seY8rE9apbemAt4SITY5xU7a7STe2MwdBhOYfGNYOAAayobvebwyhGDQ=
X-Received: by 2002:a05:6902:1709:b0:e29:1b94:ef67 with SMTP id
 3f1490d57ef6-e3a59b2216cmr4834235276.19.1733850688154; Tue, 10 Dec 2024
 09:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205114757.5916-1-simeddon@gmail.com> <20241205114757.5916-3-simeddon@gmail.com>
 <Z1hWqUMmr6pcadqD@pathway.suse.cz>
In-Reply-To: <Z1hWqUMmr6pcadqD@pathway.suse.cz>
From: BiscuitBobby <simeddon@gmail.com>
Date: Tue, 10 Dec 2024 22:40:51 +0530
Message-ID: <CAGd6pzNUquikRS8pw7D14qXqLixOCQUWqcCcD0C1O6K2TMLeNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
To: Petr Mladek <pmladek@suse.com>
Cc: shuah@kernel.org, mbenes@suse.cz, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 20:26, Petr Mladek <pmladek@suse.com> wrote:
>
> What is the reason to add another set of dependencies, please?

I had done this because not every test required all the options specified in
tools/testing/selftests/<test>/config. I thought it would not be desirable to
prevent these tests from compiling/running.

> Both CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG are already mentioned in
> tools/testing/selftests/livepatch/config

This particular test only required CONFIG_LIVEPATCH to compile, but I
had included CONFIG_DYNAMIC_DEBUG, as Miroslav had expressed
wanting both of them checked.

> IMHO, the new check should read the dependencies
> from the existing tools/testing/selftests/<test>/config file.

I shall check tools/testing/selftests/<test>/config in my next patch as
suggested.

> I run the livepatch tests the following way.
>
> 1. On my workstation, I build the kernel RPMs using
>
>      make rpm-pkg
>
> 2. In qemu test system, I mount the build directory from the
>    workstation and install both kernel and kernel-devel packages:
>
>     rpm -ivh rpmbuild/RPMS/x86_64/kernel-6.12.0_default+-35.x86_64.rpm
>     rpm -ivh rpmbuild/RPMS/x86_64/kernel-devel-6.12.0_default+-35.x86_64.rpm
>
>    and reboot
>
> 3. In rebooted qemu test system, I mount once again the build
>    directory from the workstation and run the tests:
>
>      cd tools/testing/selftests/livepatch
>      make run_tests

Thanks, I will test building kernel RPMs when I update the check to be
more distro agnostic.

Sincerely,
Siddharth Menon

