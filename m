Return-Path: <linux-kselftest+bounces-35334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD3ADFC4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 06:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5AD3A9FA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429423C8BE;
	Thu, 19 Jun 2025 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh1HfRYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096418DB03
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306797; cv=none; b=Su6zcMvxXHlr14pqwi/T+3oAMu18NNqCWyCFVyGDFmzelGw1dvjG9Eum3Afrx2UC4p3UVVA911+m9Vz/mVXa8UpQGvqUoBLQl/qR/jVlbjFTQMCWJfhJ/olG+l46eumwvmVmfY3XKIHoxkdhkROaoQ/Jz3/8Uz/KmjMYMOCNKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306797; c=relaxed/simple;
	bh=42+ZcWihADi6feelct3b85p6eGrRRLvD+RD7THwAKIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kciJiyRv67aeUjxHDFiuwpqHsidpJCj43Y3CSL3ikZEv8YwPrI4juytR4kYmLe8p0AVgyVuHpIPpvUJD4kAqEqOGwQe8HX+x48c9mUi2r6sxY7Yi6kp45VNmIXktGZZTWMCsB4u9N5Hb8Krm4BlqREoeaDhb7uLoVh+1Gez6/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh1HfRYm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2348ac8e0b4so67495ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750306795; x=1750911595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdPPLCnOw1JLV4SAcVZKzEB7UTqx2yTdOYlcY0aplos=;
        b=lh1HfRYmZOM7QoSsVjJssw7UGIlzRCqGywIXld6UFxwME6B+JaMhB3KyPP0RxWBP8u
         FqvbGul5cJyTmDTTCCmcpa1Hk091H0GbzLDlrgiBqkCbV769ozj35bjGyRkYmX2iWL5u
         7e+oTA3ghvmJQF4MK3GGHOt7GCjYqICINowCUBBOtpl5ZQib4JhIEJ+rRKLvdSnBlTI9
         +Dp1n6Xf6G8tU38uUi9f2MelY/xSXgfcTXW3Y+Fai1y/FlGoFxnyKFvHfL7AQxDzTxDP
         asHjKzumuPpOyAyW6oW6kzNt0D8QjqBcVsSx8v90HPvJ1oLoinVh4lTTH++PkmcM08G8
         WyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306795; x=1750911595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdPPLCnOw1JLV4SAcVZKzEB7UTqx2yTdOYlcY0aplos=;
        b=D4jEVX0IqSGut0NjNAVvDPa+k/aq2ZH5CIEg8TTwVE58GRQpsoIitkx09bkVTtSvbz
         1kUwh79GdF0kj6peagvovgUKTLwZu7YBaSsW6iOJB/wmvr6n26jOeMZV5b0HZqIE0CVP
         RWyaqPbBaA5z7SK/K0E7Blx6rGoEqy9zRSpfBXdtS3vLzC/dBbPZHO9zezl6P5Px8SJH
         u5hVQt6zZg/0LwC8B9yKdZzoJyIXdmvkl2cKlck+Tu3Yo6+FM9Eo+G7JPYY7w8CSqtTY
         mqXsxnAResL4RzEKyczBQrDI9HbliaJTNG0nLZXaNJxO4FTO8ba0i8Djzdq+jKKQYsPw
         CeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeKQNt3Cpz9p+07iGJT6juBLbdnKSemxp8sr7wxpV9BT2H2bYFisykPugAsL1ToASNMV6ibpuBrgQ2ozdZvQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUAMIr0RjfX6+riSwLPnyXzH28Zk2kE7o+udo3dCvHGeRlpRP
	feyTMI3dKuuWpN8CsONzNXpqdEl8OAGWBDnt5kL9dpAbwe3dYqmAHP7LGPO/JQtbsgs8gKWqL24
	Ecp8mTm+icU5ON6JZp5tjEDWxN7poni26eD+gYVMK
X-Gm-Gg: ASbGncvNBd/Jcp652wxQosXOVrTC8UVD5x2+aMdo6AqBH00jCJoC6EF/1jvdroIF7QW
	mOOcrn+iFg3lIGhvM4VrYUpplW5InLiiDMtSTQ+diNJiEoRvtLI9XZ9scdY7RnlXa5uvmEHYofd
	yRgYJIRSqJl8muuBCPm92WGnHIe+Lf/pnhzuRWL9iHHyAr
X-Google-Smtp-Source: AGHT+IG4/KdYP+fN9Tz4EPFqPl59lyfp5z5oElErmQ39hgdiqIKMNL14Yst10Fryuqu/ixWcQkhafk8e9lBxMFD/+CA=
X-Received: by 2002:a17:902:d484:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-237cdfe93c4mr1247815ad.5.1750306794932; Wed, 18 Jun 2025
 21:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
In-Reply-To: <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 18 Jun 2025 21:19:41 -0700
X-Gm-Features: AX0GCFvx-B1b2Dd3L5vrSsW0UL1IAM66_kMPRqHS2OPCt7MkBpentxKfBxCiSAk
Message-ID: <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:46=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
> >> Something is off with benchmark numbers compared to the OOT version.
> >>
> >
> > I assume you're comparing my results (my kernel config + my hardware +
> > upstream benchmark) with your results (your kernel config + your
> > hardware + OOT version). The problem may be in OOT vs upstream but it
> > may be just different code/config/hardware.
>
> True I used OOT version.
>
> Just applied this patch, but I get compile error. Because Makefile tries
> to get kernel headers (net/page_pool/helpers.h) from local Linux
> installation instead of git tree.  This need to be adjusted for patch,
> such that it builds with src-local/git tree provided headers.
>

I believe the fix to that is to do:

make KDIR=3D$(pwd) -C ./tools/testing/selftests/net/bench

I.e. the build files assume you're building the test to run it on the
current machine, to cross compile it for a different machine under
test, we need to pass explicit KDIR. I've kinda copy-pasted what other
TEST_GEN_MODS_DIR=3D makefiles do. In theory we could do something else
but I am guessing the way current TEST_GEN_MODS_DIR does it is the way
to go. Does it work for you if you do that?

[...]
> >
> > Yeah, I actually just checked and I have CONFIG_DEBUG_NET on in my
> > build, and a lot of other debug configs are turned on.
> >
>
> The CONFIG_DEBUG_NET should be low overhead, so I don't expect this to
> be the root-cause.  Other CONFIG options are more likely the issue.
>

Thank you very much for the tips. Perf report showed the locking was
taking forever on my kernel... I had locking debug configs enabled in
my build... sorry... with those disabled, I get much more sane
results:

[  185.557293] bench_page_pool: time_bench_page_pool01_fast_path():
Cannot use page_pool fast-path
[  185.607873] bench_page_pool: Type:no-softirq-page_pool01 Per elem:
11 cycles(tsc) 4.177 ns (step:0) - (measurement period
time:0.041772642 sec time_interval:41772642) - (invoke count:10000000
tsc_interval:112778487)
[  185.627090] bench_page_pool: time_bench_page_pool02_ptr_ring():
Cannot use page_pool fast-path
[  185.826991] bench_page_pool: Type:no-softirq-page_pool02 Per elem:
51 cycles(tsc) 19.117 ns (step:0) - (measurement period
time:0.191178107 sec time_interval:191178107) - (invoke count:10000000
tsc_interval:516173586)
[  185.846380] bench_page_pool: time_bench_page_pool03_slow(): Cannot
use page_pool fast-path
[  186.479432] bench_page_pool: Type:no-softirq-page_pool03 Per elem:
168 cycles(tsc) 62.469 ns (step:0) - (measurement period
time:0.624690697 sec time_interval:624690697) - (invoke count:10000000
tsc_interval:1686656879)

Does this alleviate your concern? Or do you still see an issue here?
There is still a delta between our results, on different
hardware/configs but results are in a sane range now.

--=20
Thanks,
Mina

