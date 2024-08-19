Return-Path: <linux-kselftest+bounces-15661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B43956FB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A458284396
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFE13B5AF;
	Mon, 19 Aug 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V0nsmdRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DF8287D;
	Mon, 19 Aug 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083425; cv=none; b=o11Y+DLzSUz5csPbJx8e2a82/KSN6J8BUlNz31Olbuy72B8Kv8nYnabvvmCzJKUSEGD9+G+jp7VtBaDVcVnsgRCueSceUlGKRAmFPIyq4aFdh1veRBgmVqs9ykJBmI9h+6xl0+vh9WTxZI9HFhnEpqPbWOXyxZQrCFq2yAIvvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083425; c=relaxed/simple;
	bh=CCH2LsivZ13kExzZpOcTcG5BliNZ7AV9W8FHXq+awEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUZn/9qpEGV31X8Qrz6r5hcwdc/lg3h4jx0RLlKUZVutrjorMlL3wqEMEuXV0Rina0QaQRnjAv/wBXX9jJCLY+ORADGa8HVCwOrBUp5+lmo0XD3cRWmeYR9c2huOiD/6yZEuT5H9eUl2OjtDJgLtmJ8TO0rUz54pN6g1IEtnDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V0nsmdRR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEwf5u004943;
	Mon, 19 Aug 2024 16:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=7wt5N0eSuDHQVX2o3x0GXCd9CpL
	YoYtfw7ZtKvbon+Q=; b=V0nsmdRR7YZm8EExHW6PQlQ34c4BNR2e2u3apuy1hbQ
	XaoIsj3OSOEVpBrRBr9I2uCdpyCRUEE48GOfkdZ4hKPO3LRQwwD2B7oHNc5iucBH
	NGH+JcU3hNUK9NGTdP7g1sCjg40BrN8L41jCJjABEeOGsWvabMA9nx54QK2/4Qg7
	FlyWbdWHR8W0kyM9XFl6Cs3SRdlglRfHfpOxmuetiPo83/6cDAKmU1tBSrSrjQtn
	M6YJ1V8xGA+Jt4KO2DtYeMVhGpBa+0mmFSvcDYXHFzg4vM0c6RqzzPVlZwrkM9iw
	KtHMPzUiS+rEo7Mc3G8Na6GXtBKvgTfVdT687PhT0Rw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma01mm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:03:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JG3dP2009175;
	Mon, 19 Aug 2024 16:03:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma01mm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:03:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCDUAK002256;
	Mon, 19 Aug 2024 16:03:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0eysn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:03:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JG3W8I57147762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 16:03:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 977D620040;
	Mon, 19 Aug 2024 16:03:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 012442004B;
	Mon, 19 Aug 2024 16:03:32 +0000 (GMT)
Received: from darkmoore (unknown [9.171.95.91])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Aug 2024 16:03:31 +0000 (GMT)
Date: Mon, 19 Aug 2024 18:03:30 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH 1/3] selftests: kvm: s390: Add uc_map_unmap VM test case
Message-ID: <ZsNs0sN7rWqaviZE@darkmoore>
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
 <20240815154529.628087-2-schlameuss@linux.ibm.com>
 <4c049b39-af28-488c-9e19-f22691b43585@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c049b39-af28-488c-9e19-f22691b43585@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kfz2EJIxsBeCcyN5ZKmmturA4JDNMSJV
X-Proofpoint-ORIG-GUID: AJAXlUsyWNFrMfh52jybndtjSTGz3l0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=973 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190107

On Fri Aug 16, 2024 at 4:29 PM CEST, Janosch Frank wrote:
> On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
> > Add a test case verifying basic running and interaction of ucontrol VMs.
> > Fill the segment and page tables for allocated memory and map memory on
> > first access.
> > 
> > * uc_map_unmap
> >    Store and load data to mapped and unmapped memory and use pic segment
> >    translation handling to map memory on access.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 120 +++++++++++++++++-
> >   1 file changed, 119 insertions(+), 1 deletion(-)
> > 
>
> > +static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
> > +{
> > +	struct kvm_run *run = self->run;
> > +
> > +	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> > +	switch (run->s390_ucontrol.pgm_code) {
> > +	case PGM_SEGMENT_TRANSLATION:
> > +		pr_info("ucontrol pic segment translation 0x%llx\n",
> > +			run->s390_ucontrol.trans_exc_code);
> > +		/* map / make additional memory available */
> > +		struct kvm_s390_ucas_mapping map2 = {
> > +			.user_addr = (u64)gpa2hva(self, run->s390_ucontrol.trans_exc_code),
> > +			.vcpu_addr = run->s390_ucontrol.trans_exc_code,
> > +			.length = VM_MEM_EXT_SIZE,
> > +		};
> > +		pr_info("ucas map %p %p 0x%llx\n",
> > +			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> > +		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
> > +		break;
>
> Why is this necessary if you fix up the mapping in the test?
>

I did split this out here to have an automatic and clean way to do the map for
other test cases as well. Other test cases would likely not bother with the
unmap. This is also used within the uc_skey test to make sure the remap does
work after the unmap.

I could change this to use uc_handle_exit_ucontrol for both, the map and the
remap. But looking at the test code I felt that was more confusing than this
within the uc_skey test.

> [...]
>

Thanks for finding the typos.

