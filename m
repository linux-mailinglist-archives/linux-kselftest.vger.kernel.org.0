Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE16C7EC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 14:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCXNb1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXNb0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 09:31:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BC12051;
        Fri, 24 Mar 2023 06:31:24 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OBp3Ww022486;
        Fri, 24 Mar 2023 13:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : cc :
 from : to : subject : message-id : date; s=pp1;
 bh=1dxXhbevHbImpCyDBizz3L/sJvX972Ru0eCr7UvnWiM=;
 b=o43tEMCozBZ4z90lzyz7x+PzNIPEIl3kWE0nU7bcMSzZ03+BeQxXXlFlDlopef/+T43P
 g2Thc+fuuDvMti9lbEgZ3xYYvl1BX/tiXfEE2A6MnWtaMUnaFURLM0BTU54uK33Wu+EO
 I2ikBry0Zn7kvIUXfcMbAdiEBW6+qcWSOt6yokINZWbuakdzxFZzO6mcOmf9E3IAVlRz
 E7xE+KW4el+lda7SvztBv0rtUndHPdsxaxuOJLN8Axii6gRQVW0NUTGrrPFKlO61dzwb
 2UDXbM1sbRtRRRlRnBApDBQOf+T3YAUYPn9vtOUavvzcYQBposMmFzJIwQ1tdolEIjo0 OQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phbbraf03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:31:21 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32O2lPN3000934;
        Fri, 24 Mar 2023 13:31:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3pgy9cgq9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:31:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ODVF3t28901842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 13:31:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEDE52004B;
        Fri, 24 Mar 2023 13:31:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ACE820040;
        Fri, 24 Mar 2023 13:31:15 +0000 (GMT)
Received: from t14-nrb (unknown [9.179.14.197])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Mar 2023 13:31:15 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230323153644.0ece796f@p-imbrenda>
References: <20230208144827.131300-1-nrb@linux.ibm.com> <20230208144827.131300-3-nrb@linux.ibm.com> <20230323153644.0ece796f@p-imbrenda>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Nico Boehr <nrb@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] KVM: s390: selftests: add selftest for CMMA migration
Message-ID: <167966467508.41638.7406110796797557962@t14-nrb>
User-Agent: alot/0.8.1
Date:   Fri, 24 Mar 2023 14:31:15 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ySAiUDWg0YGTN9a-tyniRmgP04eSjKSv
X-Proofpoint-GUID: ySAiUDWg0YGTN9a-tyniRmgP04eSjKSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=858 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240106
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Claudio Imbrenda (2023-03-23 15:36:44)
> > diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/test=
ing/selftests/kvm/s390x/cmma_test.c
> > new file mode 100644
> > index 000000000000..76751abf2331
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
[...]
> > +static void create_main_memslot(struct kvm_vm *vm)
> > +{
> > +     int i;
> > +
> > +     vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, MAIN_=
PAGE_COUNT, 0);
> > +     for (i =3D 0; i < NR_MEM_REGIONS; i++)
> > +             vm->memslots[i] =3D 0;
>=20
> can you explain why you are zeroing all memslots?

I think it's not all memslots, this array only contains IDs of some memslot=
s.  I think the IDs are set to 0 to indicate "this slot is unused".

I did this here, because that's what __vm_create does. Since I can't use __=
vm_create (I want my custom memslots), I have to use ____vm_create and I th=
ought it's good to just do the same thing here.
