Return-Path: <linux-kselftest+bounces-23618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B349F8627
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7170918860C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D11C5CC5;
	Thu, 19 Dec 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UgdvL+RL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16741B86DC;
	Thu, 19 Dec 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640997; cv=none; b=LEyb8avcJGmfCjej3dxU0yYdokziLzt6Jc40Xr6kBIkEyjpZneWulxrNMsc/oZJ6wIu0lgz1xHCvGITNqV6lGVx6EDSJcQL36Eq0vDpDF06UJ1VVIdmxY+1WWn5QnauqjIxrgMgmHMLe0GBeZVQUaiOMHUhLn0ZFbp1MmuIDreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640997; c=relaxed/simple;
	bh=P9HzbSF30OIDLKRJBkedgkfu0tge/oqlJ+KFo/hOKKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhWwmhmEuWVzsk7NN3dcRxMT9bnRVMAUSGqGkW0u3ieBXe3L9SubMRvCXK5ZtqdYnLMNNOgC1CjkiEhCVEMuFoYfSmbtG11OgiK899ChJ1A9UYTgGRAvQTiKPtsq+SNVVuKRVQSJu27DdROeLR+deGC5jO4IN1yAXBRv8suQtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UgdvL+RL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJKO7DB032487;
	Thu, 19 Dec 2024 20:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xGVrMfsrTZqnsZDPjNEvRZ2PPL5DYkGsFfQbgqHvJ70=; b=UgdvL+RLE65JWO1U
	tV6N0GHOA7qLZCqJ/rPWnD2nwLvzDPCoCd9axmGT95W46aEn3ODYNUhVNkODJN1E
	w3AdoKU0cBu8+RQ/Ho8qg+Pt2gVT/vKCiZmfag0RO7HMw2BGRrUOvfidNzoAL/lP
	eWcGuigpgNFSzdGHdhBMc+ebAoIGSKcCoaNa/47avtI+UH9yp+gDaoBGP/7R1MUo
	FriQtsiGTC/uh+Oi8bQW971de7Ch+BafEOKu20f77lbLKBga3jbzW6pah1/B+PzD
	enXJrNSzID9TYYGNdU8ROgu4jW5ULq7deVMv/IeleRdE6WccJneA5dPgoYDarJCC
	KsBcNw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mh3y9mwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 20:42:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJKgpEE011412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 20:42:51 GMT
Received: from PHILBER.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 12:42:45 -0800
From: Peter Hilber <quic_philber@quicinc.com>
To: <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <virtio-dev@lists.linux.dev>, <netdev@vger.kernel.org>
CC: Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Peter Hilber <quic_philber@quicinc.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shuah Khan
	<shuah@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <linux-kselftest@vger.kernel.org>, <linux-api@vger.kernel.org>,
        "David
 Woodhouse" <dwmw2@infradead.org>,
        "Ridoux, Julien" <ridouxj@amazon.com>,
        "John Stultz" <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Anna-Maria Behnsen
	<anna-maria@linutronix.de>
Subject: [RFC PATCH 1/2] ptp: add PTP_SYS_OFFSET_STAT for xtstamping with status
Date: Thu, 19 Dec 2024 21:42:03 +0100
Message-ID: <20241219204208.3160-2-quic_philber@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219204208.3160-1-quic_philber@quicinc.com>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d27hBBNNYP8kZWAYvrBJHDY9e01bsdxR
X-Proofpoint-GUID: d27hBBNNYP8kZWAYvrBJHDY9e01bsdxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190164

Ioctl PTP_SYS_OFFSET_PRECISE2 provides cross-timestamping of device time
and system time. This can be used for virtualization where (virtualization)
host and guest refer to the same clocksource. It may be preferred to
indicate UTC time, rather than TAI. It is then useful to indicate when and
how the host processes UTC leap seconds (stepping or smearing on leap
seconds), in particular if the guest is not guaranteed to have an
up-to-date Time Zone Database or similar.

Also, a host may have a notion of how accurate its clock is w.r.t. the
hosts' reference clocks.

Add a new ioctl PTP_SYS_OFFSET_STAT, which can convey, in addition to the
cross-timestamp:

- leap second related status,

- clock accuracy.

Reserve space for more information.

Drivers indicate through flags which status information is valid. A driver
zeroing struct ptp_stat_extra would only provide the
PTP_SYS_OFFSET_PRECISE2 information. Drivers implementing the backing
getstattstamp op will automatically also support PTP_SYS_OFFSET_PRECISE2.

Indicate support of the new ioctl in the capability ioctl
(PTP_CLOCK_GETCAPS2). Extend the testptp program with the new ioctl.

Users
=====

The status information corresponds to the information conveyed in the
virtio-rtc spec RFC v6 [1].

The RFC virtio_rtc driver implements the getstattstamp op backing the new
ioctl. I locally patched the chrony time sync daemon to process both the
leap second indication (when leap seconds are not smeared) and the TAI
offset indication.

The other status information is not yet used by general-purpose tools, but
can be helpful for custom use cases.

There is even more clock status information which might be added [2] to
virtio_rtc, but which has not been formally proposed so far.

Discussion
==========

This is intended to solicit comments about

- which status information is useful to third parties (in particular w.r.t.
  leap second smearing and clock accuracy)

- the most appropriate format to expose status information for
  virtualization related PHCs.

I am aware that adding support for independent PTP clocks is in progress,
but couldn't yet see any clash with this.

Alternatives
------------

An essential part of the status information could alternatively be conveyed
through clock_adjtime(2). However, struct timex should then be extended
with a system clock timestamp, which would eat a lot of padding bytes.

PTP_SYS_OFFSET_PRECISE2 only has 16 reserved bytes, so could at most add
leap second related information, which does appear unneeded for not
virtualization related use cases.

Splitting up time and leap second status retrieval to multiple syscalls
might lead to multiple requests to the device, and to race conditions.

TBD
===

- Dissect new ioctl flags in testptp.

[1] https://lore.kernel.org/virtio-comment/20241206094819.858-1-quic_philber@quicinc.com/T/#t
[2] cf. struct vmclock_abi in https://lore.kernel.org/all/78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org/

Signed-off-by: Peter Hilber <quic_philber@quicinc.com>
---
 drivers/ptp/ptp_chardev.c             |  39 ++++++++
 drivers/ptp/ptp_clock.c               |   9 ++
 include/linux/ptp_clock_kernel.h      |  31 ++++++
 include/uapi/linux/ptp_clock.h        | 130 +++++++++++++++++++++++++-
 tools/testing/selftests/ptp/Makefile  |   2 +-
 tools/testing/selftests/ptp/testptp.c | 126 ++++++++++++++++++++++++-
 6 files changed, 331 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index ea96a14d72d1..c87062a5a568 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -165,8 +165,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
+	struct ptp_sys_offset_stat stat_offset;
 	struct ptp_sys_offset *sysoff = NULL;
 	struct timestamp_event_queue *tsevq;
+	struct ptp_stat_extra stat_extra;
 	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
 	struct ptp_clock_caps caps;
@@ -195,6 +197,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 				    ptp->info->getmaxphase != NULL;
 		if (caps.adjust_phase)
 			caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
+		caps.stat_timestamping = ptp->info->getstattstamp != NULL;
 		if (copy_to_user((void __user *)arg, &caps, sizeof(caps)))
 			err = -EFAULT;
 		break;
@@ -347,6 +350,42 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			err = -EFAULT;
 		break;
 
+	case PTP_SYS_OFFSET_STAT:
+		if (!ptp->info->getstattstamp) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		memset(&stat_extra, 0, sizeof(stat_extra));
+
+		err = ptp->info->getstattstamp(ptp->info, &xtstamp,
+					       &stat_extra);
+		if (err)
+			break;
+
+		memset(&stat_offset, 0, sizeof(stat_offset));
+
+		ts = ktime_to_timespec64(xtstamp.device);
+		stat_offset.device.sec = ts.tv_sec;
+		stat_offset.device.nsec = ts.tv_nsec;
+		ts = ktime_to_timespec64(xtstamp.sys_realtime);
+		stat_offset.sys_realtime.sec = ts.tv_sec;
+		stat_offset.sys_realtime.nsec = ts.tv_nsec;
+		ts = ktime_to_timespec64(xtstamp.sys_monoraw);
+		stat_offset.sys_monoraw.sec = ts.tv_sec;
+		stat_offset.sys_monoraw.nsec = ts.tv_nsec;
+
+		stat_offset.accuracy = stat_extra.accuracy;
+		stat_offset.flags = stat_extra.flags;
+		stat_offset.leap = stat_extra.leap;
+		stat_offset.tai_offset_sec = stat_extra.tai_offset_sec;
+		stat_offset.smear_offset_nsec = stat_extra.smear_offset_nsec;
+
+		if (copy_to_user((void __user *)arg, &stat_offset,
+				 sizeof(stat_offset)))
+			err = -EFAULT;
+		break;
+
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:
 		if (!ptp->info->gettimex64) {
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index b932425ddc6a..3b08d133c2bb 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -209,6 +209,12 @@ static void ptp_clock_release(struct device *dev)
 	kfree(ptp);
 }
 
+static int ptp_getcrosststamp_from_stat(struct ptp_clock_info *info,
+					struct system_device_crosststamp *cts)
+{
+	return info->getstattstamp(info, cts, NULL);
+}
+
 static int ptp_getcycles64(struct ptp_clock_info *info, struct timespec64 *ts)
 {
 	if (info->getcyclesx64)
@@ -279,6 +285,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->n_vclocks_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
 
+	if (ptp->info->getstattstamp && !ptp->info->getcrosststamp)
+		ptp->info->getcrosststamp = ptp_getcrosststamp_from_stat;
+
 	if (ptp->info->getcycles64 || ptp->info->getcyclesx64) {
 		ptp->has_cycles = true;
 		if (!ptp->info->getcycles64 && ptp->info->getcyclesx64)
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 0d68d09bedd1..9b08cbd747ae 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -55,6 +55,25 @@ struct ptp_system_timestamp {
 	clockid_t clockid;
 };
 
+/**
+ * struct ptp_stat_extra - extra clock status
+ *
+ * @accuracy:          Accuracy of the clock at the time of reading.
+ * @flags:             Same flags as struct ptp_sys_offset_stat.
+ * @leap:              One of the ptp_utc_leap enumeration values.
+ * @tai_offset_sec:    Offset of TAI from UTC at the time of clock reading,
+ *                     in the form TAI - UTC.
+ * @smear_offset_nsec: Offset of smeared clock from UTC at the time of
+ *                     clock reading, in the form UTC - smeared clock.
+ */
+struct ptp_stat_extra {
+	struct ptp_clock_accuracy accuracy;
+	unsigned int flags;
+	unsigned int leap;
+	int tai_offset_sec;
+	int smear_offset_nsec;
+};
+
 /**
  * struct ptp_clock_info - describes a PTP hardware clock
  *
@@ -109,6 +128,15 @@ struct ptp_system_timestamp {
  *                   parameter cts: Contains timestamp (device,system) pair,
  *                   where system time is realtime and monotonic.
  *
+ * @getstattstamp:  Reads the current time from the hardware clock and system
+ *                  clock simultaneously, optionally with extra status
+ *                  information.
+ *                  parameter cts: Contains timestamp (device,system) pair,
+ *                  where system time is realtime and monotonic.
+ *                  parameter stat_extra: If not NULL, it holds extra status
+ *                  information. Drivers indicate information validity through
+ *                  flags.
+ *
  * @settime64:  Set the current time on the hardware clock.
  *              parameter ts: Time value to set.
  *
@@ -184,6 +212,9 @@ struct ptp_clock_info {
 			  struct ptp_system_timestamp *sts);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
+	int (*getstattstamp)(struct ptp_clock_info *ptp,
+			     struct system_device_crosststamp *cts,
+			     struct ptp_stat_extra *stat_extra);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
 	int (*getcycles64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*getcyclesx64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 18eefa6d93d6..c26f48967b41 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -103,7 +103,12 @@ struct ptp_clock_caps {
 	/* Whether the clock supports adjust phase */
 	int adjust_phase;
 	int max_phase_adj; /* Maximum phase adjustment in nanoseconds. */
-	int rsv[11];       /* Reserved for future use. */
+	/*
+	 * Whether the clock supports precise system-device cross timestamps
+	 * with extra status information.
+	 */
+	int stat_timestamping;
+	int rsv[10];       /* Reserved for future use. */
 };
 
 struct ptp_extts_request {
@@ -184,6 +189,128 @@ struct ptp_sys_offset_precise {
 	unsigned int rsv[4];    /* Reserved for future use. */
 };
 
+/*
+ * Bits of the ptp_clock_accuracy.flags field:
+ */
+#define PTP_CLOCK_FREQ_EST_VALID (1 << 0)
+#define PTP_CLOCK_FREQ_MAX_VALID (1 << 1)
+#define PTP_CLOCK_TIME_EST_VALID (1 << 2)
+#define PTP_CLOCK_TIME_MAX_VALID (1 << 3)
+
+enum ptp_clock_status {
+	PTP_CLOCK_STATUS_UNKNOWN,
+	PTP_CLOCK_STATUS_INITIALIZING,
+	PTP_CLOCK_STATUS_SYNCHRONIZED,
+	PTP_CLOCK_STATUS_FREERUNNING,
+	PTP_CLOCK_STATUS_UNRELIABLE,
+};
+
+struct ptp_clock_accuracy {
+	/*
+	 * Estimated (absolute) drift rate, in ppm, with a 44-bit fractional
+	 * part. Field value 1 corresponds to 2^-44 ppm.
+	 *
+	 * Valid if flag PTP_CLOCK_FREQ_EST_VALID is set.
+	 */
+	unsigned long long freq_esterror;
+	/*
+	 * Maximum (absolute) drift rate, in ppm, with a 44-bit fractional
+	 * part.
+	 *
+	 * Valid if flag PTP_CLOCK_FREQ_MAX_VALID is set.
+	 */
+	unsigned long long freq_maxerror;
+	/*
+	 * Estimate of absolute value of offset from reference, in nsec.
+	 *
+	 * Valid if flag PTP_CLOCK_TIME_EST_VALID is set.
+	 */
+	unsigned long long time_esterror;
+	/*
+	 * Maximum of absolute value of offset from reference, in nsec.
+	 *
+	 * Valid if flag PTP_CLOCK_TIME_MAX_VALID is set.
+	 */
+	unsigned long long time_maxerror;
+	/* PTP_CLOCK_(FREQ|TIME)_*_VALID flags. */
+	unsigned int flags;
+	/* PTP_CLOCK_STATUS_* enum value. */
+	unsigned int clock_status;
+};
+
+/*
+ * Bits of the ptp_sys_offset_stat.flags field:
+ */
+#define PTP_CLOCK_LEAP_VALID         (1 << 0)
+#define PTP_CLOCK_TAI_OFFSET_VALID   (1 << 1)
+#define PTP_CLOCK_SMEAR_OFFSET_VALID (1 << 2)
+
+enum ptp_utc_leap {
+	/* No leap second in the present, near future, or near past. */
+	PTP_LEAP_NONE,
+	/* Positive leap second happens in the near future. */
+	PTP_LEAP_PRE_POS,
+	/* Negative leap second happens in the near future. */
+	PTP_LEAP_PRE_NEG,
+	/* Positive leap second is in progress. */
+	PTP_LEAP_POS,
+	/* Positive leap second happened recently. */
+	PTP_LEAP_POST_POS,
+	/* Negative leap second happened recently. */
+	PTP_LEAP_POST_NEG,
+	/*
+	 * Positive leap second will be smeared into the clock in the near
+	 * future.
+	 */
+	PTP_LEAP_SMEAR_PRE_POS,
+	/*
+	 * Negative leap second will be smeared into the clock in the near
+	 * future.
+	 */
+	PTP_LEAP_SMEAR_PRE_NEG,
+	/* Positive leap second is being smeared into the clock. */
+	PTP_LEAP_SMEAR_POS,
+	/* Negative leap second is being smeared into the clock. */
+	PTP_LEAP_SMEAR_NEG,
+	/* Positive leap second was smeared into the clock recently. */
+	PTP_LEAP_SMEAR_POST_POS,
+	/* Negative leap second was smeared into the clock recently. */
+	PTP_LEAP_SMEAR_POST_NEG,
+};
+
+/*
+ * Precise system-device cross timestamp with extra info.
+ */
+struct ptp_sys_offset_stat {
+	struct ptp_clock_time device;
+	struct ptp_clock_time sys_realtime;
+	struct ptp_clock_time sys_monoraw;
+	struct ptp_clock_accuracy accuracy;
+	unsigned int flags;
+	/*
+	 * One of the ptp_utc_leap enumeration values.
+	 *
+	 * Valid if flag PTP_CLOCK_LEAP_VALID is set.
+	 */
+	unsigned int leap;
+	/*
+	 * Offset of TAI from UTC at the time of clock reading, in the form
+	 * TAI - UTC.
+	 *
+	 * Valid if flag PTP_CLOCK_TAI_OFFSET_VALID is set.
+	 */
+	int tai_offset_sec;
+	/*
+	 * Offset of smeared clock from UTC at the time of clock reading, in
+	 * the form UTC - smeared clock.
+	 *
+	 * Valid if flag PTP_CLOCK_SMEAR_OFFSET_VALID is set.
+	 */
+	int smear_offset_nsec;
+	/* Reserved for future use. */
+	unsigned int rsv[22];
+};
+
 enum ptp_pin_function {
 	PTP_PF_NONE,
 	PTP_PF_EXTTS,
@@ -245,6 +372,7 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
 #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
+#define PTP_SYS_OFFSET_STAT _IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_stat)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occurred. */
diff --git a/tools/testing/selftests/ptp/Makefile b/tools/testing/selftests/ptp/Makefile
index 8f57f88ecadd..3fa960c72337 100644
--- a/tools/testing/selftests/ptp/Makefile
+++ b/tools/testing/selftests/ptp/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := testptp
-LDLIBS += -lrt
+LDLIBS += -lrt -lm
 TEST_PROGS = phc.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 58064151f2c8..7d09f4b9272e 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -37,6 +37,8 @@
 
 #define NSEC_PER_SEC 1000000000LL
 
+#define STAT_FRACTIONAL_BITS 44
+
 /* clock_adjtime is not available in GLIBC < 2.14 */
 #if !__GLIBC_PREREQ(2, 14)
 #include <sys/syscall.h>
@@ -147,6 +149,7 @@ static void usage(char *progname)
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
 		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
+		" -Y         get a ptp clock cross timestamp with extra status information\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -164,6 +167,8 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_sys_offset_stat *sts;
+	struct ptp_clock_accuracy *accuracy;
 
 	char *progname;
 	unsigned int i;
@@ -184,6 +189,7 @@ int main(int argc, char *argv[])
 	int pct_offset = 0;
 	int getextended = 0;
 	int getcross = 0;
+	int getstat = 0;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -191,6 +197,7 @@ int main(int argc, char *argv[])
 	int settime = 0;
 	int channel = -1;
 	clockid_t ext_clockid = CLOCK_REALTIME;
+	double freq_ppm_mult;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -200,7 +207,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:Yz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -294,7 +301,9 @@ int main(int argc, char *argv[])
 				return -1;
 			}
 			break;
-
+		case 'Y':
+			getstat = 1;
+			break;
 		case 'z':
 			flagtest = 1;
 			break;
@@ -333,7 +342,8 @@ int main(int argc, char *argv[])
 			       "  %d programmable pins\n"
 			       "  %d cross timestamping\n"
 			       "  %d adjust_phase\n"
-			       "  %d maximum phase adjustment (ns)\n",
+			       "  %d maximum phase adjustment (ns)\n"
+			       "  %d cross timestamping with extra status\n",
 			       caps.max_adj,
 			       caps.n_alarm,
 			       caps.n_ext_ts,
@@ -342,7 +352,8 @@ int main(int argc, char *argv[])
 			       caps.n_pins,
 			       caps.cross_timestamping,
 			       caps.adjust_phase,
-			       caps.max_phase_adj);
+			       caps.max_phase_adj,
+			       caps.stat_timestamping);
 		}
 	}
 
@@ -661,6 +672,113 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (getstat) {
+		sts = calloc(1, sizeof(*sts));
+		if (!sts) {
+			perror("calloc");
+			return -1;
+		}
+
+		if (ioctl(fd, PTP_SYS_OFFSET_STAT, sts)) {
+			perror("PTP_SYS_OFFSET_STAT");
+		} else {
+			puts("system and phc crosstimestamping with extra status request okay");
+
+			printf("device time: %lld.%09u\n",
+			       sts->device.sec, sts->device.nsec);
+			printf("system time: %lld.%09u\n",
+			       sts->sys_realtime.sec, sts->sys_realtime.nsec);
+			printf("monoraw time: %lld.%09u\n",
+			       sts->sys_monoraw.sec, sts->sys_monoraw.nsec);
+
+			accuracy = &sts->accuracy;
+			freq_ppm_mult = pow(2, -STAT_FRACTIONAL_BITS);
+			printf("est. frequency error: %e ppm\n",
+			       accuracy->freq_esterror * freq_ppm_mult);
+			printf("max. frequency error: %e ppm\n",
+			       accuracy->freq_maxerror * freq_ppm_mult);
+			printf("est. time error: %llu.%09llu\n",
+			       accuracy->time_esterror / NSEC_PER_SEC,
+			       accuracy->time_esterror % NSEC_PER_SEC);
+			printf("max. time error: %llu.%09llu\n",
+			       accuracy->time_maxerror / NSEC_PER_SEC,
+			       accuracy->time_maxerror % NSEC_PER_SEC);
+			printf("accuracy flags: 0x%x\n", accuracy->flags);
+
+			switch (accuracy->clock_status) {
+			case PTP_CLOCK_STATUS_UNKNOWN:
+				printf("status: unknown\n");
+				break;
+			case PTP_CLOCK_STATUS_INITIALIZING:
+				printf("status: initializing\n");
+				break;
+			case PTP_CLOCK_STATUS_SYNCHRONIZED:
+				printf("status: synchronized\n");
+				break;
+			case PTP_CLOCK_STATUS_FREERUNNING:
+				printf("status: free-running\n");
+				break;
+			case PTP_CLOCK_STATUS_UNRELIABLE:
+				printf("status: unreliable\n");
+				break;
+			default:
+				printf("status: ? (0x%x)\n",
+				       accuracy->clock_status);
+				break;
+			}
+
+			printf("flags: 0x%x\n", sts->flags);
+			switch (sts->leap) {
+			case PTP_LEAP_NONE:
+				printf("leap second: none\n");
+				break;
+			case PTP_LEAP_PRE_POS:
+				printf("leap second: pre-announcing positive leap second\n");
+				break;
+			case PTP_LEAP_PRE_NEG:
+				printf("leap second: pre-announcing negative leap second\n");
+				break;
+			case PTP_LEAP_POS:
+				printf("leap second: positive leap second in progress\n");
+				break;
+			case PTP_LEAP_POST_POS:
+				printf("leap second: past positive leap second\n");
+				break;
+			case PTP_LEAP_POST_NEG:
+				printf("leap second: past negative leap second\n");
+				break;
+			case PTP_LEAP_SMEAR_PRE_POS:
+				printf("leap second: pre-announcing smearing for positive leap second\n");
+				break;
+			case PTP_LEAP_SMEAR_PRE_NEG:
+				printf("leap second: pre-announcing smearing for negative leap second\n");
+				break;
+			case PTP_LEAP_SMEAR_POS:
+				printf("leap second: smearing for positive leap second in progress\n");
+				break;
+			case PTP_LEAP_SMEAR_NEG:
+				printf("leap second: smearing for negative leap second in progress\n");
+				break;
+			case PTP_LEAP_SMEAR_POST_POS:
+				printf("leap second: past smearing for positive leap second\n");
+				break;
+			case PTP_LEAP_SMEAR_POST_NEG:
+				printf("leap second: past smearing for negative leap second\n");
+				break;
+			default:
+				printf("leap second: ? (0x%x)\n", sts->leap);
+				break;
+			}
+			printf("tai offset: %d\n", sts->tai_offset_sec);
+			printf("smear offset: %s%d.%09d\n",
+			       sts->smear_offset_nsec < 0 ? "-" : "",
+			       abs(sts->smear_offset_nsec) / (int)NSEC_PER_SEC,
+			       abs(sts->smear_offset_nsec) % (int)NSEC_PER_SEC);
+		}
+
+		free(sts);
+	}
+
 	if (channel >= 0) {
 		if (ioctl(fd, PTP_MASK_CLEAR_ALL)) {
 			perror("PTP_MASK_CLEAR_ALL");
-- 
2.43.0


