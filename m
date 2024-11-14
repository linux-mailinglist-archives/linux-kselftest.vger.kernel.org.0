Return-Path: <linux-kselftest+bounces-22009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FC9C846A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D8B2603D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB01F6695;
	Thu, 14 Nov 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gadMZCrv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858A1F6677;
	Thu, 14 Nov 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571113; cv=none; b=nDXtcUd2SMqDYakJTh9YaqnXnukz+6NDpCbULdcoqK+BUoCJJ8hy7CdsXWMOKAHss735Vg3ln4ITLWcdN/N/JdeQda+kS1siqs2dwbjtDEy3Row7QbSiTuM69jCXcf7cWqNDSPge6yYAHdu06WYxuumL6dePiG763pahn3wHr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571113; c=relaxed/simple;
	bh=nqv8HEdaBU0IP7QsnYlgk/mACzsy/tnF+QkVxY6LcuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1iJyFlEAcR/p4qIpeT7wCG+mzzQJOtnXkrul3btH891h1vnXUanXLhO2JCErBdNZ3GPWJbjp/C/of6XJ3AGewWF9mizeqXX3OHtQ+ej3AcgFq6E+nu+zlzGPBY3fqQkqjsjzXTGlKvdP/S5R2elPjhLkMxbKvrtB7RFxJ9KllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gadMZCrv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13F19C000A;
	Thu, 14 Nov 2024 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731571103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysQrhcWbVbYCLnOMe9bh7W1OYGiNtH+HKZH2UEpzyuE=;
	b=gadMZCrv5ooH9C8NDSspq86nJJL83iJn//hnkZ44t9hhKNQbFL/PrIkNOFKfnI2e7qBwDN
	B6K2JweEHUZ/n8clUetsniuUk5JAh2GoictYb9RDlAomxUx/8mDUkKZUSkRoHicgUEHZlI
	5hBCzMIp6WM5GUAvkVwofw7+AVvQZPhjdiPF4JYhD8/dKL+7Pp3eA7Mx3ulplzzyZQQSDH
	NBeEhTn4CCnNZK8D/HsuLjHWHyLpcTqLQ3ud8fXLqlZTaZ0HQw3dS6rTXka4rcLdDSnR6P
	4sL8OQm/TAd1gQY6mwHomdSeMxs522VSJV8bYyL2LI2GnbPDAnvRZV00qG/NSQ==
Message-ID: <2fefeddf-c426-4a3f-90ae-64e01fc7a557@bootlin.com>
Date: Thu, 14 Nov 2024 08:58:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/10] selftests/bpf: migrate flow_dissector
 namespace exclusivity test
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-7-27c4df0592dc@bootlin.com>
 <4f68d104-b96d-4726-a94d-1123765393c6@bootlin.com>
 <ZzTm7wKsOLuI5w20@mini-arch>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <ZzTm7wKsOLuI5w20@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/13/24 18:50, Stanislav Fomichev wrote:
> On 11/13, Alexis Lothoré wrote:
>> On 11/13/24 14:53, Alexis Lothoré (eBPF Foundation) wrote:
>>
>> [...]
>>
>>> +	ns = open_netns(TEST_NS);
>>> +	bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
>>> +	close_netns(ns);
>>
>> I would like to mention that I initially planned to directly delete the
>> namespace to perform the test cleanup, assuming it would be enough to consider
>> any non-root namespace flow_dissector to be removed. However I observed that it
>> made other tests dealing with flow_dissector starting to fail with -EEXIST,
>> despite all those tests being marked as "serial". I started examining this,
>> suspecting a real issue (a race between namespace deletion and flow dissector
>> attachment check, or a ns refcount issue) but before going further: is my
>> assumption right ? Should a mere namespace deletion be indeed enough to remove
>> the corresponding bpf flow dissector ? Or am I missing something ? If so I'll
>> keep examining this.
> 
> Don't think that's expected. Removing a namespace with an attached
> dissector program should (in theory) clearly detach it.

ACK, thanks, I'll keep investigating this then.

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

