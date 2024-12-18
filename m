Return-Path: <linux-kselftest+bounces-23513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65C9F697C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C064B165935
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E51E008E;
	Wed, 18 Dec 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eW/mDXWz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CD1DF27F;
	Wed, 18 Dec 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534542; cv=none; b=esuHxm5n6Kru/P/F6TNcZMHtGOoTvUZjTC5bh7xEZGlGF1RR9dPCzb1HWYUQWLlSOT3SlW/0SwwL/d4vtGka2JQGhhQNsA8M5TUBjNdP7+6smCjNmzjx0ezHxVDjbvDldytZEXqqJUwVd3pgc5laiIQquSmeYBXG0nc1o8cxzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534542; c=relaxed/simple;
	bh=LZIbz1tZMEBK1PmarK8c0Eov5hYMwzAa8Wu084f9y1s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aoPjLSorKukTR4Hl81ICqoKBIQSEdpEkJRVNJRLVHOou+PAtQwt+bRsDZRPP9BH/II5ROvvxEyA6TJBnpUPmIfQeoVzoECUILW9j1a/OUwvO3f3iMXpKb0wnxEgtCnz+UBg6Uz8EezoRZzqGjgxDG+s4mHF0nXyDbVr0wW8D1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eW/mDXWz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIElTfP028420;
	Wed, 18 Dec 2024 15:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aq/2xe
	4eLlgPOaUXNY0YsZeIsnH76dCFD6HPFcHMaVk=; b=eW/mDXWz0K1HMSBN9PwOe4
	wQzpoTLG4ViwTFLZwTRvGto2CY8nZe+MhwC4S/eq434nrN97pfGQMVUf6PlqKSyf
	UxKDVJAARZddwIRues02WQ89EmepecBYB+YQFx1c1PHh2KYYGq/rsUzNKYzZ/GoV
	CJWVjtY+VW1YvJAfOactaTZCl15M7w7L1BcohtLviXf41GqS6Ugepc4FYEusgTx+
	fyAu3MGfoA8TJy5t0H1aAvDuP+vOvhzo0OQ5mK5QnRt+zhA679w8eVgkpr7vVzwl
	R3JXK41Ae4b1/1ajLiL3X9k9t5dyBVcWrn50irk/hoYKFAejrQOviNFbkWdhhH6Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvgu0gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:08:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIE8rfs014388;
	Wed, 18 Dec 2024 15:08:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21r40e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:08:55 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIF8sEW21955324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:08:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 256E658054;
	Wed, 18 Dec 2024 15:08:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4794E5803F;
	Wed, 18 Dec 2024 15:08:53 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 15:08:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 16:08:52 +0100
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
Subject: Re: [PATCH v2 4/6] selftests: kvm: s390: Add ucontrol gis routing
 test
In-Reply-To: <20241216092140.329196-5-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
 <20241216092140.329196-5-schlameuss@linux.ibm.com>
Message-ID: <20a136a05340d7f0bb0c3669e0b73003@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VLP2FQuMKs5msNyarePyJiil6llB3VGM
X-Proofpoint-ORIG-GUID: VLP2FQuMKs5msNyarePyJiil6llB3VGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180117

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Add a selftests for the interrupt routing configuration when using
> ucontrol VMs.
> 
> Calling the test may trigger a null pointer dereferences on kernels not
> containing the fixes in this patch series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Tested-by: Hariharan Mari <hari55@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index b003abda8495..8f306395696e 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -783,4 +783,23 @@ TEST_F(uc_kvm, uc_flic_attrs)
>  	close(cd.fd);
>  }
> 
> +TEST_F(uc_kvm, uc_set_gsi_routing)
> +{
> +	struct kvm_irq_routing *routing = kvm_gsi_routing_create();
> +	struct kvm_irq_routing_entry ue = {
> +		.type = KVM_IRQ_ROUTING_S390_ADAPTER,
> +		.gsi = 1,
> +		.u.adapter = (struct kvm_irq_routing_s390_adapter) {
> +			.ind_addr = 0,
> +		},
> +	};
> +	int rc;
> +
> +	routing->entries[0] = ue;
> +	routing->nr = 1;
> +	rc = ioctl(self->vm_fd, KVM_SET_GSI_ROUTING, routing);
> +	ASSERT_EQ(-1, rc) TH_LOG("err %s (%i)", strerror(errno), errno);
> +	ASSERT_EQ(EINVAL, errno) TH_LOG("err %s (%i)", strerror(errno), 
> errno);
> +}
> +
>  TEST_HARNESS_MAIN

