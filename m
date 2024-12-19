Return-Path: <linux-kselftest+bounces-23617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C599F861F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 21:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7F81893865
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA931C07F4;
	Thu, 19 Dec 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hirg2Q7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC53FD1;
	Thu, 19 Dec 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640996; cv=none; b=uGUGMaxOyYw3ytkecGt9YooBFQDPSj6krC4m+wcfSDGZnVFhCvT7oLj/Kbyupm4QBpuhEn5mv0UTgMrPjiZyIGsqCQHU5nkmhGimYn4rAa6azH6QXDCh2/M39dlRTeGX/BaXNl4tVnszR3uukEoYyIEVAMDGV1fU4TVUXaF+zZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640996; c=relaxed/simple;
	bh=SBBbcrBX+Vk77S2+bxd2AMqwNH5jo2J+2V2RaUvSlEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lY300EXKB8psj5nrx8JDmy9FHxD2Qqz1p96IQhAUhywCnhXGfbfu3IGCgVH9QOPht2ATlvn3UkJpSRlKsqToMofNr/nvYQT5hUPboV+N4V4LNj4D7W9m9y8mNSGevh/Cu08nC6kZWvew6tv0gd9A0y9mAesT5xtTF/ZccgzDwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hirg2Q7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJHKrH1015075;
	Thu, 19 Dec 2024 20:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JDSWUwXe1gR2On55ugw/yZ
	9uh7N0B2gfTrX8HgykqsU=; b=Hirg2Q7IRSLIxdVty0Fipom/WtEnyN4O1upYOS
	xM3K0d+B6s6LrbZU8tVFFie4Au0pRkfrzrkEg4DcFs8Bd/wTf3fLN9bVpY0R/L2V
	B43Xy+s4BYFL+i2NIDhgCgVLRgLa7c2kE2WYInJuoiGEZY/MJoyHlEXd2VdCXMpC
	Vqhaf/KeF+2XzjEn1Xpl4irLcCQvyTDFmEUdyjvDYEflPap6jGZHtIDS2pAgVvdA
	jMTZb7GHzM7D3MC1/WUFAcVTJGtAqX1i33ClkcP/FksqBnjjtzKatuLUAhy3PVua
	BHssxdZOj2VOzeXDDatJ0v31N/gfBTnvkvruG1dJ/uicnssw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mqt80dtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 20:42:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJKgi9a011364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 20:42:44 GMT
Received: from PHILBER.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 12:42:39 -0800
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
Subject: [RFC PATCH 0/2] ptp: add PTP_SYS_OFFSET_STAT ioctl, support it in virtio_rtc
Date: Thu, 19 Dec 2024 21:42:02 +0100
Message-ID: <20241219204208.3160-1-quic_philber@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: WZjrY0ycIR4EgJb4WPifMdayeJ-b49VT
X-Proofpoint-GUID: WZjrY0ycIR4EgJb4WPifMdayeJ-b49VT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=777
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412190164

This RFC patch series proposes a new ioctl PTP_SYS_OFFSET_STAT and adds
support for it in the proposed virtio_rtc driver [1]. The new
PTP_SYS_OFFSET_STAT ioctl provides a cross-timestamp like
PTP_SYS_OFFSET_PRECISE2, plus any the following status information (for
now):

- for UTC timescale clocks: leap second related status,

- clock accuracy.

The second commit adds support for the ioctl in the proposed virtio_rtc
driver, and hence depends on the patch series "Add virtio_rtc module" [1].

[1] https://lore.kernel.org/lkml/20241219201118.2233-1-quic_philber@quicinc.com/T/#t

Signed-off-by: Peter Hilber <quic_philber@quicinc.com>


Peter Hilber (2):
  ptp: add PTP_SYS_OFFSET_STAT for xtstamping with status
  virtio_rtc: Support PTP_SYS_OFFSET_STAT ioctl

 drivers/ptp/ptp_chardev.c             |  39 ++++++++
 drivers/ptp/ptp_clock.c               |   9 ++
 drivers/virtio/Kconfig                |   4 +-
 drivers/virtio/virtio_rtc_driver.c    | 122 +++++++++++++++++++++++-
 drivers/virtio/virtio_rtc_internal.h  |   3 +-
 drivers/virtio/virtio_rtc_ptp.c       |  25 +++--
 include/linux/ptp_clock_kernel.h      |  31 ++++++
 include/uapi/linux/ptp_clock.h        | 130 +++++++++++++++++++++++++-
 tools/testing/selftests/ptp/Makefile  |   2 +-
 tools/testing/selftests/ptp/testptp.c | 126 ++++++++++++++++++++++++-
 10 files changed, 471 insertions(+), 20 deletions(-)


base-commit: 8a8009abbfa04e58f1b01b20534cac9e8fe61a46
-- 
2.43.0


