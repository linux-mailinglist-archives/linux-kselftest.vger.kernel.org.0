Return-Path: <linux-kselftest+bounces-45685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2CC5FF77
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 04:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87F0E4E4605
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 03:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619D233134;
	Sat, 15 Nov 2025 03:43:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851B21322F;
	Sat, 15 Nov 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763178213; cv=none; b=lT94Y+LFp+K+EuY+VSJnHiFA7GeyHF+jsXRiyrW9CLEw1/C+wfRmtA0kuIcUtJhiTCjqUY///SnzRLc4XYBn+kWwSWExcdR9fsO+koWm59xzSAmcprDZC0P1EJCjvrA6KjsNUh3V6pOh2xaQc9P2zussxs+1p/YpYCYzvTjtKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763178213; c=relaxed/simple;
	bh=AiWXujPQ04Yxz29lTc7t34+mHLsOGO5fR5Xm9tgyWmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1AR1FMBTZnAfANdCpgqfk2ny/MUwwETQwnTXlSJA5Y7LGTvNHFuriXkB336F0lLDq9jmk+iW7P7HA5uw/vhacr+thPKl8M03lQ4FrKzxzM+YtaI0VrKIUWPqdCqIwq7dJuXl56vXPQRo0MamYPhB/tpieRrC0RtWIjqeik3FNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cab0520c1d511f0a38c85956e01ac42-20251115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:32808797-364d-407e-ab3c-c7abec898b65,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:32808797-364d-407e-ab3c-c7abec898b65,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:1aa8b991e1503b29d3837da6fb433775,BulkI
	D:251113184535IYNM5ZGZ,BulkQuantity:5,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3cab0520c1d511f0a38c85956e01ac42-20251115
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1973445955; Sat, 15 Nov 2025 11:43:23 +0800
Message-ID: <9eddc66c-4a95-4692-889b-de9f06726a7f@kylinos.cn>
Date: Sat, 15 Nov 2025 11:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebastian.chlad@suse.com, longman@redhat.com
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
 <6916a8f5.050a0220.23bb4.ab7dSMTPIN_ADDED_BROKEN@mx.google.com>
 <4h54pkcisk5fmevglu3qldk5fb2rgo5355vfds3wplhekfumtz@qtwtixmuw2hz>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <4h54pkcisk5fmevglu3qldk5fb2rgo5355vfds3wplhekfumtz@qtwtixmuw2hz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/14/25 22:32, Michal Koutný wrote:
> On Fri, Nov 14, 2025 at 11:55:48AM +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
>> Actually, selftests are no longer just something for developers to view locally; they are now extensively 
>> run in CI and stable branch regression testing. Using a standardized layout means that general test runners 
>> and CI systems can parse the cgroup test results without any special handling.
> 
> Nice. I appreciate you took this up.
> 
>> This patch is not part of a formal, tree-wide conversion series I am running; it is an incremental step to align the 
>> cgroup C tests with the existing TAP usage. I started here because these tests already use ksft_test_result_*() and 
>> only require minor changes to generate proper TAP output.
> 
> The tests are in various state of usage, correctness and usefulness,
> hence...
> 
>>
>>> I'm asking to better asses whether also the scripts listed in
>>> Makefile:TEST_PROGS should be converted too.
>>
>> I agree that having them produce TAP output would benefit tooling and CI. I did not want to mix 
>> that into this change, but if you and other maintainers think this direction is reasonable, 
>> I would be happy to follow up and convert the cgroup shell tests to TAP as well.
> 
> ...I'd suggest next focus on test_cpuset_prs.sh (as discussed, it may
> need more changes to adapt its output too).
> 
> Michal
Yes, I agree that test_cpuset_prs.sh should be the next focus.
Thanks again for the guidance.

Guopeng


