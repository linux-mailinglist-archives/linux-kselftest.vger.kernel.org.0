Return-Path: <linux-kselftest+bounces-38643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275CB1FB10
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 18:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F39189474F
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7A25A33F;
	Sun, 10 Aug 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hY98JF3b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE818C933;
	Sun, 10 Aug 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844661; cv=none; b=po1GL96LKk7ntV4aZMuPqMZQVnatfEMY1kk2ANqEmcDBjFeACjJ34sJYsFLlk2dCcUJNhQrzvDmbH95D+iNdcylPZxXUxzvi+YOh2abSwWiYVuGsGWYocbzpS+uLKd1WlNPIDpOtcPBZimSQDV6Ln9l2/rO9iS+RQUkNek7z1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844661; c=relaxed/simple;
	bh=3VNLNjUTrhelNb9JDbpsPb6apJlCQ5RSNazhNDqjal8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4Kx9QtDv1tkNKY/ON63ZA7XSoF+lQbUPK2364f3576XBdmOh33p+H808xaQSzIoXa0RoGzC1CNNtSLeigVT3LWrKz65pqGaUh1Ru//p7KLPt//8kGQ7lhfDaqKCGFSDztLpb3gLc1O2NejPpGXNiC9JCW6kIh7DUV+DYt3+Ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hY98JF3b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AB0HnT022969;
	Sun, 10 Aug 2025 16:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rnYQL5
	Yk1Pt2iFo15ApPacITklfJKgoKX7PfLbLJd9E=; b=hY98JF3btHUjAgNeP71gQQ
	jwPkfT5O+Eln6iwS5228d0/B1um4IFdnf8TUo5maIDdlK2GBxTnHhQZYqAsVWdVJ
	jMomxX/euWxnY3h3RrruPlvuuU2/rkIG29vV2RB15q7GdIi7XXxVecVZuPGLmyEW
	18kZFtFityqTTedHBJ9yIokZ9pr+WzbkMUu+xhjMu2YpqX2XDkGqcmupg+Eka2Hz
	V+OyzmyzkvXvqSc869LmS70fSevuLhdai2VYd3pCsytquvRRB7W0hAdWUWEpmiuv
	YsdRlfy2SJyx++gpeoc8st3rZex+ayvuGapANnHaqWOog3PHh9/HVpdI3OUTLZHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwucwv7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:50:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57AGo5CW006037;
	Sun, 10 Aug 2025 16:50:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwucwv7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:50:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57ACE2PW026279;
	Sun, 10 Aug 2025 16:50:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20tn7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:50:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57AGo4j717433118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 16:50:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E5F658054;
	Sun, 10 Aug 2025 16:50:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C448B58045;
	Sun, 10 Aug 2025 16:49:55 +0000 (GMT)
Received: from [9.124.216.245] (unknown [9.124.216.245])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 16:49:55 +0000 (GMT)
Message-ID: <f7cbe7ee-35e2-4659-ba52-62b6b932c192@linux.ibm.com>
Date: Sun, 10 Aug 2025 22:19:53 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: add check_folio_orders() helper.
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
        wang lian <lianux.mm@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-3-ziy@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250808190144.797076-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDEyMSBTYWx0ZWRfX980C3vR34l7C
 GiYFFrGmMMlVp7LeFFWFqZli1+8xA8iMoQinM2vN9ibpbNx5SGeLcWq5u8ghCtnkoiPeCwNzVLx
 a/HnTDRZULVgiIUdxDbtUCFZecDh9JzkoSltN2+QEvYbLBrhrTCcY6x5pdO0+Ex3puLYUmAmRpC
 +Y/qYSA3OlqTeE5qKL64wtfQwtRW/pvFQFM8Jte9X1Xkg0f/kaNQ5fcI3OkTUGvRxOiipcqAnXt
 QuqkjQ7j5uIXlekZhKVXQXfY7GsPto5HLQAAvhCRx6JmZgsvsru33TQxVFGzeaKC8zNzVflqLWB
 VOAfAnjUO39kgGQMt/+uHg0CnlvwWNu5N7Puoyd0dkTSami+zPP+2UGSLTbPRVI4O+AsL0NuMbf
 4C0a/hJF4JQfS00ggIZGUEs+M5prrwgqbZkYEj8v1W2X2kqFURHcsjxxhEMsblPPgkoIhcid
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=6898cdbe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Ikd4Dj_1AAAA:8 a=h_jtaqhVJtM5NzTXNHYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KzsxtGyBukxEBsUHg540cpkVSaTz4Z5y
X-Proofpoint-ORIG-GUID: mp0N7QTIOyH3pOhTMOtc60gqrVosNdqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100121


On 8/9/25 12:31 AM, Zi Yan wrote:
> The helper gathers an folio order statistics of folios within a virtual
> address range and checks it against a given order list. It aims to provide
> a more precise folio order check instead of just checking the existence of
> PMD folios.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   .../selftests/mm/split_huge_page_test.c       |   4 +-
>   tools/testing/selftests/mm/vm_util.c          | 133 ++++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h          |   7 +
>   3 files changed, 141 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index cb364c5670c6..5ab488fab1cd 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -34,8 +34,6 @@ uint64_t pmd_pagesize;
>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>   
> -#define PFN_MASK     ((1UL<<55)-1)
> -#define KPF_THP      (1UL<<22)
>   #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>   
>   int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> @@ -49,7 +47,7 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
>   
>   		if (kpageflags_file) {
>   			pread(kpageflags_file, &page_flags, sizeof(page_flags),
> -				(paddr & PFN_MASK) * sizeof(page_flags));
> +				PAGEMAP_PFN(paddr) * sizeof(page_flags));
>   
>   			return !!(page_flags & KPF_THP);
>   		}
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 6a239aa413e2..41d50b74b2f6 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -338,6 +338,139 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
>   	return count;
>   }
>   
> +static int get_page_flags(char *vaddr, int pagemap_file, int kpageflags_file,
> +			  uint64_t *flags)
> +{
> +	unsigned long pfn;
> +	size_t count;
> +
> +	pfn = pagemap_get_pfn(pagemap_file, vaddr);
> +	/*
> +	 * Treat non-present page as a page without any flag, so that
> +	 * gather_folio_orders() just record the current folio order.
> +	 */
> +	if (pfn == -1UL) {
> +		*flags = 0;
> +		return 0;
> +	}
> +
> +	count = pread(kpageflags_file, flags, sizeof(*flags),
> +		      pfn * sizeof(*flags));
> +
> +	if (count != sizeof(*flags))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int gather_folio_orders(char *vaddr_start, size_t len,
> +			       int pagemap_file, int kpageflags_file,
> +			       int orders[], int nr_orders)
> +{
> +	uint64_t page_flags = 0;
> +	int cur_order = -1;
> +	char *vaddr;
> +
> +	if (!pagemap_file || !kpageflags_file)
> +		return -1;
> +	if (nr_orders <= 0)
> +		return -1;
> +
> +	for (vaddr = vaddr_start; vaddr < vaddr_start + len; ) {
> +		char *next_folio_vaddr;
> +		int status;
> +
> +		if (get_page_flags(vaddr, pagemap_file, kpageflags_file, &page_flags))
> +			return -1;
> +
> +		/* all order-0 pages with possible false postive (non folio) */
> +		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
> +			orders[0]++;
> +			vaddr += psize();
> +			continue;
> +		}
> +
> +		/* skip non thp compound pages */
> +		if (!(page_flags & KPF_THP)) {
> +			vaddr += psize();
> +			continue;
> +		}
> +
> +		/* vpn points to part of a THP at this point */
> +		if (page_flags & KPF_COMPOUND_HEAD)
> +			cur_order = 1;
> +		else {
> +			/* not a head nor a tail in a THP? */
> +			if (!(page_flags & KPF_COMPOUND_TAIL))
> +				return -1;
> +			continue;

If KPF_COMPOUND_TAIL is set, do we use the same vaddr, or should we 
advance to the next vaddr before continuing?


> +		}
> +
> +		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
> +
> +		if (next_folio_vaddr >= vaddr_start + len)
> +			break;
> +
> +		while (!(status = get_page_flags(next_folio_vaddr, pagemap_file,
> +						 kpageflags_file,
> +						 &page_flags))) {
> +			/* next compound head page or order-0 page */
> +			if ((page_flags & KPF_COMPOUND_HEAD) ||
> +			    !(page_flags & (KPF_COMPOUND_HEAD |
> +			      KPF_COMPOUND_TAIL))) {
> +				if (cur_order < nr_orders) {
> +					orders[cur_order]++;
> +					cur_order = -1;
> +					vaddr = next_folio_vaddr;
> +				}
> +				break;
> +			}
> +
> +			/* not a head nor a tail in a THP? */
> +			if (!(page_flags & KPF_COMPOUND_TAIL))
> +				return -1;
> +
> +			cur_order++;
> +			next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
> +		}
> +
> +		if (status)
> +			return status;
> +	}
> +	if (cur_order > 0 && cur_order < nr_orders)
> +		orders[cur_order]++;
> +	return 0;
> +}
> +
> +int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
> +			int kpageflags_file, int orders[], int nr_orders)
> +{
> +	int *vaddr_orders;
> +	int status;
> +	int i;
> +
> +	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
> +
> +	if (!vaddr_orders)
> +		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
> +
> +	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
> +	status = gather_folio_orders(vaddr_start, len, pagemap_file,
> +				     kpageflags_file, vaddr_orders, nr_orders);
> +	if (status)
> +		return status;
> +
> +	status = 0;
> +	for (i = 0; i < nr_orders; i++)
> +		if (vaddr_orders[i] != orders[i]) {
> +			ksft_print_msg("order %d: expected: %d got %d\n", i,
> +				       orders[i], vaddr_orders[i]);
> +			status = -1;
> +		}
> +
> +	return status;
> +}
> +
>   /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
>   int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>   			      bool miss, bool wp, bool minor, uint64_t *ioctls)
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 1843ad48d32b..02e3f1e7065b 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -18,6 +18,11 @@
>   #define PM_SWAP                       BIT_ULL(62)
>   #define PM_PRESENT                    BIT_ULL(63)
>   
> +#define KPF_COMPOUND_HEAD             BIT_ULL(15)
> +#define KPF_COMPOUND_TAIL             BIT_ULL(16)
> +#define KPF_THP                       BIT_ULL(22)
> +
> +
>   /*
>    * Ignore the checkpatch warning, we must read from x but don't want to do
>    * anything with it in order to trigger a read page fault. We therefore must use
> @@ -85,6 +90,8 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
>   int64_t allocate_transhuge(void *ptr, int pagemap_fd);
>   unsigned long default_huge_page_size(void);
>   int detect_hugetlb_page_sizes(size_t sizes[], int max);
> +int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
> +			int kpageflags_file, int orders[], int nr_orders);
>   
>   int uffd_register(int uffd, void *addr, uint64_t len,
>   		  bool miss, bool wp, bool minor);

