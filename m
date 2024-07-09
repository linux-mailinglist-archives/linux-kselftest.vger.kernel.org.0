Return-Path: <linux-kselftest+bounces-13388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E053292C220
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6631C22DAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B1C18EA70;
	Tue,  9 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Px9uD66a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE018D4C3;
	Tue,  9 Jul 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544879; cv=none; b=f8ZvF2ajQ1SBXD8QuV4DRfA4qQHhG74+Aw3yayBMOLIco83gIT94mVnn0qAdzejI9TX5zPgsKou/Fpe60YrtTWQkAxRncxL4zgw3XI5Sp7MFUL87GOIbwm0PAB5kNamVnvSxtYSppx9Q689ZZ1S+JQbsEUP8Z981Peh755BpqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544879; c=relaxed/simple;
	bh=0Ruhbdx1N5j4KET+zfe1dv5r2Y5Dt1sb5DHMVJvs1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntNFERkwZWOagXNvKZY0y8BXEb/crAU0QxbXEYMv4ISxDbuQNNAsWBqV2H+hC60ZtglgZiph23gAISd1qzyUvqT9XlyjtkuBdoe3iIFRnRb7JVPV51PC/dsRB+ODBmzmJ2s451FiKlBvdIEmk6JUzG/UWFReKOjI4q2Qk/T6p2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Px9uD66a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469GRBtE007455;
	Tue, 9 Jul 2024 17:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	TQRbn1aZUS13jCjLz8fGA+s06NmreG8XRilqxdF/v7U=; b=Px9uD66aY0GrV1+9
	x7FgzLq7yp6AJCzl39LVUgevcNsf06TrYwXHnLyvfI5K1fRpZPr612j0l5cWqa5V
	uIsHLur9WYEKqnZ5x6x6iAQH5tkKDlPGOV25w/Dlr6ZVXpf3pTA5A6vegPQMmOLG
	jsTV2orOdkd6aiEIC/c9Noozznsxr90T5XXY83JjAP33pqwkYYgpYAexnLSSSCN9
	ybhEj9ap+TJGlQPplIr9naXlzCGwlDI8uRM3GA0bcfVIOn/CDP9j2v00wbO16aZq
	6toAZM+YKpjGTyGU8bXG4Q24bWjxtKVraZF2fJoZeM7zSosXg9DWPdA3OcOMb6nO
	5TjkOA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40964h0kg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7mv5003886;
	Tue, 9 Jul 2024 17:07:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40964h0kg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469FYvqo014101;
	Tue, 9 Jul 2024 17:07:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8pnq7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7fhT55509274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC12C2004B;
	Tue,  9 Jul 2024 17:07:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FBF720040;
	Tue,  9 Jul 2024 17:07:41 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:41 +0000 (GMT)
Date: Tue, 9 Jul 2024 17:43:26 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v1 3/9] selftests: kvm: s390: Add s390x ucontrol test
 suite with hpage test
Message-ID: <20240709174326.313ef53c@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-4-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-4-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8p3udzzsjUwpjXEDZ8jIKavHBkZHVxtF
X-Proofpoint-ORIG-GUID: ALe0jQgYyQArd3tHeXtj1D-bm0GSNi4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue,  9 Jul 2024 14:56:58 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add test suite to validate the s390x architecture specific ucontrol KVM
> interface.
> 
> Make use of the selftest test harness.
> 
> * uc_cap_hpage testcase verifies that a ucontrol VM cannot be run with
>   hugepages.
> 
> To allow testing of the ucontrol interface the kernel needs a
> non-default config containing CONFIG_KVM_S390_UCONTROL.
> This config needs to be set to built-in (y) as this cannot be built as
> module.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/.gitignore        |  1 +
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  tools/testing/selftests/kvm/s390x/config      |  2 +
>  .../selftests/kvm/s390x/ucontrol_test.c       | 78 +++++++++++++++++++
>  4 files changed, 82 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/config
>  create mode 100644 tools/testing/selftests/kvm/s390x/ucontrol_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 6d9381d60172..f2a30a58cd71 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -5,3 +5,4 @@
>  !*.h
>  !*.S
>  !*.sh
> +!config
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index ac280dcba996..3b33b3975c93 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -184,6 +184,7 @@ TEST_GEN_PROGS_s390x += s390x/tprot
>  TEST_GEN_PROGS_s390x += s390x/cmma_test
>  TEST_GEN_PROGS_s390x += s390x/debug_test
>  TEST_GEN_PROGS_s390x += s390x/shared_zeropage_test
> +TEST_GEN_PROGS_s390x += s390x/ucontrol_test
>  TEST_GEN_PROGS_s390x += demand_paging_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += guest_print_test
> diff --git a/tools/testing/selftests/kvm/s390x/config b/tools/testing/selftests/kvm/s390x/config
> new file mode 100644
> index 000000000000..23270f2d679f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/config
> @@ -0,0 +1,2 @@
> +CONFIG_KVM=y
> +CONFIG_KVM_S390_UCONTROL=y
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> new file mode 100644
> index 000000000000..a706a9f2b9ea
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test code for the s390x kvm ucontrol interface
> + *
> + * Copyright IBM Corp. 2024
> + *
> + * Authors:
> + *  Christoph Schlameuss <schlameuss@linux.ibm.com>
> + */
> +#include "kselftest_harness.h"
> +#include "kvm_util.h"
> +
> +#include <linux/capability.h>
> +#include <linux/sizes.h>
> +
> +#define SYS_ADMIN_CAP 0x200000
> +
> +/* so directly declare capget to check caps without libcap */
> +int capget(cap_user_header_t header, cap_user_data_t data);
> +
> +/**
> + * In order to create user controlled virtual machines on S390,
> + * check KVM_CAP_S390_UCONTROL and use the flag KVM_VM_S390_UCONTROL
> + * as privileged user (SYS_ADMIN).
> + */
> +void require_ucontrol_admin(void)
> +{
> +	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
> +	struct __user_cap_header_struct hdr = {
> +		.version = _LINUX_CAPABILITY_VERSION_3,
> +	};
> +	int rc;
> +
> +	rc = capget(&hdr, data);
> +	TEST_ASSERT_EQ(0, rc);
> +	TEST_REQUIRE((data->effective & SYS_ADMIN_CAP) > 0);
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
> +}
> +
> +/**
> + * Assert HPAGE CAP cannot be enabled on UCONTROL VM
> + */
> +TEST(uc_cap_hpage)
> +{
> +	int rc, kvm_fd, vm_fd, vcpu_fd;
> +	struct kvm_enable_cap cap = {
> +		.cap = KVM_CAP_S390_HPAGE_1M,
> +	};
> +
> +	require_ucontrol_admin();
> +
> +	kvm_fd = open_kvm_dev_path_or_exit();
> +	vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, KVM_VM_S390_UCONTROL);
> +	ASSERT_GE(vm_fd, 0);
> +
> +	/* assert hpages are not supported on ucontrol vm */
> +	rc = ioctl(vm_fd, KVM_CHECK_EXTENSION, KVM_CAP_S390_HPAGE_1M);
> +	EXPECT_EQ(0, rc);
> +
> +	/* Test that KVM_CAP_S390_HPAGE_1M can't be enabled for a ucontrol vm */
> +	rc = ioctl(vm_fd, KVM_ENABLE_CAP, cap);
> +	EXPECT_EQ(-1, rc);
> +	EXPECT_EQ(EINVAL, errno);
> +
> +	/* assert HPAGE CAP is rejected after vCPU creation */
> +	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
> +	ASSERT_GE(vcpu_fd, 0);
> +	rc = ioctl(vm_fd, KVM_ENABLE_CAP, cap);
> +	EXPECT_EQ(-1, rc);
> +	EXPECT_EQ(EBUSY, errno);
> +
> +	close(vcpu_fd);
> +	close(vm_fd);
> +	close(kvm_fd);
> +}
> +
> +TEST_HARNESS_MAIN


