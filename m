Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE262F23B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 11:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiKRKMv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 05:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiKRKMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 05:12:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575BF71F31;
        Fri, 18 Nov 2022 02:12:49 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIA9uvt032749;
        Fri, 18 Nov 2022 10:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wcl5icUsxpcfuMwhOzo/VTcRuTygEQLTW6vBKpa0/yk=;
 b=rRz11gRYT3pGhPADwL+j3/z1i4J6b9ujSpJr72msDN8P4dYso7gIpvVxJbwa9+0e85bC
 tfI1L0brHDI5ul0NdAe1rmFGDjZxluknTt9abEYSizQVyoIrsN88ZbPSPk3gacVqAPmB
 naCKjE0Yvwyt9m98unhWYuDHZy6D0NLE68+91vgmdA5QCKd+Z58DZrEbXzAuglN0N5Sb
 RCygMi9ODTeM9lkTOeapW+f3htuAorI0mp3zAK3SaurnUhvM0QbiWqNqSyFbhOPeHxOm
 4j2KkQpwyRIk4ts6QAa0j0H/k8tEh2D34TME1BM+KhC9DZ/Xc+uqA04gw0RLfEt5xKVn gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx7bc9444-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 10:12:45 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIAAwul004894;
        Fri, 18 Nov 2022 10:12:45 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx7bc9431-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 10:12:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIA9gg0002589;
        Fri, 18 Nov 2022 10:12:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kwte4gkaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 10:12:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIACdxk59310452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 10:12:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D7415204F;
        Fri, 18 Nov 2022 10:12:39 +0000 (GMT)
Received: from osiris (unknown [9.145.17.66])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B37A95204E;
        Fri, 18 Nov 2022 10:12:38 +0000 (GMT)
Date:   Fri, 18 Nov 2022 11:12:37 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Message-ID: <Y3dalbP5yb2gflA9@osiris>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
 <20221117221758.66326-2-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117221758.66326-2-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _3Ebc4G1HOdvvyKR5KujmpmU-wwQgWgy
X-Proofpoint-GUID: Pk_qYC5A5nG-ngx3HjismAMs3CDi5Ne-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 17, 2022 at 11:17:50PM +0100, Janis Schoetterl-Glausch wrote:
> User space can use the MEM_OP ioctl to make storage key checked reads
> and writes to the guest, however, it has no way of performing atomic,
> key checked, accesses to the guest.
> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> mode. For now, support this mode for absolute accesses only.
> 
> This mode can be use, for example, to set the device-state-change
> indicator and the adapter-local-summary indicator atomically.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  include/uapi/linux/kvm.h |   5 ++
>  arch/s390/kvm/gaccess.h  |   3 ++
>  arch/s390/kvm/gaccess.c  | 101 +++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c |  35 +++++++++++++-
>  4 files changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 0d5d4419139a..1f36be5493e6 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -588,6 +588,8 @@ struct kvm_s390_mem_op {
>  		struct {
>  			__u8 ar;	/* the access register number */
>  			__u8 key;	/* access key, ignored if flag unset */
> +			__u8 pad1[6];	/* ignored */
> +			__u64 old_p;	/* ignored if flag unset */

Just one comment: the suffix "_p" for pointer is quite unusual within
the kernel. This also would be the first of its kind within kvm.h.
Usually there is either no suffix or "_addr".
So for consistency reasons I would suggest to change this to one of
the common variants.

The code itself looks good from my point of view, even though for the
sake of simplicity I would have put the complete sign/zero extended
128 bit old value into the structure, instead of having a pointer to
the value. Imho that would simplify the interface. Also alignment, as
pointed out previously, really doesn't matter for this use case.

But you had already something like that previously and changed it, so
no reason to go back and forth. Not really important.
