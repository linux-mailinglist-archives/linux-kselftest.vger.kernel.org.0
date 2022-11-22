Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607D0633D2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 14:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiKVNLD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 08:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiKVNK4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 08:10:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18E2645;
        Tue, 22 Nov 2022 05:10:55 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMAgXdu013705;
        Tue, 22 Nov 2022 13:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hQ3fVymP4HFlZ5VZh4VL4SoYVcWFpM4fBoyY3KbIllw=;
 b=fCQdtovJW9AM2EGOqGXskr2oOyevGuf1X8WxtrvDicgUlW2gFUCQfkq9b1cyg1GwYNr/
 qxsOepoe6u1g8rdoqmmSzxQcglFix+nuhsmTsb0yLZSHNXLfJ98uKKgwcxK+kRofDYdD
 uRy6qNCiwUZ4j0J0x5s/BFy/GAiqtwvI6TFXWDGCwz4OAgs2KDOFg4K0dE6qZJkYfJHc
 PlwFpTpdxL2iIgbjLJKxpzvlJ/SWa2XIMpZLCjktV8+sqltSwGNK6xzYEbfXKuSlw6Bc
 G51a6o4Hqg94Hs/OeZmafcxSqwYtcs8TX0qkfbH8lU/bsnc4kZWSZwwkJSgPuj15hUs3 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0tqaq3av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:10:49 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AMCgFQt022109;
        Tue, 22 Nov 2022 13:10:49 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0tqaq38w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:10:49 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AMD6OaT000661;
        Tue, 22 Nov 2022 13:10:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3kxps934ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:10:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AMDBNIT42926526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 13:11:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4804AE04D;
        Tue, 22 Nov 2022 13:10:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18530AE045;
        Tue, 22 Nov 2022 13:10:42 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.10.123])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Nov 2022 13:10:42 +0000 (GMT)
Message-ID: <e735fa2cde6e9c92dda134634cb3d67b64b23fe9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe
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
Date:   Tue, 22 Nov 2022 14:10:41 +0100
In-Reply-To: <f96b50e2-24ac-4016-d3f1-ffc375516e7c@redhat.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
         <20221117221758.66326-3-scgl@linux.ibm.com>
         <f96b50e2-24ac-4016-d3f1-ffc375516e7c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eXYljfTqPOrYrIkozEPhxBDypaqjOjXw
X-Proofpoint-ORIG-GUID: MH03WnBZBvlQkASGvVvGlFEGTrL5rQwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=763 mlxscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-11-22 at 08:47 +0100, Thomas Huth wrote:
> On 17/11/2022 23.17, Janis Schoetterl-Glausch wrote:
> > Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> > absolute vm write memops which allows user space to perform (storage key
> > checked) cmpxchg operations on guest memory.
> > 
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> ...
> >   Supported flags:
> >     * ``KVM_S390_MEMOP_F_CHECK_ONLY``
> >     * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> > +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> > +
> > +The semantics of the flags common with logical acesses are as for logical
> > +accesses.
> > +
> > +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> 
> I'd maybe merge this with the last sentence:
> 
> For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if 
> KVM_CAP_S390_MEM_OP_EXTENSION has bit 1 (i.e. bit with value 2) set.

Ok.
> 
> ... and speaking of that, I wonder whether it's maybe a good idea to 
> introduce some #defines for bit 1 / value 2, to avoid the confusion ?

Not sure, I don't feel it's too complicated. Where would you define it?
Next to the mem_op struct? KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG?
> 
> > +In this case, instead of doing an unconditional write, the access occurs only
> > +if the target location contains the "size" byte long value pointed to by
> > +"old_p". This is performed as an atomic cmpxchg.
> 
> I had to read the first sentence twice to understand it ... maybe it's 
> easier to understand if you move the "size" part to the second sentence:
> 
> In this case, instead of doing an unconditional write, the access occurs 
> only if the target location contains value pointed to by "old_p". This is 
> performed as an atomic cmpxchg with the length specified by the "size" 
> parameter.
> 
> ?

Ok.
> 
> > "size" must be a power of two
> > +up to and including 16.
> > +The value at the target location is written to the location "old_p" points to.
> 
> IMHO something like this would be better:
> 
> The value at the target location is replaced with the value from the 
> location that "old_p" points to.

I'm trying to say the opposite :).
I went with this:

If the exchange did not take place because the target value doesn't match the
old value, KVM_S390_MEMOP_R_NO_XCHG is returned.
In this case the value "old_addr" points to is replaced by the target value.
> 
> > +If the exchange did not take place because the target value doesn't match the
> > +old value KVM_S390_MEMOP_R_NO_XCHG is returned.
> > +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> > +has bit 1 (i.e. bit with value 2) set.
> 
>   Thomas
> 
> PS: Please take my suggestions with a grain of salt ... I'm not a native 
> speaker either.
> 

