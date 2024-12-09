Return-Path: <linux-kselftest+bounces-23056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070729E9DE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13A6188874C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2815666A;
	Mon,  9 Dec 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p8fYesV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513171F5F6;
	Mon,  9 Dec 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768087; cv=none; b=O0XTnJ6TA2N0DIPFdzLQWWMzhDxOkxN8isifNgJoRzGoN57OmJX3g63PBCu8bt9fXdUqqWvxF0VHVTWuulU7gEVUaGTKKaSQszEpD1pNajX5L+QNwhsObOBlAattCy96yBCFxInR+f04TsD03ou8pRrSVUitH/ehTJkZUJ29xW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768087; c=relaxed/simple;
	bh=E49VBYWzl2VDgDBTnaG/kwBLSjQvkZNC0v+S1CFvd7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwvlhw+jGr6UzIO87YsxvNYD/JCjDbpI06vxNwzvA1EOqGlDLYznzbrl3DhUisJ5vVG6Z9NkUoqKoUMKfRvMdkgoLGpXkxt3J+ax/PZfiNdiH/nnducLxjAEEyPLQxWClX7w6LUB4Xk8uXTb19UchQLe57cYrspHdeFhUDT6MZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p8fYesV9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CvKYv016121;
	Mon, 9 Dec 2024 18:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=llI+IA
	InT7EnPiXfWG0aJ8N9qiD1xs/Qb+SaEvhpci8=; b=p8fYesV9owVwOFPB8vaYkG
	Y5v+IMpfgQK/Fdggr3XBCkswZdDU7AU4Y7JY3hW91w5d+Kl+vRDGmi+7DVg9GKXA
	lwJ5DSF8gI/avP6YNpOL6x+n5by4nQZciZIqngMu8j20CLhfq9tUnBDM6+yGAJWk
	gQiZiy7QzfPy0gnvR8ATmrxM33uLXZPS6G1lbkLyWjA7rajlOoiXgNLmIsdsYcK4
	lH+qNBra0c65PfNxgfRGExfvbKKIYvv0IR0GGdYYB5Ew4JNtgOH6rDjDAcgNYJCi
	T/l18w6c8LSHUGD7/MFhS9wo1BydF2CbBhYGuIzna47cr9YSntTfRWU8/BxN97Dg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0x9wgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 18:14:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HgETu016910;
	Mon, 9 Dec 2024 18:14:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y008u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 18:14:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9IEYid22872758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 18:14:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A197520043;
	Mon,  9 Dec 2024 18:14:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D6D620040;
	Mon,  9 Dec 2024 18:14:34 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 18:14:34 +0000 (GMT)
Date: Mon, 9 Dec 2024 19:14:32 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/6] selftests: kvm: s390: Add ucontrol flic attr
 selftests
Message-ID: <20241209191432.03c98f38@p-imbrenda>
In-Reply-To: <20241209110717.77279-3-schlameuss@linux.ibm.com>
References: <20241209110717.77279-1-schlameuss@linux.ibm.com>
	<20241209110717.77279-3-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5_f5WAiK6GAvRVd3IdCjE3E2XPGn0xWS
X-Proofpoint-ORIG-GUID: 5_f5WAiK6GAvRVd3IdCjE3E2XPGn0xWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=974
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090136

On Mon,  9 Dec 2024 12:07:13 +0100
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add some superficial selftests for the floating interrupt controller
> when using ucontrol VMs. These tests are intended to cover very basic
> calls only.
> 
> Some of the calls may trigger null pointer dereferences on kernels not
> containing the fixes in this patch series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 0c112319dab1..972fac1023b5 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -635,4 +635,154 @@ TEST_F(uc_kvm, uc_skey)
>  	uc_assert_diag44(self);
>  }
>  
> +static char uc_flic_b[PAGE_SIZE];
> +static struct kvm_s390_io_adapter uc_flic_ioa = { .id = 0 };
> +static struct kvm_s390_io_adapter_req uc_flic_ioam = { .id = 0 };
> +static struct kvm_s390_ais_req uc_flic_asim = { .isc = 0 };
> +static struct kvm_s390_ais_all uc_flic_asima = { .simm = 0 };
> +static struct uc_flic_attr_test {
> +	char *name;
> +	struct kvm_device_attr a;
> +	int hasrc;
> +	u64 getrc;
> +	int geterrno;
> +	u64 setrc;

I wonder if you really need getrc and setrc? (see below)

> +	int seterrno;
> +} uc_flic_attr_tests[] = {
> +	{
> +		.name = "KVM_DEV_FLIC_GET_ALL_IRQS",
> +		.setrc = 1, .seterrno = EINVAL,

please put them on separate lines ^ (if you end up keeping both)

> +		.a = {
> +			.group = KVM_DEV_FLIC_GET_ALL_IRQS,
> +			.addr = (u64)&uc_flic_b,
> +			.attr = PAGE_SIZE,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_ENQUEUE",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_ENQUEUE, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_CLEAR_IRQS",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_CLEAR_IRQS, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_ADAPTER_REGISTER",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_ADAPTER_REGISTER,
> +			.addr = (u64)&uc_flic_ioa,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_ADAPTER_MODIFY",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.setrc = 1, .seterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_ADAPTER_MODIFY,
> +			.addr = (u64)&uc_flic_ioam,
> +			.attr = sizeof(uc_flic_ioam),
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_CLEAR_IO_IRQ",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.setrc = 1, .seterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_CLEAR_IO_IRQ,
> +			.attr = 32,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_AISM",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.setrc = 1, .seterrno = ENOTSUP,
> +		.a = {
> +			.group = KVM_DEV_FLIC_AISM,
> +			.addr = (u64)&uc_flic_asim,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_AIRQ_INJECT",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_AIRQ_INJECT, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_AISM_ALL",
> +		.getrc = 1, .geterrno = ENOTSUP,
> +		.setrc = 1, .seterrno = ENOTSUP,
> +		.a = {
> +			.group = KVM_DEV_FLIC_AISM_ALL,
> +			.addr = (u64)&uc_flic_asima,
> +			.attr = sizeof(uc_flic_asima),
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_APF_ENABLE",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.setrc = 1, .seterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_APF_ENABLE, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_APF_DISABLE_WAIT",
> +		.getrc = 1, .geterrno = EINVAL,
> +		.setrc = 1, .seterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_APF_DISABLE_WAIT, },
> +	},
> +};
> +
> +TEST_F(uc_kvm, uc_flic_attrs)
> +{
> +	struct kvm_create_device cd = { .type = KVM_DEV_TYPE_FLIC };
> +	struct kvm_device_attr attr;
> +	u64 value;
> +	int rc, i;
> +
> +	rc = ioctl(self->vm_fd, KVM_CREATE_DEVICE, &cd);
> +	ASSERT_EQ(0, rc) TH_LOG("create device failed with err %s (%i)",
> +				strerror(errno), errno);
> +
> +	for (i = 0; i < ARRAY_SIZE(uc_flic_attr_tests); i++) {
> +		TH_LOG("test %s", uc_flic_attr_tests[i].name);
> +		attr = (struct kvm_device_attr) {
> +			.group = uc_flic_attr_tests[i].a.group,
> +			.attr = uc_flic_attr_tests[i].a.attr,
> +			.addr = uc_flic_attr_tests[i].a.addr,
> +		};
> +		if (attr.addr == 0)
> +			attr.addr = (u64)&value;
> +
> +		rc = ioctl(cd.fd, KVM_HAS_DEVICE_ATTR, &attr);
> +		EXPECT_EQ(uc_flic_attr_tests[i].hasrc, !!rc)
> +			TH_LOG("expected dev attr missing %s",
> +			       uc_flic_attr_tests[i].name);
> +
> +		rc = ioctl(cd.fd, KVM_GET_DEVICE_ATTR, &attr);
> +		EXPECT_EQ(uc_flic_attr_tests[i].getrc, !!rc)

maybe you could just do:

	EXPECT_EQ(!!uc_flic_attr_tests[i].geterrno, !!rc)

(unless I am missing something)

this is not super important, though

> +			TH_LOG("get dev attr rc not expected on %s %s (%i)",
> +			       uc_flic_attr_tests[i].name,
> +			       strerror(errno), errno);
> +		if (uc_flic_attr_tests[i].geterrno)
> +			EXPECT_EQ(uc_flic_attr_tests[i].geterrno, errno)
> +				TH_LOG("get dev attr errno not expected on %s %s (%i)",
> +				       uc_flic_attr_tests[i].name,
> +				       strerror(errno), errno);
> +
> +		rc = ioctl(cd.fd, KVM_SET_DEVICE_ATTR, &attr);
> +		EXPECT_EQ(uc_flic_attr_tests[i].setrc, !!rc)
> +			TH_LOG("set sev attr rc not expected on %s %s (%i)",
> +			       uc_flic_attr_tests[i].name,
> +			       strerror(errno), errno);
> +		if (uc_flic_attr_tests[i].seterrno)
> +			EXPECT_EQ(uc_flic_attr_tests[i].seterrno, errno)
> +				TH_LOG("set dev attr errno not expected on %s %s (%i)",
> +				       uc_flic_attr_tests[i].name,
> +				       strerror(errno), errno);
> +	}
> +
> +	close(cd.fd);
> +}
> +
>  TEST_HARNESS_MAIN


