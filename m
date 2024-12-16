Return-Path: <linux-kselftest+bounces-23390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7789F29A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 06:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873681606FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA41B2194;
	Mon, 16 Dec 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jyFTC9fn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16081157A67;
	Mon, 16 Dec 2024 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327357; cv=none; b=N0t47eaL/uxtF5WL5kZQZBhbT4LuRBTZmpvRNrBxdcCX+QGSTq83SdMzsFkm2y4/T/QIqEgAYigfP60edvwiN/yX26dXu3HgZnK2kX9EpsAygd8SzugyiK882z93g3mysmzCVCATqG53iEqAP4UPitVp7+pEwxiYiWSEGY9DtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327357; c=relaxed/simple;
	bh=hPawctctAJmhyGaQNiq1Zgv73HfGz3rXkMHMJWMi6HU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLsLFuTYa8uUexugMQmBrJP9G5VGryBEckBKnjZzba9TnFXSxs99Vo4k4ycLCidU+aivr8Z0AF7J8bFKjcteQl0cmkhiHj4a9x1caH6NkerAGubnEht/O4ZTFc8YCNLoFP88uDSaV/GLR2Dwgq6h9L66LeFtoWbJG4FnzZfIMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jyFTC9fn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG49meT016661;
	Sun, 15 Dec 2024 21:35:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=v4NqDvhpbu9adT0Cs5L2MtbI6
	B9qYT0ry+58Y+plsos=; b=jyFTC9fnKrEopeqHbZRkS4QogZolK4KheSlMNVJ4E
	/NRXJY7t9Io3RXra6tSAuzVjABnhZblocX1dg1GSbyxZL+RGsYvsivsJ7mHGgHqC
	edvMq30ZPVbL64ybAze52BTo/gLccnTN3HHU/DS399zln4FMA1GbK1KEjOXOybBH
	ET9PUPX0SaQ6Gb/0YueYsxemTANOBY1RSXtm/UNSej+YS8hzKvKWEcE53DVogAaf
	gvZMUf2iuW6/5RAGLZn+wlbWIeKGEZLgYecQUfC5lGbSXmak0j729A497AtAgvPJ
	+1xJe58nQnCWoqhRqrXLhpAAxeZqQmLwtwIEa+CyOAITw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43jcxgr7rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 21:35:47 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 21:35:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 21:35:45 -0800
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 44BED3F7041;
	Sun, 15 Dec 2024 21:35:42 -0800 (PST)
Date: Mon, 16 Dec 2024 11:05:41 +0530
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
Message-ID: <20241216053541.GC1224111@hyd1403.caveonetworks.com>
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
X-Proofpoint-GUID: l3-LipelPYiuKBTgASP_r_OCqzt4wW0i
X-Proofpoint-ORIG-GUID: l3-LipelPYiuKBTgASP_r_OCqzt4wW0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi James,

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


Sure will add that.
Thanks.

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
> With those changes, looks good. Thanks for adding the first sysfs test.
> Hopefully we can expand them more in the future.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> 

