Return-Path: <linux-kselftest+bounces-15824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A99B9595F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDDB1C20FB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52779199FD9;
	Wed, 21 Aug 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sEBHDaiX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21A188A3B;
	Wed, 21 Aug 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224906; cv=none; b=k9vkxo8aVERuEWvb9VCpXaDI1b1PykbXRT5ijHq4zByeInRf+LPh8OO0rKWgbK6kCfio2tILuPTsdHGNzJiCBOVnd4qPQArLTZFojQQD0TIyhonxuKMPp7FubMDCuDK5eoOxqhuA2bXDb0Md/4Rhe0INNrlzDJaAK/ZQ1ZdBZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224906; c=relaxed/simple;
	bh=oEUHJAOCUF91vFrya6BkFDkbnte7nxdVCy07R55AoHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=Kl2K8889Q1tFm8QW7fxggDQKZfleLBIc+fcLF89szxMgUflFlTpSeJ52Kk1TRINiqEE+4D/6XizgDd1EFMAtxdr3LvYfRYw/vrqcC8X57gU4eGXueOhc42GfivTsp7Z63kZD5GGYArzxA0jcpKVrzZR0YKPwxRllrELHlc4CL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sEBHDaiX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4sai0016931;
	Wed, 21 Aug 2024 07:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=xISdrrgbIIMaPJF30L6tx+fjh6xV/SOcoZg2pg18oIE=; b=sEBHDaiXk3Ry
	/qIhi9or/kjPdIbtu+tvculogKTcBn0+KiWrUmHxuhLJ8jhbIY8gPCiikHHNrJPb
	X3upWz0NJ2Yo70Zi29p5ObYazbLAFkWfol9ugbXm9IL7dEUf/DLfS2IU8XLalx2+
	DhX8aTvOGE3eETX0ggOMnGEzAzVJDpALoQgC++sJJPoaVAznw5S0KAX/VBv4xQja
	Y2zZOom2A7z2HSMGb+cDc3yG7z8YupALc01BlSLPs1/VP3V3fhRyWTjgD7qqoxQB
	kqdhV6RA6BN9J9gixx0yEg2bvWQJlZCBdNw94xIViztVSaU0Qu5toJ2RKpr+y+jV
	okTLpp46rg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma09j19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:21:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L7LeRr025814;
	Wed, 21 Aug 2024 07:21:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma09j16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:21:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L31qcg013110;
	Wed, 21 Aug 2024 07:21:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u6v2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:21:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L7LY9I51577302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 07:21:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06DDE20065;
	Wed, 21 Aug 2024 07:21:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA92B2004B;
	Wed, 21 Aug 2024 07:21:33 +0000 (GMT)
Received: from darkmoore (unknown [9.171.47.216])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 07:21:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Aug 2024 09:21:28 +0200
Message-Id: <D3LEPMSO7ZJS.RQG7NGR5N9GB@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] KVM: s390: selftests: Add regression tests for
 PRNO, KDSA and KMA crypto subfunctions
X-Mailer: aerc 0.17.0
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
 <20240820065623.1140399-3-hari55@linux.ibm.com>
In-Reply-To: <20240820065623.1140399-3-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qh1doQfRNv1sWtwfYRZRw1VLcyo4GYsu
X-Proofpoint-ORIG-GUID: gVbpngYcx7SRULTb6dVQKU9P6y9Z1XEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=715 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210050

On Tue Aug 20, 2024 at 8:48 AM CEST, Hariharan Mari wrote:
> Extend the existing regression test framework for s390x CPU subfunctions
> to include tests for the PRNO (Perform Random Number Operation), KDSA
> (Compute Digital Signature Authentication) and KMA (Cipher Message with
> Authentication) crypto functions.
>
> The test procedure follows the established pattern:
>
> 1. Obtain KVM_S390_VM_CPU_MACHINE_SUBFUNC attribute for the VM.
> 2. Execute PRNO, KDSA and KMA instructions.
> 3. Compare KVM-reported results with direct instruction execution results=
.
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

LGTM

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)

[...]

