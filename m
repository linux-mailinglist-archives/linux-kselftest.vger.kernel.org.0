Return-Path: <linux-kselftest+bounces-23514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC39F698D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE4716590E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A81F191A;
	Wed, 18 Dec 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tih5ws51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C01F03ED;
	Wed, 18 Dec 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534583; cv=none; b=AhwsLTQMqLTztwlAkS2/zyD+MSs1t1rUG9ImTcpvjcVDgltJaOOwyRKe2DqEPFaHCY22+YCmOZkCCSl0mT4bgOxLpEytic9t2zI8SFl7KgbgPJfqwu2w4OqjtbLfc8OIDrfEbafipVXAaGOpSvIBS4rp6KD4hg//fMAZ+tjRgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534583; c=relaxed/simple;
	bh=wZGNSQCVNg/C6m1I550WFdXNGWmnB5WUYVLkdNxIrpE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PzLzrSQ0DfyfgZhUYTjciy3dkLKJRAy+q9hvoWyFRAoqApMwcysIsN0g2WRcH/1khoRjr8myAJ5IkDFxdEypZLuk/EFo9ZGShKS8oPK1JMZ+rQFtpee7sSxn+v+DzVagavesMx3PP6eFAb9ln7BsZfd29CXQq+zuAL3AXc2i7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tih5ws51; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICFtQb018846;
	Wed, 18 Dec 2024 15:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mQwWLo
	tBJeI73oxcQANL5VgWTLbEmd7WaRydCLVAyoo=; b=Tih5ws51OAXyyHE7/bdMo6
	HzqyaOiv7xAy7imfDNY9lPQSPTk3tUPifEsufjV1jYBDn8AAs8+BB2o0wjOkX3gV
	2se72x/MqfecFS9kMekA/K6VKJcHIk+w2MhJ2zBmkfMh0UYJdUcrd9yLlVvDQd8A
	Dx5x7eADFYK0rQlHVsdDbE4+XDOU8RGXnC/nVL0h5XP9h1mgY/BHwGA1hj1Z5NAl
	tmTGU2YkS/Q/JYZo0NvhGv24/99FHZMjI/1/ZRuqJKqDlyI74/nkCnRct91tR3DF
	j4Fn0TrhQT7Bz4pJLUM2r4AYaODwCROpdhXiLaAU2zp1r7PFDIZbi2JtCnJtVvxw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kk4abp1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:09:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIDA9T7024027;
	Wed, 18 Dec 2024 15:09:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukgcmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:09:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIF9YmW26018326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:09:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D14458055;
	Wed, 18 Dec 2024 15:09:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 416145804B;
	Wed, 18 Dec 2024 15:09:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 15:09:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 16:09:32 +0100
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
Subject: Re: [PATCH v2 5/6] selftests: kvm: s390: Streamline uc_skey test to
 issue iske after sske
In-Reply-To: <20241216092140.329196-6-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
 <20241216092140.329196-6-schlameuss@linux.ibm.com>
Message-ID: <60a4ca396110a955488270767749852e@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mPBYZXsKZnZqhF14L-Iy4Yi0XQaHVctz
X-Proofpoint-ORIG-GUID: mPBYZXsKZnZqhF14L-Iy4Yi0XQaHVctz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=998 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180117

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> In some rare situations a non default storage key is already set on the
> memory used by the test. Within normal VMs the key is reset / zapped
> when the memory is added to the VM. This is not the case for ucontrol
> VMs. With the initial iske check removed this test case can work in all
> situations. The function of the iske instruction is still validated by
> the remaining code.
> 
> Fixes: 7d900f8ac191 ("selftests: kvm: s390: Add uc_skey VM test case")
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Tested-by: Hariharan Mari <hari55@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 22 +++++--------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 8f306395696e..ef3e391811b3 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -88,10 +88,6 @@ asm("test_skey_asm:\n"
>  	"	ahi	%r0,1\n"
>  	"	st	%r1,0(%r5,%r6)\n"
> 
> -	"	iske	%r1,%r6\n"
> -	"	ahi	%r0,1\n"
> -	"	diag	0,0,0x44\n"
> -
>  	"	sske	%r1,%r6\n"
>  	"	xgr	%r1,%r1\n"
>  	"	iske	%r1,%r6\n"
> @@ -593,7 +589,9 @@ TEST_F(uc_kvm, uc_skey)
>  	ASSERT_EQ(true, uc_handle_exit(self));
>  	ASSERT_EQ(1, sync_regs->gprs[0]);
> 
> -	/* ISKE */
> +	/* SSKE + ISKE */
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
>  	ASSERT_EQ(0, uc_run_once(self));
> 
>  	/*
> @@ -607,19 +605,9 @@ TEST_F(uc_kvm, uc_skey)
>  	TEST_ASSERT_EQ(ICPT_INST, sie_block->icptcode);
>  	TEST_REQUIRE(sie_block->ipa != 0xb229);
> 
> -	/* ISKE contd. */
> +	/* SSKE + ISKE contd. */
>  	ASSERT_EQ(false, uc_handle_exit(self));
>  	ASSERT_EQ(2, sync_regs->gprs[0]);
> -	/* assert initial skey (ACC = 0, R & C = 1) */
> -	ASSERT_EQ(0x06, sync_regs->gprs[1]);
> -	uc_assert_diag44(self);
> -
> -	/* SSKE + ISKE */
> -	sync_regs->gprs[1] = skeyvalue;
> -	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> -	ASSERT_EQ(0, uc_run_once(self));
> -	ASSERT_EQ(false, uc_handle_exit(self));
> -	ASSERT_EQ(3, sync_regs->gprs[0]);
>  	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
>  	uc_assert_diag44(self);
> 
> @@ -628,7 +616,7 @@ TEST_F(uc_kvm, uc_skey)
>  	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
>  	ASSERT_EQ(0, uc_run_once(self));
>  	ASSERT_EQ(false, uc_handle_exit(self));
> -	ASSERT_EQ(4, sync_regs->gprs[0]);
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
>  	/* assert R reset but rest of skey unchanged */
>  	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
>  	ASSERT_EQ(0, sync_regs->gprs[1] & 0x04);

