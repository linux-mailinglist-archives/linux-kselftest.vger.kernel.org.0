Return-Path: <linux-kselftest+bounces-15497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5427D954852
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 13:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D709C1F21A37
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BE81ABEC1;
	Fri, 16 Aug 2024 11:55:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25919412A;
	Fri, 16 Aug 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809325; cv=none; b=SBz5f1AjTLn+ya60kIA4MZV82UYDJro9QCHGZAqiTQyqUP6zP91LfkSYCsJFctNa5mcqpnuTlFAO1XBW4+/HdcbBHri1EbZP2xokk2ucBHEePhP9zsnQDUyP1USYom4cIABE0urntFxBMLYhOEBqWYSfVJgvtN9QTgAQtxW/XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809325; c=relaxed/simple;
	bh=crRBTb++01BV7AbQhw0YhRZpdM4dL/fl/FxhwOGEdTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AEtXk/Fltlcbm1JNxKZJzcgwQQMz4DJIpseD/Lyu1tCguBEzzm3CCkt20fYlZCiTfaQRHHCU4/+BimIH2zfYaKAM3YnCXKmdyTDsb5qGaEVeHNMZSVt0e8gtbNsGFw6JByP/oF3Hn6iAs+xz1bDUWc9+Hc5s5yLNrMVhDAAeS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WlgKt6jK6zQpvH;
	Fri, 16 Aug 2024 19:50:42 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 879EA1403D5;
	Fri, 16 Aug 2024 19:55:19 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 19:55:18 +0800
Message-ID: <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com>
Date: Fri, 16 Aug 2024 19:55:18 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/15 23:00, Alexander Duyck wrote:
> On Wed, Aug 14, 2024 at 8:00 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/14 23:49, Alexander H Duyck wrote:
>>> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
>>>> Currently the page_frag API is returning 'virtual address'
>>>> or 'va' when allocing and expecting 'virtual address' or
>>>> 'va' as input when freeing.
>>>>
>>>> As we are about to support new use cases that the caller
>>>> need to deal with 'struct page' or need to deal with both
>>>> 'va' and 'struct page'. In order to differentiate the API
>>>> handling between 'va' and 'struct page', add '_va' suffix
>>>> to the corresponding API mirroring the page_pool_alloc_va()
>>>> API of the page_pool. So that callers expecting to deal with
>>>> va, page or both va and page may call page_frag_alloc_va*,
>>>> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
>>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Acked-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
>>>>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
>>>>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
>>>>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
>>>>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
>>>>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
>>>>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
>>>>  drivers/nvme/host/tcp.c                       |  8 +++----
>>>>  drivers/nvme/target/tcp.c                     | 22 +++++++++----------
>>>>  drivers/vhost/net.c                           |  6 ++---
>>>>  include/linux/page_frag_cache.h               | 21 +++++++++---------
>>>>  include/linux/skbuff.h                        |  2 +-
>>>>  kernel/bpf/cpumap.c                           |  2 +-
>>>>  mm/page_frag_cache.c                          | 12 +++++-----
>>>>  net/core/skbuff.c                             | 16 +++++++-------
>>>>  net/core/xdp.c                                |  2 +-
>>>>  net/rxrpc/txbuf.c                             | 15 +++++++------
>>>>  net/sunrpc/svcsock.c                          |  6 ++---
>>>>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
>>>>  19 files changed, 75 insertions(+), 70 deletions(-)
>>>>
>>>
>>> I still say no to this patch. It is an unnecessary name change and adds
>>> no value. If you insist on this patch I will reject the set every time.
>>>
>>> The fact is it is polluting the git history and just makes things
>>> harder to maintain without adding any value as you aren't changing what
>>> the function does and there is no need for this. In addition it just
>>
>> I guess I have to disagree with the above 'no need for this' part for
>> now, as mentioned in [1]:
>>
>> "There are three types of API as proposed in this patchset instead of
>> two types of API:
>> 1. page_frag_alloc_va() returns [va].
>> 2. page_frag_alloc_pg() returns [page, offset].
>> 3. page_frag_alloc() returns [va] & [page, offset].
>>
>> You seemed to miss that we need a third naming for the type 3 API.
>> Do you see type 3 API as a valid API? if yes, what naming are you
>> suggesting for it? if no, why it is not a valid API?"
> 
> I didn't. I just don't see the point in pushing out the existing API
> to support that. In reality 2 and 3 are redundant. You probably only
> need 3. Like I mentioned earlier you can essentially just pass a

If the caller just expect [page, offset], do you expect the caller also
type 3 API, which return both [va] and [page, offset]?

I am not sure if I understand why you think 2 and 3 are redundant here?
If you think 2 and 3 are redundant here, aren't 1 and 3 also redundant
as the similar agrument?

> page_frag via pointer to the function. With that you could also look
> at just returning a virtual address as well if you insist on having
> something that returns all of the above. No point in having 2 and 3 be
> seperate functions.

Let's be more specific about what are your suggestion here: which way
is the prefer way to return the virtual address. It seems there are two
options:

1. Return the virtual address by function returning as below:
void *page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio);

2. Return the virtual address by double pointer as below:
int page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio,
		        void **va);

If the above options is what you have in mind, please be more specific
which one is the prefer option, and why it is the prefer option.
If the above options is not what you have in mind, please list out the
declaration of API in your mind.

> 
> I am going to nack this patch set if you insist on this pointless
> renaming. The fact is it is just adding noise that adds no value.

