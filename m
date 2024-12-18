Return-Path: <linux-kselftest+bounces-23510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A894B9F6967
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F070916549C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F041E9B04;
	Wed, 18 Dec 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aav4W26/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB061B424B;
	Wed, 18 Dec 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534407; cv=none; b=fcRpxNDEVccusFdzMl81zyDh2iAwPr5fbg+ZaYO5d9LcVWx+7hDCTNVXlcJ3kY3esY4/EYacoPv3sQvoEuevKyRraAcIuTfBohwBJShQFtmopUwuq9XKTSpRsRgNIhp0DAyIoA8Q8+NJyenVvRwvBJF2Hw5BmWgM+Pvul7zsefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534407; c=relaxed/simple;
	bh=LaL/qoVTFpGjDPWLifWMBx6XcsQCXDA8yXJH+VQ3hXs=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=biXYIP3MKruIBI5Hu4zr62YVh0arF7IlpQvf0F0i1ZEYe5z8uK4yXf+ZN5mqVG8GSI2Ag9w2z17bHlMR/sIiftK0Yr0ycB7TI0sqPF4BvkBIOSKYl+AFsV7K4kyS0WHVNcW1YGqWTemTwCya1flmL0XPHsQRwTlPTn/Wry5Ubb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aav4W26/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIElTf4028420;
	Wed, 18 Dec 2024 15:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NB7clhGb9n+4MeVFGTtugtbahYSf
	HtvQydGXNkq0G/c=; b=aav4W26/8ojwF5PtO2OwVuMwqVLjkxJtj6ntqZjtvVPO
	FnSW8OlEu5qf2D/ZAAv2XC9810DZY+DgvUFG75Grx71Lh2BFB7IvLKhXCzTdYvw/
	+uokFwi/rdOs6eLxxsy/rKrOJJyRqEvqdBk2Egje8BAIJomH4I7b7Wg8ttccf14P
	4n0XvHTwJg28+osV6l9BmlML3MYPwomKYKaswjDtY5MI9r/Ge8adHJ2s2EkPkM31
	gt2Kv6F6IlygGXCYhlEDZQ4ebDF4DrW6OAzi13OExHt6KSkQwiLsLmF6jw9trc3n
	FcqxJeFnLwe4uhgxccyv3lSuHBlOmbY0X8LSnwByPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvgtywf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:06:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIEcinY014391;
	Wed, 18 Dec 2024 15:06:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21r3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:06:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIF6YrC28639800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:06:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D19A5805D;
	Wed, 18 Dec 2024 15:06:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9368958052;
	Wed, 18 Dec 2024 15:06:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 15:06:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 16:06:33 +0100
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
Subject: Re: [PATCH v2 1/6] kvm: s390: Reject setting flic pfault attributes
 on ucontrol VMs
Message-ID: <ea0ee2ae6432e8789a00955a5c1537aa@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4UXTQBXej5QqFm8yrUI00B2JAVb2szQ6
X-Proofpoint-ORIG-GUID: 4UXTQBXej5QqFm8yrUI00B2JAVb2szQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=685 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180117

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Prevent null pointer dereference when processing the
> KVM_DEV_FLIC_APF_ENABLE and KVM_DEV_FLIC_APF_DISABLE_WAIT ioctls in the
> interrupt controller.
> 
> Fixes: 3c038e6be0e2 ("KVM: async_pf: Async page fault support on s390")
> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Tested-by: Hariharan Mari <hari55@linux.ibm.com>
> ---
>  Documentation/virt/kvm/devices/s390_flic.rst | 4 ++++
>  arch/s390/kvm/interrupt.c                    | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/devices/s390_flic.rst
> b/Documentation/virt/kvm/devices/s390_flic.rst
> index ea96559ba501..b784f8016748 100644
> --- a/Documentation/virt/kvm/devices/s390_flic.rst
> +++ b/Documentation/virt/kvm/devices/s390_flic.rst
> @@ -58,11 +58,15 @@ Groups:
>      Enables async page faults for the guest. So in case of a major 
> page fault
>      the host is allowed to handle this async and continues the guest.
> 
> +    -EINVAL is returned when called on the FLIC of a ucontrol VM.
> +
>    KVM_DEV_FLIC_APF_DISABLE_WAIT
>      Disables async page faults for the guest and waits until already 
> pending
>      async page faults are done. This is necessary to trigger a
> completion interrupt
>      for every init interrupt before migrating the interrupt list.
> 
> +    -EINVAL is returned when called on the FLIC of a ucontrol VM.
> +
>    KVM_DEV_FLIC_ADAPTER_REGISTER
>      Register an I/O adapter interrupt source. Takes a 
> kvm_s390_io_adapter
>      describing the adapter to register::
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index ea8dce299954..22d73c13e555 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2678,9 +2678,13 @@ static int flic_set_attr(struct kvm_device
> *dev, struct kvm_device_attr *attr)
>  		kvm_s390_clear_float_irqs(dev->kvm);
>  		break;
>  	case KVM_DEV_FLIC_APF_ENABLE:
> +		if (kvm_is_ucontrol(dev->kvm))
> +			return -EINVAL;
>  		dev->kvm->arch.gmap->pfault_enabled = 1;
>  		break;
>  	case KVM_DEV_FLIC_APF_DISABLE_WAIT:
> +		if (kvm_is_ucontrol(dev->kvm))
> +			return -EINVAL;
>  		dev->kvm->arch.gmap->pfault_enabled = 0;
>  		/*
>  		 * Make sure no async faults are in transition when

