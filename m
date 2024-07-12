Return-Path: <linux-kselftest+bounces-13690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D4930030
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 20:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD201B212D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2F176FC9;
	Fri, 12 Jul 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d110yPXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0F176ACE;
	Fri, 12 Jul 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807714; cv=none; b=cB5uLZVKa3s/rfIhQ7k5eW0bQyZW9L0N9IefuMjc5BIYS9JDVJlQolIPdNJjZCaKKANm5g5E1Rk2v1Q9xRZ5h6wydFCSLXszTmE6C8BUyuSRjQAS0ExKZMcrEkm1MupnmZJELg0RIhKHWFmwsQBFg5IVR64yuVNdG2898PkGYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807714; c=relaxed/simple;
	bh=4214trYlTDT2VcfjYRLHzdKd/CxYkIWS14MOQpiZM/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvh003BKd0ni5PgxjC/LQCAKc1Acy6oH9B1UKv9hztRxIuXnj8A4ovmyvWMuSP9j47MXqh98uCJhvLzTqzG+pRmtBeNNe7hnynMikrbULnhff1w4YHU8FKj5aYLKvEjTpJo4InjCffJy01O8xegNdl/6PQ6kjgc7Ah9GpsfK7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d110yPXS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e98087e32so2661053e87.2;
        Fri, 12 Jul 2024 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720807711; x=1721412511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4214trYlTDT2VcfjYRLHzdKd/CxYkIWS14MOQpiZM/4=;
        b=d110yPXSfgMDZu6bWUTZnwYufK8k23rJYfpk2KajHQFekDDZEtfFtdzuQSfLSphHfJ
         nCy2nkQDSob/OQclK7i8fKsUbclzxXDK7EKToZU4z6OzwBZ9FJz8cK6aqq//O5RiDUTT
         fIMXaffYk9vnXWMbtGjlTIAg2j+qwiePRTAyx631j8zTP12N3IxfpnydoU3h6+ixm1j8
         SQbSKwVEIZNU67W3X45iA8ygUbNj6BTNNL/35dhJF+FLKL16d/PdgN4pMh26xoU6JeU6
         8+l3Bkb1xw2HezDWNG6vzRJKsiQaeW4YDnKNvPaJn2mv++1+zUxhZQcwW6czGEcIldvJ
         SMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807711; x=1721412511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4214trYlTDT2VcfjYRLHzdKd/CxYkIWS14MOQpiZM/4=;
        b=pmn1cjhZp7HjjNIq9acx8B7PH9RtCw4KpAgXHEiwS/6BFUuYFhBr+ukaG+xsA6KB46
         2uGVsKi1Az4wEWUS6/7o5hzUCxodyotgq9B4q0nWFZ4bV+jXfwvQrWgKhgLl/I9BuTlg
         b2Ti0e4HtzUQkCKOg9dH1KDorv0n6acUmWFYzJfAUMyb+ATGRY7DP7RlIXTF91Qyf8/1
         lkkt/3pamzBX2/2JU5bYxX+eX93T3H7mDipgMEro/rSlalUdd8o/qqN5ZBRq3swyBMsI
         rRfsxrmRbJDyxQ/WNaEuKoS7hSuq6xXewADNxo5kyxbvIqUEXkMzECC+PZ+DvFGtUPlF
         kQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCdDukNBko5qPukkfq8WXN08pWY6YPa0dnpLSDkfCDtbiRbnIpr0gAUL9a0D6n0H9DGPcwPFscGzYAPi7no7BdBsEqvZ+ZUjA1wS7qVGWpP71PN86Ns4dAP6BMkoc7E2g4UiCxqigjLcaE/wUZhovWcCoaSK4bG0jpnvUHh+8UiIuX
X-Gm-Message-State: AOJu0YyzVjTwpm0gPkMCQgr6drqXlYNKMRBrHVM33XlUSbwXUQ/KXZjJ
	s5MuXWsAkt09EVLR4WgXOApG1DyqikRT7sqwmJNNj09O4M9Rt2BWIFeLPwUxYX4FTTVMKVcdn7A
	qmenmk0AV5tfzw2vfCWwGsChB87M=
X-Google-Smtp-Source: AGHT+IEDQM4plrvR0qzlJhHQ3z3hykayws0uw290JWA9DNYxOLC1xf1vbjlSaW7ujt67A174DKIPqVgxkXxuq1pLv1c=
X-Received: by 2002:a05:6512:6d3:b0:52e:a008:8f41 with SMTP id
 2adb3069b0e04-52eb99916damr9379815e87.25.1720807710699; Fri, 12 Jul 2024
 11:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705145009.32340-1-puranjay@kernel.org> <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org> <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net> <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net> <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net> <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org> <SJ0PR15MB4615BF10FDB6D4577AC84D87CBA62@SJ0PR15MB4615.namprd15.prod.outlook.com>
In-Reply-To: <SJ0PR15MB4615BF10FDB6D4577AC84D87CBA62@SJ0PR15MB4615.namprd15.prod.outlook.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 12 Jul 2024 20:08:19 +0200
Message-ID: <CANk7y0gYSix9fVUC1Q+DLqu8UFaJgFbxCF+_zAzjMCyFzzM4uA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Manu Bretelle <chantra@meta.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Manu,

>
> I was able to confirm the fix using the artifacts from https://github.com/kernel-patches/bpf/actions/runs/9905842936
> Thanks
>

Thanks for testing the fix.

This bug has been resolved now but the test still hangs sometimes.
Unfortunately, I am not able to reproduce this hang
using vmtest. Can you extract some logs from the CI somehow?? If it is
hanging in the kernel there should be some
soft lockup or RCU lockup related messages.

I was talking about this with Kumar and we think that this test is
hanging in the userspace in the following loop:

while (READ_ONCE(fexit_skel->bss->fentry_cnt) != 2);

Could it be that fentry_cnt is > 2 somehow before we reach this?? This
is only a random guess though.

Thanks,
Puranjay

