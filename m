Return-Path: <linux-kselftest+bounces-43970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B054C0497E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9294E6356
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807C275B03;
	Fri, 24 Oct 2025 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ag+RvXpu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD326F46E;
	Fri, 24 Oct 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289110; cv=none; b=Chp7lgVXC2J288RC+8OM2PmQSVJEKpH7XIou4kquvcr6Itt1hG2bEw4FPX2B7XvAtF7Or+G2J/PwKWsVT8NFh5BNR/0mdK1/GVV07rUP1+ypHjf68vR94P77Z5yp4w4Cz7INauYwIUJeCHR8Oh48DvLl7f51OJLX7hMQs16OYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289110; c=relaxed/simple;
	bh=Sdsc+HimNNRly3zNHIIhGItCDW5d9nIGsh5mSBxyp2Q=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:Mime-Version:
	 References:In-Reply-To; b=g0j26hR8ZmCbsjGA7hST+cf8jKAwn+ZWphF49QS+SDYy0e/HcpkyHcsp1Taxtjwo5cnverjRAAJiFyHMzLMZIpjPID2Wp9YCgIhPhZ1D0tcUT7upHhPppCOJ7BQAhYND93OeHUE5HmvALUTl9hNujsP+3Q3hkhdiVQ4B2+0Y6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ag+RvXpu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E05CDC0C41B;
	Fri, 24 Oct 2025 06:58:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B621C60703;
	Fri, 24 Oct 2025 06:58:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8958D102F244A;
	Fri, 24 Oct 2025 08:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761289105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gaTJdVKcJhZjltv8SaaLzQ6hgLmAvbb14RM/LjN1BKs=;
	b=ag+RvXpuWocu7lddJwZwJ7ufa/ybY3bWA2D7vFXMElgKAB1iZfN4nxQVO4TIu3Acqz6sG2
	LrE/KPN8ZZ7zKsLUDZ434F9kCQAEG87HfqovSGwy0joW1uvL6czVHI+Zdzm1GlMm4wCOvI
	F2oF+0wuQL2IuD+LrDshbMB3bxwAfwinT5hyvbyZM9/opy6BOsG7/R9ir3kXYEHb5+uQ0J
	eZ6crrfZ6q/zW+RHAIo3gOPw1dURhm/2++rmPI3gsNyneo1g8fpFekIxz0xpgrVJgXxQHE
	+w5yFfl4yMQ9fBdN/vgpJFqUoIZUnQ0r5kOJ7lajf5YPN2LB/zyDU5VJbgO+eQ==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Oct 2025 08:58:06 +0200
Message-Id: <DDQCVG55KXN7.3P6MCQTNID8K9@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "bpf" <bpf@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
 <20251022-tc_tunnel-v2-3-a44a0bd52902@bootlin.com>
 <DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com>
 <CAADnVQJ6zKbThz8B5bqBpwz=gyqeindZb1kwCmM90PsR4-7iQQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ6zKbThz8B5bqBpwz=gyqeindZb1kwCmM90PsR4-7iQQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexei,

On Wed Oct 22, 2025 at 6:44 PM CEST, Alexei Starovoitov wrote:
> On Wed, Oct 22, 2025 at 12:52=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:

[...]

>> A note about test duration:
>> the overall test duration, in my setup (x86 qemu-based setup, running on
>> x86), is around 13s. Reviews on similar series ([1]) shows that such a
>> duration is not really desirable for CI integration. I checked how to
>> reduce it, and it appears that most of it is due to the fact that for ea=
ch
>> subtest, we verify that if we insert bpf encapsulation (egress) program,
>> and nothing on server side, we properly fail to connect client to server=
.
>> This test then relies on timeout connection,  and I already reduced it a=
s
>> much as possible, but I guess going below the current value (500ms) will
>> just start to make the whole test flaky.
>>
>> I took this "check connection failure" from the original script, and kin=
d
>> of like it for its capacity to detect false negatives, but should I
>> eventually get rid of it ?
>
> I vote to get rid of it.
> I'd rather have test_progs that are quick enough to execute for CI and
> for all developers then more in depth coverage for the corner case.

ACK. I' ll get rid of it. For the record, I drop down to ~3s in my testing
setup instead of ~13s when removing this "ensure connection failure test".

> Note that for the verifier range test we randomize the test coverage,
> since the whole permutation takes hours to run. Instead we randomly
> pick a couple tests and run only those. Since CI runs for every patch
> the overall coverage is good enough.
> Would something like that possible here ? and in the other xsk test?

I see that test_verifier takes some "to" and "from" indexes, selecting the
range of tests that we are able to run. Is this the mechanism you are
referring to ? (and if so, I guess the rand part is handled by the CI
runner ?)

If we want it for some specific test_progs tests like test_tc_tunnel and
test_xsk, I guess it is doable, but we need to think about who controls the
randomization, and how to still force execution of specific (or whole range
of) subtests, when needing to reproduce an issue.

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


