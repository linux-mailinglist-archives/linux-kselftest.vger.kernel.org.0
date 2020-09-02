Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF04C25AA7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBLpe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 07:45:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgIBLpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 07:45:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082BfPPb054953;
        Wed, 2 Sep 2020 07:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=T6fpH/Ru1BzDNdcKAGM7+hLUwS8hQAfx6nhqQ2wxrVY=;
 b=ffa/h1AgLMC8JrAIDWuwbfM+9X+NHLkSPSglZb4A7ezU4Tw79UZ+I1C/UWnTeTKvlhYo
 fuj430gezH2eHWnVSxKOXw0oiwgKX8i/eZYytQxkHr3pTc/6l7zmOxxhm8aF0dV5gDIM
 9uAVX/6v6HaOuffcglHh68wu7EXXNRM6fMlfsuCuLmGEfmyXZIqGC1AiN36dY/SSp5LY
 29ReB09NGt5saQDQolMGRJ953Wolm43uobczD4/IEk7RtX8rlDQYRURe3UZSOdnDp6Bn
 y5BM7bvKOLkuFvYxpZKFLbc5sVsLkZVfbPIpuomiskS4fL9Z3uBrtNya8Gd3wXyr0gsV Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33aar302yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 07:45:14 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082BgGmE056911;
        Wed, 2 Sep 2020 07:45:14 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33aar302xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 07:45:14 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082Bh8bh016372;
        Wed, 2 Sep 2020 11:45:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 339ap7s6b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 11:45:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082Bj98u61604268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 11:45:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79B89AE058;
        Wed,  2 Sep 2020 11:45:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAEF0AE055;
        Wed,  2 Sep 2020 11:45:06 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.77.200.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 11:45:06 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, npiggin@gmail.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        psampat@linux.ibm.com
Subject: [RFC v4 0/1] Selftest for cpuidle latency measurement
Date:   Wed,  2 Sep 2020 17:15:05 +0530
Message-Id: <20200902114506.45809-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=913
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020105
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog v3-->v4:
1. Overhaul in implementation from kernel module to a userspace selftest 
---

The patch series introduces a mechanism to measure wakeup latency for
IPI and timer based interrupts
The motivation behind this series is to find significant deviations
behind advertised latency and residency values

To achieve this in the userspace, IPI latencies are calculated by
sending information through pipes and inducing a wakeup, similarly
alarm events are setup for calculate timer based wakeup latencies.

To account for delays from kernel-userspace interactions baseline
observations are taken on a 100% busy CPU and subsequent obervations
must be considered relative to that.

In theory, wakeups induced by IPI and Timers should have similar
wakeup latencies, however in practice there may be deviations which may
need to be captured.

One downside of the userspace approach in contrast to the kernel
implementation is that the run to run variance can turn out to be high
in the order of ms; which is the scope of the experiments at times.

Another downside of the userspace approach is that it takes much longer
to run and hence a command-line option quick and full are added to make
sure quick 1 CPU tests can be carried out when needed and otherwise it
can carry out a full system comprehensive test.

Usage
---
./cpuidle --mode <full / quick / num_cpus> --output <output location> 
full: runs on all CPUS
quick: run on a random CPU
num_cpus: Limit the number of CPUS to run on

Sample output snippet
---------------------
--IPI Latency Test---
SRC_CPU   DEST_CPU IPI_Latency(ns)
...
  0          5       256178
  0          6       478161
  0          7       285445
  0          8       273553
Expected IPI latency(ns): 100000
Observed Average IPI latency(ns): 248334

--Timeout Latency Test--
--Baseline Timeout Latency measurement: CPU Busy--
Wakeup_src Baseline_delay(ns)
...
 32          972405
 33         1004287
 34          986663
 35          994022
Expected timeout(ns): 10000000
Observed Average timeout diff(ns): 991844

Pratik Rajesh Sampat (1):
  selftests/cpuidle: Add support for cpuidle latency measurement

 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/cpuidle/Makefile  |   7 +
 tools/testing/selftests/cpuidle/cpuidle.c | 616 ++++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings  |   1 +
 4 files changed, 625 insertions(+)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100644 tools/testing/selftests/cpuidle/cpuidle.c
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.26.2

