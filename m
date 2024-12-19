Return-Path: <linux-kselftest+bounces-23602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3299F7E94
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C661636B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328C22653F;
	Thu, 19 Dec 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M/gLjEgd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C822616C;
	Thu, 19 Dec 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623682; cv=none; b=NmyE9FSqr4bdUE3wOwZIWQHNzF8c//eWAvzXRBAS7BYOC/W/KBxd7Z8wwCAyXHZTJEtsVmDtxckTY/ByAH57uHcFZ2v7DVn6QDJYALjrGVKaTRZGRhEY9FeYdmrp72B9dTCBJVfEUiAHx4jdLKgFiFeRJ7cl+MsNrE2+FtrgmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623682; c=relaxed/simple;
	bh=po0srZuivOCxjd54M/INi2PjQra+4925Ud1lFzjdEP0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Hn2CzaMvagC7Yw9Wj3cAZ/NER2ZORC2qPXvmhV8oFFF5jyxCofv612euFnmhz7CWN1d8krAUn8YBO3GFtLUPNvmPW2x3+GrPIUVScF2dQkYooJTHmwE1300jqGsRjpF2z2+KHQyxJPh7USEYg1Todh4RxG0uFEf97alG2stlJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M/gLjEgd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJElccg025422;
	Thu, 19 Dec 2024 15:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OLPXt2
	Fr7DHqwKhW5a4fC/btDgfwvSE9Zz8c5UZXHpA=; b=M/gLjEgdDx4EWuSnudsmfJ
	hu2EbTF+jSyhPJmPyiUJGOVMAEZUQj6OLQKMXHBIeGktGGWmE3iZwnfk2Y44KRgT
	wmHgu+xTgiBgpAd0NTY2Z9MGcElIbAygMwt/0PC67xyF9eSiENi4gjQNxoHXlb0a
	SmZed1vL0eNGMt1Ap8f6aDjFJTSNsYjOd/kb8fVf9OFhfDUzQmGE704xPMSnlj7r
	t5anvFCFwmpafIyQpIJbdnmcX5m+yOYouMFPguYXFy0w4ciOIpEiYkHqy/CLHeFO
	NBwUg2PQuGF31mxfDbmZrMGoaoG1vXfFWCvsiwQVIkMxTTP9w9auTz9JsM7J0pjw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyhu3p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 15:54:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJE7rRZ011295;
	Thu, 19 Dec 2024 15:54:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkdjrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 15:54:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJFsYZj23331530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 15:54:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30B1B5805A;
	Thu, 19 Dec 2024 15:54:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4EAE58056;
	Thu, 19 Dec 2024 15:54:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 15:54:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Dec 2024 16:54:33 +0100
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
Message-ID: <0d8a5868b97d02470453b4175f347153@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HFjC_aw1Qv-mHTAoPzwnOPQ6I27NOJ08
X-Proofpoint-GUID: HFjC_aw1Qv-mHTAoPzwnOPQ6I27NOJ08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190124

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Add a selftests for the interrupt routing configuration when using
> ucontrol VMs.
> 
> Calling the test may trigger a null pointer dereferences on kernels not
> containing the fixes in this patch series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Hariharan Mari <hari55@linux.ibm.com>
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

