Return-Path: <linux-kselftest+bounces-45632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF5C5C442
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7CAE354D46
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B943054D7;
	Fri, 14 Nov 2025 09:19:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82B30215D;
	Fri, 14 Nov 2025 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111958; cv=none; b=RacRQBIRgAh3AVvu0naCKt4BnGiYE7/5yE4UfeiqHVZyelfu2nQfOY2RKw5J+OzsRjJnUsULVOnpyPMjibnrTbQSkpW/O+XRsW6mYP/N22Ux+QNPFGGhzft2kBXGwhJAd3tsa77Ugorkry+Ll7+0QtwyMX2BoZQykbyXqn5A5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111958; c=relaxed/simple;
	bh=D4OkPFQ2eTQeHzIKv1g312Zn05yoLrzXJ7pSWXHVsVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt4oRJO/pJehUHT8ziAtaI4w5iDpAfjB4lxTrGtoyNi3zggsNfOvIKAA0szyVBckKJyKpoBr2QjgBAwVXjYdzZWayyazvT833MsEM+y/opI9chDB83DQJCjQ02uIMtAjovLoSNTjXxAPLqaw0AKCiTZHo3Y2Hppz3EH1k2T5G4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f84076d0c13a11f0a38c85956e01ac42-20251114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:33a85a89-58c0-4279-aa61-a08f5896d271,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-INFO: VERSION:1.3.6,REQID:33a85a89-58c0-4279-aa61-a08f5896d271,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:11
X-CID-META: VersionHash:a9d874c,CLOUDID:dfabb8f72b851ee1ab9a7d64679c66e7,BulkI
	D:251113184535IYNM5ZGZ,BulkQuantity:3,Recheck:0,SF:19|64|66|72|78|80|81|82
	|83|102|841,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f84076d0c13a11f0a38c85956e01ac42-20251114
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1806708038; Fri, 14 Nov 2025 17:19:06 +0800
Message-ID: <d3dd2dbc-ec02-48c4-952a-2b9d6a1bf9b8@kylinos.cn>
Date: Fri, 14 Nov 2025 17:19:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
To: Sebastian Chlad <sebastian.chlad@suse.com>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
 <6916a904.9d0a0220.2b5e5.0b79SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAJR+Y9LG+qrvDdbufNpBqW4+8oPBrmY3eABJzXBm9Y_DPN4XLg@mail.gmail.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <CAJR+Y9LG+qrvDdbufNpBqW4+8oPBrmY3eABJzXBm9Y_DPN4XLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/14/25 15:04, Sebastian Chlad wrote:
> On Fri, Nov 14, 2025 at 4:59 AM Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
>>
>> Hi Michal,
>>
>> Thanks for reviewing and pointing out [1].
>>
>>> Could you please explain more why is the TAP layout beneficial?
>>> (I understand selftest are for oneself, i.e. human readable only by default.)
>>
>> Actually, selftests are no longer just something for developers to view locally; they are now extensively
>> run in CI and stable branch regression testing. Using a standardized layout means that general test runners
>> and CI systems can parse the cgroup test results without any special handling.
> 
> I second that.
> In fact, we do run some of those tests in the CI; i.e.
> https://openqa.opensuse.org/tests/5453031#external
> We added this: https://github.com/os-autoinst/openQA/blob/master/lib/OpenQA/Parser/Format/KTAP.pm
> to our CI
> but frankly the use of the KTAP across the selftests is very
> inconsistent, so we need to post-process some of the output files
> quite a lot.
> Therefore the more standardized the output, the better for any CI.
> 
Hi Sebastian,

Thanks a lot for the details and for sharing the openQA links and the KTAP parser.
That context is really helpful.
> Small ask: should we amend the commit message to say KTAP?
> 
Good point about the naming – I’ll respin this as v2 and amend the commit
message to refer to KTAP rather than just TAP.
> That being said - the cgroups tests produce nice output which is easy
> to parse and gives us no issues in our CI apart
> from the shell tests, specifically test_cpuset_prs.sh.
> 
> We currently run the cgroup tests only internally because some of them
> tend to fail when crossing resource-usage
> boundaries and don’t provide clear information about by how much.
> That ties into my earlier effort Michal linked here::
> https://lore.kernel.org/all/rua6ubri67gh3b7atarbm5mggqgjyh6646mzkry2n2547jne4s@wvvpr3esi5es/
> 
> I’ll try to add the cgroup tests to the public openSUSE CI and will
> test your patches.
> 
It’s also great to hear that the cgroup C tests already integrate reasonably
well with your CI. Once this change settles, I’d be happy to follow up with
patches to convert the cgroup shell tests, in particular test_cpuset_prs.sh,
to KTAP-style output as well.

Thanks again for trying the patches in the openSUSE CI and for the feedback.
>>
>> TAP provides a structured format that is both human-readable and machine-readable. The plan/result lines are parsed by tools,
>> while the diagnostic lines can still contain human-readable debug information. Over time, other selftest suites (such as mm, KVM, mptcp, etc.)
>> have also been converted to TAP-style output, so this change just brings the cgroup tests in line with that broader direction.
>>
>>> Or is this part of some tree-wide effort?
>>
>> This patch is not part of a formal, tree-wide conversion series I am running; it is an incremental step to align the
>> cgroup C tests with the existing TAP usage. I started here because these tests already use ksft_test_result_*() and
>> only require minor changes to generate proper TAP output.
>>
>>> I'm asking to better asses whether also the scripts listed in
>>> Makefile:TEST_PROGS should be converted too.
>>
>> I agree that having them produce TAP output would benefit tooling and CI. I did not want to mix
>> that into this change, but if you and other maintainers think this direction is reasonable,
>> I would be happy to follow up and convert the cgroup shell tests to TAP as well.
>>
>> Thanks again for your review.
>>
>> Best regards,
>> Guopeng
>>
>>


