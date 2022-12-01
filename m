Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA18763F6F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLAR6p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLAR6p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:58:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60EB2747;
        Thu,  1 Dec 2022 09:58:43 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1HpZw8012737;
        Thu, 1 Dec 2022 17:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5sZbgbdKGqHM5UqUh6KNFXUP2DY0iB04RWuZc8h+u2Y=;
 b=qhb4HcAlFA9xozlO84cLFiHWHdZ64kRKkHlgqFVCasUGL44hKk/u13/6ynFT+3MZsQVz
 eyxZ01B8hlfHVeE9D6nDDz75zqLM4ITccEkft80Xp+5tw2QEL9FzkGX0V7oFQwkq21/J
 S6ZCO3ZJ8yIY5PDCdUA0415YWRq40V89vbGO/YhEAgv50bqsvXoW9E8Aca1d5SYfibf8
 OKFBCP+OZIXkwLFA1ngynO+uoKRErX3rtaWrb0cv/ewD38K/Y83xg8fOtB1AbZofBjjH
 Az0u4jhVDDUtuNDYxMMqTcMkwBAmotVbQi7uY722+h+xwM3Dro4tAy+G4ZQPCIE4AjhV Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m711s03nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 17:58:40 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B1Hptj8013602;
        Thu, 1 Dec 2022 17:58:40 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m711s03mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 17:58:39 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1Hnuov032727;
        Thu, 1 Dec 2022 17:58:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3m3ae8wmtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 17:58:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B1Hq1R123003514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Dec 2022 17:52:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBD2C4C044;
        Thu,  1 Dec 2022 17:58:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B8B4C040;
        Thu,  1 Dec 2022 17:58:33 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.179.10.216])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Dec 2022 17:58:33 +0000 (GMT)
Message-ID: <6a387a2a174572fd2db01451b2832c5fdc60bcf1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/9] KVM: s390: selftest: memop: Replace macros by
 functions
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
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
Date:   Thu, 01 Dec 2022 18:58:32 +0100
In-Reply-To: <20221201172813.027bcd13@p-imbrenda>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
         <20221117221758.66326-5-scgl@linux.ibm.com>
         <20221201172813.027bcd13@p-imbrenda>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ptHe_V3NTGaxit2MBxKwqLiuMQZXY5U0
X-Proofpoint-GUID: yLlJAqRcfMRU511D3Q1gfWvLqm3ekpbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-12-01 at 17:28 +0100, Claudio Imbrenda wrote:
> On Thu, 17 Nov 2022 23:17:53 +0100
> Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>=20
> > Replace the DEFAULT_* test helpers by functions, as they don't
> > need the exta flexibility.
> >=20
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >  tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
> >  1 file changed, 39 insertions(+), 43 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/=
selftests/kvm/s390x/memop.c
> > index 69869c7e2ab1..286185a59238 100644
> > --- a/tools/testing/selftests/kvm/s390x/memop.c
> > +++ b/tools/testing/selftests/kvm/s390x/memop.c
> > @@ -48,6 +48,8 @@ struct mop_desc {
> >  	uint8_t key;
> >  };
> > =20
> > +const uint8_t NO_KEY =3D 0xff;
> > +
> >  static struct kvm_s390_mem_op ksmo_from_desc(const struct mop_desc *de=
sc)
> >  {
> >  	struct kvm_s390_mem_op ksmo =3D {
> > @@ -85,7 +87,7 @@ static struct kvm_s390_mem_op ksmo_from_desc(const st=
ruct mop_desc *desc)
> >  		ksmo.flags |=3D KVM_S390_MEMOP_F_INJECT_EXCEPTION;
> >  	if (desc->_set_flags)
> >  		ksmo.flags =3D desc->set_flags;
> > -	if (desc->f_key) {
> > +	if (desc->f_key && desc->key !=3D NO_KEY) {
>=20
> is this change going to affect the behaviour?
> if so, please document it in the patch description

No, previously the absence of a key in the vararg would denote there not be=
ing a key,
now that a function is used there is an explicit no key argument, which is =
checked
here to see if we use key checking or not
>=20
> >  		ksmo.flags |=3D KVM_S390_MEMOP_F_SKEY_PROTECTION;
> >  		ksmo.key =3D desc->key;
> >  	}
> > @@ -268,34 +270,28 @@ static void prepare_mem12(void)
> >  #define ASSERT_MEM_EQ(p1, p2, size) \
> >  	TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
> > =20
> > -#define DEFAULT_WRITE_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)=
		\
> > -({										\
> > -	struct test_info __copy_cpu =3D (copy_cpu), __mop_cpu =3D (mop_cpu);	=
\
> > -	enum mop_target __target =3D (mop_target_p);				\
> > -	uint32_t __size =3D (size);						\
> > -										\
> > -	prepare_mem12();							\
> > -	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
> > -			GADDR_V(mem1), ##__VA_ARGS__);				\
> > -	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
> > -	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size,		\
> > -			GADDR_V(mem2), ##__VA_ARGS__);				\
> > -	ASSERT_MEM_EQ(mem1, mem2, __size);					\
> > -})
> > +static void default_write_read(struct test_info copy_cpu, struct test_=
info mop_cpu,
> > +			       enum mop_target mop_target, uint32_t size, uint8_t key)
> > +{
> > +	prepare_mem12();
> > +	CHECK_N_DO(MOP, mop_cpu, mop_target, WRITE, mem1, size,
> > +		   GADDR_V(mem1), KEY(key));
> > +	HOST_SYNC(copy_cpu, STAGE_COPIED);
> > +	CHECK_N_DO(MOP, mop_cpu, mop_target, READ, mem2, size,
> > +		   GADDR_V(mem2), KEY(key));
> > +	ASSERT_MEM_EQ(mem1, mem2, size);
> > +}
> > =20
> > -#define DEFAULT_READ(copy_cpu, mop_cpu, mop_target_p, size, ...)		\
> > -({										\
> > -	struct test_info __copy_cpu =3D (copy_cpu), __mop_cpu =3D (mop_cpu);	=
\
> > -	enum mop_target __target =3D (mop_target_p);				\
> > -	uint32_t __size =3D (size);						\
> > -										\
> > -	prepare_mem12();							\
> > -	CHECK_N_DO(MOP, __mop_cpu, __target, WRITE, mem1, __size,		\
> > -			GADDR_V(mem1));						\
> > -	HOST_SYNC(__copy_cpu, STAGE_COPIED);					\
> > -	CHECK_N_DO(MOP, __mop_cpu, __target, READ, mem2, __size, ##__VA_ARGS_=
_);\
> > -	ASSERT_MEM_EQ(mem1, mem2, __size);					\
> > -})
> > +static void default_read(struct test_info copy_cpu, struct test_info m=
op_cpu,
> > +			 enum mop_target mop_target, uint32_t size, uint8_t key)
> > +{
> > +	prepare_mem12();
> > +	CHECK_N_DO(MOP, mop_cpu, mop_target, WRITE, mem1, size, GADDR_V(mem1)=
);
> > +	HOST_SYNC(copy_cpu, STAGE_COPIED);
> > +	CHECK_N_DO(MOP, mop_cpu, mop_target, READ, mem2, size,
> > +		   GADDR_V(mem2), KEY(key));
> > +	ASSERT_MEM_EQ(mem1, mem2, size);
> > +}
> > =20
> >  static void guest_copy(void)
> >  {
> > @@ -310,7 +306,7 @@ static void test_copy(void)
> > =20
> >  	HOST_SYNC(t.vcpu, STAGE_INITED);
> > =20
> > -	DEFAULT_WRITE_READ(t.vcpu, t.vcpu, LOGICAL, t.size);
> > +	default_write_read(t.vcpu, t.vcpu, LOGICAL, t.size, NO_KEY);
> > =20
> >  	kvm_vm_free(t.kvm_vm);
> >  }

[...]
