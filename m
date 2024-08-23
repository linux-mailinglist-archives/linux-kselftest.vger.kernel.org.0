Return-Path: <linux-kselftest+bounces-16143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E895CD1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E4283F82
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDF18595B;
	Fri, 23 Aug 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OG1zedAI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75E1448E3;
	Fri, 23 Aug 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418219; cv=none; b=rrXKva/DS1vUBxmA6ZnTa2e3s02140Jpz64uccBDGtUb3oNhUzRlABv7k7FxCZAUuprivO2YHfoycqYjThICXnw5SujSCYmOkvStJiUz+I6pI11G45yVWuAAYz4lK3r0DvD6yg+EPd+32BcVmGD7/78Mm8qZn0RIlU6NqcBqFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418219; c=relaxed/simple;
	bh=FJtvPrnrnepURGaxInYmsEE+3DmtM/ijCioKxsX05us=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=Iysj7wo9ksZqLovRelQ08HKgbC7iLYruMHWfI69hPZyOVGVuwZAKmuQXVLaq7S4mmh6sKl6q+ciYwnJ3uJlDF+Xnk3JwX7HdU81ESZbYYQ9Asl6rt5V0nhlGjEsCeqUxy2P7EnKjmVImnkjoJ6scbIgqjXOmmyuUsBlBd3Aau8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OG1zedAI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N6jDbs027508;
	Fri, 23 Aug 2024 13:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=t5sHaqw+Qm7GG+J7BCxqCavP5aKQbQDGA6C1iK8gS1M=; b=OG1zedAIolbj
	UHf3Hv1hyKk2vA2WJNVBAEjlrHPPpWL50896C7hemQ3HvalNA3HWjWqdPP2vohv8
	wzDqCXeelUMfYTR2XALrsBq2unrLCTI9LExH87t4Vi1TL92xHDov5snSgYyYmaBE
	uSEfiKCPLSnVtR0hDnznBtekaug3c+525uQJ3Fcgwxi5eb/6+M4ERCE8JCLUlZ4W
	qrHSUTTQrpmi9pE+yCbuwKXpH7o6BVamJD9t+bwc7pbwtjRYhq7cKTF4p/IXE9Y0
	2WR71qEgq5LOeFjMIJUCMdiakMgPdvCK0NkFSLmy9I1AiH7Ugxtp4xTLKTBdoVkY
	lvIvdSldyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y25dq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:03:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47ND3WZV016693;
	Fri, 23 Aug 2024 13:03:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y25dpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:03:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NCAtae029710;
	Fri, 23 Aug 2024 13:03:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmspu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:03:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ND3PFE55312844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:03:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4B992004B;
	Fri, 23 Aug 2024 13:03:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9297D20040;
	Fri, 23 Aug 2024 13:03:25 +0000 (GMT)
Received: from darkmoore (unknown [9.171.45.196])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:03:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Aug 2024 15:03:20 +0200
Message-Id: <D3NB8GXIKS75.2AR1GNELFUIBE@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Nina
 Schoetterl-Glausch" <nsg@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests: kvm: s390: Add uc_map_unmap VM test case
X-Mailer: aerc 0.17.0
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
 <20240815154529.628087-2-schlameuss@linux.ibm.com>
 <4c049b39-af28-488c-9e19-f22691b43585@linux.ibm.com>
 <ZsNs0sN7rWqaviZE@darkmoore>
 <884367dd-fba0-4acd-a614-f657768b662a@linux.ibm.com>
In-Reply-To: <884367dd-fba0-4acd-a614-f657768b662a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xSbd3g6ktdC65JTg1bz6FI_bVm1lvIcq
X-Proofpoint-ORIG-GUID: Xg8nTaFVtTxu5p9zZ8rj6cPHeI9KG5e-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=721 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230095

On Fri Aug 23, 2024 at 10:02 AM CEST, Janosch Frank wrote:
> On 8/19/24 6:03 PM, Christoph Schlameuss wrote:
> > On Fri Aug 16, 2024 at 4:29 PM CEST, Janosch Frank wrote:
> >> On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
> >>> Add a test case verifying basic running and interaction of ucontrol V=
Ms.
> >>> Fill the segment and page tables for allocated memory and map memory =
on
> >>> first access.
> >>>
> >>> * uc_map_unmap
> >>>     Store and load data to mapped and unmapped memory and use pic seg=
ment
> >>>     translation handling to map memory on access.
> >>>
> >>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> >>> ---
> >>>    .../selftests/kvm/s390x/ucontrol_test.c       | 120 ++++++++++++++=
+++-
> >>>    1 file changed, 119 insertions(+), 1 deletion(-)
> >>>
> >>
> >>> +static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
> >>> +{
> >>> +	struct kvm_run *run =3D self->run;
> >>> +
> >>> +	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> >>> +	switch (run->s390_ucontrol.pgm_code) {
> >>> +	case PGM_SEGMENT_TRANSLATION:
> >>> +		pr_info("ucontrol pic segment translation 0x%llx\n",
> >>> +			run->s390_ucontrol.trans_exc_code);
> >>> +		/* map / make additional memory available */
> >>> +		struct kvm_s390_ucas_mapping map2 =3D {
> >>> +			.user_addr =3D (u64)gpa2hva(self, run->s390_ucontrol.trans_exc_co=
de),
> >>> +			.vcpu_addr =3D run->s390_ucontrol.trans_exc_code,
> >>> +			.length =3D VM_MEM_EXT_SIZE,
> >>> +		};
> >>> +		pr_info("ucas map %p %p 0x%llx\n",
> >>> +			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> >>> +		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
> >>> +		break;
> >>
> >> Why is this necessary if you fix up the mapping in the test?
> >>
> >=20
> > This is also used within the uc_skey test to make sure the remap does
> > work after the unmap.
>
> Maybe I'm blind because I'm still recovering but where exactly?

It is literally used in the last line of the test case. Calling uc_handle_e=
xit()
again re-maps previously unmapped memory.

I can try to make that a little bit more obvious.

+	/* unmap and run loop again */
+	TH_LOG("ucas unmap %p %p 0x%llx",
+	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+	rc =3D ioctl(self->vcpu_fd, KVM_S390_UCAS_UNMAP, &map2);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+	ASSERT_EQ(true, uc_handle_exit(self));  // <--- HERE
+}


