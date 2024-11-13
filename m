Return-Path: <linux-kselftest+bounces-21943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978089C7370
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CB21F24D19
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496B1E1C38;
	Wed, 13 Nov 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z6/yPpxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFD1E1322;
	Wed, 13 Nov 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507832; cv=none; b=AV3s7jxXpTPwifGEnEcLZRmf1t06sG/9IMN0/x1uXemBkGixcSOfQurnYTeLl+ar1LFnE79MBbrKCvbIkLiFOXPRAKWSZpy/ROA/YX5qIZYqfpe3Reydba7i1od42vDEjtaXl/3k4WhbxOL8BOPOtBLj9OiheUmpRFR8z5NZs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507832; c=relaxed/simple;
	bh=d8POk7xbKhNdWGzyRLJZnpVRICiROte3+YRg3a6qLQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaSv+JmbLEPe9VUDCkNNG0dWwqW8Hw0PKhpYiEzJi1PgbkkR0mtCDu7nX+czMSTGDdHy1ac6ZzhpU5jDUn9CDH7GQ9IaZs9PCM0ui+yAoG//srqyZ+t0KpJ1JgxhFgkReulw0dRtPHwKzc3xS3KdclL9uaMtnHlk1YXJtoLWvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z6/yPpxA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73DF560004;
	Wed, 13 Nov 2024 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731507823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sxNK0rhgT+2VzUsyuFVQ0BrXwd9XqZVPxbwj0Rf4ds=;
	b=Z6/yPpxA6DySdbsDv7eDZQvgJjelRmSnM8IE8qxigJY1imiRjCgIMdTtaGhARTs5CY7TTM
	3JvIWFVyfHWdBVYN6feWo01fnxfo1vS/cr026S8tDJzLYRRl8cTuef8VdMWCoOFl0FF0ek
	60If+k6wZzSSFOxpNP4bPbr2sSoObwRPc+UXqjIeDQqVYRAUxPtFJuHdUBuUIqHV4Xwtlr
	MeuIWJ4o7R8b2dOBfQbODP7cp3KkL5tJj2/HeR4Oj+t7YAWWJ0pPYFprV4awxUx3ZE3Fm3
	h449Nd9/y9j3INuWRIkYoC4x+9p7KXidbX2C3Ksu+RbvcdpXop3Ke3WjBxJYYA==
Message-ID: <4f68d104-b96d-4726-a94d-1123765393c6@bootlin.com>
Date: Wed, 13 Nov 2024 15:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/10] selftests/bpf: migrate flow_dissector
 namespace exclusivity test
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-7-27c4df0592dc@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20241113-flow_dissector-v1-7-27c4df0592dc@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/13/24 14:53, Alexis Lothoré (eBPF Foundation) wrote:

[...]

> +	ns = open_netns(TEST_NS);
> +	bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
> +	close_netns(ns);

I would like to mention that I initially planned to directly delete the
namespace to perform the test cleanup, assuming it would be enough to consider
any non-root namespace flow_dissector to be removed. However I observed that it
made other tests dealing with flow_dissector starting to fail with -EEXIST,
despite all those tests being marked as "serial". I started examining this,
suspecting a real issue (a race between namespace deletion and flow dissector
attachment check, or a ns refcount issue) but before going further: is my
assumption right ? Should a mere namespace deletion be indeed enough to remove
the corresponding bpf flow dissector ? Or am I missing something ? If so I'll
keep examining this.

> +out_clean_ns:
> +	remove_netns(TEST_NS);
> +out_destroy_skel:
> +	bpf_flow__destroy(skel);
> +}
> +
>  static int create_tap(const char *ifname)
>  {
>  	struct ifreq ifr = {
> 


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

