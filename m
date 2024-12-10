Return-Path: <linux-kselftest+bounces-23100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964C9EAC67
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2585188C24F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141521578B;
	Tue, 10 Dec 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o3nLGlXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B32080F7;
	Tue, 10 Dec 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823272; cv=none; b=cjauxatRLw1bfK2souY/tdSZk8pXHUE6vXOIPtpx1jvOfR0tFaCv7T1Y78N+OrE3lvrLuYOElKEzzxtbll1IGax5r7piCsmHdx7cXg3SWE3Rl6zQ6FnZzPmg/xcjEdWGDRhgAJ/LsGq9P7dyCECLnqqKreqbThIr2qHfFa7r33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823272; c=relaxed/simple;
	bh=VL9S1t6P9roMYEeS05t8Msy9iyzkB1wmY1RRZiH8utY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=HjarU8D8tY6QBFHwxJi++lj4ja7tPcCCNV7iK1COOLV1vxV/vc/AtN5EnvQK0znGbCf/WyyVYmQtEgiLEd3CYs9UcC41HSlUeCQXYHPXpx5DQAMzy29L57W31VmNaamRfZM9V7FM5TtOkHT3SZfd1IyXTQLU6fAPi6HIIg+ukko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o3nLGlXV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9NXEcZ032677;
	Tue, 10 Dec 2024 09:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hpoWtD
	rIXUvzYQSAYm9mlRLAcxdm+lfkYTtlhMRxZWo=; b=o3nLGlXVsyGKhgUTgqJJUe
	+EJ4JPiuG7BzUMx5Twuc+Rh7hqUzeozf9wJxve3uzjuqphXKYfE0aRT9VD+8xOtD
	zuZ+7Ee/P/MDhl1W4ZwP2TcUaS01NxH9ZEn3pDKhgYDp2CHlVcjStN3MOdbr7xwa
	2PB0FrOFMP3VyI9+0KRzHMYjuad9lJeigkbTCfCKgm/4pGmU2zPoDoOrcq+YgPPz
	2RuInUtxXuhIQlJoWWOJO2bAGwxUD38kU8w6UHH6PBGnbIIwIbrgPKgRZfA2KHit
	pgmSgrEGMhPQTHllqIw/4tFEY/92oc8CSP+OpVAbOXhh7ufbRdLKXmgEehhqTmvA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq5ft9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:34:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA8BS1T032491;
	Tue, 10 Dec 2024 09:34:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn2x8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:34:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BA9YGfe35258784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 09:34:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E6C20043;
	Tue, 10 Dec 2024 09:34:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5341620040;
	Tue, 10 Dec 2024 09:34:16 +0000 (GMT)
Received: from darkmoore (unknown [9.171.78.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 09:34:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 10:34:10 +0100
Message-Id: <D67X1PKYYP7B.3AJ4BNEBAVI0Q@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 2/6] selftests: kvm: s390: Add ucontrol flic attr
 selftests
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Paolo Bonzini"
 <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241209110717.77279-1-schlameuss@linux.ibm.com>
 <20241209110717.77279-3-schlameuss@linux.ibm.com>
 <20241209191432.03c98f38@p-imbrenda>
In-Reply-To: <20241209191432.03c98f38@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: phykGnzjNe1YNmJ4kSBOlXfEoBf7KxUr
X-Proofpoint-GUID: phykGnzjNe1YNmJ4kSBOlXfEoBf7KxUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=808 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100070

On Mon Dec 9, 2024 at 7:14 PM CET, Claudio Imbrenda wrote:
> On Mon,  9 Dec 2024 12:07:13 +0100
> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
>
> > Add some superficial selftests for the floating interrupt controller
> > when using ucontrol VMs. These tests are intended to cover very basic
> > calls only.
> >=20
> > Some of the calls may trigger null pointer dereferences on kernels not
> > containing the fixes in this patch series.
> >=20
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >  .../selftests/kvm/s390x/ucontrol_test.c       | 150 ++++++++++++++++++
> >  1 file changed, 150 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/=
testing/selftests/kvm/s390x/ucontrol_test.c
> > index 0c112319dab1..972fac1023b5 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > @@ -635,4 +635,154 @@ TEST_F(uc_kvm, uc_skey)
> >  	uc_assert_diag44(self);
> >  }
> > =20
> > +static char uc_flic_b[PAGE_SIZE];
> > +static struct kvm_s390_io_adapter uc_flic_ioa =3D { .id =3D 0 };
> > +static struct kvm_s390_io_adapter_req uc_flic_ioam =3D { .id =3D 0 };
> > +static struct kvm_s390_ais_req uc_flic_asim =3D { .isc =3D 0 };
> > +static struct kvm_s390_ais_all uc_flic_asima =3D { .simm =3D 0 };
> > +static struct uc_flic_attr_test {
> > +	char *name;
> > +	struct kvm_device_attr a;
> > +	int hasrc;
> > +	u64 getrc;
> > +	int geterrno;
> > +	u64 setrc;
>
> I wonder if you really need getrc and setrc? (see below)
>
> > +	int seterrno;
> > +} uc_flic_attr_tests[] =3D {
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_GET_ALL_IRQS",
> > +		.setrc =3D 1, .seterrno =3D EINVAL,
>
> please put them on separate lines ^ (if you end up keeping both)
>
> > +		.a =3D {
> > +			.group =3D KVM_DEV_FLIC_GET_ALL_IRQS,
> > +			.addr =3D (u64)&uc_flic_b,
> > +			.attr =3D PAGE_SIZE,
> > +		},
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_ENQUEUE",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.a =3D { .group =3D KVM_DEV_FLIC_ENQUEUE, },
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_CLEAR_IRQS",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.a =3D { .group =3D KVM_DEV_FLIC_CLEAR_IRQS, },
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_ADAPTER_REGISTER",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.a =3D {
> > +			.group =3D KVM_DEV_FLIC_ADAPTER_REGISTER,
> > +			.addr =3D (u64)&uc_flic_ioa,
> > +		},
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_ADAPTER_MODIFY",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.setrc =3D 1, .seterrno =3D EINVAL,
> > +		.a =3D {
> > +			.group =3D KVM_DEV_FLIC_ADAPTER_MODIFY,
> > +			.addr =3D (u64)&uc_flic_ioam,
> > +			.attr =3D sizeof(uc_flic_ioam),
> > +		},
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_CLEAR_IO_IRQ",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.setrc =3D 1, .seterrno =3D EINVAL,
> > +		.a =3D {
> > +			.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ,
> > +			.attr =3D 32,
> > +		},
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_AISM",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.setrc =3D 1, .seterrno =3D ENOTSUP,
> > +		.a =3D {
> > +			.group =3D KVM_DEV_FLIC_AISM,
> > +			.addr =3D (u64)&uc_flic_asim,
> > +		},
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_AIRQ_INJECT",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.a =3D { .group =3D KVM_DEV_FLIC_AIRQ_INJECT, },
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_AISM_ALL",
> > +		.getrc =3D 1, .geterrno =3D ENOTSUP,
> > +		.setrc =3D 1, .seterrno =3D ENOTSUP,
> > +		.a =3D {
> > +			.group =3D KVM_DEV_FLIC_AISM_ALL,
> > +			.addr =3D (u64)&uc_flic_asima,
> > +			.attr =3D sizeof(uc_flic_asima),
> > +		},
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_APF_ENABLE",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.setrc =3D 1, .seterrno =3D EINVAL,
> > +		.a =3D { .group =3D KVM_DEV_FLIC_APF_ENABLE, },
> > +	},
> > +	{
> > +		.name =3D "KVM_DEV_FLIC_APF_DISABLE_WAIT",
> > +		.getrc =3D 1, .geterrno =3D EINVAL,
> > +		.setrc =3D 1, .seterrno =3D EINVAL,
> > +		.a =3D { .group =3D KVM_DEV_FLIC_APF_DISABLE_WAIT, },
> > +	},
> > +};
> > +
> > +TEST_F(uc_kvm, uc_flic_attrs)
> > +{
> > +	struct kvm_create_device cd =3D { .type =3D KVM_DEV_TYPE_FLIC };
> > +	struct kvm_device_attr attr;
> > +	u64 value;
> > +	int rc, i;
> > +
> > +	rc =3D ioctl(self->vm_fd, KVM_CREATE_DEVICE, &cd);
> > +	ASSERT_EQ(0, rc) TH_LOG("create device failed with err %s (%i)",
> > +				strerror(errno), errno);
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(uc_flic_attr_tests); i++) {
> > +		TH_LOG("test %s", uc_flic_attr_tests[i].name);
> > +		attr =3D (struct kvm_device_attr) {
> > +			.group =3D uc_flic_attr_tests[i].a.group,
> > +			.attr =3D uc_flic_attr_tests[i].a.attr,
> > +			.addr =3D uc_flic_attr_tests[i].a.addr,
> > +		};
> > +		if (attr.addr =3D=3D 0)
> > +			attr.addr =3D (u64)&value;
> > +
> > +		rc =3D ioctl(cd.fd, KVM_HAS_DEVICE_ATTR, &attr);
> > +		EXPECT_EQ(uc_flic_attr_tests[i].hasrc, !!rc)
> > +			TH_LOG("expected dev attr missing %s",
> > +			       uc_flic_attr_tests[i].name);
> > +
> > +		rc =3D ioctl(cd.fd, KVM_GET_DEVICE_ATTR, &attr);
> > +		EXPECT_EQ(uc_flic_attr_tests[i].getrc, !!rc)
>
> maybe you could just do:
>
> 	EXPECT_EQ(!!uc_flic_attr_tests[i].geterrno, !!rc)
>
> (unless I am missing something)
>
> this is not super important, though
>

Yes, that should work. I will do that. Thanks!

> > +			TH_LOG("get dev attr rc not expected on %s %s (%i)",
> > +			       uc_flic_attr_tests[i].name,
> > +			       strerror(errno), errno);
> > +		if (uc_flic_attr_tests[i].geterrno)
> > +			EXPECT_EQ(uc_flic_attr_tests[i].geterrno, errno)
> > +				TH_LOG("get dev attr errno not expected on %s %s (%i)",
> > +				       uc_flic_attr_tests[i].name,
> > +				       strerror(errno), errno);
> > +
> > +		rc =3D ioctl(cd.fd, KVM_SET_DEVICE_ATTR, &attr);
> > +		EXPECT_EQ(uc_flic_attr_tests[i].setrc, !!rc)
> > +			TH_LOG("set sev attr rc not expected on %s %s (%i)",
> > +			       uc_flic_attr_tests[i].name,
> > +			       strerror(errno), errno);
> > +		if (uc_flic_attr_tests[i].seterrno)
> > +			EXPECT_EQ(uc_flic_attr_tests[i].seterrno, errno)
> > +				TH_LOG("set dev attr errno not expected on %s %s (%i)",
> > +				       uc_flic_attr_tests[i].name,
> > +				       strerror(errno), errno);
> > +	}
> > +
> > +	close(cd.fd);
> > +}
> > +
> >  TEST_HARNESS_MAIN


