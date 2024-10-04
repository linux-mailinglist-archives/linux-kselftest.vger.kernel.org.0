Return-Path: <linux-kselftest+bounces-19008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDB98FD44
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD32B223F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D88289E;
	Fri,  4 Oct 2024 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d6g66t3i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B54DA00;
	Fri,  4 Oct 2024 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023045; cv=none; b=gY/Xt+4KoGngRSDCKSKRE4xVI9BFED3b56dmSLmXmSbsH2AmWPMEEc8sjj/a743BdVTJjGjeOb6gmEeHAsaZ32rcOkqBjMYOblYfDZZxSO4JBHzUQUp0lALnz4+94oDcAU6iNLmNHWn7l45+VcrQLbiaJuyTNimkjBmeawh3eZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023045; c=relaxed/simple;
	bh=HvkxK1aTVBWtEPE6QbXJJ7jlS4gRi5139c+pO4Kp4zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUtyIKpjoZUxaMcYVx1Vn6OucU0iUr711zHfBnJZQw/wSGY7yvJwkGZI/ig+FWmpKVU4uRrDjmcB0KA/GmUITpJkl9pG5g3+rFWjCaR7DMAQHHuDJJO2v1Zaz9WZMSc0cO6Ce1FqMBJDbrekIT8jCWUYAVG7byS3+7a9tcwe9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d6g66t3i; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6793FF802;
	Fri,  4 Oct 2024 06:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728023034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03W9nGxDFHr9kO1XmOKBkDSteAW+ydtDQleISvuWWCk=;
	b=d6g66t3ipiiFrIVhtdhw4UAkXa/n2n9VnL5Jnjqe5xUr6SEykqyOiY04TLUzM6qoRrY3q3
	1B1CDCdg+7V6rO+Nkl5g6yEpcatu0Nh5j/T2KlnGAKI+AZMoDiRyZQeL/imcglgPYwfbCN
	IGzxg859wHPXJgHRUO99BAh0xKZpUHyQcUh7dsXFqajJ2nxQq+0WiDfeJm1awZmsGNUieU
	zcqCZ0had7VD0LU0YgNT/gxRApe7IE9MhGVdjx1+1sr7YMqMuMa8ejV+0efDgWxsLW+Iiw
	a1rAevU5pjsCA+T8pdIQcBYYkI4KYGY7fPS0WaFbn0xFFqXNUd4prpZL+ZOTwA==
Message-ID: <24611a2f-ff5a-47e4-af48-9faad03273d3@bootlin.com>
Date: Fri, 4 Oct 2024 08:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev> <ZuVWmxoqXFI3qvVI@lore-desk>
 <20240914063828.7bd73c5e@kernel.org>
 <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
 <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
 <6d23b607-b6d6-4074-8778-c50bf3bd0b91@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <6d23b607-b6d6-4074-8778-c50bf3bd0b91@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 10/4/24 06:44, Martin KaFai Lau wrote:
> On 9/24/24 6:37 PM, Martin KaFai Lau wrote:
>> There are other .sh tests that could better use the test_progs migration. In
>> particular the ones without existing test coverage. For non XDP related,
>> test_tcp_check_syncookie.sh, test_flow_dissector.sh, and test_tc_edt.sh should
>> be the good ones.
> 
> I just took a closer look at the test_tc_edt.* for another reason. It seems
> doing some bandwidth test which may not be a good fit (e.g. too flaky) for
> test_progs. I would leave it to the bottom of the todo list for now.

ACK, thanks


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

