Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437936C6B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCWOiq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCWOio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:38:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D6E062;
        Thu, 23 Mar 2023 07:38:41 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NEJ0Kx012528;
        Thu, 23 Mar 2023 14:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=gDXwwDTli8az66jfGCLHiYuLr5u5tT6/V28b/Ru4pc4=;
 b=nxqpuzEurfoJ18b/h0aFL7mQkU4ccuKH4f2jgVswS5ysRoIrQKE/D47orwhHc+9aCewW
 HUz8z0rdljhxCdpflvO7O5bbGEt3fO87bfEKKakq1snewdBa0IK7SnyDzjgj7az8+sLT
 /YwjLT97t/UKDrNt7/cKff+2E14dwZ2mvqCJusXfM1TxY7MsNNKKhewgffP2nf1txWev
 DC+2zq/8MDsj8V7XrnUposnlaZV9XU/QcTTEhPT5vf40uhmMC34GaY7cOzwSygYrgTfX
 dp7VIeLBHDotGVoi1IE47Gc08MzB/MsZO8vTHIrgCLiPpyf6fCq8R/PD2Zmib2lmE1MS gg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgmc2qb9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:38:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N9QcNj017248;
        Thu, 23 Mar 2023 14:38:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6ffrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:38:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NEcW3549545700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 14:38:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41B742004D;
        Thu, 23 Mar 2023 14:38:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFE0A2004B;
        Thu, 23 Mar 2023 14:38:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 14:38:31 +0000 (GMT)
Date:   Thu, 23 Mar 2023 13:36:17 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs
 in memslot holes
Message-ID: <20230323133617.4e8b3696@p-imbrenda>
In-Reply-To: <20230208144827.131300-2-nrb@linux.ibm.com>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
        <20230208144827.131300-2-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hywSHiTFg4IWfvS6A2D_GFKVnTb6sZ1p
X-Proofpoint-ORIG-GUID: hywSHiTFg4IWfvS6A2D_GFKVnTb6sZ1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230109
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed,  8 Feb 2023 15:48:26 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> The KVM_S390_GET_CMMA_BITS ioctl may return incorrect values when userspace
> specifies a start_gfn outside of memslots.
> 
> This can occur when a VM has multiple memslots with a hole in between:
> 
> +-----+----------+--------+--------+
> | ... | Slot N-1 | <hole> | Slot N |
> +-----+----------+--------+--------+
>       ^          ^        ^        ^
>       |          |        |        |
> GFN   A          A+B      |        |
>                           A+B+C    |
> 			           A+B+C+D
> 
> When userspace specifies a GFN in [A+B, A+B+C), it would expect to get the
> CMMA values of the first dirty page in Slot N. However, userspace may get a
> start_gfn of A+B+C+D with a count of 0, hence completely skipping over any
> dirty pages in slot N.
> 
> The error is in kvm_s390_next_dirty_cmma(), which assumes
> gfn_to_memslot_approx() will return the memslot _below_ the specified GFN
> when the specified GFN lies outside a memslot. In reality it may return
> either the memslot below or above the specified GFN.
> 
> When a memslot above the specified GFN is returned this happens:
> 
> - ofs is calculated, but since the memslot's base_gfn is larger than the
>   specified cur_gfn, ofs will underflow to a huge number.
> - ofs is passed to find_next_bit(). Since ofs will exceed the memslot's
>   number of pages, the number of pages in the memslot is returned,
>   completely skipping over all bits in the memslot userspace would be
>   interested in.
> 
> Fix this by resetting ofs to zero when a memslot _above_ cur_gfn is
> returned (cur_gfn < ms->base_gfn).
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e4890e04b210..a171a66681b4 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2158,6 +2158,10 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
>  		ms = container_of(mnode, struct kvm_memory_slot, gfn_node[slots->node_idx]);
>  		ofs = 0;
>  	}
> +
> +	if (cur_gfn < ms->base_gfn)
> +		ofs = 0;
> +
>  	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
>  	while (ofs >= ms->npages && (mnode = rb_next(mnode))) {
>  		ms = container_of(mnode, struct kvm_memory_slot, gfn_node[slots->node_idx]);

