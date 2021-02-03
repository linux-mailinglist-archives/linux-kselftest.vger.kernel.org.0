Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFC30DB0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 14:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBCNY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 08:24:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhBCNYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 08:24:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113DDwRX135909;
        Wed, 3 Feb 2021 13:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TOeoctcS+1/tarsBFXRxdsLyJmXJizkOzQDCs06rzWE=;
 b=EQs2hVvA9bpKGS4t/VNDZo2YBfbO0no/CgoLN07evCclkTPwJVQNpUrpjzhBsPlpQTNl
 M0levePS7dUYIgSDjVNtbohd9QeR/xvT2s2T0azCvKPwinlvH7HIYMEy9LWMI1qNbk1n
 TyGoKsQIV21gIPebqv9eia0J7gUVauQJWqlcyGupkOnzCxVUhlV2RDmLo3LklHI8d6jY
 KJ4O1GX2TBdb9QevBJMCWvsbglHGl7YHD5XFOucqy6cXxCHUZ+uD1Ge5F+PvMpVUubc4
 WfhibqUYzjAtTP/dw7p7YzYcaIJ+canaTDJlBpJoG0EzNnwJzOAlOTeyJELR5UQEDfNp lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36fs458qp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 13:22:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113DGEsN163030;
        Wed, 3 Feb 2021 13:22:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 36dh7teqfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 13:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV9T8LWz2Tz2RoHH42caMC6ubcbA1fFj0b7lV4qnq4B0PZA3vbH+VYMs00wJsacS3jdGWkkqAEqEh/Z7AJK/yZ221jswFmT2XJMXo/OQV32VAHzHXq876P/4oquZjp+sOF36IVpdAJPg/LQPC/Rbwp86GPKQHxcotEsfdboY+5sjVikeoRaXc3Vz4q9LPsUCVWT/nA6qFHVJL0QdW7tdlFwcQJlOGiaAp0EpprSswazgTg2Zs2RggDMpxW32h5HJPVuTIq0RkutESGiK7fa3pH7zldzqRINxDm6qza3wvQW6trVfJuJ/JehUt5HQqwzl/ocJ0NFMai1UlaB51yerfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOeoctcS+1/tarsBFXRxdsLyJmXJizkOzQDCs06rzWE=;
 b=MNLaryJn/mYRqbTTo1Dq38pAp/p4ID046DkNSSideyn4kT9qPWoV1Qi2iZPnel6r1hIgkd/R0FTnDoSujy8icCHe/CqQraKNx0BeZ9uf+gRy+VeZOX9rpOrlZA/PPYrZ2xdZbEMZlG8hetGiz1YttJRXAIXWYqn/gi6EBxnhKAwAih3wxbl1SIKr9Q64ySuHMzP56OqrZzPh9RamkQjwI1UJvpaq08/hSCj2S9QY/Y+JbmOOIen/RujICLf5njfEtl0HRcBG9t3LZ8pDolif3yqC58Ek14i4yduHVfFZgQJ1m2nJKzyLtvXsUObvWZ81Uo/bCqQwACzwzsF42NtKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOeoctcS+1/tarsBFXRxdsLyJmXJizkOzQDCs06rzWE=;
 b=jxrKBysPD5h+vXsqJz/gMWkLd4KJKIePNdI3RfFhhTgivsRscGWd9MHhLf5tF+hrlxGWZhNbbmRYjcs9aigxBQeJafQ4YPbi+QMUfk8jX2BT2YFvhJ2gAMF96jwLH2QJqSgNVTkIKjgbHdkDtbx+oCH8HOHy3aYZ0PPorfLiQSU=
Authentication-Results: namei.org; dkim=none (message not signed)
 header.d=none;namei.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (20.177.226.140) by
 BYAPR10MB3093.namprd10.prod.outlook.com (20.179.154.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Wed, 3 Feb 2021 13:22:31 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 13:22:31 +0000
Subject: Re: [PATCH v8 02/14] mm/gup: check every subpage of a compound page
 during isolation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, jgg@ziepe.ca
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
 <20210125194751.1275316-3-pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org,
        jmorris@namei.org
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <05a66361-214c-2afe-22e4-12862ea1e4e2@oracle.com>
Date:   Wed, 3 Feb 2021 13:22:18 +0000
In-Reply-To: <20210125194751.1275316-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 13:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c41cf4f6-2233-44b3-6e6f-08d8c846c275
X-MS-TrafficTypeDiagnostic: BYAPR10MB3093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3093D9EE9BC6695367215697BBB49@BYAPR10MB3093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qlm9/669OtqwllF4z3w+nWPuvD0q0nAJl2RGb2PEkaWVmoGi+0j3G3w4KZVjT6RrwYsLn7r7laJN1hUy74vyr0GtGCkBk9RQ465XjVOnXvsiMJrG+/meOuko3U+hCHLiScAXYGMdjQMpDFwRi3Z0Lyqk3yAEZsMZQg0MBxp26adsriZVeo8Q7fSLmAAwZ1pA0S3w1jgS8RVkUpZZ2KDA/TGm6WIGC1rZF/yWpIDudAA2Vxf5nYDeMfLsb02IJizGL7hesKnrlgyCXpR9jucMjb4IpEgoatQfyrLg76p5xPsYsxjdZ1i3C1r7bB22AQrc5OepncmJUTcM1JNKz+cvN+WEZw8nd/kIC+uGuxU5baXoR3vgZbnZLPXbu+V9qrYhhxepUGj9GLiPb1rNHguGw2WlF3wt6oZWCyWDFBMGc8h4cYoXkFnF9RUellzQzKDVdRBMdfIPZNptXBme+5pY1U3yIFbYWPhU8Nc2sz0iRBq0R1J0j3NKm0F2wz5WlSqBAsjKYoISzjsHjNHS26UwzrcUwECXSlpa2SUV7FigBxtOJQrZz360mm0vIFkZ/kr4JxYCoZPOE+eWnXQD9Umdgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39860400002)(66556008)(83380400001)(31686004)(26005)(66476007)(8936002)(66946007)(7416002)(6666004)(2906002)(53546011)(8676002)(36756003)(2616005)(6486002)(16576012)(16526019)(186003)(31696002)(86362001)(956004)(5660300002)(4326008)(316002)(478600001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWhjcytFOTZ4REJhcU1zTER2bEJCV1VlQUU2cnZjWmdkdzlPSTN6eXpKZ1pa?=
 =?utf-8?B?dU1IblVlR2gxOUJOQnp0TDZtdWdtZWZRYkdQV0kvaVlTYU9vaVAyeFQzdEVw?=
 =?utf-8?B?VjQwOHBIZWZPZ0ZTYndrWjF3bkp1NW9PcFJORkxrY1NPcmhwcHNpUDY1UEFq?=
 =?utf-8?B?MDdEQUdnOHcxVnR5NStsTGVSRWx6SGhTUDRuaklpR2ppcW5ZUWwwWmxmS1BO?=
 =?utf-8?B?TDZ5SmdiT2VvZFJncTMzblErRjJybnlyb0pCdVc1RDhuZlEvWXk4SmZOb1V6?=
 =?utf-8?B?UHNKNUNZcTdzNzRCY1VoS2xsQ0l3b0w3cWRMc0p1UFpha3dPTnRjajltb0ds?=
 =?utf-8?B?NnVwSkZnNGs1YTVqWktGbHZ6Z3F4QWV6WlplQms5bkhEMDQxSk94TnR4QlZs?=
 =?utf-8?B?Y2dVNHhjeEthTHBkSkhBYVNldXMxVmphcUNSc0xsdkUzTmk2anVDNytOaVZz?=
 =?utf-8?B?K0lIdk50d0o5V01YelVkbUMzMnJCc002aE9yUzFZVGpESWRHSVFIc3dYYmVr?=
 =?utf-8?B?cjNNdXJHci9wQlNQREttaTl6ajNyWWRhQUtZMDh1emo3UFdmVkZEVTRJTmV5?=
 =?utf-8?B?bUdSV05ZVDhIQTZ3cXc1bEtoSXlSL0lrQ3ZRUWowMVNWSVIzTWdxWWZzcjlw?=
 =?utf-8?B?cHF3K2xJWnV4MWRTN0sxa2FERlVNa2FMQVlDdFpmNzhpOVR1d29uZ2RLajB6?=
 =?utf-8?B?Q2s3ZjUzUjZiUTJJTkVCWUpxa3RvSG5IKzlVa2xZR3pIVHlJdFh1K3JSSUJo?=
 =?utf-8?B?SWFyM01ac2grbVV1TTYxdVl1YmdiVTZCVURQWDRLZG9pQlhFTTZJcXRoNG1t?=
 =?utf-8?B?azFMcGpYOXBQRXM1d2U5dWpRTmhjZ3BkclkrNC82WEErUG5HOUxROFdlZng3?=
 =?utf-8?B?Z2hRWUcrOEl4MkpFeUc0ZGxoRjUwQnlhc21KQmp3eFMwbUdRNUVBQ0ZGNFVH?=
 =?utf-8?B?MkRyYzhieFVzYjZKeHlBaXdFdGtMcDdaM0NyY2phSUxYV2U4bHNUOEhDaSt5?=
 =?utf-8?B?Z1YvM3h5ekpTODNaTlNIeE55VkhwemlOUVhMVWk0U1ZDbzBOcGs0bCtIL2hX?=
 =?utf-8?B?VSs1bG1YU0RNWE0rN0EyZGtxdGV4alRaWFdOVWV6TDVKdEdpTnhVTUJIbVBk?=
 =?utf-8?B?VUZOcjhoUEYvUVhnTE9iQkFGd0pmVE9DNVBjM2pCeU5xRURwODRrbnA4ck45?=
 =?utf-8?B?MHhPbHBFdEdJZ2MrV1Z4TFRqbUJBbjJ1YTEzSXF4dTk4Rm5zU0dDdDNTd1dl?=
 =?utf-8?B?STBJQ2lIWjJKRkRnYm9OMUdvbDU5QzdWRWttaHV4c0pONFBET25vS1pacnc3?=
 =?utf-8?B?QklJYjF1ald0ZjhRUkl6RDMzMStsMzlhdUwwTUEvSGNPZnQ4OVFyQVU5VjA1?=
 =?utf-8?B?enJHS1ViQ1pMTVhOdmRocFpvSmo5MjNWKzhQMWVQaCs3dHBwekYrOFUwY1h0?=
 =?utf-8?Q?zT1l4EQI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41cf4f6-2233-44b3-6e6f-08d8c846c275
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 13:22:31.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTWrhJRFJG3M7ysOXnKfEbQIcmysCiTlv+CzCZuUclOypSJfWbeuYgUGwkEQeAzTi/+3OoF5NgYew28oRzkM3V0W43dPY7r46YG7KL8vyt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030081
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030081
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/25/21 7:47 PM, Pavel Tatashin wrote:
> When pages are isolated in check_and_migrate_movable_pages() we skip
> compound number of pages at a time. However, as Jason noted, it is
> not necessary correct that pages[i] corresponds to the pages that
> we skipped. This is because it is possible that the addresses in
> this range had split_huge_pmd()/split_huge_pud(), and these functions
> do not update the compound page metadata.
> 
> The problem can be reproduced if something like this occurs:
> 
> 1. User faulted huge pages.
> 2. split_huge_pmd() was called for some reason
> 3. User has unmapped some sub-pages in the range
> 4. User tries to longterm pin the addresses.
> 
> The resulting pages[i] might end-up having pages which are not compound
> size page aligned.
> 
> Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

[...]

>  		/*
>  		 * If we get a page from the CMA zone, since we are going to
>  		 * be pinning these entries, we might as well move them out
> @@ -1599,8 +1596,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  				}
>  			}
>  		}
> -
> -		i += step;
>  	}
>  

With this, longterm gup will 'regress' for hugetlbfs e.g. from ~6k -> 32k usecs when
pinning a 16G hugetlb file.

Splitting can only occur on THP right? If so, perhaps we could retain the @step increment
for compound pages but when !is_transparent_hugepage(head) or just PageHuge(head) like:

+               if (!is_transparent_hugepage(head) && PageCompound(page))
+                       i += (compound_nr(head) - (pages[i] - head));

Or making specific to hugetlbfs:

+               if (PageHuge(head))
+                       i += (compound_nr(head) - (pages[i] - head));
