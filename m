Return-Path: <linux-kselftest+bounces-38750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F5B21CB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD143A3217
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1773254B19;
	Tue, 12 Aug 2025 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S2MSZPmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF71A23A0;
	Tue, 12 Aug 2025 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975219; cv=none; b=TCNpSqxJpJYqRxA6F9PYBwN45oaxA53JVk9VlcV3xJKnepLvZXln7UnWzpk69gQPfv8bFCritAB7TqVNVQDu+ndxhKg7GABvhTSSxSRYR9O8DGRYqmTmm1Z5v6mTDXrNm6lFPFTP+WKBhKKXh+izelFjtumD/3uZa0NrUumcQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975219; c=relaxed/simple;
	bh=qzVMo1WgyTXRBw5BdkypFwKd0kf79Gz8I/cwaICkaU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y54apthJ8LU20XwK2DX3H2YeZmQwehd3QyAXIbWB0/zaT/HA1xmTujzPaY2RZZBTu+naKT3m1KsTnrFHd39hQX4AZR/WFCCK6zJ4XCt2oc6IKxQn5ilQHjHRyMjE7KU1gSy629MC40HECGmSETIYKyA5+Oj5vjIgGFeKzclP7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S2MSZPmk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f6d16c1-0e85-4709-9846-3a993a9f041b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754975205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqkxaEPaUpXKccanb3XhMWBKg2KHwbdd27DbF8Wj048=;
	b=S2MSZPmktdn+SG+bHMOcwANRkPJHXz9WO7paj/TgIuG+pwXkAnLjf72DTnxH1CQa17sbrF
	vfYQi8rav94K1u6F2Ppv/9aNF5rEtHlTBZhBf5ttEop6hz7pBFcm2zSzQmf9uH8sr7NZZX
	nTc/cCGbf2NDV+6Ndq+lZl/pbXpYC30=
Date: Mon, 11 Aug 2025 22:06:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
Content-Language: en-GB
To: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com>
 <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
 <30d8fcac.2669.19882763de2.Coremail.phoenix500526@163.com>
 <e7ba3f7f-38b8-4c06-8aff-ef1fb8d04d86@linux.dev>
 <310495cd.19eb.19893314d03.Coremail.phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <310495cd.19eb.19893314d03.Coremail.phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/10/25 1:55 AM, 赵佳炜 wrote:
>
>
> Hi Yonghong,
>
> I found another issue where symbols can be duplicated, and I’m not sure how to tell them apart.
>
> For example, I created two C files named usdt_rip.c and hello.c. Both define their own static ti variables, like:`static volatile char ti = 0;`.
>
> After compiling, I obtained an ELF file usdt_rip whose .symtab contains the following entries:
>
> $ readelf -s usdt_rip
>
> Symbol table '.symtab' contains 42 entries:
>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>       1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS Scrt1.o
>       2: 000000000000038c    32 OBJECT  LOCAL  DEFAULT    4 __abi_tag
>       3: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS usdt_rip.c
>       4: 0000000000004021     1 OBJECT  LOCAL  DEFAULT   25 ti
>       5: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
>       6: 00000000000010a0     0 FUNC    LOCAL  DEFAULT   14 deregister_tm_clones
>       7: 00000000000010d0     0 FUNC    LOCAL  DEFAULT   14 register_tm_clones
>       8: 0000000000001110     0 FUNC    LOCAL  DEFAULT   14 __do_global_dtors_aux
>       9: 0000000000004020     1 OBJECT  LOCAL  DEFAULT   25 completed.0
>      10: 0000000000003df8     0 OBJECT  LOCAL  DEFAULT   21 __do_global_dtor[...]
>      11: 0000000000001150     0 FUNC    LOCAL  DEFAULT   14 frame_dummy
>      12: 0000000000003df0     0 OBJECT  LOCAL  DEFAULT   20 __frame_dummy_in[...]
>      13: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS damo.c
>      14: 0000000000004022     1 OBJECT  LOCAL  DEFAULT   25 ti
>      15: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
>      16: 00000000000020d8     0 OBJECT  LOCAL  DEFAULT   19 __FRAME_END__
>
>
> As you can see, there are two ti variables in the .symtab section. Their values are very close, making them hard to distinguish.
>
> I’m unsure how to handle this situation. Do you have any suggestions?

Did you check relocations? Relocaitons should be able to point exact which symbol.

>
> Thanks,
> Jiawei Zhao
[...]

