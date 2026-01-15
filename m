Return-Path: <linux-kselftest+bounces-49034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F88D24E1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A093099FAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB83A1A37;
	Thu, 15 Jan 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="slWS0nqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7539E19B;
	Thu, 15 Jan 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485975; cv=none; b=jlerPQnO3gbKl8fpzOa/ifgp3TWCTr/5A3cAtTolfkT5A7GV1EO8+XbY/9/YlCFmMyiYQzsmKx+76GkKtjOU4GU4Dvpb5yE/2dX/4QzytDBWfSLRqRLDp4W1dLKrGTmfJV2+sfjAlcJuxkODgRkfXf6Txj/JGaLHJQcsUsngxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485975; c=relaxed/simple;
	bh=mZnfDVOyN9GLNRRtiEBX94YctVtoAkBwvt7cOah15yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0VJRCvf00fFMNsnYeZow4krZdNgNW8YeW83JsGT4gefTsusr0gOnjSm/J4Hsl9rUyOHPLCFc6geOQHIo86Aew/dZiw9aBZx6n+UUHQAiPsRARdIh+IRDYRSmLo/KUPu5IGVIXb+DVkKcg/Q8f1gMIcmADg+G/VIhoT3kE5qfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=slWS0nqj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F9Jpnl023573;
	Thu, 15 Jan 2026 14:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h4PwuF
	j/AlFbn3RjR4NdKF/65RpubFCMeeVI5Y6jkXU=; b=slWS0nqj+MdsSzr47MgSJi
	uZtDYTvDEKRzKAe78y3Pjz2BXAZcnEq/w3Jd+4uGQFO84zEuecZ/2zPyrDbqzRP3
	m6CJkW1JKg3OstLLVI9zNPIfN777TnHT/Z11ucVxQJidNeVbUMUbe/pHRQUoXy93
	1M+Yvul2CirTB9DJjz37xmOjFPUFCr/L6dhFkbc7Lnw2bX1d72RQ6jXbhmkB5Eur
	M0vIEeB43Jx/4/tcf09SIS+8JL/cQjqJoGf9JyRKNyCmxT/hZ5EXWIuBYAul7f0w
	8HkF9sp/jJD0RuscZfSs0RlSnSHYHfCONDYdyuwTRFNjqyEl5AfDeq0WDKFxcHYg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt6df4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 14:06:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FAsvBU002511;
	Thu, 15 Jan 2026 14:06:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13t0gke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 14:06:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60FE5xt640501656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 14:05:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B0220040;
	Thu, 15 Jan 2026 14:05:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65962004B;
	Thu, 15 Jan 2026 14:05:58 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Jan 2026 14:05:58 +0000 (GMT)
Date: Thu, 15 Jan 2026 15:05:57 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>, Jens Remus <jremus@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: getrandom: Fix path to s390 chacha
 implementation
Message-ID: <20260115140557.7060C9f-hca@linux.ibm.com>
References: <20260115-vdso-s390-getrandom-v1-1-771dfa6d1c6d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115-vdso-s390-getrandom-v1-1-771dfa6d1c6d@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEwMiBTYWx0ZWRfX3i4GiVGVsYw/
 XgCBCy/nPyDadY2eAtl44UoZ9OsSFKWMQbQJA67fVe7BMh2YMZYPVFjVCB8k3vTIltP15OonamP
 gnUR4K87XAwQ4MxW9w7jgUWRmGDyB0joyJEL4lFS02TANg7/lR4+lRz7hhecOT63LWZ5A3fvltt
 N13lapArKEO0G8Z45CnSCGGnQ6Uhwi5VWDizCP//YaFZVcvZoXwNc9BQPYNDMcWAsBFpr31lBE8
 SWk3xnH/herhVURgdPcBD6hRA5CJo4Hy2Xgm1lpMcFB5VrbVYHiye/qDIbJvUGVI5IqTHKBHtSn
 A+rZtNusMot7jIf9ptJMAO1wWF9PDwYDmD9zlw43C5XzV3JXcK4QjDP4oKXzGBxBvL+vgOP2ntK
 aM+7XXS8IjVNkioVWnhDM41I1+lZXlqm+szO9bFRR7yw5FNqAWrOQRSdYObqJ+GuORVhqV8q49o
 uCcLP1GDTXVkspipPYA==
X-Proofpoint-GUID: DNUF9unkfR5tfEgZxAo7_UbxBAlffK0J
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6968f449 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=qr4JGDaOzoSpwvLJa2sA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: DNUF9unkfR5tfEgZxAo7_UbxBAlffK0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_04,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601150102

On Thu, Jan 15, 2026 at 02:56:52PM +0100, Thomas Weiﬂschuh wrote:
> The s390 vDSO source directory was recently moved,
> but this reference was not updated.
> 
> Fixes: c0087d807ae8 ("s390/vdso: Rename vdso64 to vdso")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/testing/selftests/vDSO/vgetrandom-chacha.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Should this go via s390 or will you take it?

In any case:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

