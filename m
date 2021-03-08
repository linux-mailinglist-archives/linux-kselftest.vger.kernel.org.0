Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB5331534
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHRtx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 12:49:53 -0500
Received: from mail-mw2nam08on2075.outbound.protection.outlook.com ([40.107.101.75]:24755
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230439AbhCHRt0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 12:49:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii/xZtch2HhuvcaPRzwjdeOtLwOTKqXUmcDJ6QC9BNfw0YfdMLlaw5isL5eZ6zCAWkAjEfrPpSGOkXoFQdA3l6GrPcZ/jIymMMy1n4s4M0c7uNtBGz8M3Cm3SBBIlCSYZ4KAgqZjd86+S+fDrk/yCWwpuMwNj+ECKvPlAJWYHXgjpm6yDPyqxV2wEmmYwKU2Ew7539Dr3nDHfGG0lXJyrORG61PQ+1m2fkMgji8aBPCcdvCFyaFPlzx4SR4DTHNVGAWVk+UVx7Im/RrV/fS8jKPHq/9HrFgmEC8erSC0t4n6/vLydaCApowE0Q764iD1CgJqTvAb05anjOgKjRGSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV4hJGx1V05SpnaDPYk+58Sy0hFvC7jWfbNOdfPT/bE=;
 b=k6jhb3Oqj2JUh297hUaPkRrBSePDBj/z58gl9QiiDY3ty86GSNcEsRu9WTRQE3wa57HmAzEEupiny/cmeorT+E8B7kpjaDukpxrzQ3enLg7TX1SRwnBG3OHfvQufcVhmaCfk5HYn08SpjCyfjZ2A7GXZ2gPk20RUkBkzIWMVqLRbNKJAxdnaNdbr0Ar19Ryh9J5HkSATszsz0wS/swPjSFC7JEbwtEecZz7BKU09io60fc6RiKaiGJVfL/JdyOF4b0wjqV9BMz6ok1AO10RW9R0kOYWJ4CQTricZDklxKeWz3kiHVXcrRrbhyQk2jN3d9FFeIZlabqY7llaQPO8p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV4hJGx1V05SpnaDPYk+58Sy0hFvC7jWfbNOdfPT/bE=;
 b=aykjKrN43OzLgjmJ8MSHdYTkf1DofDjuF9u5jMZsnazPzoqq8KVSWud80wqHGriB/amhLn3pujEpzym/slApcw6nA4k8xuYNodXZb6X2Z80Vw5miEwCWak7ItktrMxRzEhI7z8alpqeY/IGX8c008eysM2VFN6zH2dR1midDoGE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 17:49:21 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 17:49:21 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "David Hildenbrand" <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
Date:   Mon, 08 Mar 2021 12:49:14 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <AD0AFA61-8DCF-467D-B961-ACFA1D33828C@nvidia.com>
In-Reply-To: <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
References: <20210308152221.28555-1-zi.yan@sent.com>
 <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B2D15306-80F6-449A-B6E0-8DBB8B34AD9F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::7) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.237] (216.228.112.22) by BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 17:49:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5837bd1-1a06-4693-0819-08d8e25a809e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4852DD82E90CF7AE331C452FC2939@BL0PR12MB4852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J055aIPGuFeZvkBF1UmW2KD6q9HbZ3xPB8qi0jvPi5YKt3Y7jJQffEA/RnvROJRKtFhkepjzG2t2mqrofx+JXmvfXMj2JMa2YO+kkon4wnhz/fk5ETG5400Y65/8lpkWJpgFBRcKQ2kDQ31CULsKuiJToeu+JhWIxweKTK++IBvZs23V0nr6PzMElaUHaP8QdFNhu2O+K8dtczr8d68sOErQ7tynyBiRijUjRhkN//vgSN3cSf6qTpg97HQvw/AzqGuqiY/bh+ib0MhQS2UmP6nMDTA/7RT/MEo8nZkAfQpc3kPTDfWUlgiAM+k8erjUb35VaI0lErfCykahNT97p3wkKdie4RG07yMl0hx4D8nHdttB7XoI20zFOdlzVpzjBIcHdxB+j8oJBA6mAys6DLSkWaVLEljRJaFf8CStcjeDgCCZujmaqY4evqHCFIwGTZzUVB3oiPznP2MXTQpEBKMd8jvo/PCFFMnzg1p5v1Y2rQDPEL4nVRQyznk97ZXmsyWWQNVYYCDoRJM3X9FBcKWjaOL3htr588ukcKz0TD+U8x56KkmuKHXq+UNa205ryCtBHM9YFvar2xQY/UTlE7pUrsj2taLkx+F6rwAI0f80hdTw4iNujtKHmz4/c3W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(33964004)(86362001)(66946007)(66476007)(33656002)(66556008)(6666004)(4326008)(16576012)(5660300002)(54906003)(8936002)(478600001)(30864003)(316002)(186003)(235185007)(8676002)(26005)(36756003)(53546011)(6916009)(2906002)(2616005)(16526019)(956004)(83380400001)(6486002)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SksrSUE5MW91WUtMTEwyd3dMQVQ1YjFWWlRLNXp1UnpvYm5NeURQcTlTTGp6?=
 =?utf-8?B?ZFh3Y1lpNnRYVWhVVVp4b0IwT0hKblBFOU80Nm1EVm9uV1ZXRFhzOERGUDhK?=
 =?utf-8?B?OURPRnJyc3pRSVU4eDA1eEx1UXpuVW1sT0hCM1VNMmYxMFJsNGFYUFRMd1I2?=
 =?utf-8?B?RmVKUVFld0RZeEMwRFFJNjhQaTgycWxuY0trc29QN21nYythVXRuYmNQdWhT?=
 =?utf-8?B?SmxCZEM4QWJQK0p0aGE2TElSTXVDOGltdDVuTW9yYkhsZmZXQkRIOVdTd09M?=
 =?utf-8?B?MDlIcmpwMkoxditQWUlmVUFiTzllekMvL2UwNGlxL1pyL3JhdnlVNVBCZ2ZI?=
 =?utf-8?B?UkFVMlBNZ2diZnBNajBHbUJVelFpdllud3FmSVk0WmM2ZHljVHg5MUthelVv?=
 =?utf-8?B?TVpvemxIYm5wTElHaUZTZEJ4OThGbCtnTTBWbjlRNU83QmxvY1NRSTZtejZr?=
 =?utf-8?B?SXVwSXlFd3U2Q05DRFZyWDk5MkJsaG9UY0ZKQlNrNDhmOU9Fd2dpYmhFclFO?=
 =?utf-8?B?WG5KWUs5aFBqTjdTaTRIc1kvSDhvR05JbWpmcjlIcHVCNkZZNXNMK1hVQXdN?=
 =?utf-8?B?NE1ISjZKSjlzL2RaeDVrdVJrTFZpOXhrU0I1Y0ZlbWJnMG0vbWRCTFlFSGVY?=
 =?utf-8?B?Z3VxcXZpK1M1ZGNUc1dYbkowOC9QRkJYK0J6ZFQ0VVBGemVLR2pod3lEajlk?=
 =?utf-8?B?cWorRDVNeXl0V0R4RXpYSlZqUkxsbzJwOTBKdDNPc1pyQnpYMFJvTDhSTzBu?=
 =?utf-8?B?OEtvaEtpM0EwbHF1R3h2am9NaDh0cDdNRm5namdZeDhtNGwwZGI3NW1objh4?=
 =?utf-8?B?d2xxT0VPZVV4Z1F6bnRYTGV4aTZEc3RGNVhMWUVHVGtKY1FrWUtaNHpqWXM2?=
 =?utf-8?B?OW9md2RGVlJqUnF4cTNhQXRITEN1UVBzd25Wdzlra3A3ZHp4RnFuS1VQOEhV?=
 =?utf-8?B?SHp3NXU5U1Y0c2Q2dHZmTDNNdzhQeGhKTzIrWGs5eWxIOHB4MGUwNUp4KzFx?=
 =?utf-8?B?L1MrMm5oQVc1Z1R2QktyNStZTTJkYlZkYk94M2ppdnNsWUFlQks3QUFOeG0y?=
 =?utf-8?B?RG9oWStXV01VSzZadk1NdTlTMnFoek8xR2grM1NKampqWlM5TVA0YUdFSk0y?=
 =?utf-8?B?VlJmMXFiWjBwRjc4MUI5QitMM3pZbC9jZzN2UVJCanlBZW1UWlZwR1FPbDE3?=
 =?utf-8?B?K0NmSkpkZTRLSXhod2tNYUJ4Q2tTNStQZnU5Z29kSUVjWjF4cG40SVpobGtw?=
 =?utf-8?B?ZWtrNXRjMnFDQUhuOXlVSWJ1OW12dm1pZHlmYnJjeXJOWndubmRxcklGYk9x?=
 =?utf-8?B?cmt2MitqMWcvcTJiSis4R1VQdzRsQ0E1UW11Ti9SUFFpQXEvVmJIdnRhSXNW?=
 =?utf-8?B?bXV6dk1uMzdIcThtNnVFTzVXMUpRRXlDdVRSOEE2VEhpZVR2RXpRbDNxRWc0?=
 =?utf-8?B?dDNiVHo3SXNOdkRkNXNORFEwTXZmZmlzb1pCRXFmS0RBNDlPVm9ROXJkR0Jr?=
 =?utf-8?B?SnpFN0ZDc0QrL01qbG4vVVhmSzBtZk1vblNBdTY4UVNnR2d2RXI1Zk9KM3Vw?=
 =?utf-8?B?dGJUdWdJOG9IU1Z6VXBzTzN3Z3Z5TkMrUlVHSzltWmdLT3AxdnkxbFpGelBx?=
 =?utf-8?B?ejRwL0dQQlZ3N2FzSVlOWkYyai9KTGZsdFJPK1RCbW5PTk5TT1Q4VUVXVDBq?=
 =?utf-8?B?V1RCZXdIbUxMRTMzUkpWb1p2RHY2M3M4eU9EQ2dDbmZNUnZ6OC8rZnRLcEFk?=
 =?utf-8?Q?BmcnwRvHcF69NeZdWom6Fh+5cGjZk4PQe7Oyz/d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5837bd1-1a06-4693-0819-08d8e25a809e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 17:49:21.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6883DSnH3JjKc6L2xmqaTrj2sQVQQ5Rqq7CDs8/IM0bvBzxsNMDGjvFrGgYOk3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_B2D15306-80F6-449A-B6E0-8DBB8B34AD9F_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8 Mar 2021, at 11:17, David Hildenbrand wrote:

> On 08.03.21 16:22, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with the
>> given pid and virtual address range are split. It is used to test
>> split_huge_page function. In addition, a selftest program is added to
>> tools/testing/selftests/vm to utilize the interface by splitting
>> PMD THPs and PTE-mapped THPs.
>
> Won't something like
>
> 1. MADV_HUGEPAGE
>
> 2. Access memory
>
> 3. MADV_NOHUGEPAGE
>
> Have a similar effect? What's the benefit of this?

Thanks for checking the patch.

No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
nothing else will be done.

Without this, we do not have a way of splitting a specific THP
(the compound page) via any user interface for debugging.
We can only write to <debugfs>/split_huge_pages to split all THPs
in the system, which has an unwanted effect on the whole system
and can overwhelm us with a lot of information. This new debugfs
interface provides a more precise method.

>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c                              |  98 ++++++
>>   mm/internal.h                                 |   1 +
>>   mm/migrate.c                                  |   2 +-
>>   tools/testing/selftests/vm/.gitignore         |   1 +
>>   tools/testing/selftests/vm/Makefile           |   1 +
>>   .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++=
++
>>   6 files changed, 420 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c=

>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 395c75111d33..818172f887bf 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -7,6 +7,7 @@
>>    #include <linux/mm.h>
>>   #include <linux/sched.h>
>> +#include <linux/sched/mm.h>
>>   #include <linux/sched/coredump.h>
>>   #include <linux/sched/numa_balancing.h>
>>   #include <linux/highmem.h>
>> @@ -2971,10 +2972,107 @@ static int split_huge_pages_set(void *data, u=
64 val)
>>   DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pag=
es_set,
>>   		"%llu\n");
>>  +static ssize_t split_huge_pages_in_range_pid_write(struct file *file=
,
>> +		const char __user *buf, size_t count, loff_t *ppops)
>> +{
>> +	static DEFINE_MUTEX(mutex);
>> +	ssize_t ret;
>> +	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>> +	int pid;
>> +	unsigned long vaddr_start, vaddr_end, addr;
>> +	nodemask_t task_nodes;
>> +	struct mm_struct *mm;
>> +	unsigned long total =3D 0, split =3D 0;
>> +
>> +	ret =3D mutex_lock_interruptible(&mutex);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D -EFAULT;
>> +
>> +	memset(input_buf, 0, 80);
>> +	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>> +		goto out;
>> +
>> +	input_buf[79] =3D '\0';
>> +	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vad=
dr_end);
>> +	if (ret !=3D 3) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> +	vaddr_start &=3D PAGE_MASK;
>> +	vaddr_end &=3D PAGE_MASK;
>> +
>> +	ret =3D strlen(input_buf);
>> +	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
>> +		 pid, vaddr_start, vaddr_end);
>> +
>> +	mm =3D find_mm_struct(pid, &task_nodes);
>> +	if (IS_ERR(mm)) {
>> +		ret =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	mmap_read_lock(mm);
>> +	/*
>> +	 * always increase addr by PAGE_SIZE, since we could have a PTE page=

>> +	 * table filled with PTE-mapped THPs, each of which is distinct.
>> +	 */
>> +	for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SIZE) {
>> +		struct vm_area_struct *vma =3D find_vma(mm, addr);
>> +		unsigned int follflags;
>> +		struct page *page;
>> +
>> +		if (!vma || addr < vma->vm_start || !vma_migratable(vma))
>> +			break;
>> +
>> +		/* FOLL_DUMP to ignore special (like zero) pages */
>> +		follflags =3D FOLL_GET | FOLL_DUMP;
>> +		page =3D follow_page(vma, addr, follflags);
>> +
>> +		if (IS_ERR(page))
>> +			break;
>> +		if (!page)
>> +			break;
>> +
>> +		if (!is_transparent_hugepage(page))
>> +			continue;
>> +
>> +		total++;
>> +		if (!can_split_huge_page(compound_head(page), NULL))
>> +			continue;
>> +
>> +		if (!trylock_page(page))
>> +			continue;
>> +
>> +		if (!split_huge_page(page))
>> +			split++;
>> +
>> +		unlock_page(page);
>> +		put_page(page);
>> +	}
>> +	mmap_read_unlock(mm);
>> +	mmput(mm);
>> +
>> +	pr_debug("%lu of %lu THP split\n", split, total);
>> +out:
>> +	mutex_unlock(&mutex);
>> +	return ret;
>> +
>> +}
>> +
>> +static const struct file_operations split_huge_pages_in_range_pid_fop=
s =3D {
>> +	.owner	 =3D THIS_MODULE,
>> +	.write	 =3D split_huge_pages_in_range_pid_write,
>> +	.llseek  =3D no_llseek,
>> +};
>> +
>>   static int __init split_huge_pages_debugfs(void)
>>   {
>>   	debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
>>   			    &split_huge_pages_fops);
>> +	debugfs_create_file("split_huge_pages_in_range_pid", 0200, NULL, NUL=
L,
>> +			    &split_huge_pages_in_range_pid_fops);
>>   	return 0;
>>   }
>>   late_initcall(split_huge_pages_debugfs);
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9902648f2206..1659d00100ef 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -623,4 +623,5 @@ struct migration_target_control {
>>   	gfp_t gfp_mask;
>>   };
>>  +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes);
>>   #endif	/* __MM_INTERNAL_H */
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 62b81d5257aa..ce5f213debb2 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1913,7 +1913,7 @@ static int do_pages_stat(struct mm_struct *mm, u=
nsigned long nr_pages,
>>   	return nr_pages ? -EFAULT : 0;
>>   }
>>  -static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_n=
odes)
>> +struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>   {
>>   	struct task_struct *task;
>>   	struct mm_struct *mm;
>> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/sel=
ftests/vm/.gitignore
>> index 9a35c3f6a557..1f651e85ed60 100644
>> --- a/tools/testing/selftests/vm/.gitignore
>> +++ b/tools/testing/selftests/vm/.gitignore
>> @@ -22,3 +22,4 @@ map_fixed_noreplace
>>   write_to_hugetlbfs
>>   hmm-tests
>>   local_config.*
>> +split_huge_page_test
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selft=
ests/vm/Makefile
>> index d42115e4284d..4cbc91d6869f 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
>>   TEST_GEN_FILES +=3D thuge-gen
>>   TEST_GEN_FILES +=3D transhuge-stress
>>   TEST_GEN_FILES +=3D userfaultfd
>> +TEST_GEN_FILES +=3D split_huge_page_test
>>    ifeq ($(MACHINE),x86_64)
>>   CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/trivia=
l_32bit_program.c -m32)
>> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools=
/testing/selftests/vm/split_huge_page_test.c
>> new file mode 100644
>> index 000000000000..8ea8000fda62
>> --- /dev/null
>> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
>> @@ -0,0 +1,318 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * A test of splitting PMD THPs and PTE-mapped THPs from a specified =
virtual
>> + * address range in a process via <debugfs>/split_huge_pages_in_range=
_pid
>> + * interface.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include "numa.h"
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <inttypes.h>
>> +#include <string.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include <sys/mman.h>
>> +#include <sys/time.h>
>> +#include <sys/wait.h>
>> +#include <malloc.h>
>> +#include <stdbool.h>
>> +
>> +uint64_t pagesize;
>> +unsigned int pageshift;
>> +uint64_t pmd_pagesize;
>> +
>> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_=
size"
>> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pi=
d"
>> +#define SMAP_PATH "/proc/self/smaps"
>> +#define INPUT_MAX 80
>> +
>> +#define PFN_MASK     ((1UL<<55)-1)
>> +#define KPF_THP      (1UL<<22)
>> +
>> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_fi=
le)
>> +{
>> +	uint64_t paddr;
>> +	uint64_t page_flags;
>> +
>> +	if (pagemap_file) {
>> +		pread(pagemap_file, &paddr, sizeof(paddr),
>> +			((long)vaddr >> pageshift) * sizeof(paddr));
>> +
>> +		if (kpageflags_file) {
>> +			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>> +				(paddr & PFN_MASK) * sizeof(page_flags));
>> +
>> +			return !!(page_flags & KPF_THP);
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +
>> +static uint64_t read_pmd_pagesize(void)
>> +{
>> +	int fd;
>> +	char buf[20];
>> +	ssize_t num_read;
>> +
>> +	fd =3D open(PMD_SIZE_PATH, O_RDONLY);
>> +	if (fd =3D=3D -1) {
>> +		perror("Open hpage_pmd_size failed");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	num_read =3D read(fd, buf, 19);
>> +	if (num_read < 1) {
>> +		close(fd);
>> +		perror("Read hpage_pmd_size failed");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	buf[num_read] =3D '\0';
>> +	close(fd);
>> +
>> +	return strtoul(buf, NULL, 10);
>> +}
>> +
>> +static int write_file(const char *path, const char *buf, size_t bufle=
n)
>> +{
>> +	int fd;
>> +	ssize_t numwritten;
>> +
>> +	fd =3D open(path, O_WRONLY);
>> +	if (fd =3D=3D -1)
>> +		return 0;
>> +
>> +	numwritten =3D write(fd, buf, buflen - 1);
>> +	close(fd);
>> +	if (numwritten < 1)
>> +		return 0;
>> +
>> +	return (unsigned int) numwritten;
>> +}
>> +
>> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vad=
dr_end)
>> +{
>> +	char input[INPUT_MAX];
>> +	int ret;
>> +
>> +	ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_star=
t,
>> +			vaddr_end);
>> +	if (ret >=3D INPUT_MAX) {
>> +		printf("%s: Debugfs input is too long\n", __func__);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
>> +		perror(SPLIT_DEBUGFS);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +}
>> +
>> +#define MAX_LINE_LENGTH 500
>> +
>> +static bool check_for_pattern(FILE *fp, const char *pattern, char *bu=
f)
>> +{
>> +	while (fgets(buf, MAX_LINE_LENGTH, fp) !=3D NULL) {
>> +		if (!strncmp(buf, pattern, strlen(pattern)))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static uint64_t check_huge(void *addr)
>> +{
>> +	uint64_t thp =3D 0;
>> +	int ret;
>> +	FILE *fp;
>> +	char buffer[MAX_LINE_LENGTH];
>> +	char addr_pattern[MAX_LINE_LENGTH];
>> +
>> +	ret =3D snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
>> +		       (unsigned long) addr);
>> +	if (ret >=3D MAX_LINE_LENGTH) {
>> +		printf("%s: Pattern is too long\n", __func__);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +
>> +	fp =3D fopen(SMAP_PATH, "r");
>> +	if (!fp) {
>> +		printf("%s: Failed to open file %s\n", __func__, SMAP_PATH);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	if (!check_for_pattern(fp, addr_pattern, buffer))
>> +		goto err_out;
>> +
>> +	/*
>> +	 * Fetch the AnonHugePages: in the same block and check the number o=
f
>> +	 * hugepages.
>> +	 */
>> +	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
>> +		goto err_out;
>> +
>> +	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) !=3D 1) {
>> +		printf("Reading smap error\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +err_out:
>> +	fclose(fp);
>> +	return thp;
>> +}
>> +
>> +void split_pmd_thp(void)
>> +{
>> +	char *one_page;
>> +	size_t len =3D 4 * pmd_pagesize;
>> +	uint64_t thp_size;
>> +	size_t i;
>> +
>> +	one_page =3D memalign(pmd_pagesize, len);
>> +
>> +	madvise(one_page, len, MADV_HUGEPAGE);
>> +
>> +	for (i =3D 0; i < len; i++)
>> +		one_page[i] =3D (char)i;
>> +
>> +	thp_size =3D check_huge(one_page);
>> +	if (!thp_size) {
>> +		printf("No THP is allocatd");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* split all possible huge pages */
>> +	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len=
);
>> +
>> +	for (i =3D 0; i < len; i++)
>> +		if (one_page[i] !=3D (char)i) {
>> +			printf("%ld byte corrupted\n", i);
>> +			exit(EXIT_FAILURE);
>> +		}
>> +
>> +
>> +	thp_size =3D check_huge(one_page);
>> +	if (thp_size) {
>> +		printf("Still %ld kB AnonHugePages not split\n", thp_size);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	printf("Split huge pages successful\n");
>> +	free(one_page);
>> +}
>> +
>> +void split_pte_mapped_thp(void)
>> +{
>> +	char *one_page, *pte_mapped, *pte_mapped2;
>> +	size_t len =3D 4 * pmd_pagesize;
>> +	uint64_t thp_size;
>> +	size_t i;
>> +	const char *pagemap_template =3D "/proc/%d/pagemap";
>> +	const char *kpageflags_proc =3D "/proc/kpageflags";
>> +	char pagemap_proc[255];
>> +	int pagemap_fd;
>> +	int kpageflags_fd;
>> +
>> +	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) {
>> +		perror("get pagemap proc error");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>> +
>> +	if (pagemap_fd =3D=3D -1) {
>> +		perror("read pagemap:");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
>> +
>> +	if (kpageflags_fd =3D=3D -1) {
>> +		perror("read kpageflags:");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> +
>> +	madvise(one_page, len, MADV_HUGEPAGE);
>> +
>> +	for (i =3D 0; i < len; i++)
>> +		one_page[i] =3D (char)i;
>> +
>> +	thp_size =3D check_huge(one_page);
>> +	if (!thp_size) {
>> +		printf("No THP is allocatd");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);=

>> +
>> +	for (i =3D 1; i < 4; i++) {
>> +		pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + pagesize * i,
>> +				     pagesize, pagesize,
>> +				     MREMAP_MAYMOVE|MREMAP_FIXED,
>> +				     pte_mapped + pagesize * i);
>> +		if (pte_mapped2 =3D=3D (char *)-1) {
>> +			perror("mremap failed");
>> +			exit(EXIT_FAILURE);
>> +		}
>> +	}
>> +
>> +	/* smap does not show THPs after mremap, use kpageflags instead */
>> +	thp_size =3D 0;
>> +	for (i =3D 0; i < pagesize * 4; i++)
>> +		if (i % pagesize =3D=3D 0 &&
>> +		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>> +			thp_size++;
>> +
>> +	if (thp_size !=3D 4) {
>> +		printf("Some THPs are missing during mremap\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* split all possible huge pages */
>> +	write_debugfs(getpid(), (uint64_t)pte_mapped,
>> +		      (uint64_t)pte_mapped + pagesize * 4);
>> +
>> +	/* smap does not show THPs after mremap, use kpageflags instead */
>> +	thp_size =3D 0;
>> +	for (i =3D 0; i < pagesize * 4; i++) {
>> +		if (pte_mapped[i] !=3D (char)i) {
>> +			printf("%ld byte corrupted\n", i);
>> +			exit(EXIT_FAILURE);
>> +		}
>> +		if (i % pagesize =3D=3D 0 &&
>> +		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>> +			thp_size++;
>> +	}
>> +
>> +	if (thp_size) {
>> +		printf("Still %ld THPs not split\n", thp_size);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	printf("Split PTE-mapped huge pages successful\n");
>> +	munmap(one_page, len);
>> +	close(pagemap_fd);
>> +	close(kpageflags_fd);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	if (geteuid() !=3D 0) {
>> +		printf("Please run the benchmark as root\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	pagesize =3D getpagesize();
>> +	pageshift =3D ffs(pagesize) - 1;
>> +	pmd_pagesize =3D read_pmd_pagesize();
>> +
>> +	split_pmd_thp();
>> +	split_pte_mapped_thp();
>> +
>> +	return 0;
>> +}
>>
>
>
> -- =

> Thanks,
>
> David / dhildenb


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_B2D15306-80F6-449A-B6E0-8DBB8B34AD9F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBGY5oPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9p4QAJdAj7Q26ZjEa4k2jbOei92J7AfP4G5l/vEZ
c0cTxUkPWzX945FIt9M12SptStkkSDg92Y0tkqQP2KQKEuXFK7J85d31Kj+BcUQs
a63vB5VkTy64w//Jus2iGmfksJCMdui1w1CLoxzJNn9hrrc5q4RXFq00fBIEotFv
TR9Yml7l2dO7QKfZx0dYbqzc88+6puwQh8nbNvQeB2yav6oemVqcKLkasKFxUpYk
rNv5apOIVceuyw6EUTsLYbvJwE0nWKGcGcVNlvLAusFKZZ7Bc7ZK3HyKiQ51mcam
cBF70XiqVpmOZG/bA5qJtA2IXoLkLl2/wOs61MBThugmG5bzC4XXccfp1g86x2nC
hI/9nWSY7IDvqPaSPxPQCOMN0utPT1oZpLtfd8g3Rd2JKrUvFkfyMM0xaio32pBp
AAmz7Zv6oX9IbnZFGPEOmXROXXxlJf9hZ0zY1Uj9Fm7dNdazTUny6Yqr0a5UVsLZ
4iyFVy4e0mCL5SUzASM6eTliLGA+z4zKEiNhGjc25Acl8JLk62A4H5g3wgt9yXss
37vSMwDzxF3vKavcRo2PPwcT7nXxqbnAt+yeZMI/1QVVcNAms6AuhTkbEWD6SDS3
3RaSw5QUiMnPsmvzejAnLRJnR/3DFAHj4Yx9wix+GhqkP0QFZxeA+lyZSa98yJ0v
fZ745A55
=WItD
-----END PGP SIGNATURE-----

--=_MailMate_B2D15306-80F6-449A-B6E0-8DBB8B34AD9F_=--
