Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D4881B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 19:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407603AbfHIRy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 13:54:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57380 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfHIRy6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 13:54:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79HrkaD085556;
        Fri, 9 Aug 2019 17:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BIZJ8s9VWMSHzLAmHEjdX/xl2iyn2dtlXxgsI9RWSag=;
 b=b/m9aXWdVCJLg8mbuczqSBp03AvKIfgtHPMb9MdszRXG57gCF0QeOC8x/UFYYOsnAx5c
 ljkmFUzvrpBvLmR9/R4JKHRezPLovTu/h1x7clREgVokVo+B6WmV4betutdzX01lzvOC
 DZ7X5vvSBE7mV3edFQSAMN/mK13xiYM/EJdfWFq77NKZS20OpsLu7uqzXgsT3PWVaCFS
 zmMADnM9NgwcfE6PlhaadJ8RdZ5DJVtU77dN7JqwM+hGDhQr5lTaI8bhhFNhn8N9y9P6
 YAeg8gIGpihtJz+CZTi38w/jun5NwKk1IaydvqChXvjBlWTELZ3pyf1UF9uewzdM5ViP Iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BIZJ8s9VWMSHzLAmHEjdX/xl2iyn2dtlXxgsI9RWSag=;
 b=D0pz9qIehlbVBpUKr1uUJgaq3OBCscE1NJ4uiLmUb5tREbOV0Bm2B1c6e+hgtkah6PBD
 ANv/kvw4q1IuyqM8T3/nzrf82NSfONja/P7kjtpaTkgxs4QbRkalgYqVwfEWDlKgf+fj
 mLkggSa8Mnoj49hppTkHhNntvBAHyY1NKyMqKXlIL42rc2NELErCjQSCINzMNzdw6Djn
 z/pogYq7opVYtUcmuCzqEEogy/48lKcJSuGNgE7y1y58qZFZPDeDSl1p4eNagAmMmRC+
 Hs4gFhzcae+b0lEsaTKCiGCPlNN1utvBgM9ldt2r32l8HsDGBxAOianucwSuArWDKKao 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u8hps966a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 17:54:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79HqtdV028169;
        Fri, 9 Aug 2019 17:54:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u8pj9cu4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 17:54:48 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x79Hske0002658;
        Fri, 9 Aug 2019 17:54:46 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 10:54:46 -0700
Subject: Re: [RFC PATCH v2 0/5] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org
References: <20190808231340.53601-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f0a5afe9-2586-38c9-9a6d-8a2b7b288b50@oracle.com>
Date:   Fri, 9 Aug 2019 10:54:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808231340.53601-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9344 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9344 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090178
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(+CC  Michal Koutný, cgroups@vger.kernel.org, Aneesh Kumar)

On 8/8/19 4:13 PM, Mina Almasry wrote:
> Problem:
> Currently tasks attempting to allocate more hugetlb memory than is available get
> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> However, if a task attempts to allocate hugetlb memory only more than its
> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> but will SIGBUS the task when it attempts to fault the memory in.
> 
> We have developers interested in using hugetlb_cgroups, and they have expressed
> dissatisfaction regarding this behavior. We'd like to improve this
> behavior such that tasks violating the hugetlb_cgroup limits get an error on
> mmap/shmget time, rather than getting SIGBUS'd when they try to fault
> the excess memory in.
> 
> The underlying problem is that today's hugetlb_cgroup accounting happens
> at hugetlb memory *fault* time, rather than at *reservation* time.
> Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> the offending task gets SIGBUS'd.
> 
> Proposed Solution:
> A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
> counter has slightly different semantics than
> hugetlb.xMB.[limit|usage]_in_bytes:
> 
> - While usage_in_bytes tracks all *faulted* hugetlb memory,
> reservation_usage_in_bytes tracks all *reserved* hugetlb memory.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than reservation_limit_in_bytes, the kernel will fail this
> reservation.
> 
> This proposal is implemented in this patch, with tests to verify
> functionality and show the usage.

Thanks for taking on this effort Mina.

Before looking at the details of the code, it might be helpful to discuss
the expected semantics of the proposed reservation limits.

I see you took into account the differences between private and shared
mappings.  This is good, as the reservation behavior is different for each
of these cases.  First let's look at private mappings.

For private mappings, the reservation usage will be the size of the mapping.
This should be fairly simple.  As reservations are consumed in the hugetlbfs
code, reservations in the resv_map are removed.  I see you have a hook into
region_del.  So, the expectation is that as reservations are consumed the
reservation usage will drop for the cgroup.  Correct?
The only tricky thing about private mappings is COW because of fork.  Current
reservation semantics specify that all reservations stay with the parent.
If child faults and can not get page, SIGBUS.  I assume the new reservation
limits will work the same.

I believe tracking reservations for shared mappings can get quite complicated.
The hugetlbfs reservation code around shared mappings 'works' on the basis
that shared mapping reservations are global.  As a result, reservations are
more associated with the inode than with the task making the reservation.
For example, consider a file of size 4 hugetlb pages.
Task A maps the first 2 pages, and 2 reservations are taken.  Task B maps
all 4 pages, and 2 additional reservations are taken.  I am not really sure
of the desired semantics here for reservation limits if A and B are in separate
cgroups.  Should B be charged for 4 or 2 reservations?
Also in the example above, after both tasks create their mappings suppose
Task B faults in the first page.  Does the reservation usage of Task A go
down as it originally had the reservation?

It should also be noted that when hugetlbfs reservations are 'consumed' for
shared mappings there are no changes to the resv_map.  Rather the unmap code
compares the contents of the page cache to the resv_map to determine how
many reservations were actually consumed.  I did not look close enough to
determine the code drops reservation usage counts as pages are added to shared
mappings.

-- 
Mike Kravetz
