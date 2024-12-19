Return-Path: <linux-kselftest+bounces-23583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8F9F7922
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 11:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACFB16945D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3214221D89;
	Thu, 19 Dec 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rhvgUpK2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC5221472;
	Thu, 19 Dec 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602630; cv=none; b=VG8J1EUj5xU1NnELQz+WYawIcOXVsq2JO2HKuJfikzO4pHZgSuXHrDs4N7VKT8L9w9NvVU+d+km+ykWhnXz0QxiutADkGl9Mz84BUesxotxpzvx2RMGxTliJlYh2C8eYHKXHcD9b/sVSC1WIRxlzOkR/IW7TtvdPLDqFt19Bqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602630; c=relaxed/simple;
	bh=XAedBOlMhtPKmrXOzx34DNTKZ7KjrXvyFemz6GIr2dI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z4aQW1QPPf5EV89HlTqmyeqhng/eVmShW10gwXOgf6+PwU8ejsqA2sm/USW8LBGvAEbQpFxOF+YPuaB3b5MPcFlrypqUNKf7on54MTuv8lOpYWY+e9dC6N2jjaH5awwWT2lpuHjpzEzMAg7dntUBS13YBujAQSw7gfOZuJnaVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rhvgUpK2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BINxGtF025761;
	Thu, 19 Dec 2024 10:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IQs4/Z
	O0ua7USvNHAZnRC+v/OF4OFq36cU5u+Uz4Y1U=; b=rhvgUpK2bhmpPOmxdco7LA
	X6sHyAfzY2O7l6XqJwYmX1Pf2lDOZoyHAXk0tZXdmOVIFSNheGdHORYWlr6BOMCs
	UUF+TsEdzqk8V1yblP/Q/0I/QitCtebEJHqZlv9ljx2w/VnLX12DuEi7a24UypCC
	7DO2jmY2HeUkPxpFQRs5gHWs6HFI/7zVjZw/jAiUw4HROoPXzEp14QiSQzSSb7FK
	T5KYPuIFUADwLsNyVYOldH2j6OxMRjm98/mktiXVfQo7TknPYqZr1UCvj5itwhUZ
	EtHvFJh542zrPb3x2zY57P1whtf3dRLO1UGtBg65QwomTvdEfrh71Ikue/YYAEIg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m8hh27g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:03:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ7U5lm029321;
	Thu, 19 Dec 2024 10:03:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsvu19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:03:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJA3gp166191860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 10:03:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FE458064;
	Thu, 19 Dec 2024 10:03:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210C75804E;
	Thu, 19 Dec 2024 10:03:41 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 10:03:41 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 11:03:40 +0100
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
In-Reply-To: <20241216092140.329196-2-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
 <20241216092140.329196-2-schlameuss@linux.ibm.com>
Message-ID: <c2740713c2e5f3ba488950908c7b5a38@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w6jOwpvRb_3WxE1AX2lsitvOLbdmmrE-
X-Proofpoint-ORIG-GUID: w6jOwpvRb_3WxE1AX2lsitvOLbdmmrE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=762 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412190080

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Prevent null pointer dereference when processing the
> KVM_DEV_FLIC_APF_ENABLE and KVM_DEV_FLIC_APF_DISABLE_WAIT ioctls in the
> interrupt controller.
> 
> Fixes: 3c038e6be0e2 ("KVM: async_pf: Async page fault support on s390")
> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Hariharan Mari <hari55@linux.ibm.com>
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

