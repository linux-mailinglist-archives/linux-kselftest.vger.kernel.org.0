Return-Path: <linux-kselftest+bounces-25082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC8A1B373
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C6A3AB72A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344421A44D;
	Fri, 24 Jan 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eX/fQkYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FD1D63C5;
	Fri, 24 Jan 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714351; cv=none; b=Y7GCgWkbKOxmRmat0jn8rRW5VqmvFuNujvXVTKXAnzu3tyMrh64uL8CUBcvodWOOzlAzqGY7wIRCzdczIpprU6qpkqrbNAfYi0AVl5775j9xtTjItqOIkBIRcmJJx4ULstAnX+OJD58cuk4Eu4jlZ7RMGspcPqc7GAPdAAH0nLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714351; c=relaxed/simple;
	bh=1tKSOU2jBWy3i7dXol9gvJP5/Csa3T3P2R2QjVzrxBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/tz1OYjCrzuYM5YnqcIDfLKA9GDNdAeifxIdTqCWiAtNNIABbZVL0KnC46DePHjbqhhUO5c2nWRFCBwbpLbvHQRyZCFxtQozHsD12qcAheqgS5uSoDgz0UP7KOc73zcneTZEjrLuJnjR30Gr43/GlHK14hQbY1HvEMH0MGo9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eX/fQkYI; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A8B41C0009;
	Fri, 24 Jan 2025 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737714346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fCdfHN1q0kTW8w9eBXyqkbB49ohSJygSeTX0zRNxMc=;
	b=eX/fQkYI4sPkIdHLonL+h8QsP4lkstETFRQ15x32KAdXejGjKBs+ugw0BP8oYVRF5icbST
	TDE8YW/60SuO+hqmNHJf4V0Uo5klTe32s07+rLxa/ydjjdtdRMctIQpz1kSkvWYNAtgnhO
	e+pr+NDCK9Bj0SK+/JWm4LCEMv88ETdBbEw27e0QXvW6m0ksunFbd9GAuoHYqhlxAoFxAw
	TB3bAli5qWbeuRM2UM0BTxj/6gLT6Lyay+Upcx1jVxfWYR3uEutQpNrYQlLHGeJA6cB93o
	jwfwBwUb98nPaf0NGG8skcyHrxjyaDINq3HvcHKNnR2DQAg958H5U/97h0HfUQ==
Message-ID: <b00deb3a-175a-4d04-9fc0-d71d317ad86e@bootlin.com>
Date: Fri, 24 Jan 2025 11:25:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/10] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
 <Z5KcP_rJw4Iv5tKp@mini-arch>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z5KcP_rJw4Iv5tKp@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Stanislav

On 1/23/25 8:45 PM, Stanislav Fomichev wrote:
> On 01/21, Bastien Curutchet (eBPF Foundation) wrote:
>> Hi all,
>>
>> This patch series continues the work to migrate the *.sh tests into
>> prog_tests framework.
>>
>> test_xdp_redirect_multi.sh tests the XDP redirections done through
>> bpf_redirect_map().
>>
>> This is already partly covered by test_xdp_veth.c that already tests
>> map redirections at XDP level. What isn't covered yet by test_xdp_veth is
>> the use of the broadcast flags (BPF_F_BROADCAST or BPF_F_EXCLUDE_INGRESS)
>> and XDP egress programs.
>>
>> Hence, this patch series add test cases to test_xdp_veth.c to get rid of
>> the test_xdp_redirect_multi.sh:
>>   - PATCH 1 to 5 rework test_xdp_veth to make it more generic and allow to
>>     configure different test cases
>>   - PATCH 6 adds test cases for 'classic' bpf_redirect_map()
>>   - PATCH 7 & 8 covers the broadcast flags
>>   - PATCH 9 covers the XDP egress programs
>>   - PATCH 10 removes test_xdp_redirect_multi.sh
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>> Changes in v2:
>> - Use serial_test_* to avoid conflict between tests
> 
> Do I understand correctly that we want them serial mostly because of the
> hard-coded namespace names? If yes, might be a good idea to follow up
> (separately) with a way to generate unique name for each subtest and
> unserialize them.
> 

Yes, that's it. Ok, I'll send a V3 with random namespace names.

> (If you have time/desire, I think there is a bunch of similar cases
> where we have to serialize tests, might as well undo that).
> 

I'll try to look at it.

> I looked briefly through the series, looks good:
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>


Best regards,
Bastien

