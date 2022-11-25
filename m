Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636E63858E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 09:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKYIwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 03:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKYIwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 03:52:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BBCE9;
        Fri, 25 Nov 2022 00:52:28 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AP8nmiJ006687;
        Fri, 25 Nov 2022 08:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references :
 subject : to : cc : from : message-id : date; s=pp1;
 bh=7RGeCEHG1G53Xom7o/juk/OP7d5IJEctJeBMolf8ohE=;
 b=jtXj+Qa0Hw49rdLzDKaQKmWe6taT9UacpCAKpRHwij/B3D8wIrJKqMMcgVCIIAgf19k9
 T77Jev2X23zV8KN2aUovjCQG3CjwXtrD5kig7Cb7j1UWRqZWg9iR0GowUNnDPAztnzB1
 zDxmZz0Fodtw8uqtd+PS2ezUEnnWDnVY80ftIiZ1pZi6/vp+pkfs+7o3L7uNRBgL0Z1M
 t+c7p70gKAsnciqPCRauo5MPozEo/wvaQUwLEyXGd1o61hqzxgJr70MSGAVZEvAdbq99
 oDGNNX4RsspzR1OBTwNAxLLxUS03V+yXjyw1wXlszudVyXyTHbPUWN7vhv8pOBTP90sk lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2thrr1ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 08:52:25 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AP8oqN1009927;
        Fri, 25 Nov 2022 08:52:24 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2thrr1nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 08:52:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AP8pOZC017679;
        Fri, 25 Nov 2022 08:52:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kxps91ar3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 08:52:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AP8qI8c63766992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 08:52:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD47B42042;
        Fri, 25 Nov 2022 08:52:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76B04203F;
        Fri, 25 Nov 2022 08:52:18 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.26.223])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Nov 2022 08:52:18 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e735fa2cde6e9c92dda134634cb3d67b64b23fe9.camel@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com> <20221117221758.66326-3-scgl@linux.ibm.com> <f96b50e2-24ac-4016-d3f1-ffc375516e7c@redhat.com> <e735fa2cde6e9c92dda134634cb3d67b64b23fe9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
From:   Nico Boehr <nrb@linux.ibm.com>
Message-ID: <166936633695.19077.13372353298394327779@t14-nrb.local>
User-Agent: alot/0.8.1
Date:   Fri, 25 Nov 2022 09:52:18 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tHcF3P8PfsqF7PEYaJjzK5zOowVa2Wef
X-Proofpoint-GUID: FNGyPJvbxGrMU8e6_jYyAt9gb_ciObwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_02,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=676
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Janis Schoetterl-Glausch (2022-11-22 14:10:41)
> On Tue, 2022-11-22 at 08:47 +0100, Thomas Huth wrote:
> > On 17/11/2022 23.17, Janis Schoetterl-Glausch wrote:
[...]
> > >   Supported flags:
> > >     * ``KVM_S390_MEMOP_F_CHECK_ONLY``
> > >     * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> > > +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> > > +
> > > +The semantics of the flags common with logical acesses are as for lo=
gical
> > > +accesses.
> > > +
> > > +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> >=20
> > I'd maybe merge this with the last sentence:
> >=20
> > For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if=20
> > KVM_CAP_S390_MEM_OP_EXTENSION has bit 1 (i.e. bit with value 2) set.
>=20
> Ok.
> >=20
> > ... and speaking of that, I wonder whether it's maybe a good idea to=20
> > introduce some #defines for bit 1 / value 2, to avoid the confusion ?
>=20
> Not sure, I don't feel it's too complicated. Where would you define it?
> Next to the mem_op struct? KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG?

I think the define would be a good idea. Location and name sound good to me.

You could also replace the hard-coded 0x3 in kvm_vm_ioctl_check_extension()=
 when you have the define.
