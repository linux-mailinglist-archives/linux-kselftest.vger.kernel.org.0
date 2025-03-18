Return-Path: <linux-kselftest+bounces-29359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E73A67753
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944B417A21E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12A20E6F0;
	Tue, 18 Mar 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lr/CZO0A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0320E003;
	Tue, 18 Mar 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310625; cv=none; b=px/QDVq4mHyoBstud8oeRPjbCLJ++8J6gM1Uk5okolaoFnb2hn703mf9hQ2nUMChItKfA7QFEbsL6rS34VUZHRlCjzaiSeSq4ErYT2kfeOORzts1ut9S6nHX7VKk6SyqJhuy+i2xM02hbIDXE7q+8GUw0d6HlJ2wMu1+0w70x2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310625; c=relaxed/simple;
	bh=PJQ45Uc3ZlwUvmPQwTgGNG1XEmjXxIqYjtnNfTcNN8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aii+CUNXrJD6zoUuqLUqA52aoCbCR9P0DfPrwFloJKUmM6urv+tV8Wxyi4Nokep2Shp6dPsoE+Mz0Uz1bQmlAuH/6NEgTqKZlFhkutG/o56COrKdk2NPOUD6RY8u2U3+nlFgaCUubUK2QVmlJ03FsD5Ci/5cLDbcjEKFr+lbf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lr/CZO0A; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6074644401;
	Tue, 18 Mar 2025 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742310615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aqTqXgy5OZ/LDTWoLOWt3ncm07Z6J+uqCOpaod9xeE=;
	b=lr/CZO0AZd8h9Kq6k/HO1L+TIyKG1CVO1n4+7DW0olOpTcPrncnLSZ7okGhXgHy3ZZ/0S5
	vCe2qVt+dviPBPBhv0bTpfAOppbSOY3J+jNjgIP28KymiTftJfS9nKMKSZmM+oFbHxRoF4
	zbvzLXagYYs7JQD7k9heY1OtEf/RBOJCFVYCW9xoBKi2cWVHVuzsY+pXyLBSHvNkIyBCEn
	KEFlMmrrrkvkIGsQM7f5h1Jk7l4kxC3Mk3DeVtpM3NQcgGEScaTMBERYGBzy3M56xIrspj
	cjAl6vArTjzxpdzalR7GKaRg7XISIsc2bBfjsfrbwKsHS+NdKHOaG5ruP/tazQ==
Message-ID: <a965cc31-bbac-43dd-86d4-b2f72e789c92@bootlin.com>
Date: Tue, 18 Mar 2025 16:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] selftests/bpf: test_xsk: Split xskxceiver
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
 <20250313-xsk-v1-10-7374729a93b9@bootlin.com> <Z9lyK5pEi+FmcvYw@boxer>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z9lyK5pEi+FmcvYw@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheeggfetffekheevuedvkedvvdeufeegjeevgfelveevveetffevfefgheeijeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepmhgrtghivghjrdhfihhjrghlkhhofihskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrghhnuhhsrdhkrghrlhhsshhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrlhgvmhhonhesghhmrghilhdrtghomhdprhgtphhtthhop
 egrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Maciej,

On 3/18/25 2:16 PM, Maciej Fijalkowski wrote:
> On Thu, Mar 13, 2025 at 11:48:08AM +0100, Bastien Curutchet (eBPF Foundation) wrote:
>> AF_XDP features are tested by the test_xsk.sh script but not by the
>> test_progs framework. The tests used by the script are defined in
>> xksxceiver.c which can't be integrated in the test_progs framework as is.
>>
>> Extract these test definitions from xskxceiver{.c/.h} to put them in new
>> test_xsk{.c/.h} files.
>> Keep the main() function and its unshared dependencies in xksxceiver to
>> avoid impacting the test_xsk.sh script which is often used to test real
>> hardware.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile     |    2 +-
>>   tools/testing/selftests/bpf/test_xsk.c   | 2416 ++++++++++++++++++++++++++++
>>   tools/testing/selftests/bpf/test_xsk.h   |  279 ++++
>>   tools/testing/selftests/bpf/xskxceiver.c | 2503 +-----------------------------
>>   tools/testing/selftests/bpf/xskxceiver.h |  156 --
>>   5 files changed, 2727 insertions(+), 2629 deletions(-)
>> +
> 
> (...)
> 
>> +int testapp_hw_sw_max_ring_size(struct test_spec *test)
>> +{
>> +	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
>> +	int ret;
>> +
>> +	test->set_ring = true;
>> +	test->total_steps = 2;
>> +	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
>> +	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
>> +	test->ifobj_rx->umem->num_frames = max_descs;
>> +	test->ifobj_rx->umem->fill_size = max_descs;
>> +	test->ifobj_rx->umem->comp_size = max_descs;
>> +	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
>> +	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
>> +
>> +	ret = testapp_validate_traffic(test);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
>> +	 * updating the Rx HW tail register.
>> +	 */
>> +	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
>> +	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
>> +	if (!pkt_stream_replace(test, max_descs, MIN_PKT_SIZE))
> 
> Here's the victim of test failures that i reported last week. This
> function succeds with 0 and you interpret it as failure:)

Oops ... Thanks for the feedback.

> One sign wrong caused two days of debugging, but it was kinda fun.
> 

I should have ordered patches in an other way to split the xskxceiver.c 
sooner, the bisection would have narrowed the bug more precisely. I'll 
do this in next iteration.

> What was happening was due to the failure here one of the sockets was not
> deleted and later on whole test suite could not attach the socket for
> every other test case which caused the ever going failures. Which makes me
> think that since you changed the logic from exits to returning failures
> probably we need to take care of state cleanup in a better way so case
> like this one described here wouldn't take place.
> 

I hadn't notice the cleanup done in __testapp_validate_traffic(), I'll 
handle this in a better way in next iteration.

> This test is only executed for hw tests that's why you haven't seen this
> problem as you were focused on veth case.
> 
> If you want to proceed with that then i would like to ask you to grab the
> hw and check you're not introducing regressions. FWIW i have been working
> with i40e and ice drivers.
> 

I don't think I have such hardware available but I'll try to find some 
equivalent to test the next iteration on real HW before submitting it.

> One last note is that verbose mode seemed to be broken for me.
> 

I'll take a look at this, thank you.


Best regards,
Bastien


