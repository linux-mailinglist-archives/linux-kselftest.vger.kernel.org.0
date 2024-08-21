Return-Path: <linux-kselftest+bounces-15823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572099595E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBC51F269D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9171B653E;
	Wed, 21 Aug 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AlWGtbCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E621B6530;
	Wed, 21 Aug 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224792; cv=none; b=eRRenr1HTV6gTpX52QhW3l//masLLh22VCuToNohMrTgCG7cs3xN3aBg7NKAs4i+9sVnb4oKorolNGY6dBZLy82ZkC97yyShBA1qhcKBQ9//6STVUn71yLXzvt3HK2VW/61vmuY8oPBgJuQzEefNN1bhqgLVgw4xuEDjxNEhivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224792; c=relaxed/simple;
	bh=dFNrwOcElm5n9rX99Ez5N6RZ+RZYJ3dYcXbj7IhbC2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=b1rmC2ItLTd1u++tkG7EpJCLodfPoQ07725b5QAxMhikoPcfVC0Be/M3hzKWGk7+fkxXRuacqCSXRMG1RyQ5zpWxtvSJuPIZqDGeGBA8/5FifPmBw6IxDWh3bb11Agkk189wlDogxiyXDjG5KcV++KyUyZUDs1UyslXBNhfALKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AlWGtbCH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L2SZdb014304;
	Wed, 21 Aug 2024 07:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=8B39Z+dWL8T3wh7kUpsLCvWDtm+/C5D+bAl7SRBMnkM=; b=AlWGtbCH3wQv
	Fv+113TW6RIHu6m/KO3NGrmcUFMM6e46kii/KBhPXv8cpVMIfaJdjFBT6ZLm7Riw
	p1qYNYhVZGVDWBOemlr2oqIuXL4Qn0gLpzHS/jT4y8Ip1JqwlWuH2S9mVUk7LT+f
	EFWhuVBtprggjeTOxXrv7gfUBva23K+B8FnZO7xk3hVQ33Hx73iyxkLaEaaOZc4r
	fH9d9JCiTi/Lft7dlw0qkT0xB1k13ZyDL1ApoBfjRMWcsU7g7JLQqyXTPbOKExT2
	0vPvTHgOB7A0qiGVZIkgjYwttkkXSbRWXbRs2HfVHceBSidGOuc2UtNsCqb9XArC
	XvBWJAzqVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg0taa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:19:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L7JhqZ032265;
	Wed, 21 Aug 2024 07:19:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg0ta5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:19:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6Cq40017663;
	Wed, 21 Aug 2024 07:19:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3695m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:19:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L7Jaam51183930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 07:19:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BABEF2004E;
	Wed, 21 Aug 2024 07:19:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90D3F2004D;
	Wed, 21 Aug 2024 07:19:36 +0000 (GMT)
Received: from darkmoore (unknown [9.171.47.216])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 07:19:36 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Aug 2024 09:19:31 +0200
Message-Id: <D3LEO4WHFT3W.1REW6G0NE9RVS@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] KVM: s390: selftests: Add regression tests for
 SORTL and DFLTCC CPU subfunctions
X-Mailer: aerc 0.17.0
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
 <20240820065623.1140399-2-hari55@linux.ibm.com>
In-Reply-To: <20240820065623.1140399-2-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pMR6oa6MXxyMlRRFM0YKnNmYm-gNma-T
X-Proofpoint-ORIG-GUID: 2Utzfy0qKrYYSK-0LVGsi3AtCQXk9tBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=567 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210050

On Tue Aug 20, 2024 at 8:48 AM CEST, Hariharan Mari wrote:
> Introduce new regression tests to verify the ASM inline block in the SORT=
L
> and DFLTCC CPU subfunctions for the s390x architecture. These tests ensur=
e
> that future changes to the ASM code are properly validated.
>
> The test procedure:
>
> 1. Create a VM and request the KVM_S390_VM_CPU_MACHINE_SUBFUNC attribute
>    from the KVM_S390_VM_CPU_MODEL group for this VM. This SUBFUNC attribu=
te
>    contains the results of all CPU subfunction instructions.
> 2. For each tested subfunction (SORTL and DFLTCC), execute the
>    corresponding ASM instruction and capture the result array.
> 3. Perform a memory comparison between the results stored in the SUBFUNC
>    attribute (obtained in step 1) and the ASM instruction results (obtain=
ed
>    in step 2) for each tested subfunction.
>
> This process ensures that the KVM implementation accurately reflects the
> behavior of the actual CPU instructions for the tested subfunctions.
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

LGTM

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/s390x/facility.h    |  50 ++++++++
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 115 ++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/facility.h
>  create mode 100644 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_t=
est.c

[...]

