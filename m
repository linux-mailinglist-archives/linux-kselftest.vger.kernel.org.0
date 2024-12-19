Return-Path: <linux-kselftest+bounces-23601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD91C9F7E8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E571654FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF602288C0;
	Thu, 19 Dec 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7BVNUSI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155A22687C;
	Thu, 19 Dec 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623635; cv=none; b=utw99TiDD+R6PRrbtOrmNlKCecd/ain1HtjOdTLxE1OOs3Nu08V22xiLEbJhFJqB37ep52xnxYXYEThjecBBLke5jvQEsw2lMUa0OFPyDcZMm4vHtgjAjrliO0zcSX+ey+Kb52/eMRIEyHRyEYuTGexTT2mnQpvGGwpdJZkLCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623635; c=relaxed/simple;
	bh=JErlbF8ALZtxhAM/umtCxCQcpvWzWc3AhPFXqjZrfmc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=X4UMUFM2FSsOBRUVID8L+2/bt6EoinHD69PTcgqAWWlRvEKmNrzn/u+65RGNsbEGe6caQK5soVLEQ+ZGhDRjbRkufmx8/TqSzTGb+u8MyoVDEqjsHRl8+QwCwN0YKt68uk6zqiD5r+CLb6UuVxMt4yuri6Oc9W47GeeTUwi4pls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H7BVNUSI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBcKvF023743;
	Thu, 19 Dec 2024 15:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RkIHYD
	/NvS9GGhNliGwnGD+PpS8nUBTLy4hbYI1jSzg=; b=H7BVNUSI5bmRDK2iPIGaKI
	6wV/5wmzJeVAtLio47eHyMTx7Qt/Ky+0CPDqxVii3rY7esgTd9dA/7XHe0yD/YM5
	97sQG96tBYzV+1DwJJMg3ZLqCXeHzZUgXT79NsU4Nm1jqTxNyXMK6YzamSdr9ARh
	OuT5iyNii+QH4HlY306G8fPmNr/c3DfYPopzWaV/YRyjedIhVxlN00Me4AqWRMvj
	fYPU21BMYEt5AgXV2/nhPbH8L/oxMeKsn3+UaZSMH79sM+z1o/+pX0d3axh0tl7k
	U9aBPN8iHwjxrefvSUXiHxKABco2Qgt/diRabQGDGoycFEIBELfD/scKDny0aAEA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m8hh3vrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 15:53:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJCx4ZX005549;
	Thu, 19 Dec 2024 15:53:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbndub5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 15:53:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJFrjD125559788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 15:53:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E753758061;
	Thu, 19 Dec 2024 15:53:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 577FC58057;
	Thu, 19 Dec 2024 15:53:44 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 15:53:44 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 16:53:44 +0100
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
Message-ID: <9c7144c3bb5c927a2f7a845beead27dc@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FLWDoRbQTCVFV81nq__kw4SFTEfLmZ7h
X-Proofpoint-ORIG-GUID: FLWDoRbQTCVFV81nq__kw4SFTEfLmZ7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=640 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412190124

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Prevent null pointer dereference when processing
> KVM_IRQ_ROUTING_S390_ADAPTER routing entries.
> The ioctl cannot be processed for ucontrol VMs.
> 
> Fixes: f65470661f36 ("KVM: s390/interrupt: do not pin adapter interrupt 
> pages")
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Hariharan Mari <hari55@linux.ibm.com>
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

