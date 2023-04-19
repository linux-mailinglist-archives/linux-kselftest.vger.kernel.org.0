Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139236E78C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Apr 2023 13:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjDSLmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjDSLmO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 07:42:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058115466;
        Wed, 19 Apr 2023 04:41:45 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JB0dfo004586;
        Wed, 19 Apr 2023 11:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jvitvu8tNatkgoZLUb/7EoCBqdtrYk/17qPZfc3bgOs=;
 b=MpyF3S6oqeISAqJTKFHWOZSHNSFkagp15cThaXAR/6EDJIFO8nVhFdUkVQYAcV0mi9i2
 SFohJ8tWX8lFUDubvQJDYoEfFUTDOgHePuwokQoKz14heJ/e75QPbDc6VwgXM097MU1w
 nlBx8GpVfKDmidp/tb6a04dzRkqlE5hEKgHM4zgxReb5stBFGN/Xl1CQZQyuLI3PdHll
 lsVufL+QTZsjDakCy73FQyJZqNFN+hz5oj17IEwYpEPo0V3jXal+bzOKK0BUwDJcM7r4
 +9SlxeicI+xv4byXMAxQWCSRGcUU8RTwQzE2j4ZINuYhgjtkeen3ojfymyCfx9uw8U3+ lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q20x17775-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 11:39:19 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33JBDnC9023064;
        Wed, 19 Apr 2023 11:39:19 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q20x1776s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 11:39:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33J6Q5Jx003283;
        Wed, 19 Apr 2023 11:39:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pykj6j7sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 11:39:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33JBdD9I20709964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 11:39:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C46A920043;
        Wed, 19 Apr 2023 11:39:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDE5520040;
        Wed, 19 Apr 2023 11:39:12 +0000 (GMT)
Received: from [9.171.27.132] (unknown [9.171.27.132])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Apr 2023 11:39:12 +0000 (GMT)
Message-ID: <42df1c58-f0bf-5dd8-03db-ee2fa28d7c1b@linux.ibm.com>
Date:   Wed, 19 Apr 2023 13:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-4-david@redhat.com>
Content-Language: en-US
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] mm/ksm: move disabling KSM from s390/gmap code to
 KSM code
In-Reply-To: <20230418152849.505124-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6IxnLG2-LMktCbzW90tov6FIPqZB3dRQ
X-Proofpoint-GUID: jvs1HAeEVjkq_CnN1R30R2G2A3flzTM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=580
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304190103
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/18/23 17:28, David Hildenbrand wrote:
> Let's factor out actual disabling of KSM. The existing
> "mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can be dropped,
> because def_flags should never include VM_MERGEABLE. Note that we don't
> currently prevent re-enabling KSM.
> 
> This should now be faster in case KSM was never enabled, because we only
> conditionally iterate all VMAs. Further, it certainly looks cleaner.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/s390/mm/gmap.c | 20 +-------------------
>   include/linux/ksm.h |  6 ++++++
>   mm/ksm.c            | 11 +++++++++++
>   3 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 0949811761e6..dfe905c7bd8e 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
>   
>   int gmap_mark_unmergeable(void)
>   {
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
> -	unsigned long vm_flags;
> -	int ret;
> -	VMA_ITERATOR(vmi, mm, 0);
> -
>   	/*
>   	 * Make sure to disable KSM (if enabled for the whole process or
>   	 * individual VMAs). Note that nothing currently hinders user space
>   	 * from re-enabling it.
>   	 */

Is that still true?

My KSM knowledge is nearly zero but from what I can see the patch looks 
ok to me:
Acked-by: Janosch Frank <frankja@linux.ibm.net>


