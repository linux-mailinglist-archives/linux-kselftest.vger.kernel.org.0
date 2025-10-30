Return-Path: <linux-kselftest+bounces-44438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33489C2130D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AE8563302
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA273678A2;
	Thu, 30 Oct 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PSfXjPME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F425784A;
	Thu, 30 Oct 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841633; cv=none; b=FP3wK9M2Mr864NTNpPlZHR7+I9lxADBqCM9nelE+wXlUEtWpC8mdeSuJn+bi2Akqh5bnJPiIXWY4XZtFOUq1cy3sh0bzcHd1RxHkI2fJNCmhaKx/IABZAMxECO5MOPyBxqT0nBkddW83jympSdD6p+CFSi1zsIP8zNJcAfSwtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841633; c=relaxed/simple;
	bh=X8CIPBVv77pC1c5MspqiZdzd3lFev3oupZ96gyIju70=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=gD10tqfzTkhyDh4g8Iq0N+8/8PMIKY/BOLXsLcf3WS9D55bgqa0Le2Nt7/9JcZ/1J0WRH7ALjPCR71Wjek8etJDY24AF+3SXHmXmRQIzFf+tYRdQrdOcv4p+Ssk8X0FQOMufp2lhCSjs2mSILNJSzRNrQ7xpve/9KP4WLWtkd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PSfXjPME; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0B6A84E413FD;
	Thu, 30 Oct 2025 16:27:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC02560331;
	Thu, 30 Oct 2025 16:27:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FE7311808BEA;
	Thu, 30 Oct 2025 17:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761841627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lBi0Ye0OKMfCGldRnjSwq59CUYQYeOwgXqoWKNOC9sc=;
	b=PSfXjPMETKW9F8bO8zUpxrANeYPbUILC+FMpzbLL5xoGDKcrR6yFMp+xk2eKdCSaJcBbAv
	8a/PRmNlPVwH1EauDjmRQpmdQmpt/icwgLa/pWRQKVI+JRqbX7QQEtfYkHZholWfoJA2o9
	AtwRKeVGP4wkcP6FfNoxb9F5LbjUADOOXjiVQL4mh2zyroRihO0tZ/M9Cmxzb2B/LSI5Ag
	1FSpwy55lVL4a2z1JRd0uIRjmWlHbYPI4EH5ynClgRaoaQPZZdUgyFUyKwS6QPbaoDx5XK
	NtI9+r0iEm9olhmqiU6LpI761/PAQtRxTS9yHoZJ0X7Lid+pzWJDdRAnQC/pQw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 17:27:03 +0100
Message-Id: <DDVSQC84SOHH.2R3VKM1MF6RMG@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
 <20251027-tc_tunnel-v3-3-505c12019f9d@bootlin.com>
 <1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev>
 <DDVPPGIO5P1F.E3DWINA74BJ6@bootlin.com>
 <efa3540a-1f52-46ca-9f49-e631a5e3e48c@linux.dev>
In-Reply-To: <efa3540a-1f52-46ca-9f49-e631a5e3e48c@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Oct 30, 2025 at 5:21 PM CET, Martin KaFai Lau wrote:
> On 10/30/25 7:04 AM, Alexis Lothor=C3=A9 wrote:
>>>> +	int family =3D cfg->ipproto =3D=3D 6 ? AF_INET6 : AF_INET;
>>>> +
>>>> +	cfg->server_fd =3D start_reuseport_server(family, SOCK_STREAM,
>>>> +						cfg->server_addr, TEST_PORT,
>>>> +						TIMEOUT_MS, 1);
>>>
>>> Why reuseport is needed? Does it have issue in bind() to the same
>>> ip/port in the later sub-test?
>>=20
>> Yes, I observed that is I use the bare start_server, I systematically ha=
ve
>> the first test passing, an all the others failing on the server startup
>> with errno 98 (Address already in use). I have been assuming that it is =
due
>> to some TIME_WAIT state on the freshly closed socket, but I may be missi=
ng
>> something ?
>
> Thanks for confirming. You are right. It should be the TIME_WAIT. Using=
=20
> SO_REUSEPORT works but become confusing on what the test is trying to do=
=20
> by starting only 1 reuseport server. reuseport is usually used with >1=20
> server listening on the same address. A better thing to do is to always=
=20
> setsockopt(SO_REUSEADDR) in start_server_addr for TCP.

Sure, I can go for start_server_addr + SO_REUSEADDR :) I'll add it as well
in the incoming follow-up series, next to the missing open_netns checks.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


