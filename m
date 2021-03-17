Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6E33F446
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhCQPsr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 11:48:47 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:34752
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232471AbhCQPsN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVYXNreD19k/ZY9uC4rYXMD8hYZANbzG5G7CUi1abDM/lJQNikPDx6AB1ZIIjYgjld7Ro300JAOqqsvaneev8LWZ3PxmMyx+8ZG40QtvyTtYzMcxW+qcTib6Y92TIqpshWUFk5qzucxwFm3eFPf2je2Oaf25D/EIc5TpQrO/zCD343sRs2Q/eyJCeNNfapcT11UaJ6GSbsaz30p+Ux0G5VzceD7Id5aRkoT9L2rqSZqwmM1yCbmYh+jna/aRVMIuT3xpzca2+tFdNHZehHo7tz15GzaRlufFp1JpbCq0wW+098LfPmN91LabbJMvJOyKB2ap1H3melBvxgbmQeBqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtYLyWY4afAuTiqKajBQ8OzgHpV9HBenqKb5XDMcdSs=;
 b=SuiDwRxQp+g/IimZ/r0Q8BVf1ovXaeVPSJWWVaX29Yi8EmQKRyCuvLe5S8kV0z0QrDLtTh8sftpWWtDd4HrTOJ4jLk6Rql6v0mGForJSN9P+JIhY+RzAG+zVHAKk2TozQfLO5Zue8hzoOQguFYVcMShMyzAkSOARd2E3KFmImXpwkjKEp8W3r2ro4IoReD/LR8Af6rZbJpMyZtt5Ukegb3c7M1C6XtPVfmdl/1WGtTAOjasfQjOc0mmFCy5XPmX2fCK5RCEPw56RZkkRJByRqel+VatXqeKb7OCcgCmfYNesQGXnuvRRMYstWnBfX+wPQLWFBdzDtPzkt3gIVrh1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtYLyWY4afAuTiqKajBQ8OzgHpV9HBenqKb5XDMcdSs=;
 b=EKtxQo+eId7QTvAFVAv8EnC/KN19wSJWONiCSVJpuQFmvvS9Qi3NzUqd1/smVd+IkClOZ5J+HPIcKEHHpRhaSDXs2FZceCyIsB7kk0qRX1mmhAdiTNS+aXdFf5FkY1kscmFzX4a/CW1a9Ru3T5xcuTCDCXoRjdUiHqJlna8vlGItZA4cOAJrIjT/7KjlAAn+y3lUXdBl3Nlocv6LMxqJvIak8BIghsVHjyC2qRq+j+JyLVtqM+PZYDfe82NbRgUA9Y+IX+ZALFvGMuOl0CpA4wTd7lIlrDdmXc66EIp643AbMBuuZe1y8ubZWV/IO6LFp2B21VJEXr3AJJdet/LGgA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3871.namprd12.prod.outlook.com (2603:10b6:208:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 14:52:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 14:52:02 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mika Penttila" <mika.penttila@nextfour.com>
Subject: Re: [PATCH v4 1/2] mm: huge_memory: a new debugfs interface for
 splitting THP tests.
Date:   Wed, 17 Mar 2021 10:51:55 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <E0700320-BB6B-451D-A8F2-A7BA5B5F4D7B@nvidia.com>
In-Reply-To: <CAHbLzkrK5=QOy_GM3iLbHWVk_Xhk+4exA6rKidt=M1dUN0mCog@mail.gmail.com>
References: <20210315203349.171760-1-zi.yan@sent.com>
 <CAHbLzkrK5=QOy_GM3iLbHWVk_Xhk+4exA6rKidt=M1dUN0mCog@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A3BE8E8D-044D-4D0C-8008-7A6659AD4ED4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 14:51:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aecf52b-6f33-4da6-1fe2-08d8e9543942
X-MS-TrafficTypeDiagnostic: MN2PR12MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB387154A3F05CB8C3EA974EC4C26A9@MN2PR12MB3871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRynTIJen5ZNMjinATj6Y1iQvLVg0hefl6PmXoy/NtZcJsMs8rT+2U2zLRQAApY94g3zG6DRu88iuEPzXjyFsIOeD82qOgikODnOmr/QYOXLkjw4+Dori1j2kF78j8FN63m7Hi3hrzf5kFzdJ61eXceEyZeWoPqLbTQdD8jn+rww5DZn3kIvSAxh+YAjZmbSXN1AifvAx8ndWhtdOmLZERsTC/Z/aXV0smp3rzJqeSiDTti8gJrEi2gmkBoeShRInA4SH3wisvR7D9Ao3L4es31p9yBku6oQ/3J+8QC4TjVlHS2sfyb10RoB5h9I9eBJxy6I+4caId128iAC0CekI+rxvqRpcPMAvAQsAlCr2d4sTo0vFq8/VECEgqettOuSvg6sg0J4CRKbfarYoH3ml37G95cgPDXu2h7NLgR/cTFy6RNw/6QUhWZotTKOFhDnLlxs1K6AdmibO9cE4TFYifN3P5hfSQ0tm4xde6Qby7PbzYl+70mHnZQzPieH6pk7Gvk3KMg7ssWLoyl3c82AE/c6nb7tpTV0bqQXNVl1iBqOZ/8fVsnkRKqbkUQTUzI/HOWCy5xYp/ZIwOJGzfON9A0hU+ZRPxgglpFHk9Jxd9WnOdSnmEnnV/hBWHKRwYEfobmy6lIB6hinIe9kI2vrb6b92NaheLqy2HCWxDEtuDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(36756003)(26005)(8936002)(6666004)(4326008)(33656002)(16576012)(478600001)(316002)(8676002)(6916009)(53546011)(2616005)(86362001)(2906002)(235185007)(956004)(54906003)(30864003)(66476007)(66946007)(83380400001)(66556008)(16526019)(6486002)(7416002)(186003)(5660300002)(33964004)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dTBDamhRa1NBcVR3UExCNThxcDc2VUE1WTZIeHRZcnhIbUUyRmd2N0t3MjV1?=
 =?utf-8?B?NWFveXNPTm9xcVg2ejRITStLeVZZaXZxbGhnSktkajVDYmJ2anFBMG53RFM4?=
 =?utf-8?B?ekRZY0ZZa1FvYlFYdmxYcjlBc2ZiM1Vwa3Uwcmc0cnduRDV1czUyajBnQnZz?=
 =?utf-8?B?M2x0aVdXdFRJWlpNZ05kLzVlQzRwYjFiSWdnM0M3bHVReHVuMEFVQWNsdmI0?=
 =?utf-8?B?c3ozcDVybndnTGxsV2VFaEo1c0t2ZXVVNFh0QTlCQStUTXNvMktlWTdUc3Bj?=
 =?utf-8?B?RWpyVnBEaWpJdHNkTFl5cFUxWEJFRTQxdjlQOWFlYnhxWk1IK3dST3p3Sys5?=
 =?utf-8?B?dkxYV0x1dnZtUDF2Y2FkRFo0Si9JUlNKT3h3S3JNYTVZaXF0UlpOSHNEeW8v?=
 =?utf-8?B?K3dJR0dtVmxzK1RHZ2M3bEZqOEZrbWloOXlGVXpuMjBzMllxTWJkU3VLTHdO?=
 =?utf-8?B?R2psYUMwYjh0TkVnM3E3WjlINGMraUZ0K2xWMEZxNVFnWThlNzI3VkFmZEVU?=
 =?utf-8?B?TVQ0aWFnY3prL3AyT0JDTU5oaWhRVzR4QmFhZTdSVytHRUYxYklhalh3Q1k4?=
 =?utf-8?B?U2dzTGdxSUs1VmJuMURpTTRXcWhqWW9LQStvWWV4aHBvQkJabG4rMTFkV3Z6?=
 =?utf-8?B?b0NaY0ZaOXBZVlJ5UXZkUE9tZXB5WWFabmJNVkNxNFE5eUdoNXNCT2Nxemg4?=
 =?utf-8?B?MHoyUlMvUlFBMkQ4VGxZajAzVU1tL3Rjbml1ZlpWb3c0UGV5RU1aNEw3T1lE?=
 =?utf-8?B?NXJYNlF1ODNLeUhMcjltWGhoM01tMHl3cHU4RXVxd0VETjQxYjBLN2ljVWl1?=
 =?utf-8?B?T0hGbXNKOENWWjF5OFdIaDhlWENEcXhoQWszOVZ3eUIwZ3ZNdTRjQlhIZEVO?=
 =?utf-8?B?bnRDVHh0Vy92dlVOUWxiWG9vQ0lablB5RTR0d09KNDk4UUltR1dCNFliWEo0?=
 =?utf-8?B?cVZOYWVNdEtyVm95aWp4ZWs5N2tKNjVteDEwK3JjNzJiWE9vTDBKT3IxNVRu?=
 =?utf-8?B?Q0dSVWNYUjdtMDRBYWJ2UW5CcWc4UzhoTWs1Rjlrd1lMS2tVZWc3TWovbGJr?=
 =?utf-8?B?MXNFYys0ZUtPT3pqZnVBQ3pTc0N6M1dZZ2pIWXBDZVlVeGl0ZmhXd3ZFT0ll?=
 =?utf-8?B?RnY0VjdSMXVZdjNSRzM5SEFIVXh1QWsvSnBkdkdQOWM2d1orYzVDSWlkTEM4?=
 =?utf-8?B?S3RYWGwxcWhGOEFiYUdKcXQrSC9aVUFLRURYeWphVGpLcStwc0V1d1drZDNI?=
 =?utf-8?B?bVF0NDZpbzUvbUNrLy9XbmpFcWVGWElGaE03bUp5OEliK3EyY05hZ3pmOGhp?=
 =?utf-8?B?RmpFbThVUFljWUtEa2c5am1Kb2ZJSWdnNXhJb3hCQ0NCbzA5Q1pJQzhjUElz?=
 =?utf-8?B?QVVvY3pkejE4WWNLaForYUpNaVE1eWdvV1NTaW5VR0E2dmFlaDdzelBaQW1B?=
 =?utf-8?B?VVZoSjcya25zVkZtcjlmVlRYUDlleDhtRmJhdFhGY1NpMWNxSldTN05oeFlR?=
 =?utf-8?B?Mi8vSm1rUkZNRVBtS3oxR1BPQ2dEa3Y5YlpSMlhmSDFoVXE3YWJENEIwYlR0?=
 =?utf-8?B?L2IyOFBGZUFTTTlCL1g2V2xqQUFRdEs5Q0RKcGdUVmFReUFiOVRTUHF6cnlC?=
 =?utf-8?B?ZGMwZi9MdGRjQWQzWCtMRVBEc2xZN2NCTERxKytQbnVtNDBaWGJzbWZhZzU2?=
 =?utf-8?B?c3FqVXFxd0tDS3ZOa0Q2UU8zMFhkaGxxcFlJYTVEK3VrQjFPNmpSS2k5Mm1C?=
 =?utf-8?Q?eazdpN/9foggTkADFZQ9mqOCfTmRLMJazb9OTD/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aecf52b-6f33-4da6-1fe2-08d8e9543942
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 14:52:02.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxBR7M2Mj+1zpE6bVYzqAhe8SHpWG+Fdh3h6qpd0D6YowQB4MpN51IEZ2J2LKOE9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_A3BE8E8D-044D-4D0C-8008-7A6659AD4ED4_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 16 Mar 2021, at 18:23, Yang Shi wrote:

> On Mon, Mar 15, 2021 at 1:34 PM Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We did not have a direct user interface of splitting the compound page=

>> backing a THP and there is no need unless we want to expose the THP
>> implementation details to users. Make <debugfs>/split_huge_pages accep=
t
>> a new command to do that.
>>
>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>> <debugfs>/split_huge_pages, THPs within the given virtual address rang=
e
>> from the process with the given pid are split. It is used to test
>> split_huge_page function. In addition, a selftest program is added to
>> tools/testing/selftests/vm to utilize the interface by splitting
>> PMD THPs and PTE-mapped THPs.
>>
>> This does not change the old behavior, i.e., writing 1 to the interfac=
e
>> to split all THPs in the system.
>>
>> Changelog:
>>
>> From v3:
>> 1. Factored out split huge pages in the given pid code to a separate
>>    function.
>> 2. Added the missing put_page for not split pages.
>> 3. pr_debug -> pr_info, make reading results simpler.
>>
>> From v2:
>>
>> 1. Reused existing <debugfs>/split_huge_pages interface. (suggested by=

>>    Yang Shi)
>>
>> From v1:
>>
>> 1. Removed unnecessary calling to vma_migratable, spotted by kernel te=
st
>>    robot <lkp@intel.com>.
>> 2. Dropped the use of find_mm_struct and code it directly, since there=

>>    is no need for the permission check in that function and the functi=
on
>>    is only available when migration is on.
>> 3. Added some comments in the selftest program to clarify how PTE-mapp=
ed
>>    THPs are formed.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c                              | 136 +++++++-
>>  tools/testing/selftests/vm/.gitignore         |   1 +
>>  tools/testing/selftests/vm/Makefile           |   1 +
>>  .../selftests/vm/split_huge_page_test.c       | 313 +++++++++++++++++=
+
>>  4 files changed, 444 insertions(+), 7 deletions(-)
>>  create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bff92dea5ab3..3bfee54e2cd0 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -7,6 +7,7 @@
>>
>>  #include <linux/mm.h>
>>  #include <linux/sched.h>
>> +#include <linux/sched/mm.h>
>>  #include <linux/sched/coredump.h>
>>  #include <linux/sched/numa_balancing.h>
>>  #include <linux/highmem.h>
>> @@ -2922,16 +2923,14 @@ static struct shrinker deferred_split_shrinker=
 =3D {
>>  };
>>
>>  #ifdef CONFIG_DEBUG_FS
>> -static int split_huge_pages_set(void *data, u64 val)
>> +static void split_huge_pages_all(void)
>>  {
>>         struct zone *zone;
>>         struct page *page;
>>         unsigned long pfn, max_zone_pfn;
>>         unsigned long total =3D 0, split =3D 0;
>>
>> -       if (val !=3D 1)
>> -               return -EINVAL;
>> -
>> +       pr_info("Split all THPs\n");
>>         for_each_populated_zone(zone) {
>>                 max_zone_pfn =3D zone_end_pfn(zone);
>>                 for (pfn =3D zone->zone_start_pfn; pfn < max_zone_pfn;=
 pfn++) {
>> @@ -2959,11 +2958,134 @@ static int split_huge_pages_set(void *data, u=
64 val)
>>         }
>>
>>         pr_info("%lu of %lu THP split\n", split, total);
>> +}
>>
>> -       return 0;
>> +static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>> +                               unsigned long vaddr_end)
>> +{
>> +       int ret =3D 0;
>> +       struct task_struct *task;
>> +       struct mm_struct *mm;
>> +       unsigned long total =3D 0, split =3D 0;
>> +       unsigned long addr;
>> +
>> +       vaddr_start &=3D PAGE_MASK;
>> +       vaddr_end &=3D PAGE_MASK;
>> +
>> +       /* Find the task_struct from pid */
>> +       rcu_read_lock();
>> +       task =3D find_task_by_vpid(pid);
>> +       if (!task) {
>> +               rcu_read_unlock();
>> +               ret =3D -ESRCH;
>> +               goto out;
>> +       }
>> +       get_task_struct(task);
>> +       rcu_read_unlock();
>> +
>> +       /* Find the mm_struct */
>> +       mm =3D get_task_mm(task);
>> +       put_task_struct(task);
>> +
>> +       if (!mm) {
>> +               ret =3D -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n=
",
>> +                pid, vaddr_start, vaddr_end);
>> +
>> +       mmap_read_lock(mm);
>> +       /*
>> +        * always increase addr by PAGE_SIZE, since we could have a PT=
E page
>> +        * table filled with PTE-mapped THPs, each of which is distinc=
t.
>> +        */
>> +       for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SI=
ZE) {
>> +               struct vm_area_struct *vma =3D find_vma(mm, addr);
>> +               unsigned int follflags;
>> +               struct page *page;
>> +
>> +               if (!vma || addr < vma->vm_start)
>> +                       break;
>
> I think you could skip some special vmas, i.e. VM_HUGETLB, VM_PFNMAP,
> VM_MIXEDMAP and VM_IO, this should save some time for some cases.
>

Sure. Will do.

>> +
>> +               /* FOLL_DUMP to ignore special (like zero) pages */
>> +               follflags =3D FOLL_GET | FOLL_DUMP;
>> +               page =3D follow_page(vma, addr, follflags);
>> +
>> +               if (IS_ERR(page))
>> +                       break;
>> +               if (!page)
>> +                       break;
>
> Shouldn't use continue here and in the above IS_ERR branch? The addr
> might be not mapped, but the next one might be mapped.
>

My original intention was just to test split on known THP ranges, so
the code did not anticipate any error from follow_page. But you point
makes sense. Will let the split process continue even if there is an
error or unmapped pages.

>> +
>> +               if (!is_transparent_hugepage(page))
>> +                       goto next;
>> +
>> +               total++;
>> +               if (!can_split_huge_page(compound_head(page), NULL))
>> +                       goto next;
>> +
>> +               if (!trylock_page(page))
>> +                       goto next;
>> +
>> +               if (!split_huge_page(page))
>> +                       split++;
>> +
>> +               unlock_page(page);
>> +next:
>> +               put_page(page);
>> +       }
>> +       mmap_read_unlock(mm);
>> +       mmput(mm);
>> +
>> +       pr_info("%lu of %lu THP split\n", split, total);
>> +
>> +out:
>> +       return ret;
>>  }
>> -DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_page=
s_set,
>> -               "%llu\n");
>> +
>> +static ssize_t split_huge_pages_write(struct file *file, const char _=
_user *buf,
>> +                               size_t count, loff_t *ppops)
>> +{
>> +       static DEFINE_MUTEX(mutex);
>
> May have a more descriptive name for the mutex?

Sure. split_debug_mutex.

>
>> +       ssize_t ret;
>> +       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
>> +       int pid;
>> +       unsigned long vaddr_start, vaddr_end;
>> +
>> +       ret =3D mutex_lock_interruptible(&mutex);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret =3D -EFAULT;
>> +
>> +       memset(input_buf, 0, 80);
>> +       if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>> +               goto out;
>> +
>> +       input_buf[79] =3D '\0';
>> +       ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start=
, &vaddr_end);
>> +       if (ret =3D=3D 1 && pid =3D=3D 1) {
>> +               split_huge_pages_all();
>> +               ret =3D strlen(input_buf);
>> +               goto out;
>> +       } else if (ret !=3D 3) {
>> +               ret =3D -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       if (!split_huge_pages_pid(pid, vaddr_start, vaddr_end))
>> +               ret =3D strlen(input_buf);
>
> Why not return the errno from split_huge_pages_pid()? The
> split_huge_pages_pid() may return -ESRCH or -EINVAL.

You are right. This is also causing a return error code issue spotted
by the bot. I am changing it to return error code from split_huge_pages_p=
id.

>
>> +out:
>> +       mutex_unlock(&mutex);
>> +       return ret;
>> +
>> +}
>> +
>> +static const struct file_operations split_huge_pages_fops =3D {
>> +       .owner   =3D THIS_MODULE,
>> +       .write   =3D split_huge_pages_write,
>> +       .llseek  =3D no_llseek,
>> +};
>>
>>  static int __init split_huge_pages_debugfs(void)
>>  {
>> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/sel=
ftests/vm/.gitignore
>> index 9a35c3f6a557..1f651e85ed60 100644
>> --- a/tools/testing/selftests/vm/.gitignore
>> +++ b/tools/testing/selftests/vm/.gitignore
>> @@ -22,3 +22,4 @@ map_fixed_noreplace
>>  write_to_hugetlbfs
>>  hmm-tests
>>  local_config.*
>> +split_huge_page_test
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selft=
ests/vm/Makefile
>> index d42115e4284d..4cbc91d6869f 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
>>  TEST_GEN_FILES +=3D thuge-gen
>>  TEST_GEN_FILES +=3D transhuge-stress
>>  TEST_GEN_FILES +=3D userfaultfd
>> +TEST_GEN_FILES +=3D split_huge_page_test
>>
>>  ifeq ($(MACHINE),x86_64)
>>  CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial=
_32bit_program.c -m32)
>> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools=
/testing/selftests/vm/split_huge_page_test.c
>> new file mode 100644
>> index 000000000000..9f33ddbb3182
>> --- /dev/null
>> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
>> @@ -0,0 +1,313 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * A test of splitting PMD THPs and PTE-mapped THPs from a specified =
virtual
>> + * address range in a process via <debugfs>/split_huge_pages interfac=
e.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <inttypes.h>
>> +#include <string.h>
>> +#include <fcntl.h>
>> +#include <sys/mman.h>
>> +#include <malloc.h>
>> +#include <stdbool.h>
>> +
>> +uint64_t pagesize;
>> +unsigned int pageshift;
>> +uint64_t pmd_pagesize;
>> +
>> +#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_=
size"
>> +#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>> +#define SMAP_PATH "/proc/self/smaps"
>> +#define INPUT_MAX 80
>> +
>> +#define PFN_MASK     ((1UL<<55)-1)
>> +#define KPF_THP      (1UL<<22)
>> +
>> +int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_fi=
le)
>> +{
>> +       uint64_t paddr;
>> +       uint64_t page_flags;
>> +
>> +       if (pagemap_file) {
>> +               pread(pagemap_file, &paddr, sizeof(paddr),
>> +                       ((long)vaddr >> pageshift) * sizeof(paddr));
>> +
>> +               if (kpageflags_file) {
>> +                       pread(kpageflags_file, &page_flags, sizeof(pag=
e_flags),
>> +                               (paddr & PFN_MASK) * sizeof(page_flags=
));
>> +
>> +                       return !!(page_flags & KPF_THP);
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
>> +
>> +static uint64_t read_pmd_pagesize(void)
>> +{
>> +       int fd;
>> +       char buf[20];
>> +       ssize_t num_read;
>> +
>> +       fd =3D open(PMD_SIZE_PATH, O_RDONLY);
>> +       if (fd =3D=3D -1) {
>> +               perror("Open hpage_pmd_size failed");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +       num_read =3D read(fd, buf, 19);
>> +       if (num_read < 1) {
>> +               close(fd);
>> +               perror("Read hpage_pmd_size failed");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +       buf[num_read] =3D '\0';
>> +       close(fd);
>> +
>> +       return strtoul(buf, NULL, 10);
>> +}
>> +
>> +static int write_file(const char *path, const char *buf, size_t bufle=
n)
>> +{
>> +       int fd;
>> +       ssize_t numwritten;
>> +
>> +       fd =3D open(path, O_WRONLY);
>> +       if (fd =3D=3D -1)
>> +               return 0;
>> +
>> +       numwritten =3D write(fd, buf, buflen - 1);
>> +       close(fd);
>> +       if (numwritten < 1)
>> +               return 0;
>> +
>> +       return (unsigned int) numwritten;
>> +}
>> +
>> +static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vad=
dr_end)
>> +{
>> +       char input[INPUT_MAX];
>> +       int ret;
>> +
>> +       ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vadd=
r_start,
>> +                       vaddr_end);
>> +       if (ret >=3D INPUT_MAX) {
>> +               printf("%s: Debugfs input is too long\n", __func__);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
>> +               perror(SPLIT_DEBUGFS);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +}
>> +
>> +#define MAX_LINE_LENGTH 500
>> +
>> +static bool check_for_pattern(FILE *fp, const char *pattern, char *bu=
f)
>> +{
>> +       while (fgets(buf, MAX_LINE_LENGTH, fp) !=3D NULL) {
>> +               if (!strncmp(buf, pattern, strlen(pattern)))
>> +                       return true;
>> +       }
>> +       return false;
>> +}
>> +
>> +static uint64_t check_huge(void *addr)
>> +{
>> +       uint64_t thp =3D 0;
>> +       int ret;
>> +       FILE *fp;
>> +       char buffer[MAX_LINE_LENGTH];
>> +       char addr_pattern[MAX_LINE_LENGTH];
>> +
>> +       ret =3D snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
>> +                      (unsigned long) addr);
>> +       if (ret >=3D MAX_LINE_LENGTH) {
>> +               printf("%s: Pattern is too long\n", __func__);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +
>> +       fp =3D fopen(SMAP_PATH, "r");
>> +       if (!fp) {
>> +               printf("%s: Failed to open file %s\n", __func__, SMAP_=
PATH);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +       if (!check_for_pattern(fp, addr_pattern, buffer))
>> +               goto err_out;
>> +
>> +       /*
>> +        * Fetch the AnonHugePages: in the same block and check the nu=
mber of
>> +        * hugepages.
>> +        */
>> +       if (!check_for_pattern(fp, "AnonHugePages:", buffer))
>> +               goto err_out;
>> +
>> +       if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) !=3D 1) {
>> +               printf("Reading smap error\n");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +err_out:
>> +       fclose(fp);
>> +       return thp;
>> +}
>> +
>> +void split_pmd_thp(void)
>> +{
>> +       char *one_page;
>> +       size_t len =3D 4 * pmd_pagesize;
>> +       uint64_t thp_size;
>> +       size_t i;
>> +
>> +       one_page =3D memalign(pmd_pagesize, len);
>
> Need to check if one_page is NULL.

Right. Thanks.

>
>> +
>> +       madvise(one_page, len, MADV_HUGEPAGE);
>> +
>> +       for (i =3D 0; i < len; i++)
>> +               one_page[i] =3D (char)i;
>> +
>> +       thp_size =3D check_huge(one_page);
>> +       if (!thp_size) {
>> +               printf("No THP is allocatd");
>
> s/allocted/allocated

Will change.
>
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       /* split all THPs */
>> +       write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page=
 + len);
>> +
>> +       for (i =3D 0; i < len; i++)
>> +               if (one_page[i] !=3D (char)i) {
>> +                       printf("%ld byte corrupted\n", i);
>> +                       exit(EXIT_FAILURE);
>> +               }
>> +
>> +
>> +       thp_size =3D check_huge(one_page);
>> +       if (thp_size) {
>> +               printf("Still %ld kB AnonHugePages not split\n", thp_s=
ize);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       printf("Split huge pages successful\n");
>> +       free(one_page);
>> +}
>> +
>> +void split_pte_mapped_thp(void)
>> +{
>> +       char *one_page, *pte_mapped, *pte_mapped2;
>> +       size_t len =3D 4 * pmd_pagesize;
>> +       uint64_t thp_size;
>> +       size_t i;
>> +       const char *pagemap_template =3D "/proc/%d/pagemap";
>> +       const char *kpageflags_proc =3D "/proc/kpageflags";
>> +       char pagemap_proc[255];
>> +       int pagemap_fd;
>> +       int kpageflags_fd;
>> +
>> +       if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < =
0) {
>> +               perror("get pagemap proc error");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +       pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>> +
>> +       if (pagemap_fd =3D=3D -1) {
>> +               perror("read pagemap:");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
>> +
>> +       if (kpageflags_fd =3D=3D -1) {
>> +               perror("read kpageflags:");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_W=
RITE,
>> +                       MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> +
>> +       madvise(one_page, len, MADV_HUGEPAGE);
>> +
>> +       for (i =3D 0; i < len; i++)
>> +               one_page[i] =3D (char)i;
>> +
>> +       thp_size =3D check_huge(one_page);
>> +       if (!thp_size) {
>> +               printf("No THP is allocatd");
>
> s/allocatd/allocated

Will change.
>
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       /* remap the first pagesize of first THP */
>> +       pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAY=
MOVE);
>> +
>> +       /* remap the Nth pagesize of Nth THP */
>> +       for (i =3D 1; i < 4; i++) {
>> +               pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + p=
agesize * i,
>> +                                    pagesize, pagesize,
>> +                                    MREMAP_MAYMOVE|MREMAP_FIXED,
>> +                                    pte_mapped + pagesize * i);
>> +               if (pte_mapped2 =3D=3D (char *)-1) {
>> +                       perror("mremap failed");
>> +                       exit(EXIT_FAILURE);
>> +               }
>> +       }
>> +
>> +       /* smap does not show THPs after mremap, use kpageflags instea=
d */
>> +       thp_size =3D 0;
>> +       for (i =3D 0; i < pagesize * 4; i++)
>> +               if (i % pagesize =3D=3D 0 &&
>> +                   is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpage=
flags_fd))
>> +                       thp_size++;
>> +
>> +       if (thp_size !=3D 4) {
>> +               printf("Some THPs are missing during mremap\n");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       /* split all remapped THPs */
>> +       write_debugfs(getpid(), (uint64_t)pte_mapped,
>> +                     (uint64_t)pte_mapped + pagesize * 4);
>> +
>> +       /* smap does not show THPs after mremap, use kpageflags instea=
d */
>> +       thp_size =3D 0;
>> +       for (i =3D 0; i < pagesize * 4; i++) {
>> +               if (pte_mapped[i] !=3D (char)i) {
>> +                       printf("%ld byte corrupted\n", i);
>> +                       exit(EXIT_FAILURE);
>> +               }
>> +               if (i % pagesize =3D=3D 0 &&
>> +                   is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpage=
flags_fd))
>> +                       thp_size++;
>> +       }
>> +
>> +       if (thp_size) {
>> +               printf("Still %ld THPs not split\n", thp_size);
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       printf("Split PTE-mapped huge pages successful\n");
>> +       munmap(one_page, len);
>> +       close(pagemap_fd);
>> +       close(kpageflags_fd);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +       if (geteuid() !=3D 0) {
>> +               printf("Please run the benchmark as root\n");
>> +               exit(EXIT_FAILURE);
>> +       }
>> +
>> +       pagesize =3D getpagesize();
>> +       pageshift =3D ffs(pagesize) - 1;
>> +       pmd_pagesize =3D read_pmd_pagesize();
>> +
>> +       split_pmd_thp();
>> +       split_pte_mapped_thp();
>> +
>> +       return 0;
>> +}
>> --
>> 2.30.1
>>

Thanks for your review and comments.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_A3BE8E8D-044D-4D0C-8008-7A6659AD4ED4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBSF4sPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKCVAQAIUdTrQh1cdW04200GoJHF6SH93fKaYgKoLU
ZraYMn4bX/hvcrSK1FpBOGZkhsxPfKI5aaXcTsMPHj+Qx8JPLkq9lzBvReKcvQSF
IS+DWPjvibyX8PL7Q/+2IbJkOCOBzfpsm/dzuBmIAAmCUoUufUSz9AaFeMHKJp5c
yX26o1DhyEUBi4/hDYZLTN44Y1GMJWlDHITDqBmV5CgB1E76xKUWD9Tz3g5YmtfT
y6PeoqBn6+AKZD9xfAoJYfJtdZBm3mqOn2n7DhqqBD1HB/4SIPjESQlSVCjYFb38
NMMlPAbUleK1gjOWJvDH/Xd49BBams3ojdAHtStQfke1lYL0UbZ9OWkUAxj82e6N
jMhT08bYNNmVJEzkaaMagWm9LZUwELt+BGYO4KF7BcHO20rQH2q5pJCrG6glU20S
i3qPKPxQ3hAt2uqMCXVfsXIC8l6ibbhqOsvW1Gtkl0kMUx/fx6CA2XX9JqSHJkXV
RS9x6eEn656xk77BpIQ7DJ5xZfGQbx0xmOgPKTnyrQi/sy4IuL1pM9v002LIp8VI
8Ek5iPKL7yhPfoXP5FjI36UWZ7gNf3lCBGJKQM8zd4nYSisGpFx5kZ6i6lU6unl5
54EPFivDHvsfJg7THI45x2Cmlc0EDdbVq2k36cPlXJm5T9DAdL8j6HJccwfzUKSi
kY+eKtmP
=HgpH
-----END PGP SIGNATURE-----

--=_MailMate_A3BE8E8D-044D-4D0C-8008-7A6659AD4ED4_=--
