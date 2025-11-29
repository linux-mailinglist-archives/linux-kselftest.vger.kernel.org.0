Return-Path: <linux-kselftest+bounces-46734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA1C946ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50BD04E1705
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECFA238D54;
	Sat, 29 Nov 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RY4nB4f0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404C1E260A;
	Sat, 29 Nov 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764443512; cv=none; b=WVm6z1rz5MNNY9hafLb+fVsKVqf/GCFK3KsS8hEddXeFngp9HdtQNL1aSKQTGBhkSAJYugCNmbZC468U9kp9jSDM12Z632YsEjCYU9fc8X2ZWIjHse4ENIe5npqd5dJcHyuGuC23Jn548xojZo6SX9ksUpyCZCWKJVAoRUAsnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764443512; c=relaxed/simple;
	bh=zjozRn4pbgaxuIk48p9aucayYkZaVp7CSobHrncbe7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=pPmP84l/Ko1g5wB+VIkg1W3VJCzImXolfqIQ+pLie+PHrAB183f0ZHLlItRIBDdUPCbXyrOERYI4odNfvT7DZlI3Jaz0OfYxGydcEzTDl5lUBtwZuiK9ffe2X3v8rk2Qc92n2POfrkIpjVWN21yk6P7qQzDIC+0ZnKKwYP/L6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RY4nB4f0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 35D484E41979;
	Sat, 29 Nov 2025 19:11:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE1B360706;
	Sat, 29 Nov 2025 19:11:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3168511910A1D;
	Sat, 29 Nov 2025 20:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764443502; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S9q1MPldQnRfT0Gwn1mdhyeeUOLcb5XYG1aj/3IUCfo=;
	b=RY4nB4f0vcVWWyOzjXoX8f8XVzZQ1nLmS0bJTVcxZG3PfyPsjh2lrjnQ5IzrK1wxO31qZV
	G/p7jTL5ctpLfs02ojdfFa8MTJRvHMTQLcKNpqA/7CJHlTakpr6Y5Q7MGgUkRPqi3XDzSa
	/BzjMENNOMfPunMPv6ciplXaVU3JumdMoiduIg8LqTtuy6pbWUfJUfYsf/W+xo/aYP9qas
	M3Zy/SnLMpfMUtlsIinafLl/ZEaHwPfUbDK56dr3BfzRFnNHlqz23Yo1RpN2Dg8EYWUueR
	tZ5z8SRqOLCMWuefmQzQ9dxLODKi6i6TDwq6+fUcYTw6xnlDI/gHX0szeR+Uqg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Nov 2025 20:11:38 +0100
Message-Id: <DELF0P1CC5BB.19GJDYJ9C3ZWX@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "bpf" <bpf@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: convert test_tc_edt.sh
 into test_progs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
 <CAADnVQJwjFcZ8Uz_WZrhrh6QEOHHNsVt7ARQRR8iL2O9DhREpw@mail.gmail.com>
In-Reply-To: <CAADnVQJwjFcZ8Uz_WZrhrh6QEOHHNsVt7ARQRR8iL2O9DhREpw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexei,=20

On Sat Nov 29, 2025 at 6:46 PM CET, Alexei Starovoitov wrote:
> On Fri, Nov 28, 2025 at 2:27=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:

[...]

>> The original test was configured with a 20s duration and a 1% error
>> margin. The new test is configured with 1MB of data being pushed and a
>> 2% error margin, to:
>> - make the duration tolerable in CI
>> - while keeping enough margin for rate measure fluctuations depending on
>>   the CI machines load
>
> Applied, but it's still a bit flaky in my setup.
> Fails like this from time to time when run in parallel with other tests:
> run_test:FAIL:rate error is lower than threshold unexpected rate error
> is lower than threshold: actual 6 > expected 2
> #450     tc_edt:FAIL

Yeah, that's what I was worrying about with this test. For the record, I
tested the v2 using my own fork this time to run GH actions before sending,
rather than opening a dummy PR onto the official GH repo, and this somehow
led to only x86 testing (which passed). I then saw the test failing on the
official CI triggered by the series being posted, in S390. I guess this is
not so suprising, as any qemu other than x86 will likely make tests more
sensitive to CPU load.

Maybe we can afford to raise the admissible error on the effective rate to
something way higher, like 10%. That would validate any rate between
4.5MBps and 5.5MBps, but that's still pretty far from the rates we can
expect if the shaper fails to trigger, so the test would still make sense.

Otherwise, an intermediate test that we could do is setting it as a serial =
test
and see if it improves things in CI ?

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


