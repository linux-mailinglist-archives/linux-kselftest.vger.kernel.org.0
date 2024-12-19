Return-Path: <linux-kselftest+bounces-23619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E649F8625
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA74F16CCF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B511D63D1;
	Thu, 19 Dec 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O8rcKaAs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DD1D3582;
	Thu, 19 Dec 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641000; cv=none; b=ELnxXJ0ZomhZ50ODpQuvnyGLuoumDCSvfkqaOZP0BV2deGrzrHVyN9ByN0yryYV9ry5Rt+Z8EFqRRwiMbLkKUtjWg8hCP4OFO9SZru8aV6yUtTxSF4B8w0zohD/nZ7Ww0U8zQxDo1DRlyT0ZjxohZ9s76NXCoHBn2PCtrXEKAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641000; c=relaxed/simple;
	bh=Aw0ygaTgXE8shj74qZIYsfpAaIwxFnzyySU10omah6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVLYSQ7KKF+/HT3dgpXdWE7K5bSs1oM/P/W6a01he8c1HbzqDgBKVXj+8wDH3P/OnJZCkXdFGH3z5HXHXqcSZ53CMuBBWsxG1fAt7oSyscjAcMxcd3eqJxy4Kt4Iap+NLRKwgcdjcpkHZIxOGCHVpRmCfw5OsTrQthkHHlWhPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O8rcKaAs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJJrTfj024244;
	Thu, 19 Dec 2024 20:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A9KLcfHAemRRS1s4tP3cKSagcyHYfQ+dNOBZUMh27rI=; b=O8rcKaAs+yti+Oz/
	Xq3q++2EIHcTc32E29paYw2EsP9V/0xkBj7QcOS4bYJ+LEuYnGWca5Z81xoXEtiB
	KJT+ymQg8j0VYV+wjS8DzvBOZdJV2rrCgxuPHRY1BUapx2xb9Qbn5pgwrVazn1EO
	T+fUrbQC70Pb3fAFkUmhV984Eqzt0olf3y80YZdTcJs4uj1kU0rFej5Jm7lvbL2D
	zSgakloFno29D2Zhcu6e0XSV00WbLoXEOhEFk3ohh77UZNdNN4oj5WOkL6KtMw0g
	QYM2cn7kt2adtPwL9iQF2uH8ZtNOqpVlhTPGQ89pVOCrDySokUyRqCOaKwacUbB5
	qhyr2Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mt1wr32y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 20:42:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJKgwpS008071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 20:42:58 GMT
Received: from PHILBER.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 12:42:52 -0800
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
Subject: [RFC PATCH 2/2] virtio_rtc: Support PTP_SYS_OFFSET_STAT ioctl
Date: Thu, 19 Dec 2024 21:42:04 +0100
Message-ID: <20241219204208.3160-3-quic_philber@quicinc.com>
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
X-Proofpoint-GUID: kZi1uzOJnq87MzXwLdEbElKHqTFgiQiO
X-Proofpoint-ORIG-GUID: kZi1uzOJnq87MzXwLdEbElKHqTFgiQiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190164

Support the new PTP_SYS_OFFSET_STAT ioctl. The virtio-rtc cross-timestamp
status information is aligned with the PTP_SYS_OFFSET_STAT output, so the
conversion is trivial.

Drop the getcrosststamp op implementation, for which the PTP clock core
will insert a getstattstamp wrapper.

Signed-off-by: Peter Hilber <quic_philber@quicinc.com>
---
 drivers/virtio/Kconfig               |   4 +-
 drivers/virtio/virtio_rtc_driver.c   | 122 ++++++++++++++++++++++++++-
 drivers/virtio/virtio_rtc_internal.h |   3 +-
 drivers/virtio/virtio_rtc_ptp.c      |  25 +++---
 4 files changed, 140 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6db5235a7693..7cb8b761eaa1 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -230,8 +230,8 @@ config VIRTIO_RTC_ARM
 	 This enables Virtio RTC cross-timestamping using the Arm Generic Timer.
 	 It only has an effect if the Virtio RTC device also supports this. The
 	 cross-timestamp is available through the PTP clock driver precise
-	 cross-timestamp ioctl (PTP_SYS_OFFSET_PRECISE2 aka
-	 PTP_SYS_OFFSET_PRECISE).
+	 cross-timestamp ioctls (PTP_SYS_OFFSET_PRECISE2 aka
+	 PTP_SYS_OFFSET_PRECISE, PTP_SYS_OFFSET_STAT).
 
 	 If unsure, say Y.
 
diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index f8b890afc528..055aa1166519 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/ptp_clock.h>
 
 #include <uapi/linux/virtio_rtc.h>
 
@@ -617,16 +618,22 @@ int viortc_read(struct viortc_dev *viortc, u16 vio_clk_id, u64 *reading)
  * @hw_counter: virtio_rtc HW counter type
  * @reading: clock reading [ns]
  * @cycles: HW counter cycles during clock reading
+ * @stat_extra: extra information, if non-NULL
  *
  * Context: Process context.
  * Return: Zero on success, negative error code otherwise.
  */
 int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
-		      u64 *reading, u64 *cycles)
+		      u64 *reading, u64 *cycles,
+		      struct ptp_stat_extra *stat_extra)
 {
 	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, VIRTIO_RTC_REQ_READ_CROSS,
 				       struct virtio_rtc_req_read_cross,
 				       struct virtio_rtc_resp_read_cross);
+	struct ptp_clock_accuracy *accuracy;
+	u8 flags, leap, clock_status;
+	u32 smear_offset_nsec;
+	u16 tai_offset_sec;
 	int ret;
 
 	ret = VIORTC_MSG_INIT(hdl, viortc);
@@ -647,6 +654,119 @@ int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
 	VIORTC_MSG_READ(hdl, clock_reading, reading);
 	VIORTC_MSG_READ(hdl, counter_cycles, cycles);
 
+	if (stat_extra) {
+		accuracy = &stat_extra->accuracy;
+
+		VIORTC_MSG_READ(hdl, perf.freq_esterror,
+				&accuracy->freq_esterror);
+		VIORTC_MSG_READ(hdl, perf.freq_maxerror,
+				&accuracy->freq_maxerror);
+		VIORTC_MSG_READ(hdl, perf.time_esterror,
+				&accuracy->time_esterror);
+		VIORTC_MSG_READ(hdl, perf.time_maxerror,
+				&accuracy->time_maxerror);
+
+		VIORTC_MSG_READ(hdl, perf.flags, &flags);
+
+		accuracy->flags = 0;
+
+		if (flags & VIRTIO_RTC_FLAG_FREQ_ESTERROR_VALID)
+			accuracy->flags |= PTP_CLOCK_FREQ_EST_VALID;
+
+		if (flags & VIRTIO_RTC_FLAG_FREQ_MAXERROR_VALID)
+			accuracy->flags |= PTP_CLOCK_FREQ_MAX_VALID;
+
+		if (flags & VIRTIO_RTC_FLAG_TIME_ESTERROR_VALID)
+			accuracy->flags |= PTP_CLOCK_TIME_EST_VALID;
+
+		if (flags & VIRTIO_RTC_FLAG_TIME_MAXERROR_VALID)
+			accuracy->flags |= PTP_CLOCK_TIME_MAX_VALID;
+
+		VIORTC_MSG_READ(hdl, perf.clock_status, &clock_status);
+
+		switch (clock_status) {
+		case VIRTIO_RTC_STATUS_INITIALIZING:
+			accuracy->clock_status = PTP_CLOCK_STATUS_INITIALIZING;
+			break;
+		case VIRTIO_RTC_STATUS_SYNCHRONIZED:
+			accuracy->clock_status = PTP_CLOCK_STATUS_SYNCHRONIZED;
+			break;
+		case VIRTIO_RTC_STATUS_FREERUNNING:
+			accuracy->clock_status = PTP_CLOCK_STATUS_FREERUNNING;
+			break;
+		case VIRTIO_RTC_STATUS_UNRELIABLE:
+			accuracy->clock_status = PTP_CLOCK_STATUS_UNRELIABLE;
+			break;
+		default:
+			accuracy->clock_status = PTP_CLOCK_STATUS_UNKNOWN;
+			break;
+		}
+
+		VIORTC_MSG_READ(hdl, leap_info.flags, &flags);
+
+		stat_extra->flags = 0;
+
+		if (flags & VIRTIO_RTC_FLAG_LEAP_VALID)
+			stat_extra->flags |= PTP_CLOCK_LEAP_VALID;
+
+		if (flags & VIRTIO_RTC_FLAG_TAI_OFFSET_VALID)
+			stat_extra->flags |= PTP_CLOCK_TAI_OFFSET_VALID;
+
+		if (flags & VIRTIO_RTC_FLAG_SMEAR_OFFSET_VALID)
+			stat_extra->flags |= PTP_CLOCK_SMEAR_OFFSET_VALID;
+
+		VIORTC_MSG_READ(hdl, leap_info.leap, &leap);
+
+		switch (leap) {
+		case VIRTIO_RTC_LEAP_NONE:
+			stat_extra->leap = PTP_LEAP_NONE;
+			break;
+		case VIRTIO_RTC_LEAP_PRE_POS:
+			stat_extra->leap = PTP_LEAP_PRE_POS;
+			break;
+		case VIRTIO_RTC_LEAP_PRE_NEG:
+			stat_extra->leap = PTP_LEAP_PRE_NEG;
+			break;
+		case VIRTIO_RTC_LEAP_POS:
+			stat_extra->leap = PTP_LEAP_POS;
+			break;
+		case VIRTIO_RTC_LEAP_POST_POS:
+			stat_extra->leap = PTP_LEAP_POST_POS;
+			break;
+		case VIRTIO_RTC_LEAP_POST_NEG:
+			stat_extra->leap = PTP_LEAP_POST_NEG;
+			break;
+		case VIRTIO_RTC_LEAP_SMEAR_PRE_POS:
+			stat_extra->leap = PTP_LEAP_SMEAR_PRE_POS;
+			break;
+		case VIRTIO_RTC_LEAP_SMEAR_PRE_NEG:
+			stat_extra->leap = PTP_LEAP_SMEAR_PRE_NEG;
+			break;
+		case VIRTIO_RTC_LEAP_SMEAR_POS:
+			stat_extra->leap = PTP_LEAP_SMEAR_POS;
+			break;
+		case VIRTIO_RTC_LEAP_SMEAR_NEG:
+			stat_extra->leap = PTP_LEAP_SMEAR_NEG;
+			break;
+		case VIRTIO_RTC_LEAP_SMEAR_POST_POS:
+			stat_extra->leap = PTP_LEAP_SMEAR_POST_POS;
+			break;
+		case VIRTIO_RTC_LEAP_SMEAR_POST_NEG:
+			stat_extra->leap = PTP_LEAP_SMEAR_POST_NEG;
+			break;
+		default:
+			ret = -EINVAL;
+			goto out_release;
+		}
+
+		VIORTC_MSG_READ(hdl, leap_info.tai_offset_sec, &tai_offset_sec);
+		stat_extra->tai_offset_sec = (s16)tai_offset_sec;
+
+		VIORTC_MSG_READ(hdl, leap_info.smear_offset_nsec,
+				&smear_offset_nsec);
+		stat_extra->smear_offset_nsec = (s32)smear_offset_nsec;
+	}
+
 out_release:
 	viortc_msg_release(VIORTC_MSG(hdl));
 
diff --git a/drivers/virtio/virtio_rtc_internal.h b/drivers/virtio/virtio_rtc_internal.h
index e7f865259afd..ab998e033f07 100644
--- a/drivers/virtio/virtio_rtc_internal.h
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -20,7 +20,8 @@ struct viortc_dev;
 
 int viortc_read(struct viortc_dev *viortc, u16 vio_clk_id, u64 *reading);
 int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
-		      u64 *reading, u64 *cycles);
+		      u64 *reading, u64 *cycles,
+		      struct ptp_stat_extra *stat_extra);
 int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
 		     bool *supported);
 int viortc_read_alarm(struct viortc_dev *viortc, u16 vio_clk_id,
diff --git a/drivers/virtio/virtio_rtc_ptp.c b/drivers/virtio/virtio_rtc_ptp.c
index 09f5a9adf2e4..1a02ee3121d9 100644
--- a/drivers/virtio/virtio_rtc_ptp.c
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -79,6 +79,7 @@ static int viortc_ptp_get_time_fn(ktime_t *device_time,
  * @hw_counter: virtio_rtc HW counter type
  * @cs_id: clocksource id corresponding to hw_counter
  * @ctx: context for get_device_system_crosststamp()
+ * @stat_extra: extra information, if non-NULL
  *
  * Reads HW-specific crosststamp from device.
  *
@@ -87,7 +88,8 @@ static int viortc_ptp_get_time_fn(ktime_t *device_time,
  */
 static int viortc_ptp_do_xtstamp(struct viortc_ptp_clock *vio_ptp,
 				 u8 hw_counter, enum clocksource_ids cs_id,
-				 struct viortc_ptp_cross_ctx *ctx)
+				 struct viortc_ptp_cross_ctx *ctx,
+				 struct ptp_stat_extra *stat_extra)
 {
 	u64 ns;
 	u64 max_ns;
@@ -96,8 +98,8 @@ static int viortc_ptp_do_xtstamp(struct viortc_ptp_clock *vio_ptp,
 	ctx->system_counterval.cs_id = cs_id;
 
 	ret = viortc_read_cross(vio_ptp->viortc, vio_ptp->vio_clk_id,
-				hw_counter, &ns,
-				&ctx->system_counterval.cycles);
+				hw_counter, &ns, &ctx->system_counterval.cycles,
+				stat_extra);
 	if (ret)
 		return ret;
 
@@ -115,15 +117,17 @@ static int viortc_ptp_do_xtstamp(struct viortc_ptp_clock *vio_ptp,
  */
 
 /**
- * viortc_ptp_getcrosststamp() - PTP clock getcrosststamp op
+ * viortc_ptp_getstattstamp() - PTP clock getcrosststamp with extras op
  * @ptp: PTP clock info
  * @xtstamp: crosststamp
+ * @stat_extra: extra information, if non-NULL
  *
  * Context: Process context.
  * Return: Zero on success, negative error code otherwise.
  */
-static int viortc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
-				     struct system_device_crosststamp *xtstamp)
+static int viortc_ptp_getstattstamp(struct ptp_clock_info *ptp,
+				    struct system_device_crosststamp *xtstamp,
+				    struct ptp_stat_extra *stat_extra)
 {
 	struct viortc_ptp_clock *vio_ptp =
 		container_of(ptp, struct viortc_ptp_clock, ptp_info);
@@ -152,7 +156,8 @@ static int viortc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 	 *
 	 * So, get the actual cross-timestamp first.
 	 */
-	ret = viortc_ptp_do_xtstamp(vio_ptp, hw_counter, cs_id, &ctx);
+	ret = viortc_ptp_do_xtstamp(vio_ptp, hw_counter, cs_id, &ctx,
+				    stat_extra);
 	if (ret)
 		return ret;
 
@@ -225,7 +230,7 @@ static int viortc_ptp_enable(struct ptp_clock_info *ptp,
  *
  * The .name member will be set for individual virtio_rtc PTP clocks.
  *
- * The .getcrosststamp member will be cleared for PTP clocks not supporting
+ * The .getstattstamp member will be cleared for PTP clocks not supporting
  * crosststamp.
  */
 static const struct ptp_clock_info viortc_ptp_info_template = {
@@ -236,7 +241,7 @@ static const struct ptp_clock_info viortc_ptp_info_template = {
 	.gettimex64 = viortc_ptp_gettimex64,
 	.settime64 = viortc_ptp_settime64,
 	.enable = viortc_ptp_enable,
-	.getcrosststamp = viortc_ptp_getcrosststamp,
+	.getstattstamp = viortc_ptp_getstattstamp,
 };
 
 /**
@@ -329,7 +334,7 @@ struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
 		goto err_free_dev;
 
 	if (!vio_ptp->have_cross)
-		vio_ptp->ptp_info.getcrosststamp = NULL;
+		vio_ptp->ptp_info.getstattstamp = NULL;
 
 	ptp_clock = ptp_clock_register(&vio_ptp->ptp_info, parent_dev);
 	if (IS_ERR(ptp_clock))
-- 
2.43.0


