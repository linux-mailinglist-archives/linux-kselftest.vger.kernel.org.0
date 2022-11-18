Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF362F912
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiKRPP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 10:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiKRPP1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 10:15:27 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D4393;
        Fri, 18 Nov 2022 07:15:26 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIEBR5f001483;
        Fri, 18 Nov 2022 15:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=3QixmXZRUsYz8QUYFuFVYj9VtTztT/o6h9bsXT5zTXA=;
 b=RB9196RxjYMYVOKr6YClxtNg2jZWRC8pGSOwmBW33RlhcgVtbCPtdLBMLGHuDlriG/0+
 jxOEewL3uMUDmtWT+awEAUw1JiZ/iJAqpyxfrFtZHF7gBMR4NG9Q/IBnD+La3yZ0I3/b
 aMinLON2N+WN8/4FN1UAtdZQqKWAJxlmoOJOi+rcSxueIyGYKtSfbvSLeUgrEFDs5g72
 GEtAuG9ctDFHuRi7grZmHpIbe/om8UVr5QGkGZ3IBdttY/3RI9RX+ugvDUP9xDSGRVmX
 pYeZA1wZjHcezSlLK4GwwOA8kUdbJAwgysV7eIG25I4Vr2wp341hj0Oljhbf/OUvBMV1 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx6e7hktp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:15:21 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIEmKQ6030274;
        Fri, 18 Nov 2022 15:15:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx6e7hksx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:15:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIF9H6n022224;
        Fri, 18 Nov 2022 15:15:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kwu4yh2np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:15:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIFFuXS36962600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 15:15:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9214C046;
        Fri, 18 Nov 2022 15:15:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760F94C040;
        Fri, 18 Nov 2022 15:15:15 +0000 (GMT)
Received: from osiris (unknown [9.145.17.66])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Nov 2022 15:15:15 +0000 (GMT)
Date:   Fri, 18 Nov 2022 16:15:14 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Message-ID: <Y3ehgt9rDIltfp2C@osiris>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
 <20221117221758.66326-2-scgl@linux.ibm.com>
 <Y3dalbP5yb2gflA9@osiris>
 <90f07edc-238f-b3d0-80d2-f4b4573f12ad@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f07edc-238f-b3d0-80d2-f4b4573f12ad@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cI6jH_0A4VBCDYfop7B3gShbwa2VViey
X-Proofpoint-GUID: IE8C0bfBv8bbrp7wGVU2pyK4nlSSDxqX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=779
 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 18, 2022 at 03:37:26PM +0100, Thomas Huth wrote:
> > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > index 0d5d4419139a..1f36be5493e6 100644
> > > --- a/include/uapi/linux/kvm.h
> > > +++ b/include/uapi/linux/kvm.h
> > > @@ -588,6 +588,8 @@ struct kvm_s390_mem_op {
> > >   		struct {
> > >   			__u8 ar;	/* the access register number */
> > >   			__u8 key;	/* access key, ignored if flag unset */
> > > +			__u8 pad1[6];	/* ignored */
> > > +			__u64 old_p;	/* ignored if flag unset */
> > 
> > Just one comment: the suffix "_p" for pointer is quite unusual within
> > the kernel. This also would be the first of its kind within kvm.h.
> > Usually there is either no suffix or "_addr".
> > So for consistency reasons I would suggest to change this to one of
> > the common variants.
> > 
> > The code itself looks good from my point of view, even though for the
> > sake of simplicity I would have put the complete sign/zero extended
> > 128 bit old value into the structure, instead of having a pointer to
> > the value.
> 
> See
> https://lore.kernel.org/kvm/37197cfe-d109-332f-089b-266d7e8e23f8@redhat.com/
> ... it would break the "IOW" definition of the ioctl. It can be done, but
> that confuses tools like valgrind, as far as I know. So I think the idea
> with the pointer is better in this case.

Ah right, I forgot about that. Then let's do it this way.
