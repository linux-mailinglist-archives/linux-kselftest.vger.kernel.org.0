Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C222109209
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfKYQmc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 11:42:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40570 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfKYQmc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 11:42:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CC041A02AC;
        Mon, 25 Nov 2019 17:42:30 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F69D1A0211;
        Mon, 25 Nov 2019 17:42:30 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AA43204D5;
        Mon, 25 Nov 2019 17:42:29 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v3 2/4] PM / QOS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
Date:   Mon, 25 Nov 2019 18:42:17 +0200
Message-Id: <43ffe25df5e9b268778656a0b9259c2939715681.1574699610.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574699610.git.leonard.crestez@nxp.com>
References: <cover.1574699610.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1574699610.git.leonard.crestez@nxp.com>
References: <cover.1574699610.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

QOS requests for DEFAULT_VALUE are supposed to be ignored but this is
not the case for FREQ_QOS_MAX. Adding one request for MAX_DEFAULT_VALUE
and one for a real value will cause freq_qos_read_value to unexpectedly
return MAX_DEFAULT_VALUE (-1).

This happens because freq_qos max value is aggregated with PM_QOS_MIN
but FREQ_QOS_MAX_DEFAULT_VALUE is (-1) so it's smaller than other
values.

Fix this by redefining FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX.

Looking at current users for freq_qos it seems that none of them create
requests for FREQ_QOS_MAX_DEFAULT_VALUE.

Fixes: 77751a466ebd ("PM: QoS: Introduce frequency QoS")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 include/linux/pm_qos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index ebf5ef17cc2a..24a6263c9931 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -254,11 +254,11 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
 #endif
 
 #define FREQ_QOS_MIN_DEFAULT_VALUE	0
-#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
+#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
 
 enum freq_qos_req_type {
 	FREQ_QOS_MIN = 1,
 	FREQ_QOS_MAX,
 };
-- 
2.17.1

