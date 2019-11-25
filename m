Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1792610920C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfKYQmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 11:42:33 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40596 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbfKYQmd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 11:42:33 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BBD841A050D;
        Mon, 25 Nov 2019 17:42:30 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ADF491A0211;
        Mon, 25 Nov 2019 17:42:30 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E7D2204D5;
        Mon, 25 Nov 2019 17:42:30 +0100 (CET)
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
Subject: [PATCH v3 3/4] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
Date:   Mon, 25 Nov 2019 18:42:18 +0200
Message-Id: <f6d6572ad860d479416108a41f0e20d5cb72ae46.1574699610.git.leonard.crestez@nxp.com>
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

This allows dev_pm_qos to embed freq_qos structs, which is done in the
next patch. Separate commit to make it easier to review.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 include/linux/pm_qos.h | 74 ++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 24a6263c9931..678fec6da5b9 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -47,25 +47,10 @@ struct pm_qos_request {
 struct pm_qos_flags_request {
 	struct list_head node;
 	s32 flags;	/* Do not change to 64 bit */
 };
 
-enum dev_pm_qos_req_type {
-	DEV_PM_QOS_RESUME_LATENCY = 1,
-	DEV_PM_QOS_LATENCY_TOLERANCE,
-	DEV_PM_QOS_FLAGS,
-};
-
-struct dev_pm_qos_request {
-	enum dev_pm_qos_req_type type;
-	union {
-		struct plist_node pnode;
-		struct pm_qos_flags_request flr;
-	} data;
-	struct device *dev;
-};
-
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,
 	PM_QOS_MAX,		/* return the largest value */
 	PM_QOS_MIN,		/* return the smallest value */
 	PM_QOS_SUM		/* return the sum */
@@ -88,10 +73,48 @@ struct pm_qos_constraints {
 struct pm_qos_flags {
 	struct list_head list;
 	s32 effective_flags;	/* Do not change to 64 bit */
 };
 
+
+#define FREQ_QOS_MIN_DEFAULT_VALUE	0
+#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
+
+enum freq_qos_req_type {
+	FREQ_QOS_MIN = 1,
+	FREQ_QOS_MAX,
+};
+
+struct freq_constraints {
+	struct pm_qos_constraints min_freq;
+	struct blocking_notifier_head min_freq_notifiers;
+	struct pm_qos_constraints max_freq;
+	struct blocking_notifier_head max_freq_notifiers;
+};
+
+struct freq_qos_request {
+	enum freq_qos_req_type type;
+	struct plist_node pnode;
+	struct freq_constraints *qos;
+};
+
+
+enum dev_pm_qos_req_type {
+	DEV_PM_QOS_RESUME_LATENCY = 1,
+	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_FLAGS,
+};
+
+struct dev_pm_qos_request {
+	enum dev_pm_qos_req_type type;
+	union {
+		struct plist_node pnode;
+		struct pm_qos_flags_request flr;
+	} data;
+	struct device *dev;
+};
+
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
@@ -253,31 +276,10 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
 #endif
 
-#define FREQ_QOS_MIN_DEFAULT_VALUE	0
-#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
-
-enum freq_qos_req_type {
-	FREQ_QOS_MIN = 1,
-	FREQ_QOS_MAX,
-};
-
-struct freq_constraints {
-	struct pm_qos_constraints min_freq;
-	struct blocking_notifier_head min_freq_notifiers;
-	struct pm_qos_constraints max_freq;
-	struct blocking_notifier_head max_freq_notifiers;
-};
-
-struct freq_qos_request {
-	enum freq_qos_req_type type;
-	struct plist_node pnode;
-	struct freq_constraints *qos;
-};
-
 static inline int freq_qos_request_active(struct freq_qos_request *req)
 {
 	return !IS_ERR_OR_NULL(req->qos);
 }
 
-- 
2.17.1

