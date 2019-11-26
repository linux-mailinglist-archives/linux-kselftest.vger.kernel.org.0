Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C418E10A10C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfKZPRY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 10:17:24 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57234 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbfKZPRX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 10:17:23 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9ACE9200343;
        Tue, 26 Nov 2019 16:17:21 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 861F420011C;
        Tue, 26 Nov 2019 16:17:21 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E8A5020506;
        Tue, 26 Nov 2019 16:17:20 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v4 3/4] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
Date:   Tue, 26 Nov 2019 17:17:12 +0200
Message-Id: <8ca3c4f69921b3d65eb354d528614e4763094bf7.1574781196.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574781196.git.leonard.crestez@nxp.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1574781196.git.leonard.crestez@nxp.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows dev_pm_qos to embed freq_qos structs, which is done in the
next patch. Separate commit to make it easier to review.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

