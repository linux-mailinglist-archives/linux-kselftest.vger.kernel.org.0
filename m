Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0892530E008
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBCQuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 11:50:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33876 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBCQuY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 11:50:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113Gcwgs157095;
        Wed, 3 Feb 2021 16:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7PpAYVzyIqIJ+B85/c1uwsNEo+c61KKpGfHeJdunKKY=;
 b=ayVRKQaMadiGFbxDog4vECX5QTZSO8bYUT/djkAaoJhoSsyiGnz9ZR7oaWd3bCCSjxcJ
 s7is/Z/gPjcGm82/sdCMlMdrnUZu7SH5RfI+DKZVwRsSrbNEvrjjCoG8wrjXmc/T6VO5
 jwAaaCss/qDAdIfjpwVjs7N4rJSBIBxFNxwQwCUofBJwG+rI+YKLC2vmcanmolPprp6G
 hesG19ptDvetV4+wlW4ngXUQuxfB7m1HtDWsmWAQ534gOyhC3uXFDcnJHAa63Q0xp3I1
 q+VQvtN+QW9AW1xW2oSYNaWcf23t7JNGwC77GWb6OSQlB0pJHHTjXxEd6QnmdInqGQMO xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm11y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:48:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113Gf4BX168170;
        Wed, 3 Feb 2021 16:46:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36dhc1chvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:46:51 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 113GkeAR006957;
        Wed, 3 Feb 2021 16:46:41 GMT
Received: from [10.175.189.55] (/10.175.189.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Feb 2021 08:46:40 -0800
Subject: Re: [PATCH v8 02/14] mm/gup: check every subpage of a compound page
 during isolation
From:   Joao Martins <joao.m.martins@oracle.com>
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
 <ce96a71d-845b-b8d2-92d3-fc7336a765c5@oracle.com>
Message-ID: <9f021b82-8618-3cd4-28df-1d6a9bd749cf@oracle.com>
Date:   Wed, 3 Feb 2021 16:46:32 +0000
MIME-Version: 1.0
In-Reply-To: <ce96a71d-845b-b8d2-92d3-fc7336a765c5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030100
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/21 3:32 PM, Joao Martins wrote:
> On 2/3/21 2:51 PM, Pavel Tatashin wrote:
>> On Wed, Feb 3, 2021 at 8:23 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>> On 1/25/21 7:47 PM, Pavel Tatashin wrote:
>>> for compound pages but when !is_transparent_hugepage(head) or just PageHuge(head) like:
>>>
>>> +               if (!is_transparent_hugepage(head) && PageCompound(page))
>>> +                       i += (compound_nr(head) - (pages[i] - head));
>>>
>>> Or making specific to hugetlbfs:
>>>
>>> +               if (PageHuge(head))
>>> +                       i += (compound_nr(head) - (pages[i] - head));
>>
>> Yes, this is reasonable optimization. I will submit a follow up patch
>> against linux-next.

Realized it late, but the previous step was already broken. And I inherited its brokeness,
when copy-pasting the deleted chunk:

The @step should be capped at the remaining pages to iterate:

	i += min(nr_pages - i, compound_nr(head) - (pages[i] - head));

  Joao
