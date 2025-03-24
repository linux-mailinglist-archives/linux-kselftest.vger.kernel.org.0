Return-Path: <linux-kselftest+bounces-29648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB8A6DF19
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 16:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3B2188C7EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82B261368;
	Mon, 24 Mar 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="slU4z1fO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912425EFA3;
	Mon, 24 Mar 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831736; cv=none; b=miY0f38EP4zXgoYy4CHzhp77CJ9VbjDO9mjrWbeb2Roe+FXSEwKRZnqjWAswalENV9TTtzZ63ysRMoyn/QO0xNi6+Y6PQXU2uVi1np7s5na3NFQyQSV//FDDK2k2eV9QFDNXGveVcKpW0VuGKiw+J1qYzP7UbZitkcocEGWhEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831736; c=relaxed/simple;
	bh=+NvCRMW5ROIVpKI6SRARIqzmezFBTN8z5YZU5EI2Q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAz/nAQlIAvTXvFJ8HE8yYoGuGUzWzcFoL1fe3L8uRCy29al6+YxzdgrSKBVf897eSwvlRCPF8kLl3o3rdEZc+UqGCcp7jIi8oiDxwABaP10uTePV/LJdC1maxyxDFLnFdphe4rULYpAcf8vUvp0VrQsnfyKG55v3j+k6HAruSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=slU4z1fO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OCRwYf026840;
	Mon, 24 Mar 2025 15:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1rJXdj
	QWgt7e1qHOvdDS2AQvHPF/x2DFNRCGBAIimRM=; b=slU4z1fOo++xhl0TnHuEF1
	bRH7xBhB/t2ll7t8h/rL1H4A8o/OEA2zJMHqbrHMDZErhnP2sEwkJ0Iy5ovn3Jmh
	10YE8iOxTHNbss7Jjb7XWRt79pruWHqfCCXI6nM1mclFD/x0q3WkbTy1qfBcVXYb
	XzKeHJH6X9BMb8xL6iuTxfIJm1/S7CV/OcATknvFDBvDNqtJIAItj2GdCB4ypuFz
	EB2aL56AtDDZzD/qGa/IGSz8VgSvrhUUw5w4YCycDNUz8RWisnOJLVaUJwNESSyV
	KCCLrk4VB1GnP5RzOh2pxk9656QPzJ0dCJgva3J1bff9CPloLGSdOyvAHQh3gOjw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k7e394vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:55:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52OFHAip030325;
	Mon, 24 Mar 2025 15:55:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7ht7626-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:55:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OFtFJq21103066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 15:55:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2868F20043;
	Mon, 24 Mar 2025 15:55:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B901C20040;
	Mon, 24 Mar 2025 15:55:14 +0000 (GMT)
Received: from osiris (unknown [9.179.14.66])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Mar 2025 15:55:14 +0000 (GMT)
Date: Mon, 24 Mar 2025 16:55:13 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] selftests: vDSO: chacha: Provide default definition
 of HWCAP_S390_VXRS
Message-ID: <20250324155513.12139G44-hca@linux.ibm.com>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
 <20250324-s390-vdso-hwcap-v1-3-cb9ad001ceba@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324-s390-vdso-hwcap-v1-3-cb9ad001ceba@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _KUvzStrdFxpiUUDujmjVBeoTJ8Ndv6N
X-Proofpoint-GUID: _KUvzStrdFxpiUUDujmjVBeoTJ8Ndv6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=575 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240112

On Mon, Mar 24, 2025 at 03:03:17PM +0100, Thomas Weiﬂschuh wrote:
> s390 does not provide a hwcap.h UAPI header.
> 
> Add an inline definition for the constant HWCAP_S390_VXRS until a proper
> UAPI header is introduced.
> 
> Fixes: 210860e7f733 ("selftests: vDSO: check cpu caps before running chacha test")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> index fd5c5108b42f04ec459d39b74f33edc2ceafbba1..0ce5189718ce35b0a4d69b71559db8379b598b93 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> @@ -19,6 +19,9 @@ static bool cpu_has_capabilities(void)
>  	return getauxval(AT_HWCAP) & HWCAP_ASIMD;
>  }
>  #elif defined(__s390x__)
> +#ifndef HWCAP_S390_VXRS
> +#define HWCAP_S390_VXRS	(1 << 11)
> +#endif
>  static bool cpu_has_capabilities(void)
>  {
>  	return getauxval(AT_HWCAP) & HWCAP_S390_VXRS;

How did this cause a problem?

Did you use something different than glibc(-devel) on your test
system? Just wondering since glibc-devel provides the define since
ages and is also required for getauxval().

