Return-Path: <linux-kselftest+bounces-13387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2B92C21D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FB61C220F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357118EA65;
	Tue,  9 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i7Uq78Ei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D318D4C1;
	Tue,  9 Jul 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544879; cv=none; b=R6NQ70lf9PDz7GSl/2ncNv7srt1ZtfXhhitnLsfWUsSkJhwJuTmsd7CfgvjCceR4mEJDpEE/pEzIL1jfb6sz1sTV1qQkg5Ugq0m5E3bYV7dj0c1olKw8qTKkHZxIfi1qsPEM5lVQ/Bx5GIpJvtBijDwF/ipzWF+PxcNxYjiJIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544879; c=relaxed/simple;
	bh=4q4/U/fkX9TpCjsVGI5B45TfctF4+pvoqcVJg/Qnmiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IscLpWooXKbpau0ags2C3BmFMqIHdFXi9J/awIzkNuZrTpfRFpTFIohKhMIAiS4GGX4dybNf2NYz54YL+DyM3vPBr2GacgBrYwZVrM+7ns2EJlUeJzWSAV6Nd0VqKuzw2/ej8cdAcFD3ZXB1Oy/V0UgdIAC+4m42QBgR9qDu8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i7Uq78Ei; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469DTJCO032113;
	Tue, 9 Jul 2024 17:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	Fo2RwIVMALRmUy7uzipu2wuazXaZATxFskwqiIgWoCg=; b=i7Uq78EiamdSKHcP
	h/Grc+zOhxxMk36TsxC5GGobpfaCeIP9uvNhysgo9K15U6RwR1sWaaULqsatulUE
	b91gav90tpz5jfHU0EXiDvIi9udrPaEv7cQeDECG6QL6msWM+h6+nwhm39H+fczx
	u7jjecOaSx/sul83ohb8DRJlWE3QdXF6NhnShNnDIAXNHvwFosk4trkLIoRO1aHO
	pB0yPobnf/T9VPl0k3ZSVQjurVF3FBPCucm5JZtbXklVAcoul+bc1NbYrxfqu2Qa
	SUEKlZSm3J6ebaRPpzsJDD+ZDXr97eF/2H+WmwHR+CNM7fzyEsWTfQoSgjz1/wh5
	JLxxnw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40964h0kgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7rxM003897;
	Tue, 9 Jul 2024 17:07:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40964h0kg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469GUFS5006916;
	Tue, 9 Jul 2024 17:07:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmdd7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7lrW45023692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB27D2005A;
	Tue,  9 Jul 2024 17:07:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 934042004B;
	Tue,  9 Jul 2024 17:07:47 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:47 +0000 (GMT)
Date: Tue, 9 Jul 2024 18:56:30 +0200
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
Subject: Re: [PATCH v1 9/9] selftests: kvm: s390: Verify reject memory
 region operations for ucontrol VMs
Message-ID: <20240709185630.2c68010a@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-10-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-10-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: BE_opT3x2L1zRmBqQKHvI4b7jMI9-SYC
X-Proofpoint-ORIG-GUID: JhJCvHTBeVPFOhi9p-czFTGgsdkBILkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=950 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue,  9 Jul 2024 14:57:04 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add a test case verifying KVM_SET_USER_MEMORY_REGION and
> KVM_SET_USER_MEMORY_REGION2 cannot be executed on ucontrol VMs.
> 
> Executing this test case on not patched kernels will cause a null
> pointer dereference in the host kernel.

please add a reference to the patch that fixes the bug

> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 64ad31f667e3..a6f8a51519f8 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -587,4 +587,26 @@ TEST_F(uc_kvm, uc_gprs)
>  	ASSERT_EQ(1, sync_regs->gprs[0]);
>  }
>  
> +TEST_F(uc_kvm, uc_no_user_region)
> +{
> +	struct kvm_userspace_memory_region region = {
> +		.slot = 1,
> +		.guest_phys_addr = self->code_gpa,
> +		.memory_size = VM_MEM_EXT_SIZE,
> +		.userspace_addr = (uintptr_t)self->code_hva,
> +	};
> +	struct kvm_userspace_memory_region2 region2 = {
> +		.slot = 1,
> +		.guest_phys_addr = self->code_gpa,
> +		.memory_size = VM_MEM_EXT_SIZE,
> +		.userspace_addr = (uintptr_t)self->code_hva,
> +	};
> +
> +	ASSERT_EQ(-1, ioctl(self->vm_fd, KVM_SET_USER_MEMORY_REGION, &region));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	ASSERT_EQ(-1, ioctl(self->vm_fd, KVM_SET_USER_MEMORY_REGION2, &region2));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
>  TEST_HARNESS_MAIN


