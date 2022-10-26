Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387560E11A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiJZMoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiJZMoS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 08:44:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81D10075;
        Wed, 26 Oct 2022 05:44:18 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QCbnpK017383;
        Wed, 26 Oct 2022 12:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vahBHWcjmX25fVfVppqO25R8GRT50gCuNofrt1TcoK4=;
 b=pBs6LbiNS3CUyqAiiOPizWkElYkgt5B10jYMfFaCrnEI6ICsORTtLyl17N0adkl9w9lR
 YgLj84hxehhCbxTeIY6wgF3XOpqtqf/Q4SjdxsLEooiMbDyU9Ckr0M9EGyGYgbCGavHd
 SBodUGORSUhPywMBxOpfVnOKqcWax2Mbi6dnvBm0Xvr0mlt31NvWgk/xSP8t0vtkFugS
 Av6VJ3nlkpXa2u3Udso9GJD7n1HebJD/wLyWX6Z4eHLNWl+hQ8buNpxL1sll8OZMrZe9
 UXOCDb2XZo+z5u4MymC+t5jAOdqNeDuO1RPcvZSf4XHO0VaoZMSNflY8CJGlsefGosza 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf3n5ua0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:44:12 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29QCcNow022863;
        Wed, 26 Oct 2022 12:44:11 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf3n5u9y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:44:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29QCaYtB015665;
        Wed, 26 Oct 2022 12:44:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3kc859ndav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:44:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29QCcqSc49414598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 12:38:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5795CA4040;
        Wed, 26 Oct 2022 12:44:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEA43A4051;
        Wed, 26 Oct 2022 12:44:06 +0000 (GMT)
Received: from thinkpad (unknown [9.171.3.66])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 26 Oct 2022 12:44:06 +0000 (GMT)
Date:   Wed, 26 Oct 2022 14:44:04 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] selftests: vm: use 1 MB hugepage size for s390
Message-ID: <20221026144404.2d67681a@thinkpad>
In-Reply-To: <e5eff1ef-760c-5e6f-9f32-e8a7a624993b@redhat.com>
References: <20221025152610.3439102-1-gerald.schaefer@linux.ibm.com>
        <e5eff1ef-760c-5e6f-9f32-e8a7a624993b@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Yn-AhucFM2Iy7NU2wdj19KAUIBuFP63
X-Proofpoint-ORIG-GUID: mwDdvCMyECj3v-6kQ4FEuQuocyYSjqm2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=868 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 25 Oct 2022 17:34:52 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 25.10.22 17:26, Gerald Schaefer wrote:
> > hugepage-vmemmap test fails for s390 because it assumes a hugepagesize
> > of 2 MB, while we have 1 MB on s390. This results in iterating over two
> > hugepages. If they are consecutive in memory, check_page_flags() will
> > stumble over the additional head page. Otherwise, it will stumble over
> > non-huge pageflags, after crossing the first 1 MB hugepage.
> > 
> > Fix this by using 1 MB MAP_LENGTH for s390.
> > 
> > Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > ---
> >   tools/testing/selftests/vm/hugepage-vmemmap.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/vm/hugepage-vmemmap.c b/tools/testing/selftests/vm/hugepage-vmemmap.c
> > index 557bdbd4f87e..a4695f138cec 100644
> > --- a/tools/testing/selftests/vm/hugepage-vmemmap.c
> > +++ b/tools/testing/selftests/vm/hugepage-vmemmap.c
> > @@ -11,7 +11,14 @@
> >   #include <sys/mman.h>
> >   #include <fcntl.h>
> >   
> > +/*
> > + * 1 MB hugepage size for s390
> > + */
> > +#if defined(__s390x__)
> > +#define MAP_LENGTH		(1UL * 1024 * 1024)
> > +#else
> >   #define MAP_LENGTH		(2UL * 1024 * 1024)
> > +#endif
> 
> Why not detect it at runtime, so this works on any architecture (e.g., 
> ppc64 with 16 MiB IIRC and arm64 with weird sizes)?
> 
> A patch that adds such detection code is currently on its way upstream:
> 
> https://lore.kernel.org/all/20220927110120.106906-5-david@redhat.com/T/#u
> 
> We could factor that out into vm_utils.c
> 

Hello David, nice, I guess that would be much better than adding new #ifdefs,
and also allow to check all available hugepage sizes per arch.
