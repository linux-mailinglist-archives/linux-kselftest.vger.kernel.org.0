Return-Path: <linux-kselftest+bounces-49098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691AD2D92F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2DCD30150EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD62D5950;
	Fri, 16 Jan 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q+jD3U4q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3B21FF47;
	Fri, 16 Jan 2026 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550282; cv=none; b=cb/wA9PGVJnSfXNgNZiIxYOrWqaAJWPLj6LhfKq2ILnhKJQ82PL20bjeXTgrWeK0cbtNvQ2WaZWDwaob8YSXfiHDvXNObBi+PIgdDrKVXwrJQgkP0bJ9KBkXM3zSsVEY/naJ0tqxkWD+NAsLfuWFDbqyJb/daoMR1A2OMO4Txs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550282; c=relaxed/simple;
	bh=cASj+FIW6AwiVSw8nEyxkZB7wqaoLxu/2R8gfOjJaas=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=pRIDfkr527wNmKl+PSZv1u5t1PmximDWRLYl3Tk28w4/x9dIjsy/tRmVlfdAWrwKvaUa55796nh98u7uSwlrLDaiBapdYCDhgqZ6vRdN70iWJQM0aqxBus8qazWQnvAGr5m9NSTr/2LSkzfa/Dj3/ynfzAiXFZIIGMvJOCxU61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q+jD3U4q; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0CDDC1F1F5;
	Fri, 16 Jan 2026 07:57:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5967F60732;
	Fri, 16 Jan 2026 07:57:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C31C10B68571;
	Fri, 16 Jan 2026 08:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768550276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cASj+FIW6AwiVSw8nEyxkZB7wqaoLxu/2R8gfOjJaas=;
	b=q+jD3U4qOF+rUsN/V6UgWvloifkFmP3OVxPGhA8/JCoMOWnPm6VIpsmmH2vVXp2ct1f3QI
	mHLa8oLqs4LAvXzFIwxArkkaFVAofot1McIq9cmwzslLF8Yr7EjIkogRsAfLov4dbWvouq
	Tmw3LW9JZflIRt39Fq+QHA8vJyCTXOR75Ue5TRpCdqTIA/OWoHHwUyMtdHv886jMFBD31w
	j8MsM1FB9NygXYAtIplgM4BAuoL3CNQYRxksTKBVKY5aFbXZ3IPMQHuljmwXfuqQ1Euovm
	OJPlJ/BN4GKF4UrT9LnVaOQgtL4mYgYK9aN/fbv3xJQaJRToih1tyEKmmXCBZA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 08:57:52 +0100
Message-Id: <DFPUQZ5PNXKA.12KADC78HCRQ5@bootlin.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: add a new runner for
 bpftool tests
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <CAEf4BzYvZsjSpsDHXAuZ9G3=r4e27+c_LDpSUampw-fTfKA2=g@mail.gmail.com>
In-Reply-To: <CAEf4BzYvZsjSpsDHXAuZ9G3=r4e27+c_LDpSUampw-fTfKA2=g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrii,

On Thu Jan 15, 2026 at 6:58 PM CET, Andrii Nakryiko wrote:
> On Wed, Jan 14, 2026 at 12:59=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Founda=
tion)
> <alexis.lothore@bootlin.com> wrote:
>>
>> Hello,
>> this series is part of the larger effort aiming to convert all
>> standalone tests to the CI runners so that they are properly executed on
>> patches submission.
>>
>> Some of those tests are validating bpftool behavior(test_bpftool_map.sh,
>> test_bpftool_metadata.sh, test_bpftool_synctypes.py, test_bpftool.py...)
>> and so they do not integrate well in test_progs. This series proposes to
>
> Can you elaborate why they do not integrate well? In my mind,
> test_progs should be the only runner into which we invest effort
> (parallel tests, all the different filtering, etc; why would we have
> to reimplement subsets of this). The fact that we have test_maps and
> test_verifier is historical and if we had enough time we'd merge all
> of them into test_progs.
>
> What exactly in test_progs would prevent us from implementing bpftool
> test runner?

I don't think there is any strong technical blocker preventing from
integrating those tests directly into test_progs. That's rather about
the fact that test_progs tests depends (almost) exclusively on
libbpf/skeletons. Those bpftool tests rather need to directly execute
bpftool and parse its stdout output, so I thought that it made sense to
have a dedicated runner for this. If I'm wrong and so if those tests
should rather be moved in the test_progs runner (eg to avoid duplicating
the runner features), I'm fine with it. Any additional opinion on this
is welcome.

Thanks,

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


