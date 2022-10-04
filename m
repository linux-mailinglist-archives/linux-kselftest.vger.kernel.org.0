Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50E5F4978
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJDSwI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJDSwH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 14:52:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463061DAF;
        Tue,  4 Oct 2022 11:51:54 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294IZ1Ms007437;
        Tue, 4 Oct 2022 18:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=okNrQoOOAKp7rX9H9gitL78BaDqjgeTG34ONzWtxWmQ=;
 b=E57NGs5zYbtzAOP9oXzMRsjJ+Vf7QFjMM+IrLH8kTnoJ6Ln9J7InMP7UjtkYcCP4SX7/
 2PqwGCQExLIui+I0l/R6GW4I+w7qvhODhyvynukR3hSXkWslaLumyutmW9w/5kEGAv0c
 mZ6LMmocwav+YaMd6bpZ7qXOx/VhS+7ou3JQLYyvGW0br3gbM2K3XEbNgeNMpDFlDf1A
 MpA+x2i83qOLfVB7KLJH6S8g1TVgq4h/tly+Gp8sP6/xTEYg4a71jizNTwO0yTtsEm50
 8zlLNewh++atK+JBrsF1H7VoQ6MHza3mhVT0vnZ6V8EwaCIca9PZArlCdhEAh5k0vIa6 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gpq275d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 18:51:43 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 294Im2jN005228;
        Tue, 4 Oct 2022 18:51:43 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gpq274j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 18:51:43 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294IoO8j021028;
        Tue, 4 Oct 2022 18:51:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3jxd68uajr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 18:51:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294IpbWo60031284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 18:51:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9909042041;
        Tue,  4 Oct 2022 18:51:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D65124203F;
        Tue,  4 Oct 2022 18:51:36 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.6.222])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 18:51:36 +0000 (GMT)
Message-ID: <dca9e17ffbe71c76665ba25a6d9cd91d4aa0c329.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Tue, 04 Oct 2022 20:51:36 +0200
In-Reply-To: <85399389-9b5a-d72a-5db1-b8418008ad58@redhat.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
         <20220930210751.225873-4-scgl@linux.ibm.com>
         <85399389-9b5a-d72a-5db1-b8418008ad58@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _UNaA-cHpN_FYmyJlyAccAWzob0jG6bx
X-Proofpoint-ORIG-GUID: c72-2sVsijxEwFYVaNKYmL9Z3Obkv5f0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_08,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-10-04 at 10:16 +0200, Thomas Huth wrote:
> On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> > Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> > absolute vm write memops which allows user space to perform (storage key
> > checked) cmpxchg operations on guest memory.
> > 
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >   Documentation/virt/kvm/api.rst | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index abd7c32126ce..0e02d66e38ae 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -3771,6 +3771,7 @@ Parameters are specified via the following structure::
> >   		struct {

What is the reason you initially didn't copy the /* in */ comment here?


Thanks for the reviews.

> >   			__u8 ar;	/* the access register number */
> >   			__u8 key;	/* access key, ignored if flag unset */
> 
> Padding / alignment?
> 
> > +			__u64 old[2];	/* ignored if flag unset */
> >   		};
> >   		__u32 sida_offset; /* offset into the sida */
> >   		__u8 reserved[32]; /* ignored */
> > @@ -3853,8 +3854,23 @@ Absolute accesses are permitted for non-protected guests only.
> >   Supported flags:
> >     * ``KVM_S390_MEMOP_F_CHECK_ONLY``
> >     * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> > +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> > +
> > +The semantics of the flags common with logical acesses are as for logical accesses.
> > +
> > +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> > +In this case, instead of doing an unconditional write, the access occurs only
> > +if the target location contains the value provided in "old". This is performed
> > +as an atomic cmpxchg. "size" must be a power of two up to and including 16.
> > +Values with sizes <8 byte are to be provided by assignment to "old[1]".
> > +Doublewords are provided with the higher value word in "old[0]" and the lower
> > +word in "old[1]".
> > +The value at the target location is returned in "old", encoded in the same manner.
> > +If the value was exchanged the KVM_S390_MEMOP_F_CMPXCHG bit in "flags" is set to
> > +0, otherwise it remains set.
> > +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> > +has bit 1 (i.e. bit with value 2) set.
> 
> Please try to fit the text within 80 columns.
> 
>   Thanks,
>    Thomas
> 

