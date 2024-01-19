Return-Path: <linux-kselftest+bounces-3241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BC832A1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 14:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9006E28601E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98905524BF;
	Fri, 19 Jan 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eEkPtlKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852F33CE9;
	Fri, 19 Jan 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669882; cv=none; b=gM1hR1+NhGewmhRUGyLqYDiZo1SCFkevGyLgnU27EIP+Gtx9iT7gvk4PK7BwvNcp6ydBn8ECuGAkA8Bsw6cBKSwoILyR+J0DaGwn7oSaIK4TvcGs8AfQWUUmEp2tf/L1/WQZVunJXZ7qUWrY04YQogOaemJRX7JXh3u+ua/cKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669882; c=relaxed/simple;
	bh=0AgduXsuld70K/EMlbZrFK/ZLPaT4SXhbyZdDcrTuzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO18uSDivgHYs8Xl6/Qc2iMeNzBP0s6BgIXgYGB7P6f6dYGCELrzQxYXGWj/3NGtCb9nSNA7wN1/n4dx0eySgeBnmNLTVCNuHCuCAatQ48lGz5wrvdV9RWzNoFtlnhmZcBo1Z7pL+gdAuu29jhQa4HGZt8SrBDlUB4s/w73+sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eEkPtlKJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JD0OLp017291;
	Fri, 19 Jan 2024 13:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=y3roZCLy1ySD+5Ai9Ht2UZyOzehoiSJRmh+F6cP6vxc=;
 b=eEkPtlKJixGFZWrJc0a0cE7/OPuyE4AQNMvB4RD4MomJoWpHNtzULXT3rUj8Bra2BKac
 qWF16GxsLGE+tcQpBJbTsD9hLj2TFWYRXspN1fLWKsBEkpL2qRoFNL0P6bAasmJTvX/S
 nUNoHXi5RuFDeJD0n3RqZgDpwfuU0uH5Lp5ymvlZtkCaQAYPpDmQg8ES5pN24/7GIwEx
 j4aLL3+RY3wMFdMYKE/YVrbzneQrqb157DazL2Qu0opFfdx/WIvpIoBFksIhDbyq9woI
 g0FtlH6ZBgQeuk8FRX49KHKwrevYtIsW9m+3HnNITiorZkf0w4h+D//lLEfc0XZUfqX3 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqs1jhcrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:11:05 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JD0nHk018582;
	Fri, 19 Jan 2024 13:11:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqs1jhcr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:11:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40JAM1gl030870;
	Fri, 19 Jan 2024 13:11:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72khaks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:11:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40JDB13E43188718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 13:11:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585682004B;
	Fri, 19 Jan 2024 13:11:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E85B20040;
	Fri, 19 Jan 2024 13:10:59 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.85.177])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jan 2024 13:10:59 +0000 (GMT)
Date: Fri, 19 Jan 2024 14:10:57 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p-8a8pwvXQe30bZjF8SmExCBArjrS_A1
X-Proofpoint-ORIG-GUID: LtCFlP5IylQnTIoJja1a4g7w6R36SAxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=875
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401190067

On Fri, Jan 12, 2024 at 02:43:51PM -0300, Marcos Paulo de Souza wrote:
Hi Marcos,
...
>  arch/s390/configs/debug_defconfig                  |  1 -
>  arch/s390/configs/defconfig                        |  1 -
>  lib/Kconfig.debug                                  | 22 ----------
...
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 85490d9373fc..5948afeeb56c 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -884,4 +884,3 @@ CONFIG_ATOMIC64_SELFTEST=y
>  CONFIG_STRING_SELFTEST=y
>  CONFIG_TEST_BITOPS=m
>  CONFIG_TEST_BPF=m
> -CONFIG_TEST_LIVEPATCH=m
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index fb690fbbf54b..8d8c2989b6fe 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -813,4 +813,3 @@ CONFIG_KPROBES_SANITY_TEST=m
>  CONFIG_PERCPU_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=y
>  CONFIG_TEST_BPF=m
> -CONFIG_TEST_LIVEPATCH=m
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 97ce28f4d154..c2147caa7da2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2853,28 +2853,6 @@ config TEST_MEMCAT_P
>  
>  	  If unsure, say N.
>  
> -config TEST_LIVEPATCH
> -	tristate "Test livepatching"
> -	default n
> -	depends on DYNAMIC_DEBUG
> -	depends on LIVEPATCH
> -	depends on m
> -	help
> -	  Test kernel livepatching features for correctness.  The tests will
> -	  load test modules that will be livepatched in various scenarios.
> -
> -	  To run all the livepatching tests:
> -
> -	  make -C tools/testing/selftests TARGETS=livepatch run_tests
> -
> -	  Alternatively, individual tests may be invoked:
> -
> -	  tools/testing/selftests/livepatch/test-callbacks.sh
> -	  tools/testing/selftests/livepatch/test-livepatch.sh
> -	  tools/testing/selftests/livepatch/test-shadow-vars.sh
> -
> -	  If unsure, say N.
> -
>  config TEST_OBJAGG
>  	tristate "Perform selftest on object aggreration manager"
>  	default n

FWIW, for s390 part:

Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

