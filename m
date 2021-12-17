Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794D14793A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhLQSQM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 13:16:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53456 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240112AbhLQSQJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 13:16:09 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHGXpOi005184;
        Fri, 17 Dec 2021 18:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+SIc1aHO1Z6S87T/YjsHWPZsW3NLz0Wxug+gM+9UDEc=;
 b=ATgH5rjnSHjqFTm/Ohxf2SxukCqgFOQZ/F8RxzrBEaMOjEUEyQMFiYu8KjC9GL5S78DV
 XzYEXPf38RobUlL78DY+nkGN3Lqv6AHJEZSqOIevUQ3O+A8x7NvVUmMVSbl42gozmmb1
 9WRZ9D8sWXP31SF+TgECdPW18DSueSbHuLXICA7TGcDNhjC/R67goHkWKfJTakRnk0/I
 sACcd/eH4JLGMvgn0/t+hjglFi4do9eImQGJ5rHh51oV1ROaty/GOJc/vxEg8MfDUWOW
 WqufPdIt+poNSDzJUarE2oQZFvzAff0QWVuqCVDEMOfZh6MPdjUKGAJjZcnSjxeUOU4r 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc6eph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 18:06:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHI0Jos024168;
        Fri, 17 Dec 2021 18:06:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3cyjubq0a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 18:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF0E9DLCa6CCZchucG9EU0GibWq1QhTnpxIgefY22UMgLYhzZtr+JCZm80gB+QxlG55SGKEAgMTbTJkr1se9xZ5Q+VynRSOFLm2I+uCmfzLJ4oW9m0iIKcuVxNj2EUo7i8664sojrmhyGHE2gLiyC+VvdEsXEhFDGjJk93sBhtbpaogjwblAx7d2ZMVBegP+rM4utK+phENlRmn6f3QDooKHnYNiqyQak/dQYeQgLYH70wljFtf7MpQiNVFjsgZs3hy1b+fD+94EpTfj1oixUxj2snLaFKDABTq0QMwDIhP17Xclrn9DJUujSjCrKFQ9acQOl2k4enkjWgM7dIhOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SIc1aHO1Z6S87T/YjsHWPZsW3NLz0Wxug+gM+9UDEc=;
 b=YInsWLdHH95GEIFHldS0Htr7UGt4P+JAP8irtaU7/d/sd4G7jeaLkKoRmCcaoIFCVZAV1bZk0jRUj3bdf+MA6i1KCGhOyWsp8rwBMbdzEHnhIRJ+pt4hk6u067Sp3Ic6mLQ0HaCrMMlytH+hZb1L1bYHevLVrUmUyZYL1rJPRXT44sYpFJo6AXr7vWx3zZoR+OXVKArKgu+MqVUoWGp3X6T7Rhf7RvVYwjNKSKOkOAGm3bdQNJO3bC2iE+P//4aYKnoz2yZJ1BuPy9rj5uzv8Zl7pUmbeolVdWxFQcSOU2E3xe0++KCMemoYm5MLnSwc2U2oEgPrjN5UsXlX2hqVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SIc1aHO1Z6S87T/YjsHWPZsW3NLz0Wxug+gM+9UDEc=;
 b=uMU5XoMkXH/VSkAx1R9DKtLeI84ZwDmSrsDdEqW8UbcngDclooiBeJ199nDgXgPiggowForY+cSDidi+4KXsmGi+O2pmCMWUCq0eCqud6BSmUX+HjzGrIQ06c80qZRLxiVgi85PR0p8k+il5zKvucB4FzGm3/dHdOXCxDTvWzG8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 18:06:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c%6]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 18:06:31 +0000
Message-ID: <0b0007b3-bf6f-ccd7-96cf-3dd861abf224@oracle.com>
Date:   Fri, 17 Dec 2021 10:06:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in
 __page_mapcount()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-4-david@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211217113049.23850-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:300:ee::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2075be1-56b6-4664-3800-08d9c187f3fc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4541:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB454115671CAEF1183BF4076AE2789@SJ0PR10MB4541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YnOdaj/1xzoqAdfOJdXAWl3aT4bgdjirZDHTerEGR1s4VEzUVvDAs2GJ4ktYVTc6/RayqbaGhKt3PUfpDiqfOwcmp9oPRhoEwHi2+oXKIWfNIO5mn3r3GGD79p4xGvp7sBopES0Y+HEEH9z6oLj/Hy5mT3yTuniGde9xiVfuZtgwVPdOU+zskMKVGDaV/1WNBUdcQdsqyEPrtwdsaN3od6AWsK9CFxclB+TZgSu9xFo6KulVsuQveTYsGISJMCwSao+OBBUAJI95niCRhN6+f2I0nf09YoS6l5PFkEP8ar529/bgJEozmQxUnZWH2yfXiWKXbMf90mrBlo4HArKtkf+wvdTmW+KJ+33oQvTshs5qaWatUj25c4SkW6fwfZqr78sca+3cwlICWBNyy/sZwBqimixrRE9jobOdbYoq4/ZN10VTyyTFCvKRapLzlP0JpalQtbAIJwQmkn98DXKgH2OsId/GkLmR/l/Bn3IZaJ3qgQEtCovyyubvsN/9rBqrMtXsbEVp3f9aApM9PcuhaQ2TCSWFWVyLuVHVzF0SNbrnKuu0izlGDkhlEHFi56P1uvMxsHRoiyDx3316kinyiwCIan4Q5JLv3xnq6ihRDFNmS/y5cpb3W10FIY8KSaaG4OxxTyZXUXFx9pVVwWBf4CveM2E0Q/KYKE3QKFPCXghC+VhxQx9tmE4dMpWpd/FoYbOdIFJ2HpuHKFZFIHJTvAGrhLQIyuc0rxTjGxXxijDyUYN+M5HiLbB3xA1TIV+XEpcTLvB8eSSck+oEXeccQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(36756003)(86362001)(6666004)(316002)(4326008)(2616005)(66946007)(186003)(26005)(508600001)(8936002)(66476007)(83380400001)(7416002)(2906002)(66556008)(5660300002)(52116002)(53546011)(31686004)(38350700002)(6506007)(38100700002)(8676002)(6486002)(54906003)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RSt5bGRMT1RGRFZ6cGlPTStISmJBRHorOXJXaU8yZnM4NGZhN25UNlJQbUgw?=
 =?utf-8?B?cGFWL204b0FKSElRbFFZY0JPSGl1dGlYMUNwQXFyWkFOd1VXekRCTjZvZ3ND?=
 =?utf-8?B?UDVMcU5HNGtOUjl6RDBnZklyM3k4d2xhZmkzZVF0NktMbFZOYnZ5OWNNUXJw?=
 =?utf-8?B?bnlSMWR4Z1FjUnNrQVdvdkpadGVGRnNRR2tpRlpZbVVNZHpzZmFvY3g2dDd6?=
 =?utf-8?B?cTZ4WHhpMVFDa3lZa2djUHBrSk5ENldMUUs3SGpoa2szNVhSbjFLeTJxUEYy?=
 =?utf-8?B?aEdZajBTWXRkM25RSFNZcE5EYVk1cVVpanE0a1NuTXd6QkMycTlQZDQyVkds?=
 =?utf-8?B?aUtlK1hGR0UyOHNNTUJQNlRoS25ENlhwUEMwbGtLTUNhZHp5MEU3Y3ViYWwr?=
 =?utf-8?B?dXpqaDQ2bTh4aTMxa281UzRWRE1SekszM2xDNTFZYmhwNys5Z3lBcFlWM0ZJ?=
 =?utf-8?B?NEJTZitmWFNPQ21BUk1zTVNUbzlVY3F3aFpvMHJvb1lnOXlzZVNicHJVNGRT?=
 =?utf-8?B?Syt3NG1EQmFnY3lMOFk2M3lKL2ZTRWRzMUhjRjlWTWpOZVB3S3F2WjRzMnNy?=
 =?utf-8?B?VEJGUEptb3ZETm8vbTVvQXlJQXYxV0lXcnh3NWgzMnBscnNyVGtycVp5YW1u?=
 =?utf-8?B?SzREN2ZtMVVqTy94V0krZCtBTFVyODZMMS9vM1BqVUEzelFYcms1Q29xaTE1?=
 =?utf-8?B?U1VlcVpQeWErTFZURnhhdk93eFNoeUZyTXZqaE5ESW1XZVVMckRvL3VNN1l0?=
 =?utf-8?B?VkZjZEpOcGp5elNzWHlKVndtcVRQWHFBcU5GQ3E2UTU0a21EZzJnUzZVTE5B?=
 =?utf-8?B?eGhZWHNGYlFiR2hnSkpUczV0eThPa1poWktXOGVWNE5VRWV1ZjZhUnJoaUxC?=
 =?utf-8?B?L1krRXg1L2xsK2RaclJGZU12dnQwdVdKc2ZyaHBYRnZLbnB0V0tjR1F4ckRJ?=
 =?utf-8?B?NUEwOXdxOU96REZzSXNmL2s2eG0wWnVOVFFwbkg0NlFkQ00rbExjQy9Wa3Ir?=
 =?utf-8?B?ZW5TN2RRUHFaT0FzT1p0c1ZXM0wrSXJmZUVuaXZRaXYwVHhDbFFwbUtURm56?=
 =?utf-8?B?QnliL0tnSnNqaU80a2lraHI5d3AweDhNc2FsZWV3akpidzcxMzYxN0dhTG9u?=
 =?utf-8?B?OXphL214ZTdFUjlXc2ZEanQ0K3NaOWZabzl1L1ZVclpRUVlWR3ZaZzVwV0wv?=
 =?utf-8?B?NnR0MFV1MHhXY2Z0WU14aW1TZVdkMDhLcjh4dU9oc1pmNVk4QXNDV3lzV1Zu?=
 =?utf-8?B?RFEzcEpSZmh4K1AzMHY2Vy9xZ0NZbFZrTlRaQ0dSdnRSdTQ5dElrSEpqMW5K?=
 =?utf-8?B?WUJ5bnZEcUhGMkdJQ255b2VtZ0dVREIzL1JvOFFSWTlMMkIrV2lhYzduUDBr?=
 =?utf-8?B?UW1PM3MxblBNTzJtdHZjWGMyZ016T0xDaXVZTk5oNjZxVFlndXByWHRqa2hy?=
 =?utf-8?B?QStvdWVTMEI5QzJUOE9NeHFmanViVzN1RFdqdFhkVzNCRC8rUVBNbHdPYnBx?=
 =?utf-8?B?NThCMGRGQlZSTThHTTBJelJ3VFpNUjd1eC9ieTZ5NXloY1I2eUJ5UjY1WVlX?=
 =?utf-8?B?MkJZYWNOeUEzQlgvVzJnVHIreE9CMlpHTkIvMVcyNHpjUEJBZEdibGs0VEVX?=
 =?utf-8?B?MmNkR1R2c0MzeE13ZEhvYTY2Z0VwUWdRcFNlYW1oOGs1ZFAxa3FtZmcyVTla?=
 =?utf-8?B?L1kxbXlUUUhFUldJVm8yNm8yZlJSQVNSNi82cjQrZFB6SDN1T1ZpQ1VnS1RF?=
 =?utf-8?B?aGZla3F4eDBrVjE5a0lNd3hUZWdsS2t4aDZROHlRaE9sbHE0aTB2QzlrQnVr?=
 =?utf-8?B?Z2VMRzdPTXFBQkQzVCt0VElCWEtSQ2p3Y0R5dzJLbUFFMStwSFpmMWY3QVkz?=
 =?utf-8?B?eEJwQnBFOCtvUFNQS0tIbGxZV0lnWDFFMVV2cWJmT3lmNVNwRjQyN2U2ZjVJ?=
 =?utf-8?B?UGxnM1cyN2h1eUlJZU1zYlBLa3pveTNhZkN2TkNjaGRIallzaHBXalZWbjJ3?=
 =?utf-8?B?Y1E3UWhxT0FOckw4aDZxM3JmNlhOZ0t3NVBXa3dyL1h5Ky8rTENlYXBlcm9k?=
 =?utf-8?B?UzZaS252V3N3YUo1K1dkWHR1eC8zN0dldjRtSDRTNmovSXQ1UWZCdlh1bkN5?=
 =?utf-8?B?RkY3Ukg5aUE2WWxBSkttZzgySHNpaVNRb0oyalAwVm1Pa21DWjZvZ1p0Z2wv?=
 =?utf-8?Q?5afXCiBdgguFFu2x8lwke8I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2075be1-56b6-4664-3800-08d9c187f3fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 18:06:30.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNaHec1SaLMRsFAc4c1rxzHEiFGDhqmlyCFF36feCZTL+Z4fAE93VL5l/5oeY5gyLCSF6g1dWfLtj0kqa7bJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170102
X-Proofpoint-ORIG-GUID: kYZHRfk0ePyuGTbK3nImEKwSs3KYWAEj
X-Proofpoint-GUID: kYZHRfk0ePyuGTbK3nImEKwSs3KYWAEj
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/21 03:30, David Hildenbrand wrote:
> Let's return early for hugetlb, which really only relies on the compound
> mapcount so far and does not support PageDoubleMap() yet. Use the chance

It is too early to say if hugetlb double mapping will use PageDoubleMap().
I do not think (hope) it will be necessary.  So, I think you can drop mention
of it here.

> to cleanup the file-THP case to make it easier to grasp. While at it, use
> head_compound_mapcount().
> 
> This is a preparation for further changes.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/util.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 741ba32a43ac..3239e75c148d 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -732,15 +732,18 @@ int __page_mapcount(struct page *page)
>  {
>  	int ret;
>  
> -	ret = atomic_read(&page->_mapcount) + 1;
> +	if (PageHuge(page))
> +		return compound_mapcount(page);
>  	/*
>  	 * For file THP page->_mapcount contains total number of mapping
>  	 * of the page: no need to look into compound_mapcount.
>  	 */
> -	if (!PageAnon(page) && !PageHuge(page))
> -		return ret;
> +	if (!PageAnon(page))
> +		return atomic_read(&page->_mapcount) + 1;
> +
> +	ret = atomic_read(&page->_mapcount) + 1;
>  	page = compound_head(page);
> -	ret += atomic_read(compound_mapcount_ptr(page)) + 1;
> +	ret += head_compound_mapcount(page);
>  	if (PageDoubleMap(page))
>  		ret--;
>  	return ret;
> 


