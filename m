Return-Path: <linux-kselftest+bounces-23600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE059F7E8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27239188E901
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B2227565;
	Thu, 19 Dec 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EigtaQQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29122616E;
	Thu, 19 Dec 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623568; cv=none; b=TMCX7vRVlQQO1PPX5BX5zZPAREfJhXVV3aEcZNdLnL8NYrSVgZXiODqlXXdFHNcWZ7QjjtRMFm2w0gQBh3vcZ4PO7BcDHqONPQpjVmlPCmMwx57b41Cs2V3Hy+5AEW++hhSF0OXABwVrtnUnsgS4UhJUGeN3Jv2tWrJcWz+lJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623568; c=relaxed/simple;
	bh=pZS0z/+QmAkuWRS00bA7z53xQJNLEdQgeveeVGf3BtM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Az+rHSp/T09sE8VSp/iBvipiLE5N3fMzYkapqAc6RjcOcNMKnLsAJx/wyMYRHAZuQZyTJz4BELgS+srrH48tdC6s+QZVUecD+2t6I1dFPQuBEKqHP3nefWrO4k/3wOMlUHR0b/Pl/T8BfumltFT/nYqLfewE5iGdcvC3n3jCXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EigtaQQw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJEHjlQ026270;
	Thu, 19 Dec 2024 15:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HP4gNt
	CVE41AhqwbvJgSpDbsQIUOJMCKdPKKLcAwHWI=; b=EigtaQQw1ryQcuKHtZPZdI
	fbT27M8xyGXXFao5Cqs3z6hz5mOfz42I6uFeaBSL6yLHEFwfpgKBjrCGJLxbn5jh
	rk2mHZNPXRfW8hCbbVVDhAX08donDmDn0JA/8HQvaQCfo+KLytaeH2Tw6BVX8fTG
	J3iDL6D42BM5GllyFrSsBONHJsZLhGgBLB02ON7KKYs4hGh0i5u/OieghINWVNoU
	VgiYUiMGJCO0vD4pfORX9W3lE+FImbOc29NbrihzPLGaAcawFftrdFkl0OlaT8sq
	ed8kPJGy+SWuL6ZPMPyVB+c+XD4zl3wJvkrRb3Vvyy/bnybiDOaX7gpxkDss1Jyw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyhu3d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 15:52:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJDmrBf011271;
	Thu, 19 Dec 2024 15:52:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkdjh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 15:52:40 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJFqcwW22151748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 15:52:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404F058043;
	Thu, 19 Dec 2024 15:52:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C6158055;
	Thu, 19 Dec 2024 15:52:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 15:52:37 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 16:52:37 +0100
From: Hariharan Mari <hari55@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo
 Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand
 <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/6] selftests: kvm: s390: Add ucontrol flic attr
 selftests
In-Reply-To: <20241216092140.329196-3-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
 <20241216092140.329196-3-schlameuss@linux.ibm.com>
Message-ID: <0cc5df8fb51600c1c9d843ba36becf95@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EsgNTH-R3NbOTXGvfxBx1ZKrGfhFlt1q
X-Proofpoint-GUID: EsgNTH-R3NbOTXGvfxBx1ZKrGfhFlt1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=908 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190124

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Add some superficial selftests for the floating interrupt controller
> when using ucontrol VMs. These tests are intended to cover very basic
> calls only.
> 
> Some of the calls may trigger null pointer dereferences on kernels not
> containing the fixes in this patch series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Hariharan Mari <hari55@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 0c112319dab1..b003abda8495 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -635,4 +635,152 @@ TEST_F(uc_kvm, uc_skey)
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
> +	int geterrno;
> +	int seterrno;
> +} uc_flic_attr_tests[] = {
> +	{
> +		.name = "KVM_DEV_FLIC_GET_ALL_IRQS",
> +		.seterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_GET_ALL_IRQS,
> +			.addr = (u64)&uc_flic_b,
> +			.attr = PAGE_SIZE,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_ENQUEUE",
> +		.geterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_ENQUEUE, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_CLEAR_IRQS",
> +		.geterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_CLEAR_IRQS, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_ADAPTER_REGISTER",
> +		.geterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_ADAPTER_REGISTER,
> +			.addr = (u64)&uc_flic_ioa,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_ADAPTER_MODIFY",
> +		.geterrno = EINVAL,
> +		.seterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_ADAPTER_MODIFY,
> +			.addr = (u64)&uc_flic_ioam,
> +			.attr = sizeof(uc_flic_ioam),
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_CLEAR_IO_IRQ",
> +		.geterrno = EINVAL,
> +		.seterrno = EINVAL,
> +		.a = {
> +			.group = KVM_DEV_FLIC_CLEAR_IO_IRQ,
> +			.attr = 32,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_AISM",
> +		.geterrno = EINVAL,
> +		.seterrno = ENOTSUP,
> +		.a = {
> +			.group = KVM_DEV_FLIC_AISM,
> +			.addr = (u64)&uc_flic_asim,
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_AIRQ_INJECT",
> +		.geterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_AIRQ_INJECT, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_AISM_ALL",
> +		.geterrno = ENOTSUP,
> +		.seterrno = ENOTSUP,
> +		.a = {
> +			.group = KVM_DEV_FLIC_AISM_ALL,
> +			.addr = (u64)&uc_flic_asima,
> +			.attr = sizeof(uc_flic_asima),
> +		},
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_APF_ENABLE",
> +		.geterrno = EINVAL,
> +		.seterrno = EINVAL,
> +		.a = { .group = KVM_DEV_FLIC_APF_ENABLE, },
> +	},
> +	{
> +		.name = "KVM_DEV_FLIC_APF_DISABLE_WAIT",
> +		.geterrno = EINVAL,
> +		.seterrno = EINVAL,
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
> +		EXPECT_EQ(!!uc_flic_attr_tests[i].geterrno, !!rc)
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
> +		EXPECT_EQ(!!uc_flic_attr_tests[i].seterrno, !!rc)
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

