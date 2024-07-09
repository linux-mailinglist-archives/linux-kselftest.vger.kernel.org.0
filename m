Return-Path: <linux-kselftest+bounces-13384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15592C234
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C9B21FE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A2318D4C7;
	Tue,  9 Jul 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gHt4t0TF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C818C198;
	Tue,  9 Jul 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544877; cv=none; b=QueQKrdlRbxpPu7rktZC+mwG00hEOdOinRUpBS2kiKtYTm+gS9bFZXoF0u76S3HWqNzL9z/ubO7WMwZcLb2iohvpim3Y05YpIwRgkWnHufIruL6IFKd1HnIMeBdMhOTp8JZb4FMGiCbeu0LEzwnpAlw6OUORu+Ie2Ov0r8VBITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544877; c=relaxed/simple;
	bh=GFQ+P8QxJObLPzRVIa4KnKL1Xd/zukTKXiqtBaYuEOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROU9aCs3G3EgWVEHD5mxNegYTFxcSeD4js71SCPJLt71APhvhgAH5B82JSy9wJSn0sPCuo+FUrc8iRb/wYofOEZ/ckuvip4hGyRkE1CrSXQrCMYbrwZY0EKHq1+qp4FQ1KGeYECKJBolAKGY8zPz65yD/v4Fsn6BzfPDlnjq6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gHt4t0TF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FQnA5013163;
	Tue, 9 Jul 2024 17:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	SV1N/UGh8CX6iKoD2zd6gCj5uIrN3jIdFr7YGYpEH5U=; b=gHt4t0TFls4erNBP
	yFBfbownye3pHIA8Sow6TcnixMDQ6H60S6tMiibqO8qJvQsQh3gARAwXBYUggno7
	cAxH7dwqgF1uvsOefWgCLHWf7600R4GtHTvdPqLad906NdxZ0x1GZueTpgmy7WW4
	+cqcq4i6Sji+AIuG5X3LWaykQfUsCgibIOgc4CfBLZ19BH8NJJnT4NT++PGtyeM0
	tUTWDR1YSCMEqDdGMxjtXRbfq0i4S98Ps/A8bD2CC49I51qkeNyWpow5SKiaB0DX
	IFToXc2Wt1T1Mb59+SJ625hN+pYivfZKFG/4j3dr5lckM7/hJDwsWTstw/T+2Trt
	BkIvHw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4095p6guke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:47 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7k9B005261;
	Tue, 9 Jul 2024 17:07:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4095p6guka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469EPBYb024664;
	Tue, 9 Jul 2024 17:07:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8u5xs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7e9U45023688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53BCF20043;
	Tue,  9 Jul 2024 17:07:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D86120040;
	Tue,  9 Jul 2024 17:07:40 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:40 +0000 (GMT)
Date: Tue, 9 Jul 2024 18:17:06 +0200
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
Subject: Re: [PATCH v1 4/9] selftests: kvm: s390: Add test fixture and
 simple VM setup tests
Message-ID: <20240709181706.7098cfa0@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-5-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-5-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: bXlERJfe7nJvojTOHAktrTNP4NI83INe
X-Proofpoint-ORIG-GUID: btA4llJCKVI6sdaeffa08rtGb2iMuscM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 spamscore=1 clxscore=1015
 mlxlogscore=229 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090112

On Tue,  9 Jul 2024 14:56:59 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add a uc_kvm fixture to create and destroy a ucontrol VM.
> 
> * uc_sie_assertions asserts basic settings in the SIE as setup by the
>   kernel.
> * uc_attr_mem_limit asserts the memory limit is max value and cannot be
>   set (not supported).
> * uc_no_dirty_log asserts dirty log is not supported.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

[...]

> +
> +/**
> + * create VM with single vcpu, map kvm_run and SIE control block for easy access
> + */
> +FIXTURE_SETUP(uc_kvm)
> +{
> +	struct kvm_s390_vm_cpu_processor info;
> +	int rc;
> +
> +	require_ucontrol_admin();
> +
> +	self->kvm_fd = open_kvm_dev_path_or_exit();
> +	self->vm_fd = ioctl(self->kvm_fd, KVM_CREATE_VM, KVM_VM_S390_UCONTROL);
> +	ASSERT_GE(self->vm_fd, 0);
> +
> +	kvm_device_attr_get(self->vm_fd, KVM_S390_VM_CPU_MODEL,
> +			    KVM_S390_VM_CPU_PROCESSOR, &info);
> +	TH_LOG("create VM 0x%llx", info.cpuid);
> +
> +	self->vcpu_fd = ioctl(self->vm_fd, KVM_CREATE_VCPU, 0);
> +	ASSERT_GE(self->vcpu_fd, 0);
> +
> +	self->kvm_run_size = ioctl(self->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
> +	ASSERT_GE(self->kvm_run_size, sizeof(struct kvm_run))
> +		  TH_LOG(KVM_IOCTL_ERROR(KVM_GET_VCPU_MMAP_SIZE, self->kvm_run_size));
> +	self->run = (struct kvm_run *)mmap(NULL, self->kvm_run_size,
> +		    PROT_READ | PROT_WRITE, MAP_SHARED, self->vcpu_fd, 0);
> +	ASSERT_NE(self->run, MAP_FAILED);
> +	/**
> +	 * For virtual cpus that have been created with S390 user
> +	 * controlled virtual machines,

this line does not need to end like this, I guess?

> +	 * the resulting vcpu fd can be memory mapped at page offset
> +	 * KVM_S390_SIE_PAGE_OFFSET in order to obtain a memory map
> +	 * of the virtual cpu's hardware control block.
> +	 */

with the comment fixed:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

[...]

