Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAA665F1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjAKPaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 10:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjAKPaE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 10:30:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B4318E3D;
        Wed, 11 Jan 2023 07:30:03 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BF9TLb016774;
        Wed, 11 Jan 2023 15:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lh6nNqu+9dmdutpmBjGMxOjAEUOL7Ufi7Rj7prOWxas=;
 b=VTa1hEe9FsZwIIPnqwr/PyG3Cyu7bCCYDJfso8J2zzoypOcNgoPm0SBi2UfuDLubAW49
 eF2mS0Nt/n6cq6CWBew/LloCgzGhk7KtxPVvV0rFhvZdmEntHvpJJ1dN8qwf3QblwhiU
 goGDIxBXOXO0VV4FGvUPMwCGppaH9cpGKpvTclUudB0QGO7M7wNkg1JVmxQAz4HDK/8B
 vaMi4LQlPcXpnse8H2BPWtG95C9jfxtKEvsFG5CKTLi0AdG5E8E+LbIeJ4Z29p8Jh/TM
 dmyN/sQJfT+Eg00ZlsJ7LpSE5VmchShE2DEZSqD1pukiyiookNPYWRyDNwqDWfw60GNd AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1v9ydee7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:29:58 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30BFA72A018932;
        Wed, 11 Jan 2023 15:29:57 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1v9ydedb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:29:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30BCiMuJ004531;
        Wed, 11 Jan 2023 15:29:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n1kkys2u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:29:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30BFTqE520709918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 15:29:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 165542004B;
        Wed, 11 Jan 2023 15:29:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC44520043;
        Wed, 11 Jan 2023 15:29:51 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.175.58])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jan 2023 15:29:51 +0000 (GMT)
Message-ID: <839f7ee6c273f8542f06d3330622e545b86b8abc.camel@linux.ibm.com>
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Date:   Wed, 11 Jan 2023 16:29:51 +0100
In-Reply-To: <10ba824d-6174-2fc4-b58b-a914cc5524be@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
         <20230110202632.2533978-2-scgl@linux.ibm.com>
         <10ba824d-6174-2fc4-b58b-a914cc5524be@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dO2BQm-dusktdhWPzSRTkgqF1rqRVjrk
X-Proofpoint-GUID: VG9eHh-oH0FJicEpST3dsR3oHPrediWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=976
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-01-11 at 10:38 +0100, Janosch Frank wrote:
> On 1/10/23 21:26, Janis Schoetterl-Glausch wrote:
> > User space can use the MEM_OP ioctl to make storage key checked reads
> > and writes to the guest, however, it has no way of performing atomic,
> > key checked, accesses to the guest.
> > Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> > mode. For now, support this mode for absolute accesses only.
> >=20
> > This mode can be use, for example, to set the device-state-change
> > indicator and the adapter-local-summary indicator atomically.
> >=20
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >   include/uapi/linux/kvm.h |   7 +++
> >   arch/s390/kvm/gaccess.h  |   3 ++
> >   arch/s390/kvm/gaccess.c  | 102 ++++++++++++++++++++++++++++++++++++++=
+
> >   arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
> >   4 files changed, 151 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 55155e262646..452f43c1cc34 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
> >   		struct {
> >   			__u8 ar;	/* the access register number */
> >   			__u8 key;	/* access key, ignored if flag unset */
> > +			__u8 pad1[6];	/* ignored */
> > +			__u64 old_addr;	/* ignored if flag unset */
>=20
> These 3 are only used for flag values >=3D4, no?
> They aren't used for all flag values but for specific ones, right?

key is used with the skey flag, old_addr with the cmpxchg flag,
so yes only used with specific flags.
ar is used for logical accesses.

