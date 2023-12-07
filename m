Return-Path: <linux-kselftest+bounces-1334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266D807E8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 03:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82C4B21140
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0C36D;
	Thu,  7 Dec 2023 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tOpou7Zj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA0D7D
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 18:32:58 -0800 (PST)
Message-ID: <544aad70-0492-496c-8747-ff6b2a204b3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701916375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaTAr3n1Zo+WQ9fxFhHx7mUs6gY/pefswV7mSrJu1Fs=;
	b=tOpou7Zj9UjoYiMxw+NoscyXn9cK0IYzeHsVMBiOwD0nec5YxQ0rQp1TMC3hIXUIaThmev
	3teqqT5qXRJE6u4ptQpmA4CSU0IX5NLOj/w1+HipZklpBVwLWh2sccQ9nW3H7/ZZUQi1TE
	I3tnOXYu5KHOJvs4ymbxt3WpxqT6fZ0=
Date: Thu, 7 Dec 2023 10:32:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
 cerasuolodomenico@gmail.com, sjenning@redhat.com, ddstreet@ieee.org,
 vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, chrisl@kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev>
 <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
 <CAKEwX=M8YThH8qOdHt5TV1E4PCiw2FSv7815O3fhqXNVMt5ezg@mail.gmail.com>
 <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2023/12/7 03:47, Nhat Pham wrote:
> [...]
>>
>> Hmm so how should we proceed from here? How about this:
>>
>> a) I can send a fixlet to move the enablement check above the stats
>> flushing + use mem_cgroup_flush_stats
>> b) Then maybe, you can send a fixlet to update this new callsite?
>>
>> Does that sound reasonable?
> 
> I just sent out the fixlet. Yosry and Chengming, let me know if that
> looks good. Thank you both for detecting this issue and proposing the
> fix!

Yeah, also looks good to me. Thanks!

-- 
Best regards,
Chengming Zhou


