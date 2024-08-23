Return-Path: <linux-kselftest+bounces-16158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F895D056
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9D0286535
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11515187FFC;
	Fri, 23 Aug 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r49CN/aQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE91865ED;
	Fri, 23 Aug 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424463; cv=none; b=DN9TlWcgY10Hgtp1k33nWTmRIPtFTzwqCtyLf5NiW7oZj+phmErPphGsGvB6SBgk1OglHh2Cgwj0kRc6tS5t6aFQbgZT7/tcDteL+QZSBsGD5O82vZXwZK7iz/DyUDZBxucCt0wtJ3uhhOuAT8RQyT/yU+nO57vGY9RGzzmqUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424463; c=relaxed/simple;
	bh=QkVDrRG+bwVo2Que5A45k+H96lRpMPjMgglMy/BFh4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=dqWP07Z56W1vPlJzfr9yKDc8uiExV+qyHX/BOw5Jzneer43VEPZyknwiYu202gp3PmRIWsyEweL40YxNtkeUiVBYGqLC76fzxJliBqmkGG7uzOcXzNg6sF05XDpwquWCvO0ksWW6hXBXyytKWarBIVp7k01CHrKUWdtMMx5iAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r49CN/aQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NEdgVV013718;
	Fri, 23 Aug 2024 14:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:to:subject:from:cc:references:in-reply-to; s=pp1;
	 bh=UHCoi8H9SkJyWN+bg3VEga0aQtVxmmJrvg/q91th08M=; b=r49CN/aQWgqY
	j2AUdWjl8Ngjr8AZ1IWoV3IxsWoUTlYa6x0Yrp4msTsicTm3fDxuVNKfGiP2pyaN
	28OgaytO3CI2ocOYtFgGAa9pT5NRvYtOYRiCfBY9SAsbwSQPDqhWtlpH9vtGpPPb
	X73kqh3BXJ1j+Nk3FCtJckZcAwFiNYcHWkeX5Tb53SSSolMsZFbSplcQQRYy/x95
	iGIiJeJfLgX4ynn0rrhWequtQZUAHhNSF3K0Czs6Xm+nAYNKNR9RhK58N3L0h/4s
	1Y8EN1SyaFhG3YWHTMdR+ulR8o/gkPMcsFB+WjT2hdtWRvtPwK91NGvTaH32Y5YI
	1IHgvG+5Jg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 416vc6r0yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 14:47:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NElVtM028079;
	Fri, 23 Aug 2024 14:47:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 416vc6r0yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 14:47:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NB61Wc019044;
	Fri, 23 Aug 2024 14:47:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376qaayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 14:47:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NElOUZ54591752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 14:47:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14A7D20043;
	Fri, 23 Aug 2024 14:47:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF5B320040;
	Fri, 23 Aug 2024 14:47:23 +0000 (GMT)
Received: from darkmoore (unknown [9.171.45.196])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 14:47:23 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Aug 2024 16:47:18 +0200
Message-Id: <D3NDG2T6LAPQ.2NWIY72YYTM3F@linux.ibm.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] KVM: s390: selftests: Add regression tests for
 SORTL and DFLTCC CPU subfunctions
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240823130947.38323-1-hari55@linux.ibm.com>
 <20240823130947.38323-2-hari55@linux.ibm.com>
In-Reply-To: <20240823130947.38323-2-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: joBWqXu38rRWeSJVLAbCt0vd2B5HOrnU
X-Proofpoint-GUID: feQMs60FA9k7UMgDuvCz7jUoq6a6etmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxlogscore=593 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230107

On Fri Aug 23, 2024 at 3:05 PM CEST, Hariharan Mari wrote:
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
>  tools/testing/selftests/kvm/Makefile          |   2 +
>  .../selftests/kvm/include/s390x/facility.h    |  50 +++++++++
>  .../selftests/kvm/lib/s390x/facility.c        |  14 +++
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 105 ++++++++++++++++++
>  4 files changed, 171 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/facility.h
>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/facility.c
>  create mode 100644 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_t=
est.c

[...]

