Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B8202DD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 02:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgFVAQ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Jun 2020 20:16:27 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1216 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgFVAQ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Jun 2020 20:16:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeff82e0000>; Sun, 21 Jun 2020 17:15:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 17:16:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 21 Jun 2020 17:16:26 -0700
Received: from [10.2.167.171] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 00:16:18 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 14/16] mm/thp: add THP allocation helper
Date:   Sun, 21 Jun 2020 20:15:45 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <9948121A-CA52-494F-9B68-6C0089E15057@nvidia.com>
In-Reply-To: <20200619215649.32297-15-rcampbell@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-15-rcampbell@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_4C36EFB0-847C-4A5D-A41C-B10AE0145101_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592784942; bh=Lr8iQ6hREjxuIrrKajV9oQHe0CBRPThD6DDsvzRvG88=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=kcNK9B7kDcnIj5KTg2K7ZI3H/ITfv/fVhMe6LNHevMFvtR9mrnxySOqp8KItN6/zU
         uPApsdYyrDEwN9Sdw+J33HBTV6bTaWPReJ7agzPv3XDX1T3jara8+nBSWZCN3Xs7W2
         w26R03Vzir/ckhxS6NkSV4lYEZkuiT4PraqoF+zbtY2f8cnFY7xck3U/xS2wTQsoEZ
         VGQ+i5dfa1qqKFIOZDjoZYuzcOi7z9Tk4SO2qk9YdVUMv5BKQgjNTYfecpvQMIL/kK
         jJPBH28+w+yCFuzHuNrpJZ/vXnn6QNbuqrckX3VMU2Nebqjmp4mgfMcMgRZJfotG4G
         rMSkddnkNVykw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_4C36EFB0-847C-4A5D-A41C-B10AE0145101_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 19 Jun 2020, at 17:56, Ralph Campbell wrote:

> Transparent huge page allocation policy is controlled by several sysfs
> variables. Rather than expose these to each device driver that needs to=

> allocate THPs, provide a helper function.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  include/linux/gfp.h | 10 ++++++++++
>  mm/huge_memory.c    | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 67a0774e080b..1c7d968a27d3 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -562,6 +562,16 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask=
, int order,
>  	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
>  #define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
>  	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +extern struct page *alloc_transhugepage(struct vm_area_struct *vma,
> +					unsigned long addr);
> +#else
> +static inline struct page *alloc_transhugepage(struct vm_area_struct *=
vma,
> +						unsigned long addr)
> +{
> +	return NULL;
> +}
> +#endif
>
>  extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int ord=
er);
>  extern unsigned long get_zeroed_page(gfp_t gfp_mask);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 25d95f7b1e98..f749633ed350 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -775,6 +775,22 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fa=
ult *vmf)
>  	return __do_huge_pmd_anonymous_page(vmf, page, gfp);
>  }
>
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +struct page *alloc_transhugepage(struct vm_area_struct *vma,
> +				 unsigned long haddr)
> +{
> +	gfp_t gfp;
> +	struct page *page;
> +
> +	gfp =3D alloc_hugepage_direct_gfpmask(vma);
> +	page =3D alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
> +	if (page)
> +		prep_transhuge_page(page);
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(alloc_transhugepage);
> +#endif
> +
>  static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long a=
ddr,
>  		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
>  		pgtable_t pgtable)
> -- =

> 2.20.1

Why use CONFIG_ARCH_ENABLE_THP_MIGRATION to guard THP allocator helper?
Shouldn=E2=80=99t CONFIG_TRANSPARENT_HUGEPAGE be used? Also the helper st=
ill allocates
a THP even if transparent_hugepage_enabled(vma) is false, which is wrong,=
 right?


--
Best Regards,
Yan Zi

--=_MailMate_4C36EFB0-847C-4A5D-A41C-B10AE0145101_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7v+DEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKQCQP/R4abSW0mnepE+hQxnoAry2FCsgoq4kfwbLS
z61PThcPrmTTEvbT9kRmqtarVtKhK1u0NxFkzhBYEZA4jfrs9JOufIXWBdhEEI+L
Lp0xXMwc4qEugDb2whgdiTWIWfwhDqzYExaaZMuWlpr2H9Uw+qEENzlBvTBnd2Xa
4cj2nAipD6ggJ4qz/h7pt+2JTNKhNBirkfXqYjoXeWZpj/N0AfUs8IziaHyOwqxZ
1p2KvBeqsOB5M67Mr6TVzOHh1EZEbN7VMRHbXEgw6mBt179v67IGmP129Xp/zzFh
U0KDQiMGUh7rt8rScMpv9v9xbvTXA5Ztpe/ExGARRK9cmOWOr3UHK2fDLwl3WSTl
IN7swIwEBTpKPSWpCEi0f4fiQOqOk9PuexRM6ZxI5W/GYPKR99Fn7cHEMjgESOw1
fKCXPMXx95DDabWoRdMmTPEKkReI8k/RWSJhBq5mIUH8kHNilWgbPhUH/l7pbgMB
W636ZixfVK0q7F95lwwU+fEH5BTfMwwk/usVT0ugRoTsiAFOFEZ3GXi6W8mmp8fo
6oaOysR1M3K01IXl8RRlDrWqK3oPsv2MnNTH2adPCxKKXU8PSRgs9Zcc7d9EIIO1
I7bnvmSZ7pTWK0RaHfv/yIbcfqpyyUt9wJy9kc83VXknBsOjJs9QtOBchjzpBWq1
q2tbBUmt
=CvYf
-----END PGP SIGNATURE-----

--=_MailMate_4C36EFB0-847C-4A5D-A41C-B10AE0145101_=--
