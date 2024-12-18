Return-Path: <linux-kselftest+bounces-23512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87039F698C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3444B1882D72
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E141B424B;
	Wed, 18 Dec 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V6UanqHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A8156225;
	Wed, 18 Dec 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534515; cv=none; b=TPpSFjz2vITEi0bgohGFMvuRWT+DVp0jO/USGz5bpYEi/3X1hdNcix3R9vQM9ilVnhugI8ekmKo7bqw+iR0qwaFVScRcyTe6bW1GFW0KHNcwhfcLDskKDKVFyb6xWeauZVLo3V2dZWtDeYdQ0pd/jxBWR9Oj+Iek9AfB2ABagZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534515; c=relaxed/simple;
	bh=yjx/+xmzRIY6hDS5igbruUF7GTJYoK88xV8fU5us02A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ReOjLtXb8/mgwJNY5qEYqEhUYoFt87LgiNH8eSm4Sjk5RL2bZ0RUKunRx5KL4zrNQXee9uUnIM6tEQFDJCIWgZtb3MO2fw/+b0qQ6ftGi1njHM/o3fr4qjS0pMo4ho7Vk/B89kmYxMwpChX8oOFGIP6e6KEboKea80hJzJ1/rvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V6UanqHy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICvwMU018831;
	Wed, 18 Dec 2024 15:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9MsIkY
	1SVjf57kml3grjxItyTHdXDpb0JOUvvJAwnF0=; b=V6UanqHyccUTB+qkkfK8oB
	EwO2yjdm/anC3RnK7qyKDCZdgk249vecoZTnA7bytx7ZP2tG8U0Um8FD04DybGop
	4DYF9hdhd8GBrGYOacGhRwgWmO6WcNas7vvhcbYIU3GQp9gsHJvewnOwTZntVQqE
	grvhfA4m8gKsrmsU1ECdU8Fv6GcTV+UpB/d7siEPUYvln6ylv+3zcs+PC8Ra6C/Y
	bwOeHcgfzSJFmx8hTjgF9cE2R02S+Jhkz4nxHXzQTLyR2YXdBJ0YTNE09jBTyAYu
	/8fcSeScPDJd4toqztFRgJhnLM+K7Kv/Y+hYeaOJrFmp56VM0JRXFN8jenbP9rug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kk4abnqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:08:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BID3ehe024022;
	Wed, 18 Dec 2024 15:08:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukgcf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:08:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIF8RfW20578896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:08:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE3815805D;
	Wed, 18 Dec 2024 15:08:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E4358064;
	Wed, 18 Dec 2024 15:08:25 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 15:08:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 16:08:25 +0100
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
Subject: Re: [PATCH v2 3/6] kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol
 VMs
In-Reply-To: <20241216092140.329196-4-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
 <20241216092140.329196-4-schlameuss@linux.ibm.com>
Message-ID: <90f03f727a19907415536cc0323bdcb1@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dy-FR2TC9fycXBya29kXcAUrhR3iL56F
X-Proofpoint-ORIG-GUID: Dy-FR2TC9fycXBya29kXcAUrhR3iL56F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=640 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180117

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Prevent null pointer dereference when processing
> KVM_IRQ_ROUTING_S390_ADAPTER routing entries.
> The ioctl cannot be processed for ucontrol VMs.
> 
> Fixes: f65470661f36 ("KVM: s390/interrupt: do not pin adapter interrupt 
> pages")
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Tested-by: Hariharan Mari <hari55@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 3 +++
>  arch/s390/kvm/interrupt.c      | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst 
> b/Documentation/virt/kvm/api.rst
> index 454c2aaa155e..f15b61317aad 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -1914,6 +1914,9 @@ No flags are specified so far, the corresponding
> field must be set to zero.
>    #define KVM_IRQ_ROUTING_HV_SINT 4
>    #define KVM_IRQ_ROUTING_XEN_EVTCHN 5
> 
> +On s390, adding a KVM_IRQ_ROUTING_S390_ADAPTER is rejected on ucontrol 
> VMs with
> +error -EINVAL.
> +
>  flags:
> 
>  - KVM_MSI_VALID_DEVID: used along with KVM_IRQ_ROUTING_MSI routing 
> entry
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 22d73c13e555..d4f031e086fc 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2898,6 +2898,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  	switch (ue->type) {
>  	/* we store the userspace addresses instead of the guest addresses */
>  	case KVM_IRQ_ROUTING_S390_ADAPTER:
> +		if (kvm_is_ucontrol(kvm))
> +			return -EINVAL;
>  		e->set = set_adapter_int;
>  		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.summary_addr);
>  		if (uaddr == -EFAULT)

