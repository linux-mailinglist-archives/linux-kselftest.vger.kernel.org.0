Return-Path: <linux-kselftest+bounces-23391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C69F29BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 06:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF3164702
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 05:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F131C5498;
	Mon, 16 Dec 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kPNfJws6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CC157469;
	Mon, 16 Dec 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328228; cv=none; b=tRM8JCvsf2TmEt0Q5eJQ5t6TfDZAT/qLcCmDHCUhMD/ESR2okVYJsDPiYuZ82GEsW61RABLnz4gsWROv/XkI2NUKqOsPFlRnCqBgnkHedr5pyGA2a80Vwrwf8UhoZ3VyaaP1mYfbIJNYZPOnz86D+7rTxL9io0iXYXfNMyjYEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328228; c=relaxed/simple;
	bh=N/MufcIXoeNYB+zKT/lQpUdgN+fWVfhoOXO/N8mGp2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0GkgviIatQgAAQOwhUtdyajjGez94O3vBPZ5Wj8o/HJ0tXpkv1cTZne29XxX/5298q/pYaziBW9IWyHrcZk2S3DibrzVZnG+RfTj/9CXzOhGpzgC/IMKAg4hfLU3Pd8U6iBZS0HZJB7jzjH1LFuV43fGrQKYE2UU6itR08qJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kPNfJws6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4CqjX014943;
	Sun, 15 Dec 2024 21:50:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=k+RLTPUZy3+zfG6K2U5lRmIcg
	b4pnhmlUqm9rLAiFJE=; b=kPNfJws6YkDTGM2m3e4Ls0SR6ZXLswcu51cG8yUu0
	4SzW6f9oUHQaYjlJfyRJWTZumbJlSVd9psXUmVw3nV2Cg7VbyjX1olcmDwGWA2QL
	nv2TdMyd7rvuNUaREmlbx90PYg4iyS9mPCKbC/m5tlBsSmljJY4/ebjv94toXSZE
	Uq7xtoYk69m/vU6fY91Nnn60V9tdqxF6yDnkXyP/gNE66X7i6Asw7qruwd1Kwujk
	Q7J+tH8baqk0SjUEZkPNfemXb7zaIeG+BL7CS9udSUplueNH9FvcCDC5x74AP/Ab
	axIxPZ8CpuU7Fc8qDerf+wOIlwewJr8f47JRGZh15oHPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43jcyv08ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 21:50:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 21:50:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 21:50:15 -0800
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 8A92F3F7093;
	Sun, 15 Dec 2024 21:50:11 -0800 (PST)
Date: Mon, 16 Dec 2024 11:20:10 +0530
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan
	<leo.yan@arm.com>
Subject: Re: [PATCH] selftests: arm coresight: sysfsmode testing
Message-ID: <20241216055010.GA1237565@hyd1403.caveonetworks.com>
References: <20241129083813.3056909-1-lcherian@marvell.com>
 <1b7aaa17-48b7-45cd-b468-ef54ca048e31@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b7aaa17-48b7-45cd-b468-ef54ca048e31@linaro.org>
X-Proofpoint-GUID: Zj18E5iGenMM-xpe-bK_TsBZ9dFSQz9d
X-Proofpoint-ORIG-GUID: Zj18E5iGenMM-xpe-bK_TsBZ9dFSQz9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

On 2024-12-04 at 16:45:42, James Clark (james.clark@linaro.org) wrote:
> 
> 
> On 29/11/2024 8:38 am, Linu Cherian wrote:
> > Add sysfs mode selftest for ARM Coresight hardware tracer.
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> >   .../drivers/hwtracing/coresight/Makefile      |   5 +
> >   .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
> >   2 files changed, 149 insertions(+)
> >   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> 
> Hi Linu,
> 
> You need to add this path into TARGETS for make install to work:
> 
>  TARGETS += drivers/dma-buf
> +TARGETS += drivers/hwtracing/coresight
>  TARGETS += drivers/s390x/uvdevice
> 
> 
> >   create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> > 
> > diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/Makefile b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> > new file mode 100644
> > index 000000000000..7dc68ae1c0a9
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +TEST_PROGS = sysfs_test_trace.sh
> > +
> > +include ../../../lib.mk
> > diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> > new file mode 100755
> > index 000000000000..0d6307fff1d2
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> > @@ -0,0 +1,144 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 Marvell.
> > +
> > +# Test Arm CoreSight trace capture in sysfs mode
> > +# Based on tools/perf/tests/shell/test_arm_coresight.sh
> > +
> > +glb_err=0
> > +
> > +arm_cs_report() {
> > +	if [ $2 != 0 ]; then
> > +		echo "$1: FAIL"
> > +		glb_err=$2
> > +	else
> > +		echo "$1: PASS"
> > +	fi
> > +}
> > +
> > +is_device_sink() {
> > +	# If the node of "enable_sink" is existed under the device path, this
> > +	# means the device is a sink device.
> > +
> 
> Looks like you still need the skip for TPIU here the same as the Perf test.
> It's an external sink and doesn't have a readable file so the test fails.
> 

Okay will skip.

> With those changes, looks good. Thanks for adding the first sysfs test.
> Hopefully we can expand them more in the future.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 

Thanks.
Linu Cherian.
 

