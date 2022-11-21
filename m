Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6728632B40
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKURmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKURmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 12:42:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62838D28B1;
        Mon, 21 Nov 2022 09:42:08 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGRk4V009093;
        Mon, 21 Nov 2022 17:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yty/7DiPlJ4v2j4gvgeSX7Mya9x2N/OMpJm8yIe9JO0=;
 b=IscGch+I0rww/6u5zkNSiki3DY0BP4IIdodchGKr8w4Okr1XKABovJNgv5DuWk7VEjPW
 z2GWbAhfhS3ZPJBAFxC4uh8O3VtIWIw+kGl/6sJAnP38hpxAFEnLCbEIGC8iXOu8y+02
 S1B4g1XyWoNxkvfv6fi0dg3RdrJ+nsRhiwo2nkt9QiOeBAmTj2s4VTy94z47v3TZochQ
 +3tde1b1cTM0id2P5EK5PjxSKNWscxZAVwqxrHCpsQVb6ihxCUs6c9U/esWQnQds8Nuh
 CijZCJ5Fpcko6Z4H/69VXjXahki0FqGkJZq1vJlAxBOGq5YZJZpABg6HAFk1JjSaXPf9 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cvg1qdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:42:02 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALHg2Lf017277;
        Mon, 21 Nov 2022 17:42:02 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cvg1qcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:42:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALHbE1h001980;
        Mon, 21 Nov 2022 17:42:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3kxpdhu1e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:42:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALHfvsc51118506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 17:41:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5896D5204E;
        Mon, 21 Nov 2022 17:41:57 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.52.183])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AD65A52050;
        Mon, 21 Nov 2022 17:41:56 +0000 (GMT)
Message-ID: <2bee338bddf828a735a7c66473679fd388840851.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
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
Date:   Mon, 21 Nov 2022 18:41:56 +0100
In-Reply-To: <Y3dalbP5yb2gflA9@osiris>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
         <20221117221758.66326-2-scgl@linux.ibm.com> <Y3dalbP5yb2gflA9@osiris>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2aXbb6tfkp0FHum4hPbro6_tFPL2-4f-
X-Proofpoint-ORIG-GUID: ef1HfGmyCDiEJjkutdZsunQv77TtVL-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211210132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-11-18 at 11:12 +0100, Heiko Carstens wrote:
> On Thu, Nov 17, 2022 at 11:17:50PM +0100, Janis Schoetterl-Glausch wrote:
> > User space can use the MEM_OP ioctl to make storage key checked reads
> > and writes to the guest, however, it has no way of performing atomic,
> > key checked, accesses to the guest.
> > Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> > mode. For now, support this mode for absolute accesses only.
> > 
> > This mode can be use, for example, to set the device-state-change
> > indicator and the adapter-local-summary indicator atomically.
> > 
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >  include/uapi/linux/kvm.h |   5 ++
> >  arch/s390/kvm/gaccess.h  |   3 ++
> >  arch/s390/kvm/gaccess.c  | 101 +++++++++++++++++++++++++++++++++++++++
> >  arch/s390/kvm/kvm-s390.c |  35 +++++++++++++-
> >  4 files changed, 142 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 0d5d4419139a..1f36be5493e6 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -588,6 +588,8 @@ struct kvm_s390_mem_op {
> >  		struct {
> >  			__u8 ar;	/* the access register number */
> >  			__u8 key;	/* access key, ignored if flag unset */
> > +			__u8 pad1[6];	/* ignored */
> > +			__u64 old_p;	/* ignored if flag unset */
> 
> Just one comment: the suffix "_p" for pointer is quite unusual within
> the kernel. This also would be the first of its kind within kvm.h.
> Usually there is either no suffix or "_addr".
> So for consistency reasons I would suggest to change this to one of
> the common variants.
> 
Thanks, good point.

[...]
