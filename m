Return-Path: <linux-kselftest+bounces-29056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F08A615EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 17:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965B61B64E46
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53F202F8F;
	Fri, 14 Mar 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZEg4Jipu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9F202C49;
	Fri, 14 Mar 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968523; cv=none; b=TRozUtDC970tPPoccpyHeftudpYI52CJfHuaswNs2nshTI2ssMn810NQeIOpfyW5erVv24Nzv+sfCrChWfbZ4sYjKo93Tbdc40ZnHmzFegCBQbKklh3OaR+rZx9/PSTL4bdo/LE1djZh48SD+uik0S2IFCZ4KY6HVM6nTY1M4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968523; c=relaxed/simple;
	bh=ow/xM2BzJY15oFxKt4B5fKNXKa5WQC08GFensnmTqlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayxa0EgIUAIAvKM0AZbqAc+6ZTEMw9r/eRVRpZg/93+0azvVPeYOv+uqiVQgcqSbg+ZRIzBQSDFp0FwAXgnB/iknqCykalp37BBmEzNGIjoPbrDoIadc7eFimvueX0sk4u/fiwmCrZPghXbG1hf9dlufsRLa9seMRLuXIaKTttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZEg4Jipu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8623744287;
	Fri, 14 Mar 2025 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741968513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc5lGmMpmWaulKCgFmVYIGp/S0/wgDgZkGe6mPR+/0w=;
	b=ZEg4Jipu4DRz6VRl88DhD8Pbqq2RVPR4SJqaKqAGCMWDDtk0SPmWJWpzRl5v55zdrTgJyF
	PG9Dm9yyQcFXRFhGD6NvHNrAOPaxlZD/1IeNhA5aj/mYVR2ZJHMgAC05z70rAvPGCaHWDx
	pQvu/ESRIT2rPtl/glUZwLJ25qgX/jYv/Itqe+s+Sp4PwAQGB5agKr6tR9adFOYTCb88jE
	0cMGwZeQNPHh0QGxkV0cd9zEADQuRK4npdhppBsfRMygbQpOue50xkxIJHUrbxGQ1D1i7X
	4uYYKMGSUKXllUfwcnPZdVB871JKGDol68DQ5i9FN2NEys8CHSESOYMsOIE99w==
Message-ID: <a8c7e353-2e5f-4cdc-99fb-0937b8121b38@bootlin.com>
Date: Fri, 14 Mar 2025 17:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] selftests/bpf: Integrate test_xsk.c to test_progs
 framework
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
 <Z9RPNzJtBgheiTeS@boxer>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z9RPNzJtBgheiTeS@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheeggfetffekheevuedvkedvvdeufeegjeevgfelveevveetffevfefgheeijeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepmhgrtghivghjrdhfihhjrghlkhhofihskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrghhnuhhsrdhkrghrlhhsshhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrlhgvmhhonhesghhmrghilhdrtghomhdprhgtphhtthhop
 egrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Maciej

On 3/14/25 4:45 PM, Maciej Fijalkowski wrote:
> On Thu, Mar 13, 2025 at 11:47:58AM +0100, Bastien Curutchet (eBPF Foundation) wrote:
>> Hi all,
>>
>> This patch series continues the work to migrate the script tests into
>> prog_tests.
> 
> Hi Bastien,
> 
> the sole purpose of this is a cleanup of some sort?
> 

The goal is to have more tests run by the CI and fewer standalone 
scripts so that regressions are spotted more efficiently.

>>
>> The test_xsk.sh script tests lots of AF_XDP use cases. The tests it uses
>> are defined in xksxceiver.c. As this script is used to test real
>> hardware, the goal here is to keep it as is and only integrate the
>> tests on veth peers into the test_progs framework.
> 
> We're doubling the functionality for no additional benefits? Or the
> benefit of this set would be the veth xsk tests execution within BPF CI?
> 

Yes the benefit would be the tests execution within BPF CI.

>> Three tests are flaky on s390 so they won't be integrated to test_progs
>> yet (I'm currently trying to make them more robust).
>>
>> PATCH 1 & 2 fix some small issues xskxceiver.c
>> PATCH 3 to 9 rework the xskxceiver to ease the integration in the
>> test_progs framework. Two main points are addressed in them :
>>   - wrap kselftest calls behind macros to ease their replacement later
>>   - handle all errors to release resources instead of calling exit() when
>>     any error occurs.
>> PATCH 10 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
>> tests available to test_progs
>> PATCH 11 enables kselftest de-activation
>> PATCH 12 isolates the flaky tests
>> PATCH 13 integrate the non-flaky tests to the test_progs framework
> 
> I didn't bisect but this set breaks the HW tests for me which *is* what we
> care about. I'll dig onto that on monday and will get back to you.
> 

Ok, thank you. Can you tell me what hardware you use please ? If by any 
chance I have the same HW somewhere in my office, I can try to reproduce 
on my side.


Best regards,
Bastien


