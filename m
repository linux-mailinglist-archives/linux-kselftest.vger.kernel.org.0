Return-Path: <linux-kselftest+bounces-15148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B994E7AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2451C219CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D71547D3;
	Mon, 12 Aug 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dvsskRbh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC614D712;
	Mon, 12 Aug 2024 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447387; cv=none; b=X1J09/bLASd9NgYzlTnurgfyzF/XYg8zIZtDsyV7RhDJsHllX0u3Qgs63Kp8O1zqpDfnBOF9q1aYzJKZzMStZlmRBbcdrzDJ2ueULaW8w6OftLPgxWMyCjO2tIIf6AXZTeCJVNnkx9IYJ1QBpH8jd65h+FeX1SwA1HTOtTPnjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447387; c=relaxed/simple;
	bh=YNI++lsZPhQphrW/mByHCjzWnEZ7Z47kgXJiDUkFiRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpvXda9EnH9NSE+z86cQDOjwQNz1X/rWhUcg3Mj1giAA7ESbJNNFlpQyOzmjnBf7yOIu3sw7EjGimUCFicLNZGS03v0U+Dak5P2taFBvgd35xoF9ZTFy7RATJzyKem966rgOlNadYQ3yeYg70P22spFyON7vKAjZT/KELmqJThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dvsskRbh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50F1BE0004;
	Mon, 12 Aug 2024 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723447376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AatjnqTj6Mo60vCkzZj5OOcMtyHEcgfGQYB4BrNoXiA=;
	b=dvsskRbhmNQqLPGkbmUZ7An8x6i/97/SAKJm5wa2G8D1FYl5XEvSLJK+2iaM7lp6LXTQzV
	TyoFY2BxE2PBcRas/ZwYDYOdMfxllPSVOJPVpR9lgmoVxw1AdXm0qEAksVoE3WZTjifPV3
	kKYKRg0PImvHVflxc1wSVsDjJ1oHOyKzD0f8C1MyUU+qBx/bz/gh3nJKxu4sYlRAxFBzDx
	CnuwpnaqTdiedfMMCo1D34JZXqlDvpFt9LewJC5uOFtUFfiGBWDMjIOc6k5nmRYbI9Ffy0
	SEkXS4nHme3IGGzeFHRAYGEjR0O3swgv1Qkt8JvShEBkeuuMpbLvTZVFsheD3g==
Message-ID: <ebbdf2e9-932f-4a7c-9c6e-3c8c80a3b524@bootlin.com>
Date: Mon, 12 Aug 2024 09:22:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
 <20240806-convert_cgroup_tests-v2-4-180c57e5b710@bootlin.com>
 <5f91072d-fd63-4d81-8442-ef7aa62e192f@linux.dev>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <5f91072d-fd63-4d81-8442-ef7aa62e192f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Martin,

On 8/10/24 01:53, Martin KaFai Lau wrote:
> On 8/6/24 12:55 AM, Alexis Lothoré (eBPF Foundation) wrote:

[...]

>> +    SYS(fail, "ip link add dev %s type veth peer name %s", VETH_1, VETH_2);
>> +    SYS(fail, "ip link set %s up", VETH_1);
>> +    SYS(fail, "ip link set %s up", VETH_2);
> 
> Same. Do it under a new netns.
> 
>> +

[...]

>> +    if (setup_network(&t))
>> +        goto cleanup_progs;
>> +
>> +    cgroup_fd = cgroup_setup_and_join(CGROUP_PATH);
> 
> cgroup_fd is leaked.

ACK, I will prepare a new revision with all the leaked file descriptors you have
spotted fixed, and with tests performed in a dedicated netns.

> Thanks for working on this.

Thanks for the review !

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


