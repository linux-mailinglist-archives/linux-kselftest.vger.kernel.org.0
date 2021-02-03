Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19930DECF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhBCPyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 10:54:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhBCPeZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 10:34:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FTq9u196018;
        Wed, 3 Feb 2021 15:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=evC+yvY/baRweXvhmMOVe6BiDIQe6PUcvHngw2yjVfU=;
 b=EgF5togCQykx/Lz+hqWPNJ3SpC5s2t21x4Vt8ASv/p3ieKtRG5wLicmVycK4ofwKyn8z
 bbjchpBlrViOeQPxXxKm5RigACQd/GpFLnpjaVRJ5TbJ50lhCU69q2IzuwFHqxwtrrIG
 6bxysgm9NtdilPZbcTKcxoJSytLpWwg1Tui/vVjQ3dc5u640yaZ/h4fZLfrIPbYYWpAb
 zlR8UntvkFsV0p41417/4r6LXzWAC9pwAPOexA2FNGA9wAqCZ/zeFTupjnq5gAkkjcDZ
 sxxSMZo0Pge6tkTFYcfm2tJ9ClMjklZ1hRJAV+73y62um9fgUF2hzuEI3SPsvgZrPja5 NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36fs4596wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:32:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FUdV4172341;
        Wed, 3 Feb 2021 15:32:37 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by userp3030.oracle.com with ESMTP id 36dhcyufr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU5NwY4cEJO6hvcERoRoRWXEW2epKE8TvbbfW7YSQdbJ3S8Hi7I/hvtLHGWWZyNUtpPHk2Do0ic9AS//Y3D1e7mehEHEd7Dwm3JAOVmKEGWfx9zOZ8C7PrJzxEaKC3bhmo8cE5r4m8MVHVm3iZAJ6E+N8QRpqxtutEa6+rU3zUdA6b8KZphHsWNP1VHNT8fqTbxVabHasQo6W5eWMYM6X01PbMECqvtGzqTEcFB+PfyWIcWw1enaSCkIc5w2Dw8j9DsTVbP3jkWtqEcOR8tE1RiVCWBxJyKKh3bqsRkKoNYlRo+zq8qRa4l3556DxYzZ+DiWdpcOfEsnUULKihR3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evC+yvY/baRweXvhmMOVe6BiDIQe6PUcvHngw2yjVfU=;
 b=bT/WrwUsYhp4Pzr/0LjkVsIwGjMRDtTLm6t+ApbK5LM7oWwbpWnXzPjb/6i2IPdGpuS7aH+PpCa07uT9jlQMNcAWRLAJGFpaDl/WxL2/TTnHR+irvjbvJlu0bGwJQ6MbbXBnt8Odvxv+cbaghQLH0Ns+3mZyIbMnODCn5Rz8FDR9D07OjheovxFi+pXFVR4ujz92iK49K7rnmkvUBigySK9IauNw+eSiDl/+dipySd1C0Fe0QSJmVIR9BVdb6hMSOEAKgtOF0UczGLdV1rg7aZzc60Ic+DMQglgdvFomBl6XfJtBvy9RwEZjmC8n6+4gncKfFTec+5fAqM3FNA7d2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evC+yvY/baRweXvhmMOVe6BiDIQe6PUcvHngw2yjVfU=;
 b=EDzeswRwcoVe+TCfXXdcaoFaC6CECu5J/E31BgWIzn7rFHf9IXvAwyhQNC6jfTE1SdfgCJoPiyQ0iA5aPRNWsFkQUBsBZoZV0u47HvN2u73qLBVc8XYVjEZGsCBAbHAVpgpbNN/5YFWFJNVt1LsLgXTZI6XECBiiqjMUS7Ss6iI=
Authentication-Results: namei.org; dkim=none (message not signed)
 header.d=none;namei.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4733.namprd10.prod.outlook.com (2603:10b6:a03:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 15:32:34 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 15:32:34 +0000
Subject: Re: [PATCH v8 02/14] mm/gup: check every subpage of a compound page
 during isolation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org, James Morris <jmorris@namei.org>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
 <20210125194751.1275316-3-pasha.tatashin@soleen.com>
 <05a66361-214c-2afe-22e4-12862ea1e4e2@oracle.com>
 <CA+CK2bBSJ7T=jsukntQGqO0DoWE_MnhDwtHv-6rfXAPvznKh0Q@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <ce96a71d-845b-b8d2-92d3-fc7336a765c5@oracle.com>
Date:   Wed, 3 Feb 2021 15:32:22 +0000
In-Reply-To: <CA+CK2bBSJ7T=jsukntQGqO0DoWE_MnhDwtHv-6rfXAPvznKh0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::9) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P123CA0076.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:138::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 15:32:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00683509-c8ee-4e78-ee12-08d8c858edbf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4733DFF36F6041C104EA96D7BBB49@SJ0PR10MB4733.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dx2Eu+Mp5p5ZLNRIeOSpgPkyTGizEwkruEaJy4ZiyHTw1Pm2O7KfYihdirCE+bOJiy/9RQbdx1P7lkq5kj9XStf6KiX7XMWvUQlB8AN4P34/T/Z/0Be6JFAEt2YxDno2YNxzDE9l69jw/IhIMOu+spM1kzTesENm4C9Ai5THtxnn1m0BL19Gpc+B47SaLFJDbocLyUdoXhwpQu462ZKT2nymG2ylRl6EUDy2NmPwCzXZvBa6aBmK26Iw+GDi6jH4UdDPmUz0B8X17YeN85u3SoF4i58UCh6UYajCYwA/AGS3PVSTg9LWSAmLJE7JTEQzWz85udQEXMenL2QMXpOR9wDVzdL181BkTiTj/OAAGqTKafIIuI0xaVpzKrRXO0HmiWb0xZ93E3ZAvS/hPOumrKDkon8fsoAiKF9mXqRI4FPGJ9LKlHarp7prxKTdjmy13YRGDpYbw+uw9IGeIss4VUEzH/TDkulIETOs9j1Dy/AZRUREetIx4jyGhDPqDp7jesYFeUKuaHsvqYlUuBPRUO0WSFxMdEL1bMx5SCKid48KArqXNa64/M51fu/LxID6NJ5emVgCUMWWyNr2J0iOuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(136003)(39860400002)(8676002)(6916009)(6666004)(316002)(956004)(66946007)(16576012)(53546011)(26005)(2616005)(7416002)(4326008)(478600001)(31686004)(66556008)(2906002)(8936002)(83380400001)(31696002)(86362001)(5660300002)(16526019)(54906003)(186003)(36756003)(6486002)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bmxHalU3TTNha3RoWk9QNFlJTkdyRDgrclVqVDN1UWJheWNTMndiUzhkZTBx?=
 =?utf-8?B?MGpld0c2T3V4OXdyaWxQbmdQNGkxYkJKcUdoWUpCTTJ3UW1saXFMdUF6WGQw?=
 =?utf-8?B?dmR6ZVJGRjBOWHhtYVI3K0NmR2g0NnVvY1B6QisxTFBWWkFPbmlXY2FrQnFB?=
 =?utf-8?B?ZWdZcXpOMjdjWE1EQWp1aUJhMWVYQnU4dEZlc3g4WXRib1Yvc1dmZ0VrOHRt?=
 =?utf-8?B?Z0l2RndMTElockY4YjNTWXJQVGtmN3d0aHJZeERIOVVPc3JzSExFUmpieEFZ?=
 =?utf-8?B?cmxBU2d5QjVMWGx2Q3NmSmNrd0JyVCtBZURESm02NWJCaVJXM0wzMVBTWXdW?=
 =?utf-8?B?QjdyenNhY083blYvLzc0UWNzUGQzZkw2YjZzWWFGOEJaTTdmVGNnRDVoUFdM?=
 =?utf-8?B?UEJteUM5aFhFMnhTcTJWMVB6dEo1ZmZKMEk4SUJJWW1KUW5nM1h2b0JFZlps?=
 =?utf-8?B?L3ExaDlBUHU0RXNBZFREaExhUVFaNUVhMGNmQ0wrYVEzUGdBWFNiTTdRb1Zo?=
 =?utf-8?B?dlZLd08va3BKRDI3OVMvUEVlSHg3WVlFMUV4L3l6ZUg2cmw1b2I5em9BbVNJ?=
 =?utf-8?B?dGhmdVBacHc1Z0JlVWtLYjhuckxOYUdWbDF2VFdrVktlRzBDREtmWU50R2VT?=
 =?utf-8?B?aU1jdEFSV05PR1lJTnF6WVZtY3h5S0JJMElxRzRldGF0Nk1zSjQweHdVcFUx?=
 =?utf-8?B?WnI5anBra1RGVjJJR1BsUjI2d1RsdjR0M3lzTEQ2eWpnbzdPcldON3pONDFk?=
 =?utf-8?B?MElxVGN3RGdySk1rdExndDdibC9rM2xHRW5nNmdiQ3A5aWw5czVva2MwY0ZK?=
 =?utf-8?B?VXZRY2NvbXk2YmRxb25RZ3YzRlhvaTl1WEljeHhFdCsyMjlCS3gxc1A4aUVY?=
 =?utf-8?B?YTRFYk5GejIwMXg2SmVtNHhSREdTN1pTSkVCZDJHUUlXaDN4U3VqQjUzUkFo?=
 =?utf-8?B?MVM5cXFzbnkwM3NTTENwWjNwQ3RWcTFqNlRpVzZ1NEwrdVYvaE53ZW03dit0?=
 =?utf-8?B?cE54VnQ4Y2ozenQvQW5nRkR0K0E2N29pOFl2dFd3ZFdJR0JzWkNmbVBrdlRK?=
 =?utf-8?B?amp4dWZDTXVwRHFsUEhJOWFRUU96eVVtRUJ1blIvV05RdDlqNkswTG5WZ2ZS?=
 =?utf-8?B?MWpYTTJkN0dzeGFoc0FRbVpuR2txN2xCSXZlcE9ZaXJuRTNwNDJqRlVvY09a?=
 =?utf-8?B?K3NrYjFEbk8zcXdDV05hTUNVMnVham1OZG80YjlzYUJXT1g3RDNwdmVRdkt6?=
 =?utf-8?B?dWtKOVFyajJ3V0NuVFBPQllSUmgyRGswbk9TRVQrTlEvSmdlL2QzR0VrWWIz?=
 =?utf-8?B?V3c4WnFwMG0zWTNVVWhtVUpwam14NkZyckp5T0xic25pVU1mS0xVdFNaVjh2?=
 =?utf-8?B?OUVVZ1FtZklJMGFCc1JYdkV5ZmlaZ3lvTGdZYnhzeFo2ZTlLMUoyQ0lnV21U?=
 =?utf-8?Q?bQ4eD8M1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00683509-c8ee-4e78-ee12-08d8c858edbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 15:32:34.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbeM16CvwgcY/LgDMIJYqVMfCQoVF5AZi1lGhqTf7bGfIM04Eyh1G3aOqo1dexjUeFr23OpJCBhl4G+A2ZIBCOdqT2b6Q3fLR+sHuvLj7ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4733
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/21 2:51 PM, Pavel Tatashin wrote:
> On Wed, Feb 3, 2021 at 8:23 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> On 1/25/21 7:47 PM, Pavel Tatashin wrote:
>>> When pages are isolated in check_and_migrate_movable_pages() we skip
>>> compound number of pages at a time. However, as Jason noted, it is
>>> not necessary correct that pages[i] corresponds to the pages that
>>> we skipped. This is because it is possible that the addresses in
>>> this range had split_huge_pmd()/split_huge_pud(), and these functions
>>> do not update the compound page metadata.
>>>
>>> The problem can be reproduced if something like this occurs:
>>>
>>> 1. User faulted huge pages.
>>> 2. split_huge_pmd() was called for some reason
>>> 3. User has unmapped some sub-pages in the range
>>> 4. User tries to longterm pin the addresses.
>>>
>>> The resulting pages[i] might end-up having pages which are not compound
>>> size page aligned.
>>>
>>> Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")
>>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> ---
>>
>> [...]
>>
>>>               /*
>>>                * If we get a page from the CMA zone, since we are going to
>>>                * be pinning these entries, we might as well move them out
>>> @@ -1599,8 +1596,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>>>                               }
>>>                       }
>>>               }
>>> -
>>> -             i += step;
>>>       }
>>>
>>
> 
> Hi Joao,
> 
>> With this, longterm gup will 'regress' for hugetlbfs e.g. from ~6k -> ~32k usecs when
>> pinning a 16G hugetlb file.
> 
> Estimate or you actually measured?
> 
It's what I had measured before sending. The ~ is because there's error variance.

>>
> 
>> Splitting can only occur on THP right? If so, perhaps we could retain the @step increment
> 
> Yes, I do not think we can split HugePage, only THP.
> 
Right, that's my impression too.

>> for compound pages but when !is_transparent_hugepage(head) or just PageHuge(head) like:
>>
>> +               if (!is_transparent_hugepage(head) && PageCompound(page))
>> +                       i += (compound_nr(head) - (pages[i] - head));
>>
>> Or making specific to hugetlbfs:
>>
>> +               if (PageHuge(head))
>> +                       i += (compound_nr(head) - (pages[i] - head));
> 
> Yes, this is reasonable optimization. I will submit a follow up patch
> against linux-next.
