Return-Path: <linux-kselftest+bounces-23388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCEC9F266D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Dec 2024 23:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F236F188502E
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Dec 2024 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACF1B4F08;
	Sun, 15 Dec 2024 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HBmwOSY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746B1D696;
	Sun, 15 Dec 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300592; cv=none; b=KncamGO3ZFg56tOIT/QhMKLjmLJDhGz4JpdpEado+DTarLuYKSToV1EojmRKBzSbnRkQBKgMJTVPEJzIPfwdxcOwL4q0ZJhsl5iGs+7XowpCXLBNr8taQXCEztpl2uigjmsZoA2TkSacAcSNDKxeG9T+zpR1vcbjTRYQtmhWpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300592; c=relaxed/simple;
	bh=1K4UDzQibAAbh+HcOfggNwiJiB/uWyO18wdmGXvsReI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZdajq4nZJVgHnny9m8qPw8DnjJoHUPnqfvh2YOhhuwsgjwxXECv/BwdwILVAdnIk7j/4gOvJI9K90ZdT8/hYcnwTy0dQWIKuiv71I9ybGlkdU/2+XBGAKZbIvxxPa+BazBXg/r5ckSpBpNpc47KKN093JBu9kl/84MbJeH4g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HBmwOSY6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF2Ib3M000400;
	Sun, 15 Dec 2024 22:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=foavY3
	NUBKwRVvv82vUPDlwf/CmqkiZ880rnbJW+UKY=; b=HBmwOSY6M9KxGlnSUxzMVa
	+uskSUz7Xp637o3fcTYGypxlrA6hCVi96O74r4RqUd4ip9/TwNuqkLrpBfcyXdNh
	n0dn4nrqvXVH1Ocwa7Rvz67QvfChAdyXSnurqzfnc+S8O/FeaC1M4bjIrnda3S7i
	PuaZp0S0WXM4KUVruvPy83/7Q7Vb1LKihy+j3FWjkAAwb7E4wdhBykp8vHMVK7Cs
	3QVoL5AqHThIPWUUPqnAzDeFyIhoDDmvrgSmCZgv9boo0Udc7mTIbtqUelPCl9fk
	tnONbQDPgTXzdtq2KOJn33ZLx6V9bLEItBgm950ztrcBDktGnDzQ/lAz9n+pD08A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hm5gu78p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 22:09:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFK6Tbr014397;
	Sun, 15 Dec 2024 22:09:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21ax5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 22:09:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BFM9VKp56099082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 22:09:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F752005A;
	Sun, 15 Dec 2024 22:09:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D3C02004E;
	Sun, 15 Dec 2024 22:09:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 15 Dec 2024 22:09:31 +0000 (GMT)
Date: Sun, 15 Dec 2024 23:09:27 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aruna.ramakrishna@oracle.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, keith.lucas@oracle.com, ryan.roberts@arm.com,
        shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 11/14] selftests/mm: Use sys_pkey helpers consistently
Message-ID: <Z19Tl30BuKTfL629@tuxmaker.boeblingen.de.ibm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
 <20241209095019.1732120-12-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209095019.1732120-12-kevin.brodsky@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DFxHJAOykh2WDho1kMjZipalLMNewXsl
X-Proofpoint-GUID: DFxHJAOykh2WDho1kMjZipalLMNewXsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150192

On Mon, Dec 09, 2024 at 09:50:16AM +0000, Kevin Brodsky wrote:

Hi Kevin, Andrew,

> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 814b17a43385..1f0743d9459d 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -147,8 +147,8 @@ TEST_FILES += write_hugetlb_memory.sh
>  
>  include ../lib.mk
>  
> -$(TEST_GEN_PROGS): vm_util.c thp_settings.c
> -$(TEST_GEN_FILES): vm_util.c thp_settings.c
> +$(TEST_GEN_PROGS): vm_util.c thp_settings.c pkey_util.c
> +$(TEST_GEN_FILES): vm_util.c thp_settings.c pkey_util.c

This patch breaks s390 in -next with the below error messages:

In file included from pkey_util.c:5:
pkey-helpers.h:109:2: error: #error Architecture not supported
  109 | #error Architecture not supported
      |  ^~~~~
pkey-helpers.h: In function ‘set_pkey_bits’:
pkey-helpers.h:126:21: error: implicit declaration of function ‘pkey_bit_position’ [-Wimplicit-function-declaration]
  126 |         u32 shift = pkey_bit_position(pkey);
      |                     ^~~~~~~~~~~~~~~~~
pkey-helpers.h: In function ‘_read_pkey_reg’:
pkey-helpers.h:151:24: error: implicit declaration of function ‘__read_pkey_reg’; did you mean ‘_read_pkey_reg’? [-Wimplicit-function-declaration]
  151 |         u64 pkey_reg = __read_pkey_reg();
      |                        ^~~~~~~~~~~~~~~
      |                        _read_pkey_reg
pkey-helpers.h: In function ‘write_pkey_reg’:
pkey-helpers.h:165:18: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘int’ [-Wformat=]
  165 |         dprintf4("%s() changing %016llx to %016llx\n", __func__,
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  166 |                         __read_pkey_reg(), pkey_reg);
      |                         ~~~~~~~~~~~~~~~~~
      |                         |
      |                         int
pkey-helpers.h:62:32: note: in definition of macro ‘dprintf_level’
   62 |                 sigsafe_printf(args);           \
      |                                ^~~~
pkey-helpers.h:165:9: note: in expansion of macro ‘dprintf4’
  165 |         dprintf4("%s() changing %016llx to %016llx\n", __func__,
      |         ^~~~~~~~
pkey-helpers.h:165:39: note: format string is defined here
  165 |         dprintf4("%s() changing %016llx to %016llx\n", __func__,
      |                                 ~~~~~~^
      |                                       |
      |                                       long long unsigned int
      |                                 %016x
pkey-helpers.h:169:9: error: implicit declaration of function ‘__write_pkey_reg’; did you mean ‘write_pkey_reg’? [-Wimplicit-function-declaration]
  169 |         __write_pkey_reg(pkey_reg);
      |         ^~~~~~~~~~~~~~~~
      |         write_pkey_reg
pkey-helpers.h:171:18: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘int’ [-Wformat=]
  171 |         dprintf4("%s(%016llx) pkey_reg: %016llx\n", __func__,
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  172 |                         pkey_reg, __read_pkey_reg());
      |                                   ~~~~~~~~~~~~~~~~~
      |                                   |
      |                                   int
pkey-helpers.h:62:32: note: in definition of macro ‘dprintf_level’
   62 |                 sigsafe_printf(args);           \
      |                                ^~~~
pkey-helpers.h:171:9: note: in expansion of macro ‘dprintf4’
  171 |         dprintf4("%s(%016llx) pkey_reg: %016llx\n", __func__,
      |         ^~~~~~~~
pkey-helpers.h:171:47: note: format string is defined here
  171 |         dprintf4("%s(%016llx) pkey_reg: %016llx\n", __func__,
      |                                         ~~~~~~^
      |                                               |
      |                                               long long unsigned int
      |                                         %016x
pkey-helpers.h: In function ‘is_pkeys_supported’:
pkey-helpers.h:207:14: error: implicit declaration of function ‘cpu_has_pkeys’; did you mean ‘kernel_has_pkeys’? [-Wimplicit-function-declaration]
  207 |         if (!cpu_has_pkeys()) {
      |              ^~~~~~~~~~~~~
      |              kernel_has_pkeys

Please, let me know if I am missing something.

>  $(OUTPUT)/uffd-stress: uffd-common.c
>  $(OUTPUT)/uffd-unit-tests: uffd-common.c

Thanks!

