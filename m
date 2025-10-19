Return-Path: <linux-kselftest+bounces-43514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C67BEE131
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0B93E4328
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DC329D29B;
	Sun, 19 Oct 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IJVgo4VR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3B19D074;
	Sun, 19 Oct 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863886; cv=none; b=VJslqvHtTHEtRIGQxap0c8JTbcDvMf1SYRFMH99otkJCOoPJlUKzGtCSSFfCFHaAGd2yazLYOfshmpqxFV+UEgg0E8wE+b0vFV5+mD9Fulz8U0gKZ8D8/UHoBhH3yn0nnAHBVCOMcnWcN3LueQrIOPWXuwVq2IYO2t2LTPPLPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863886; c=relaxed/simple;
	bh=Y0pWpuDrYmI4OMUjMbc/jTMaeVXhpIIYiTNqLlufnk8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=tw935j5X1ZV2SMF9h1xYECwqxrMbzBiqUqHob9UZKSww/37nlkQeuhLCTq6zU6qkPLaq1q81KrHLO1E21UCXLYREunrBX5QmYmdeCXsz3DiOVRkZsG3IIMULCDFF1769HKM4bgYaFcbqifEu9GbHWdWGTGZZQjft7SHqZNBLdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IJVgo4VR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 77B9FC09A03;
	Sun, 19 Oct 2025 08:45:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B06B3606D5;
	Sun, 19 Oct 2025 08:45:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FBC1102F238D;
	Sun, 19 Oct 2025 10:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760863543; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jyv8Ny3eYcuzCA4QCGmdA/mqKgQJfhy3966PAg5VYa4=;
	b=IJVgo4VRUdHkSOpbpwbI4i3XQUiKYBTZbjOnqcTfBFPYwedIkVoTNmOoOLwUNgNqslwEpl
	HoNbo4pVnSZtX0VkqX7Ztqd9rvSv4nn3E9r41u3YWvBLY7CS1ys2HSmtC0Ua0l4Zy9V5oG
	yFX0WhKjsXmmAaeoEuYOVx7zcv1Y0KWm09SdA2cbpgjgObfBNxAXW/zHL+0w5SK/O2sEm2
	vGeo0SLjcN+hZWGLDT3w9+ZaVSYEXXEte+8Zsv5Hs5DGFMJufsz3POym+NFXp0niX1upx/
	ZQG/jSrBhI6FItdxYjf4zN586DDvBw7SPY9prcBP7uFVjrJUg9g5EQBsY0SmvA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Oct 2025 10:45:28 +0200
Message-Id: <DDM60XIK0NUQ.S2QMK9E7HQ2U@bootlin.com>
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
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: integrate test_tc_tunnel.sh
 tests into test_progs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
 <20251017-tc_tunnel-v1-4-2d86808d86b2@bootlin.com>
 <2477894b-3325-4bc2-9d3c-a066b3cbb8f6@linux.dev>
In-Reply-To: <2477894b-3325-4bc2-9d3c-a066b3cbb8f6@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hello Martin,

On Sat Oct 18, 2025 at 2:18 AM CEST, Martin KaFai Lau wrote:
> On 10/17/25 7:29 AM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> The test_tc_tunnel.sh script checks that a large variety of tunneling
>> mechanisms handled by the kernel can be handled as well by eBPF
>> programs. While this test shares similarities with test_tunnel.c (which
>> is already integrated in test_progs), those are testing slightly
>> different things:
>> - test_tunnel.c creates a tunnel interface, and then get and set tunnel
>>    keys in packet metadata, from BPF programs.
>> - test_tc_tunnels.sh manually parses/crafts packets content
>>=20
>> Bring the tests covered by test_tc_tunnel.sh into the test_progs
>> framework, by creating a dedicated test_tc_tunnel.sh. This new test
>> defines a "generic" runner which, for each test configuration:
>> - will bring the relevant veth pair, each of those isolated in a
>>    dedicated namespace
>> - will check that traffic will fail if there is only an encapsulating
>>    program attached to one veth egress
>> - will check that traffic succeed if we enable some decapsulation module
>>    on kernel side
>> - will check that traffic still succeeds if we replace the kernel
>>    decapsulation with some eBPF ingress decapsulation.
>>=20
>> Example of the new test execution:
>>=20
>>    # ./test_progs -a tc_tunnel
>>    #447/1   tc_tunnel/ipip_none:OK
>>    #447/2   tc_tunnel/ipip6_none:OK
>>    #447/3   tc_tunnel/ip6tnl_none:OK
>>    #447/4   tc_tunnel/sit_none:OK
>>    #447/5   tc_tunnel/vxlan_eth:OK
>>    #447/6   tc_tunnel/ip6vxlan_eth:OK
>>    #447/7   tc_tunnel/gre_none:OK
>>    #447/8   tc_tunnel/gre_eth:OK
>>    #447/9   tc_tunnel/gre_mpls:OK
>>    #447/10  tc_tunnel/ip6gre_none:OK
>>    #447/11  tc_tunnel/ip6gre_eth:OK
>>    #447/12  tc_tunnel/ip6gre_mpls:OK
>>    #447/13  tc_tunnel/udp_none:OK
>>    #447/14  tc_tunnel/udp_eth:OK
>>    #447/15  tc_tunnel/udp_mpls:OK
>>    #447/16  tc_tunnel/ip6udp_none:OK
>>    #447/17  tc_tunnel/ip6udp_eth:OK
>>    #447/18  tc_tunnel/ip6udp_mpls:OK
>>    #447     tc_tunnel:OK
>>    Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED
>
> Thanks for working on this!

Thanks for the prompt and detailed review !
>
> One high level comment is to minimize switching netns to make the test=20
> easier to follow.

Yeah, all the NS switches make the overall setup a bit tedious. I'll give a
try to your suggestions and see if we can reduce the number of NS
open/close pairs.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


