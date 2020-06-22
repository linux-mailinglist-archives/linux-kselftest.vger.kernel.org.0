Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8002042B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 23:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgFVVdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 17:33:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9672 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgFVVdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 17:33:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef1233d0000>; Mon, 22 Jun 2020 14:31:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 14:33:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 14:33:12 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 21:33:06 +0000
Subject: Re: [PATCH 14/16] mm/thp: add THP allocation helper
To:     Zi Yan <ziy@nvidia.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-15-rcampbell@nvidia.com>
 <9948121A-CA52-494F-9B68-6C0089E15057@nvidia.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <21d571c4-8442-82df-4baf-e5d1c2ced99d@nvidia.com>
Date:   Mon, 22 Jun 2020 14:33:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9948121A-CA52-494F-9B68-6C0089E15057@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592861501; bh=kKhAiBb2dmKarFPnUN3DCh6t35CXVfyB9l3jASZ5HS0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HVvsXz7yZCRk/1Gi4xfI78UyQRxmdOWyHhToZ7q8RRU/XpEchdduB5J1EdR3hAspm
         hDsQe33+5+b43imv23uHWzdOtu/wdiCleINuTsdiXDSmSJnsULEXoDAOCobWjGExzN
         eEYNrUPKYEbPolDSt41vTQAjr9TmQMvXHxQaUcKq9R2q8xQ+UhWJYoTQMe2vhOrlQV
         JegU98QBSfPri8F2t4Ac/QXcgu6CafkAPjclLPvNhHAXExBGCRihESc6Ph8qBSsPkG
         duBtcb0Bqwxweelf1+NLa4tv72S5t5/a4Bt8LgxdyA7dpOkyk8XmwrLxCJ2QwYJKWx
         6+r0Eu3vPylAg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/21/20 5:15 PM, Zi Yan wrote:
> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
>=20
>> Transparent huge page allocation policy is controlled by several sysfs
>> variables. Rather than expose these to each device driver that needs to
>> allocate THPs, provide a helper function.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>   include/linux/gfp.h | 10 ++++++++++
>>   mm/huge_memory.c    | 16 ++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 67a0774e080b..1c7d968a27d3 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -562,6 +562,16 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask,=
 int order,
>>   	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
>>   #define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
>>   	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> +extern struct page *alloc_transhugepage(struct vm_area_struct *vma,
>> +					unsigned long addr);
>> +#else
>> +static inline struct page *alloc_transhugepage(struct vm_area_struct *v=
ma,
>> +						unsigned long addr)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>>
>>   extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int ord=
er);
>>   extern unsigned long get_zeroed_page(gfp_t gfp_mask);
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 25d95f7b1e98..f749633ed350 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -775,6 +775,22 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fau=
lt *vmf)
>>   	return __do_huge_pmd_anonymous_page(vmf, page, gfp);
>>   }
>>
>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> +struct page *alloc_transhugepage(struct vm_area_struct *vma,
>> +				 unsigned long haddr)
>> +{
>> +	gfp_t gfp;
>> +	struct page *page;
>> +
>> +	gfp =3D alloc_hugepage_direct_gfpmask(vma);
>> +	page =3D alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
>> +	if (page)
>> +		prep_transhuge_page(page);
>> +	return page;
>> +}
>> +EXPORT_SYMBOL_GPL(alloc_transhugepage);
>> +#endif
>> +
>>   static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long a=
ddr,
>>   		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
>>   		pgtable_t pgtable)
>> --=20
>> 2.20.1
>=20
> Why use CONFIG_ARCH_ENABLE_THP_MIGRATION to guard THP allocator helper?
> Shouldn=E2=80=99t CONFIG_TRANSPARENT_HUGEPAGE be used? Also the helper st=
ill allocates
> a THP even if transparent_hugepage_enabled(vma) is false, which is wrong,=
 right?
>=20
>=20
> --
> Best Regards,
> Yan Zi
>=20

Oops, I'm not sure why I thought that was needed. The whole file is only co=
mpiled
if CONFIG_TRANSPARENT_HUGEPAGE is defined and the calls to alloc_hugepage_v=
ma()
and alloc_hugepage_direct_gfpmask() are unprotected just above this in
do_huge_pmd_anonymous_page(). I'll fix that in v2.

The helper is intended to be called by a device driver to allocate a THP wh=
en
migrating device private memory back to system memory. The THP should never=
 be
migrated to device private memory in the first place if
transparent_hugepage_enabled(vma) is false.
I suppose I could add a if (WARN_ON_ONCE()) return NULL as a sanity check.
The real checks are in migrate_vma_setup() and migrate_vma_pages().

