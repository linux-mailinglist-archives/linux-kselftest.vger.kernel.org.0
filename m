Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99045282A91
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Oct 2020 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgJDMLd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Oct 2020 08:11:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgJDMLd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Oct 2020 08:11:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 094C1aeP156881;
        Sun, 4 Oct 2020 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jOstFuoqORVtqsaljM7g8VLIl5jtMfVcSTizc+NICcI=;
 b=pjN+01wJon2rKoKWMLUjiseAfM/TRhMNuSzxh7H7K3kO6MxJdx8Bb7fxZm6rLrhtQtiA
 2QRcQ015RZogxC+RBIl3S6bvJ5SaFRpmYFeEhRtGSC9pM3I3HaflhM2K/hrGS/sFewyQ
 sk7zZrkfvkS8pXti7yemkBBT99ilh6B1184SuwMaS4pxBfFHGwAD1omFGrRMdI6xELp3
 V9+O+Pl+KK54iIej3R3hWhyPTqcaa5jpOdCTfLNbZNhVv0x6ICP96kbDAPnliwNnOuPL
 L/ts/3yPzAnrGt01R/JabFSsyNhRVgblyV40Bxdr1wK2RsPp3GztI3F2bPtZses/WFlV Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ye07r7yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 08:11:23 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 094C8ZSP003197;
        Sun, 4 Oct 2020 08:11:22 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ye07r7x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 08:11:22 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 094C7HpM030756;
        Sun, 4 Oct 2020 12:11:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 33xgx7rk0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 12:11:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 094CBHnP28377564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Oct 2020 12:11:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A3642042;
        Sun,  4 Oct 2020 12:11:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E4404203F;
        Sun,  4 Oct 2020 12:11:15 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.77.207.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  4 Oct 2020 12:11:15 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com, psampat@linux.ibm.com
Subject: [RFC v5 0/1] Selftest for cpuidle latency measurement
Date:   Sun,  4 Oct 2020 17:41:13 +0530
Message-Id: <20201004121114.19043-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-04_09:2020-10-02,2020-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=622 bulkscore=0
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010040089
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v4: https://lkml.org/lkml/2020/9/2/356
v4-->v5
Based on comments from Artem Bityutskiy, evaluation of timer based
wakeup latencies may not be a fruitful measurement especially on the x86
platform which has the capability to pre-arm a CPU when a timer is set.

Hence, including only the IPI based tests for latency measurement to
acheive expected behaviour across platforms.

kernel module + bash selftest approach which presents lower deviations
and higher accuracy: https://lkml.org/lkml/2020/7/21/567
---

The patch series introduces a mechanism to measure wakeup latency for
IPI based interrupts.
The motivation behind this series is to find significant deviations
behind advertised latency values

To achieve this in the userspace, IPI latencies are calculated by
sending information through pipes and inducing a wakeup.

To account for delays from kernel-userspace interactions baseline
observations are taken on a 100% busy CPU and subsequent obervations
must be considered relative to that.

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

Pratik Rajesh Sampat (1):
  selftests/cpuidle: Add support for cpuidle latency measurement

 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/cpuidle/Makefile  |   7 +
 tools/testing/selftests/cpuidle/cpuidle.c | 479 ++++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings  |   1 +
 4 files changed, 488 insertions(+)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100644 tools/testing/selftests/cpuidle/cpuidle.c
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.26.2

