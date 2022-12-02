Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016E66402D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 10:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiLBJCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 04:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiLBJCT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 04:02:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7798547;
        Fri,  2 Dec 2022 01:00:42 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B27g5ts013292;
        Fri, 2 Dec 2022 09:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=8xnE/Mb0rP1cjkQQ7k3iLfRpCly+KU3D84URS1QVylo=;
 b=Ua5V/Efa2ZJwhDOyOgGdP3pTKIK0thms7qhlRfn0gaKcR0oon45fGCPDuCVrs7wJ9iAp
 sCNnrdEUNqOm/Q2Rm5R6uR1kGUuWCKfCJFkMNfAEldVZB/fshpHAYTJ97TkVn+guABZZ
 RB+SibMAVqVXZe1tOfMs3gNWQ/imiZ8tNStiAaqu5gxShzFWDn5sWA0COYb9iUQB0XES
 Pt1BcOjBp7K+LpsIJp1g92kvCpvClFzKZ0Yr4npvr0rvOD3EWoInrGrAiZarOpeyfX2k
 mu4XnnDjLoTD3frZbpHvO9fstRvh9foLMKFkBoCz7Q7pnDr4DtHEKdDoWI4qEGBYgbSv jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m7d6t1w9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 09:00:39 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B28UEkL016043;
        Fri, 2 Dec 2022 09:00:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m7d6t1w88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 09:00:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B28njd3006167;
        Fri, 2 Dec 2022 09:00:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3m3ae9gtk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 09:00:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B291GEY4195004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Dec 2022 09:01:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F344A4055;
        Fri,  2 Dec 2022 09:00:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D90DA4040;
        Fri,  2 Dec 2022 09:00:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.31.115])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  2 Dec 2022 09:00:31 +0000 (GMT)
Date:   Fri, 2 Dec 2022 10:00:28 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
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
Message-ID: <20221202100028.686c605e@p-imbrenda>
In-Reply-To: <dc192fa099eb1b7d49d19b52c416d21589e22d87.camel@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
        <20221117221758.66326-2-scgl@linux.ibm.com>
        <20221201171528.13f17ec4@p-imbrenda>
        <dc192fa099eb1b7d49d19b52c416d21589e22d87.camel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MIE7Tkq8dREDb3bLyBCIWdFsFhwuZl_T
X-Proofpoint-ORIG-GUID: echR8s-Y313utW3Umn7s9LGDwFrdS-el
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 01 Dec 2022 18:44:56 +0100
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> > 
> > please also document -EOPNOTSUPP  
> 
> I'd add "* -EOPNOTSUPP: should never occur", then, that ok with you?

no, also explain in which conditions it is returned

something like: 
 * -EOPNOTSUPP: if the memslot is not writable (should never occour)

> >   
> > > + */
> > > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> > > +			       __uint128_t *old_p, __uint128_t new,
> > > +			       u8 access_key)
> > > +{
> > > +	gfn_t gfn = gpa >> PAGE_SHIFT;
> > > +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);  
> > 
> > exchange the above two lines (reverse christmas tree)  
> 
> Is this a hard requirement? Since there is a dependency.
> If I do the initialization further down, the order wouldn't actually change.

ahhhhh right, I had missed that

keep it as it is, of course

[...]

> > I really dislike repeating the same code 5 times, but I guess there was
> > no other way?  
> 
> I could use the function called by cmpxchg_user_key directly, but Heiko won't agree to that.
> A macro would work too, of course, not sure if I prefer that tho.

ok so there is no other way, let's keep it as it is

[...]

> To me it feels like KVM_S390_MEMOP_R_NO_XCHG is api surface and should be referenced here.
> cmpxchg_guest_abs_with_key isn't mem op specific
> (of course that's the only thing it is currently used for).

fair enough

> >   
> > > +				if (copy_to_user(old_p, &old.raw[off_in_quad], mop->size))
> > > +					r = -EFAULT;
> > > +			}
> > >  		} else {
> > >  			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> > >  				r = -EFAULT;  
> >   
> 

