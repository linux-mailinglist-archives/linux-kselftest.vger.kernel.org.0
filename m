Return-Path: <linux-kselftest+bounces-15772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1010958797
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829AF283C47
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929C6190670;
	Tue, 20 Aug 2024 13:07:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74A190667;
	Tue, 20 Aug 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159260; cv=none; b=iy4iBbDpfxEuy5OT+AadfaZIrgNeJrvZyo5Dhgd2C0ZcJVjSvwPSDFUUznrGvzljHSMedo+WErM4aKsggLj1c8AMFNKs9kyv3BJbeX2OZhfNOwUq3QoeSxU8CefdPe9OJLOz5RlTrakLbTMaGx7m+0gomgsBDbtQu0jOFH5iCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159260; c=relaxed/simple;
	bh=JO6RWeMlWaObYRyseZlU/Pqn9dKedWmcF4CIwKnCdJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cefnfAjJhBxTY1m1MB72uu65BizHBw/Ya3a+QbCstsNJaMBUxheG2dvc1mijVq8gAMxNiaXOwDIj3RyYDXmDu/QDwuWEJcpYglY4SibiIiVtDwmvTDibBnTgH5LYbvXLhR9j9xIqzDec5EsHewqXAntNMBGsrT/5SXjhsWl1otQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wp8lF0HMDzQptG;
	Tue, 20 Aug 2024 21:02:49 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EF6B140138;
	Tue, 20 Aug 2024 21:07:30 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 21:07:29 +0800
Message-ID: <98ceade3-8d60-45bf-a419-ff3982a96101@huawei.com>
Date: Tue, 20 Aug 2024 21:07:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Chuck Lever <chuck.lever@oracle.com>, Sagi Grimberg
	<sagi@grimberg.me>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, hariprasad
	<hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-mm@kvack.org>, <bpf@vger.kernel.org>, <linux-afs@lists.infradead.org>,
	<linux-nfs@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com>
 <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com>
 <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
 <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com>
 <CAKgT0UcDDFeMqD_eRe1-2Og0GEEFyNP90E9SDxDjskdgtMe0Uw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UcDDFeMqD_eRe1-2Og0GEEFyNP90E9SDxDjskdgtMe0Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/19 23:54, Alexander Duyck wrote:

...

>>>>
>>>> "There are three types of API as proposed in this patchset instead of
>>>> two types of API:
>>>> 1. page_frag_alloc_va() returns [va].
>>>> 2. page_frag_alloc_pg() returns [page, offset].
>>>> 3. page_frag_alloc() returns [va] & [page, offset].
>>>>
>>>> You seemed to miss that we need a third naming for the type 3 API.
>>>> Do you see type 3 API as a valid API? if yes, what naming are you
>>>> suggesting for it? if no, why it is not a valid API?"
>>>
>>> I didn't. I just don't see the point in pushing out the existing API
>>> to support that. In reality 2 and 3 are redundant. You probably only
>>> need 3. Like I mentioned earlier you can essentially just pass a
>>
>> If the caller just expect [page, offset], do you expect the caller also
>> type 3 API, which return both [va] and [page, offset]?
>>
>> I am not sure if I understand why you think 2 and 3 are redundant here?
>> If you think 2 and 3 are redundant here, aren't 1 and 3 also redundant
>> as the similar agrument?
> 
> The big difference is the need to return page and offset. Basically to
> support returning page and offset you need to pass at least one value
> as a pointer so you can store the return there.
> 
> The reason why 3 is just a redundant form of 2 is that you will
> normally just be converting from a va to a page and offset so the va
> should already be easily accessible.

I am assuming that by 'easily accessible', you meant the 'va' can be
calculated as below, right?

va = encoded_page_address(encoded_va) +
		(page_frag_cache_page_size(encoded_va) - remaining);

I guess it is easily accessible, but it is not without some overhead
to calculate the 'va' here.

> 
>>> page_frag via pointer to the function. With that you could also look
>>> at just returning a virtual address as well if you insist on having
>>> something that returns all of the above. No point in having 2 and 3 be
>>> seperate functions.
>>
>> Let's be more specific about what are your suggestion here: which way
>> is the prefer way to return the virtual address. It seems there are two
>> options:
>>
>> 1. Return the virtual address by function returning as below:
>> void *page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio);
>>
>> 2. Return the virtual address by double pointer as below:
>> int page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio,
>>                         void **va);
> 
> I was thinking more of option 1. Basically this is a superset of
> page_frag_alloc_va that is also returning the page and offset via a
> page frag. However instead of bio_vec I would be good with "struct
> page_frag *" being the value passed to the function to play the role
> of container. Basically the big difference between 1 and 2/3 if I am
> not mistaken is the fact that for 1 you pass the size, whereas with
> 2/3 you are peeling off the page frag from the larger page frag cache

Let's be clear here: The callers just expecting [page, offset] also need
to call type 3 API, which return both [va] and [page, offset]? and it
is ok to ignore the overhead of calculating the 'va' for those kinds
of callers just because we don't want to do the renaming for a existing
API and can't come up with good naming for that?

> after the fact via a commit type action.

Just be clear here, there is no commit type action for some subtype of
type 2/3 API.

For example, for type 2 API in this patchset, it has below subtypes:

subtype 1: it does not need a commit type action, it just return
           [page, offset] instead of page_frag_alloc_va() returning [va],
           and it does not return the allocated fragsz back to the caller
           as page_frag_alloc_va() does not too:
struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
                                unsigned int *offset, unsigned int fragsz,
                                gfp_t gfp)

subtype 2: it does need a commit type action, and @fragsz is returned to
           the caller and caller used that to commit how much fragsz to
           commit.
struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
                                        unsigned int *offset,
                                        unsigned int *fragsz, gfp_t gfp)

Do you see subtype 1 as valid API? If no, why?
If yes, do you also expect the caller to use "struct page_frag *" as the
container? If yes, what is the caller expected to do with the size field in
"struct page_frag *" from API perspective? Just ignore it?


