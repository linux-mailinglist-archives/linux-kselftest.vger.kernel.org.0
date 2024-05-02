Return-Path: <linux-kselftest+bounces-9256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE08B965E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908B51C21747
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5436139;
	Thu,  2 May 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FD+omsla"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAB171AA
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638134; cv=none; b=T5tlCE81UQ/2TJtAo4bPEQ0q/ssuy9BNB7yZ2MbaEiRuvgRNnx4fbBJF8VxHYmLpIs39mzm3xGdlkvACp99j4SBOr2AFIKrul3bjuNjVy3CK10kiHRq1sLhC9bIhYMdEsAAcNXzffhzQy0yvuhIhhH6eDSqHmgl2L34ktxgSrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638134; c=relaxed/simple;
	bh=BCX4wXaPY4fyv4SRjFhOrDD7YPP4XLQ9tx19ZWuUX54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbQrckz1VD8LVLduO73Y79XFk4jxW3lwhNwJ2KW0f0t8kVKk6g82bjCtNiajJW84Bky8GS3ws5cmhgPwBbtNhWFOB10qXlnb24Dit3oWZJJRRQfG8a/G9CYIXcyrvFWBTyeJ2v7KC9L9ufZbgE3D69/XIRAtI+gNLoarZKd/D5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FD+omsla; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4427vEJY019173;
	Thu, 2 May 2024 08:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+e1sy4bUe3023GtY1gPbpRm6ulsaeQmRvwovFAJwMJQ=;
 b=FD+omslaKaYQPIkOWXLQn40NI5sK/xg/QotBpidn2DX6U+9gtQ3HfYInNYCJYheASCTS
 fzo9BxKi6Qj1DecNkAy6JQq5vJqA0r8zLJrjCFCPqYhz9SN5NG2qEx3fubIajSa2EhRV
 JE+v72OhWUznB0pzDnW2fAXmKvPWxgCaUv05MWyXsX/rrIIDh2ZCa1LHuRcvIM4Ay0JK
 8HYsBKDrfsKAGMsdN2IrvoCdBTYrYzkIv1iPohPQZSAZIohvWL2GmO5dv4eyHPj3tgIO
 x8DSP5DlN9/GMK2507PoPY90rqkF9XXEZJb+G35Cy8Sblv6996T5eHGOiNyLqh1QBBP1 XA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xv6w101v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 08:22:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4426XIVn015582;
	Thu, 2 May 2024 08:22:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsed36gyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 08:22:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4428Lxn826477226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 08:22:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE37B20040;
	Thu,  2 May 2024 08:21:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450EB2004B;
	Thu,  2 May 2024 08:21:58 +0000 (GMT)
Received: from [9.171.50.201] (unknown [9.171.50.201])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 May 2024 08:21:58 +0000 (GMT)
Message-ID: <5f0cb59d-0deb-4919-97b6-a99ae640c424@linux.ibm.com>
Date: Thu, 2 May 2024 13:51:56 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/powerpc: Convert pmu Makefile to for
 loop style
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: spoorthy@linux.ibm.com, linux-kselftest@vger.kernel.org
References: <20240422133453.1793988-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20240422133453.1793988-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D-vFqqofNExImy4mrjLrTskLwyotx9c_
X-Proofpoint-GUID: D-vFqqofNExImy4mrjLrTskLwyotx9c_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020049


On 4/22/24 7:04 PM, Michael Ellerman wrote:
> The pmu Makefile has grown more sub directories over the years. Rather
> than open coding the rules for each subdir, use for loops.

Nice cleanup. Thanks.

Tested-by: Madhavan Srinivasan <maddy@linux.ibm.com>


> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/powerpc/pmu/Makefile | 43 ++++++++++----------
>   1 file changed, 22 insertions(+), 21 deletions(-)
>
> v2: Actually send both patches.
>
> diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
> index 1fcacae1b188..773933e5180e 100644
> --- a/tools/testing/selftests/powerpc/pmu/Makefile
> +++ b/tools/testing/selftests/powerpc/pmu/Makefile
> @@ -9,7 +9,9 @@ top_srcdir = ../../../../..
>   include ../../lib.mk
>   include ../flags.mk
>   
> -all: $(TEST_GEN_PROGS) ebb sampling_tests event_code_tests
> +SUB_DIRS := ebb sampling_tests event_code_tests
> +
> +all: $(TEST_GEN_PROGS) $(SUB_DIRS)
>   
>   $(TEST_GEN_PROGS): $(EXTRA_SOURCES)
>   
> @@ -23,12 +25,16 @@ $(OUTPUT)/count_stcx_fail: loop.S $(EXTRA_SOURCES)
>   
>   $(OUTPUT)/per_event_excludes: ../utils.c
>   
> +$(SUB_DIRS):
> +	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
> +
>   DEFAULT_RUN_TESTS := $(RUN_TESTS)
>   override define RUN_TESTS
>   	$(DEFAULT_RUN_TESTS)
> -	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
> -	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
> -	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
> +	+@for TARGET in $(SUB_DIRS); do \
> +		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests; \
> +	done;
>   endef
>   
>   emit_tests:
> @@ -36,34 +42,29 @@ emit_tests:
>   		BASENAME_TEST=`basename $$TEST`;	\
>   		echo "$(COLLECTION):$$BASENAME_TEST";	\
>   	done
> -	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
> -	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
> -	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
> +	+@for TARGET in $(SUB_DIRS); do \
> +		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests; \
> +	done;
>   
>   DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
>   override define INSTALL_RULE
>   	$(DEFAULT_INSTALL_RULE)
> -	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install
> -	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install
> -	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install
> +	+@for TARGET in $(SUB_DIRS); do \
> +		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install; \
> +	done;
>   endef
>   
>   DEFAULT_CLEAN := $(CLEAN)
>   override define CLEAN
>   	$(DEFAULT_CLEAN)
>   	$(RM) $(TEST_GEN_PROGS) $(OUTPUT)/loop.o
> -	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean
> -	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean
> -	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean
> +	+@for TARGET in $(SUB_DIRS); do \
> +		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean; \
> +	done;
>   endef
>   
> -ebb:
> -	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
> -
> -sampling_tests:
> -	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
> -
> -event_code_tests:
> -	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
>   
>   .PHONY: all run_tests ebb sampling_tests event_code_tests emit_tests

