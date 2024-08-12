Return-Path: <linux-kselftest+bounces-15158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77294EA4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE77B28231A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1B16DEBA;
	Mon, 12 Aug 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kEt5DQJ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9A16DC05;
	Mon, 12 Aug 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456275; cv=none; b=Yr0rOJl3p936TCmYoTj8hMFYDCqwnh0w7J8FH+klSL2Hoa4MlhzuC/eFmGIHUB3NCvqZ01/+mTzdISRHWWijXAge88L4+zllouRvJo6P9UwHLRCYdNXL4NGwv4gow2tw6cYwz+RoqoxN6o/lmkP6WWSnOicZ773izMouJyQG+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456275; c=relaxed/simple;
	bh=N39pImIulu0yWXn8R68y+7zRjcDs45zt4/rjKD8+G50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgzAnojU3rYm78DdaDX/SulKvwR6Z5+wIkxiv0Yjt4CUaGX/VMvz/mt+nYv78uuKNr8kRRnzFunJo7y1uuai5YjMNAACLyS1EF9v/m8nWD13gw1yVPHFeU98AckBHyaqGI7L5FeM0A9+KK/kqR+/q/cYUSnUlttxz6V4umts9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kEt5DQJ4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D336FC0006;
	Mon, 12 Aug 2024 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723456271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOLs8cJ464OCDM3eZnzqLL9Zk7yzPtLClQiYQw/1gFA=;
	b=kEt5DQJ4JinzAjwIznC2iCvD2dB/wa48T3Pl8vqE0J+10kKcm3LtHL1CAa3wvqf4CXvS5c
	fDX5SzcUpITYGzMCv0JTq/PVvUVnakfYcNLfFy0+Xziir6cJgJdHPF3WaNZuDs12V5K5Ty
	9yFRyy45BxtQYppLmjFu1Du6azVbS6TL1AmfTvW1+5lmseYRe79ofU7DZBffojNxVIfbkK
	/m+aNm50gNiGtQ/BlIbz9sCzktfuK8cqCAjRNk4GzoBnfQSZ3Mgms4ak7sDtkPG26pZ076
	KYIfIZ7qXkV6SJLui2vACcEq5a9h6qKRCqQIFYkdjdKY4wV6l/t0yKRc6qbKIQ==
Message-ID: <eb36ce16-3711-4388-9ebf-bc29577f6626@bootlin.com>
Date: Mon, 12 Aug 2024 11:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: convert three other cgroup
 tests to test_progs
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>
References: <20240812-convert_cgroup_tests-v3-0-47ac6ce4e88b@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240812-convert_cgroup_tests-v3-0-47ac6ce4e88b@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/12/24 10:58, Alexis Lothoré (eBPF Foundation) wrote:
> Hello,
> this series brings a new set of test converted to the test_progs framework.
> Since the tests are quite small, I chose to group three tests conversion in
> the same series, but feel free to let me know if I should keep one series
> per test. The series focuses on cgroup testing and converts the following
> tests:
> - get_cgroup_id_user
> - cgroup_storage
> - test_skb_cgroup_id_user
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

So I messed up during the testing step for this revision and broke one of the
new tests. Sorry for the noise, please ignore this revision.

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


