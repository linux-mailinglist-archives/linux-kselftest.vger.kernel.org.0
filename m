Return-Path: <linux-kselftest+bounces-18959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045998EC32
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F52D1F22107
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA15145B27;
	Thu,  3 Oct 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FigTZQoM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52B13CFB8;
	Thu,  3 Oct 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947252; cv=none; b=u/YzBLsuykkHFvr06xICeb192wGLa9sUJGO0lgzFtNDW36WuXcYmT581DO9mGFawHtpMQdy4UZdD0DXk5q3wx9cBLrMWmCKQ05K3v1L03uUe0V+bAoux31uNmvroPhjbJvirnRpOorEuvHZ1c6FNY6gcSxAF0OKvtYccVIMnMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947252; c=relaxed/simple;
	bh=NfQncgWPFyaHgbioFiexl7rGbC4z6BCOkL7xL3esQdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MojxLcWshv/xYsoKWne25ksbTBdrOK4/zORbfg2Q3+DwRzbpdnjIuGvMFow/usHH7rUmA52tWfqR/jRMfj11PNpKxnnwsqMqqSLUkao+AsJ7V19J2Bz9WSkXLr9dJ3w8kZTOcMbB7XPJWpwNDcCV0TTwJar9uvZLLeJM4oAZsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FigTZQoM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4934WdWd015803;
	Thu, 3 Oct 2024 09:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Iz2rY8jbndLfHvEarCD5o9TP
	fOlEtCcaQg9CpP6UU2w=; b=FigTZQoMJQYVoDUtUMrGmBTSnKLNmwy1Ue+hBmCf
	62EdP8G4JlPKqreeQamiGiUEs1L4oSIQeZMsE5qH0rQIaF/U/L3ioRQTVEyk6IEJ
	Qfs/gu2rv2SntUEPVgnwdlq6kFddATzDUhOe51w8JeYtng/wV4/UbRp5xeaIBrMS
	6JhaSpmcdbGuJrEMHtIO4kDNuK5FOgHL/QuLW/e6lew+EiCssbgncNTfiJ28c49T
	88DiyBdHOmr4eXuRuE964DYI8YyoWQxOJi1ff7NUjbYWEgeNFZcdq9ku1miFBP4n
	97ZFaHF696KSZI963ddxoNUphOzhDSQJRu0c7bnXfyoftw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94hnx11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 09:20:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4939KdRq028362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 09:20:39 GMT
Received: from hu-wasimn-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 3 Oct 2024 02:20:37 -0700
Date: Thu, 3 Oct 2024 14:50:22 +0530
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
CC: Shuah Khan <shuah@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH v2] selftest: remoteproc: Add basic test for start/stop
 sequence
Message-ID: <Zv5h1hQ/Ji8aJ/GI@hu-wasimn-hyd.qualcomm.com>
References: <20240927112132.3927298-1-quic_wasimn@quicinc.com>
 <xee5pz7qha3nn2ldr6ogtikbrc23d4mrxabdfv6ujtbtj7fcch@whh726b6xlhc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xee5pz7qha3nn2ldr6ogtikbrc23d4mrxabdfv6ujtbtj7fcch@whh726b6xlhc>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HBJ4d3LoJv0pINwWfAn9YRDuscYOg8G6
X-Proofpoint-ORIG-GUID: HBJ4d3LoJv0pINwWfAn9YRDuscYOg8G6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030067

On Sun, Sep 29, 2024 at 10:03:23PM -0500, Bjorn Andersson wrote:
> On Fri, Sep 27, 2024 at 04:51:32PM GMT, Wasim Nazir wrote:
> > This test includes:
> >     1) Start/stop test for each rproc instance sequencially
> >     2) Start/stop test for all rproc instances concurrently
> > 
> 
> This fails to describe the purpose of the patch. Provide a proper commit
> mesasge.
> 
> In particular, I expect an argumentation for your test scheme. Will this
> work across all remoteproc instances? Does it have any dependencies,
> etc...
As we are tesing only the core ops based on the availabe sysfs entries,
it should work accross targets where remoteproc config is enabled & instances
are available. Otherwise I am skipping the tests.
Please correct me if I am missing anything here.

I will try to elaborate purpose of the tests in next patch.
> 
> > Changes in v2:
> > - Update commit message
> > - Addressed start/stop flow
> 
> The changelog goes below the '---' line, adjacent to your diffstat -
> which is missing from your patch. I don't know how you're sending these
> patches, but your system is either configured weirdly or you're not
> following my instructions on go/upstream.
> 
Will do the correction in next patch.
> > 
> > Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a77770cd96b8..02ebad5ae790 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19596,6 +19596,7 @@ F:	Documentation/staging/remoteproc.rst
> >  F:	drivers/remoteproc/
> >  F:	include/linux/remoteproc.h
> >  F:	include/linux/remoteproc/
> > +F:	tools/testing/selftests/remoteproc/
> > 
> >  REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
> >  M:	Bjorn Andersson <andersson@kernel.org>
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index b38199965f99..0c8a0f427d01 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -82,6 +82,7 @@ TARGETS += proc
> >  TARGETS += pstore
> >  TARGETS += ptrace
> >  TARGETS += openat2
> > +TARGETS += remoteproc
> >  TARGETS += resctrl
> >  TARGETS += riscv
> >  TARGETS += rlimits
> > diff --git a/tools/testing/selftests/remoteproc/Makefile b/tools/testing/selftests/remoteproc/Makefile
> > new file mode 100644
> > index 000000000000..a84b3934fd36
> > --- /dev/null
> > +++ b/tools/testing/selftests/remoteproc/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +TEST_PROGS := remoteproc_test.sh
> > +
> > +include ../lib.mk
> > diff --git a/tools/testing/selftests/remoteproc/config b/tools/testing/selftests/remoteproc/config
> > new file mode 100644
> > index 000000000000..a5c237d2f3b4
> > --- /dev/null
> > +++ b/tools/testing/selftests/remoteproc/config
> > @@ -0,0 +1 @@
> > +CONFIG_REMOTEPROC=y
> > diff --git a/tools/testing/selftests/remoteproc/remoteproc_test.sh b/tools/testing/selftests/remoteproc/remoteproc_test.sh
> > new file mode 100644
> > index 000000000000..589368285307
> > --- /dev/null
> > +++ b/tools/testing/selftests/remoteproc/remoteproc_test.sh
> > @@ -0,0 +1,134 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > +#
> > +
> > +DIR="$(dirname $(readlink -f "$0"))"
> > +
> > +KTAP_HELPERS="${DIR}/../kselftest/ktap_helpers.sh"
> > +if [ -e "$KTAP_HELPERS" ]; then
> > +    . "$KTAP_HELPERS"
> > +else
> > +    echo -n "1..0 # SKIP $KTAP_HELPERS file not found"
> > +    exit 4
> > +fi
> > +
> > +RPROC_SYS=/sys/class/remoteproc
> > +RPROC_SEQ_SLEEP=5
> > +rproc_instances=
> > +# Declare an array to save initial states of each instance
> > +org_instance_to_state=""
> > +num_tests=0
> > +test_err=0
> > +
> > +check_error() {
> > +	if [ $? -ne 0 ]; then
> > +		test_err=$((test_err+1))
> > +		ktap_print_msg "$@"
> > +	fi
> > +}
> > +
> > +rproc_stop_instances() {
> > +	for instance in ${rproc_instances}; do
> > +		rproc=${RPROC_SYS}/$instance
> > +		rproc_name=$(cat $rproc/name)
> > +		rproc_state=$(cat $rproc/state)
> > +
> > +		echo stop > "$rproc/state"
> > +		check_error "$rproc_name state-stop failed at state $rproc_state"
> > +	done
> > +	sleep ${RPROC_SEQ_SLEEP}
> > +}
> > +
> > +rproc_start_instances() {
> > +	for instance in ${rproc_instances}; do
> > +		rproc=${RPROC_SYS}/$instance
> > +		rproc_name=$(cat $rproc/name)
> > +		rproc_state=$(cat $rproc/state)
> > +
> > +		echo start > "$rproc/state"
> > +		check_error "$rproc_name state-start failed at state $rproc_state"
> > +	done
> > +	sleep ${RPROC_SEQ_SLEEP}
> > +}
> > +
> > +rproc_seq_test_instance_one() {
> > +	instance=$1
> > +	rproc=${RPROC_SYS}/$instance
> > +	rproc_name=$(cat $rproc/name)
> > +	rproc_state=$(cat $rproc/state)
> > +	ktap_print_msg "Testing rproc sequence for $rproc_name"
> > +
> > +	# Reset test_err value
> > +	test_err=0
> > +
> > +	# Begin start/stop sequence
> > +	echo start > "$rproc/state"
> > +	check_error "$rproc_name state-start failed at state $rproc_state"
> > +
> > +	sleep ${RPROC_SEQ_SLEEP}
> > +
> > +	echo stop > "$rproc/state"
> > +	check_error "$rproc_name state-stop failed at state $rproc_state"
> > +
> > +	if [ $test_err -ne 0 ]; then
> > +		ktap_test_fail "$rproc_name"
> > +	else
> > +		ktap_test_pass "$rproc_name"
> > +	fi
> > +}
> > +
> > +rproc_seq_test_instances_concurrently() {
> > +	# Reset test_err value
> > +	test_err=0
> > +
> > +	rproc_start_instances
> > +
> > +	rproc_stop_instances
> > +
> > +	if [ $test_err -ne 0 ]; then
> > +		ktap_test_fail "for any of $rproc_instances"
> > +	else
> > +		ktap_test_pass "for all $rproc_instances"
> > +	fi
> > +}
> > +
> > +ktap_print_header
> > +
> > +if [ ! -d "${RPROC_SYS}" ]; then
> > +	ktap_skip_all "${RPROC_SYS} doesn't exist."
> > +	exit "${KSFT_SKIP}"
> > +fi
> > +
> > +rproc_instances=$(find ${RPROC_SYS}/remoteproc* -maxdepth 1 -exec basename {} \;)
> > +num_tests=$(echo ${rproc_instances} | wc -w)
> > +if [ "${num_tests}" -eq 0 ]; then
> > +	ktap_skip_all "${RPROC_SYS}/remoteproc* doesn't exist."
> > +	exit "${KSFT_SKIP}"
> > +fi
> > +
> > +# Total tests will be:
> > +# 1) Seq tests for each instance sequencially
> > +# 2) Seq tests for all instances concurrently
> > +num_tests=$((num_tests+1))
> > +
> > +ktap_set_plan "${num_tests}"
> > +
> > +# Stop all instances
> > +rproc_stop_instances
> 
> Will this not fail for remoteproc instances that aren't started
> automatically?
This is don't care case where I only intend to stop previous instances
wherever applicable.

After this I am expecting that all instances will be in stop state so
that I can test start/stop sequence. This is inline to the previous review comments.

I will add comments in code for further clarification.

Thanks & Regards,
Wasim
> 
> Regards,
> Bjorn
> 
> > +
> > +# Test 1
> > +ktap_print_msg "Testing rproc start/stop sequence for each instance sequencially"
> > +for instance in ${rproc_instances}; do
> > +	rproc_seq_test_instance_one $instance
> > +done
> > +
> > +# Test 2
> > +ktap_print_msg "Testing rproc start/stop sequence for all instances concurrently"
> > +rproc_seq_test_instances_concurrently
> > +
> > +# Restore all instances
> > +rproc_start_instances
> > +
> > +ktap_finished
> > --
> > 2.46.1
> > 
> 

