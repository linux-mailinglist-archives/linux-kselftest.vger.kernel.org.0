Return-Path: <linux-kselftest+bounces-1664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718580EA2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6052814F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3E5CD2F;
	Tue, 12 Dec 2023 11:17:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5EBE;
	Tue, 12 Dec 2023 03:17:24 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SqGKp54dqzZcl2;
	Tue, 12 Dec 2023 19:17:18 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4699618005A;
	Tue, 12 Dec 2023 19:17:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Dec
 2023 19:17:21 +0800
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To: Mina Almasry <almasrymina@google.com>
CC: Shailend Chand <shailend@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
	<dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com>
 <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
 <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
 <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com>
 <CAHS8izPEFsqw50qgM+sPot6XVvOExpd+DrwrmPSR3zsWGLysRw@mail.gmail.com>
 <CAHS8izN6Cbjy0FCYhJyNsP396XfgJ_nTFXWuHb5QWNct=PifAg@mail.gmail.com>
 <59e07233-24cb-7fb2-1aee-e1cf7eb72fa9@huawei.com>
 <CAHS8izMdpo0D7GYzMkOtg1ueCODAVNxtwSP_qPseSYXNMhPGCw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2cdf173c-95e4-2141-56f7-0761705cd737@huawei.com>
Date: Tue, 12 Dec 2023 19:17:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izMdpo0D7GYzMkOtg1ueCODAVNxtwSP_qPseSYXNMhPGCw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/12 2:14, Mina Almasry wrote:
> On Mon, Dec 11, 2023 at 3:51 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/12/11 12:04, Mina Almasry wrote:
>>> On Sun, Dec 10, 2023 at 6:26 PM Mina Almasry <almasrymina@google.com> wrote:
>>>>
>>>> On Sun, Dec 10, 2023 at 6:04 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>>
>>>>> On 2023/12/9 0:05, Mina Almasry wrote:
>>>>>> On Fri, Dec 8, 2023 at 1:30 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> As mentioned before, it seems we need to have the above checking every
>>>>>>> time we need to do some per-page handling in page_pool core, is there
>>>>>>> a plan in your mind how to remove those kind of checking in the future?
>>>>>>>
>>>>>>
>>>>>> I see 2 ways to remove the checking, both infeasible:
>>>>>>
>>>>>> 1. Allocate a wrapper struct that pulls out all the fields the page pool needs:
>>>>>>
>>>>>> struct netmem {
>>>>>>         /* common fields */
>>>>>>         refcount_t refcount;
>>>>>>         bool is_pfmemalloc;
>>>>>>         int nid;
>>>>>>         ...
>>>>>>         union {
>>>>>>                 struct dmabuf_genpool_chunk_owner *owner;
>>>>>>                 struct page * page;
>>>>>>         };
>>>>>> };
>>>>>>
>>>>>> The page pool can then not care if the underlying memory is iov or
>>>>>> page. However this introduces significant memory bloat as this struct
>>>>>> needs to be allocated for each page or ppiov, which I imagine is not
>>>>>> acceptable for the upside of removing a few static_branch'd if
>>>>>> statements with no performance cost.
>>>>>>
>>>>>> 2. Create a unified struct for page and dmabuf memory, which the mm
>>>>>> folks have repeatedly nacked, and I imagine will repeatedly nack in
>>>>>> the future.
>>>>>>
>>>>>> So I imagine the special handling of ppiov in some form is critical
>>>>>> and the checking may not be removable.
>>>>>
>>>>> If the above is true, perhaps devmem is not really supposed to be intergated
>>>>> into page_pool.
>>>>>
>>>>> Adding a checking for every per-page handling in page_pool core is just too
>>>>> hacky to be really considerred a longterm solution.
>>>>>
>>>>
>>>> The only other option is to implement another page_pool for ppiov and
>>>> have the driver create page_pool or ppiov_pool depending on the state
>>>> of the netdev_rx_queue (or some helper in the net stack to do that for
>>>> the driver). This introduces some code duplication. The ppiov_pool &
>>>> page_pool would look similar in implementation.
>>
>> I think there is a design pattern already to deal with this kind of problem,
>> refactoring common code used by both page_pool and ppiov into a library to
>> aovid code duplication if most of them have similar implementation.
>>
> 
> Code can be refactored if it's identical, not if it is similar. I

Similarity indicates an opportunity to the refactor out the common
code, like the page_frag case below:
https://patchwork.kernel.org/project/netdevbpf/cover/20231205113444.63015-1-linyunsheng@huawei.com/

But untill we do a proof of concept implemention, it is hard to tell if
it is feasiable or not.

> suspect the page_pools will be only similar, and if you're not willing
> to take devmem handling into the page pool then refactoring page_pool
> code into helpers that do devmem handling may also not be an option.
> 
>>>>
>>>> But this was all discussed in detail in RFC v2 and the last response I
>>>> heard from Jesper was in favor if this approach, if I understand
>>>> correctly:
>>>>
>>>> https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@redhat.com/
>>>>
>>>> Would love to have the maintainer weigh in here.
>>>>
>>>
>>> I should note we may be able to remove some of the checking, but maybe not all.
>>>
>>> - Checks that disable page fragging for ppiov can be removed once
>>> ppiov has frag support (in this series or follow up).
>>>
>>> - If we use page->pp_frag_count (or page->pp_ref_count) for
>>> refcounting ppiov, we can remove the if checking in the refcounting.
>>>
> 
> I'm not sure this is actually possible in the short term. The
> page_pool uses both page->_refcount and page->pp_frag_count for
> refcounting, and I will not be able to remove the special handling
> around page->_refcount as i'm not allowed to call page_ref_*() APIs on
> a non-struct page.

the page_ref_*() API may be avoided using the below patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20231113130041.58124-7-linyunsheng@huawei.com/

But I am not sure how to do that for tx part if devmem for tx is not
intergating into page_pool, that is why I suggest having a tx implementation
for the next version, so that we can have a whole picture of devmem.

> 
>>> - We may be able to store the dma_addr of the ppiov in page->dma_addr,
>>> but I'm unsure if that actually works, because the dma_buf dmaddr is
>>> dma_addr_t (u32 or u64), but page->dma_addr is unsigned long (4 bytes
>>> I think). But if it works for pages I may be able to make it work for
>>> ppiov as well.
>>>
>>> - Checks that obtain the page->pp can work with ppiov if we align the
>>> offset of page->pp and ppiov->pp.
>>>
>>> - Checks around page->pp_magic can be removed if we also have offset
>>> aligned ppiov->pp_magic.
>>>
>>> Sadly I don't see us removing the checking for these other cases:
>>>
>>> - page_is_pfmemalloc(): I'm not allowed to pass a non-struct page into
>>> that helper.
>>
>> We can do similar trick like above as bit 1 of page->pp_magic is used to
>> indicate that if it is a pfmemalloc page.
>>
> 
> Likely yes.
> 
>>>
>>> - page_to_nid(): I'm not allowed to pass a non-struct page into that helper.
>>
>> Yes, this one need special case.
>>
>>>
>>> - page_pool_free_va(): ppiov have no va.
>>
>> Doesn't the skb_frags_readable() checking will protect the page_pool_free_va()
>> from being called on devmem?
>>
> 
> This function seems to be only called from veth which doesn't support
> devmem. I can remove the handling there.
> 
>>>
>>> - page_pool_sync_for_dev/page_pool_dma_map: ppiov backed by dma-buf
>>> fundamentally can't get mapped again.
>>
>> Can we just fail the page_pool creation with PP_FLAG_DMA_MAP and
>> DMA_ATTR_SKIP_CPU_SYNC flags for devmem provider?
>>
> 
> Jakub says PP_FLAG_DMA_MAP must be enabled for devmem, such that the
> page_pool handles the dma mapping of the devmem and the driver doesn't
> use it on its own.

I am not sure what benefit does it bring by enabling the DMA_MAP for devmem,
as devmem seems to call dma_buf_map_attachment() in netdev_bind_dmabuf(), it
does not really need enabling PP_FLAG_DMA_MAP to get the dma addr for the
devmem chunk.

