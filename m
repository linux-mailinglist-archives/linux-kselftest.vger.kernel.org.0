Return-Path: <linux-kselftest+bounces-23389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54A9F29A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 06:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BE81603CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 05:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F117DE36;
	Mon, 16 Dec 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UyKkvcs3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3C1422B8;
	Mon, 16 Dec 2024 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327320; cv=none; b=lrMsslbIdKYskjGG5FsD/WPp/Qs0++5p/p5fJtSP2C8Zg72LPXSEQt4O81T2Gui/jb//wcgYTsRrCOlI2/4jrVN2+pzKSOlEI6QmxLC8updEdIQ1RnPSMfNXQpY6SaqHk3fwYIXyCXF5+LHydjyz9YPlEE0nRYoC5aYCYRsVPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327320; c=relaxed/simple;
	bh=Hf/dwopCu8A4CKbJGD3yNVgwpdu0X+3DbmShenZhd1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFR+mufjg9hsTNTPieu88Sp8tX2/YeIocXYQXOZu+Z1Q9zfKJpFHylog5lWWQ0iljBCUy7Vs0H5yf6WX01BDpK26CA9kM/c/QJ2OBszXDFJUpOE9mK8y9DykivH2GY0JxpHwpxgJuhakvYytwTwijitatxbWjND0v/U/POHf38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UyKkvcs3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4A44R017722;
	Sun, 15 Dec 2024 21:35:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RamQrwqiR8YzmFJXnap7mvQDn
	iCLk74JwWIfHpFfvpc=; b=UyKkvcs3qyAfR/58ZBBJVXzxUsION05Ue75AH8IyK
	BwFGt3c0L4wUln3LS1uIdvEhlX1eZEdbRjMxOI6XANH8RP5hmZgpl29QmjnHrWX5
	0SAiKy+yHWC8NFONj0TxvVbU+rrCvgWiQdsGaPI3Al+ww+2PuFX66aqEXRhe+vc2
	ZGfdBFRLmGhKh2FeLvEiJKbwvWmwISATS8HLVeOAabSaP+jDYjzx0r0H1Nu4Yfnl
	a+drRA8mBjVwpG++zHFU/NZpRyoSWcYpndDbj44jI/ChCjEbkpLDVlAeJYMAPufU
	kZcd9jh2CxVS3INnlZLEirIcvNu+nTvhrTe5XE3QCAuEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43jcxgr7q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 21:35:09 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 21:35:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 21:35:08 -0800
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id E61D23F7041;
	Sun, 15 Dec 2024 21:35:04 -0800 (PST)
Date: Mon, 16 Dec 2024 11:05:03 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH] selftests: arm coresight: sysfsmode testing
Message-ID: <20241216053503.GB1224111@hyd1403.caveonetworks.com>
References: <20241129083813.3056909-1-lcherian@marvell.com>
 <115bb206-8401-4475-977d-7dd98a2b872c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <115bb206-8401-4475-977d-7dd98a2b872c@linuxfoundation.org>
X-Proofpoint-GUID: ka43qKm3HAQMVCEIw_2xV_RysnTBS7RN
X-Proofpoint-ORIG-GUID: ka43qKm3HAQMVCEIw_2xV_RysnTBS7RN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

On 2024-12-04 at 05:53:56, Shuah Khan (skhan@linuxfoundation.org) wrote:
> On 11/29/24 01:38, Linu Cherian wrote:
> > Add sysfs mode selftest for ARM Coresight hardware tracer.
> 
> Please add details on what this test does in here. Include
> the output from the test?

Ack. Will add test descripion here. 

> 
> Does this test have dependencies on config? If it does, does
> this test detect and skip if config isn't enabled?

Will add dependency.

Thanks.

> 
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> >   .../drivers/hwtracing/coresight/Makefile      |   5 +
> >   .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
> >   2 files changed, 149 insertions(+)
> >   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile
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
> > +	if [ -e "$1/enable_sink" ]; then
> > +
> > +		return 0
> > +	else
> > +		return 1
> > +	fi
> > +}
> > +
> > +# Configure sink for buffer mode
> > +cfg_sink_buf_mode() {
> > +	sink_dev=$1
> > +	mode=$2
> > +	# Set buffer mode if supported
> > +	if [ -e "$sink_dev/buf_modes_available" ]; then
> > +		cat $sink_dev/buf_modes_available | grep -E -q $mode
> > +		if [ $? -eq 0 ]; then
> > +			echo $mode > $sink_dev/buf_mode_preferred
> > +			return 0
> > +		fi
> > +	fi
> > +
> > +	return 1
> > +}
> > +
> > +run_app() {
> > +
> > +	taskset -c $1 dd if=/dev/urandom  of=/dev/null bs=1M count=64
> > +}
> > +
> > +sysfs_trace() {
> > +	src_dev=$1
> > +	sink_dev=$2
> > +	cpu=$3
> > +
> > +	# Enable sink device
> > +	echo 1 > $sink_dev/enable_sink
> > +	# Enable source device
> > +	echo 1 > $src_dev/enable_source
> > +
> > +	# Run app to be traced
> > +	run_app $cpu
> > +
> > +	# Read back trace data
> > +	dd if=/dev/$sink_dev_name of=/tmp/tracedata
> > +
> > +	# Verify if read is successful
> > +	err=$?
> > +
> > +	# Disable source device
> > +	echo 0 > $src_dev/enable_source
> > +
> > +	# Diskable sink device
> > +	echo 0 > $sink_dev/enable_sink
> > +
> > +	arm_cs_report "CoreSight path testing (CPU$cpu -> $sink_dev_name)" $err
> > +}
> > +
> > +try_sysfs_trace_resrv_buf() {
> > +	src_dev=$1
> > +	sink_dev=$2
> > +	cpu=$3
> > +
> > +	# Configure the resrved buffer mode if available
> > +	cfg_sink_buf_mode $sink_dev "resrv"
> > +	if [ $? -eq 0 ]; then
> > +		echo "Running sysfs trace with resrv buf mode"
> > +		sysfs_trace $src_dev $sink_dev $cpu
> > +		# Restore buffer mode
> > +		cfg_sink_buf_mode $sink_dev "auto"
> > +		if [ $? -eq 1 ]; then
> > +			echo "Failed to restore default buf mode"
> > +		fi
> > +	fi
> > +}
> > +
> > +arm_cs_iterate_devices() {
> > +	src_dev=$1
> > +	cpu=$3
> > +	for cdev in $2/connections/out\:*; do
> > +
> > +		# Skip testing if it's not a directory
> > +		! [ -d $cdev ] && continue;
> > +
> > +		# Read out its symbol link file name
> > +		sink_dev=`readlink -f $cdev`
> > +
> > +		# Extract device name from path, e.g.
> > +		#   sink_dev = '/sys/devices/platform/20010000.etf/tmc_etf0'
> > +		#     `> sink_dev_name = 'tmc_etf0'
> > +		sink_dev_name=$(basename $sink_dev)
> > +
> > +		if is_device_sink $sink_dev; then
> > +			# Run trace with resrv buf mode (if available)
> > +			try_sysfs_trace_resrv_buf $src_dev $sink_dev $cpu
> > +
> > +			# Run the default mode
> > +			echo "Running sysfs trace with default settings"
> > +			sysfs_trace $src_dev $sink_dev $cpu
> > +		fi
> > +
> > +		arm_cs_iterate_devices $src_dev $cdev $cpu
> > +
> > +	done
> > +}
> > +
> > +arm_cs_etm_traverse_path_test() {
> > +	# Iterate for every ETM device
> > +	for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
> > +		# Canonicalize the path
> > +		dev=`readlink -f $dev`
> > +
> > +		# Find the ETM device belonging to which CPU
> > +		cpu=`cat $dev/cpu`
> > +
> > +		# Use depth-first search (DFS) to iterate outputs
> > +		arm_cs_iterate_devices $dev $dev $cpu
> > +	done
> > +}
> > +
> > +arm_cs_etm_traverse_path_test
> > +
> > +exit $glb_err
> 
> thanks,
> -- Shuah
> 

