Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5267010920E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfKYQme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 11:42:34 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40622 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbfKYQme (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 11:42:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5724C1A051A;
        Mon, 25 Nov 2019 17:42:31 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4951B1A0211;
        Mon, 25 Nov 2019 17:42:31 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BD50220505;
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
Subject: [PATCH v3 4/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Date:   Mon, 25 Nov 2019 18:42:19 +0200
Message-Id: <4496ea06c9b04b464ceb1ecf2498768e1689301e.1574699610.git.leonard.crestez@nxp.com>
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

Support for adding per-device frequency limits was removed in commit
2aac8bdf7a0f ("PM: QoS: Drop frequency QoS types from device PM QoS")
after cpufreq switched to use a new "freq_constraints" construct.

Restore support for per-device freq limits but base this upon
freq_constraints. This is primarily meant to be used by the devfreq
subsystem.

This removes the "static" marking on freq_qos_apply but does not export
it for modules.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/base/power/qos.c | 69 ++++++++++++++++++++++++++++++++++++----
 include/linux/pm_qos.h   | 12 +++++++
 kernel/power/qos.c       |  4 ++-
 3 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 350dcafd751f..4eefa00aff2d 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -113,14 +113,24 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 	unsigned long flags;
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (type == DEV_PM_QOS_RESUME_LATENCY) {
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
 		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
 			: pm_qos_read_value(&qos->resume_latency);
-	} else {
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
+			: freq_qos_read_value(&qos->freq, FREQ_QOS_MIN);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
+			: freq_qos_read_value(&qos->freq, FREQ_QOS_MAX);
+		break;
+	default:
 		WARN_ON(1);
 		ret = 0;
 	}
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -157,10 +167,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 		if (ret) {
 			value = pm_qos_read_value(&qos->latency_tolerance);
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = freq_qos_apply(&req->data.freq, action, value);
+		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
 		break;
 	default:
@@ -207,10 +221,12 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->target_value = PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE;
 	c->default_value = PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE;
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	freq_constraints_init(&qos->freq);
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
 	dev->power.qos = qos;
 	spin_unlock_irq(&dev->power.lock);
@@ -267,10 +283,22 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
 
+	c = &qos->freq.min_freq;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
+	c = &qos->freq.max_freq;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
@@ -312,15 +340,26 @@ static int __dev_pm_qos_add_request(struct device *dev,
 		ret = -ENODEV;
 	else if (!dev->power.qos)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
 	trace_dev_pm_qos_add_request(dev_name(dev), type, value);
-	if (!ret) {
-		req->dev = dev;
-		req->type = type;
+	if (ret)
+		return ret;
+
+	req->dev = dev;
+	req->type = type;
+	if (req->type == DEV_PM_QOS_MIN_FREQUENCY)
+		ret = freq_qos_add_request(&dev->power.qos->freq,
+					   &req->data.freq,
+					   FREQ_QOS_MIN, value);
+	else if (req->type == DEV_PM_QOS_MAX_FREQUENCY)
+		ret = freq_qos_add_request(&dev->power.qos->freq,
+					   &req->data.freq,
+					   FREQ_QOS_MAX, value);
+	else
 		ret = apply_constraint(req, PM_QOS_ADD_REQ, value);
-	}
+
 	return ret;
 }
 
 /**
  * dev_pm_qos_add_request - inserts new qos request into the list
@@ -380,10 +419,14 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
 		curr_value = req->data.pnode.prio;
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		curr_value = req->data.freq.pnode.prio;
+		break;
 	case DEV_PM_QOS_FLAGS:
 		curr_value = req->data.flr.flags;
 		break;
 	default:
 		return -EINVAL;
@@ -505,10 +548,16 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 	switch (type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
 						       notifier);
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = freq_qos_add_notifier(&dev->power.qos->freq, FREQ_QOS_MIN, notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = freq_qos_add_notifier(&dev->power.qos->freq, FREQ_QOS_MAX, notifier);
+		break;
 	default:
 		WARN_ON(1);
 		ret = -EINVAL;
 	}
 
@@ -544,10 +593,18 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 	switch (type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
 							 notifier);
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = freq_qos_remove_notifier(&dev->power.qos->freq,
+					       FREQ_QOS_MIN, notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = freq_qos_remove_notifier(&dev->power.qos->freq,
+					       FREQ_QOS_MAX, notifier);
+		break;
 	default:
 		WARN_ON(1);
 		ret = -EINVAL;
 	}
 
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 678fec6da5b9..19eafca5680e 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -32,10 +32,12 @@ enum pm_qos_flags_status {
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
+#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
+#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	FREQ_QOS_MAX_DEFAULT_VALUE
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
 
 struct pm_qos_request {
@@ -99,25 +101,29 @@ struct freq_qos_request {
 
 
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_MIN_FREQUENCY,
+	DEV_PM_QOS_MAX_FREQUENCY,
 	DEV_PM_QOS_FLAGS,
 };
 
 struct dev_pm_qos_request {
 	enum dev_pm_qos_req_type type;
 	union {
 		struct plist_node pnode;
 		struct pm_qos_flags_request flr;
+		struct freq_qos_request freq;
 	} data;
 	struct device *dev;
 };
 
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct freq_constraints freq;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
 	struct dev_pm_qos_request *flags_req;
 };
@@ -212,10 +218,14 @@ static inline s32 dev_pm_qos_read_value(struct device *dev,
 					enum dev_pm_qos_req_type type)
 {
 	switch (type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 	default:
 		WARN_ON(1);
 		return 0;
 	}
 }
@@ -291,10 +301,12 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
 int freq_qos_add_request(struct freq_constraints *qos,
 			 struct freq_qos_request *req,
 			 enum freq_qos_req_type type, s32 value);
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
 int freq_qos_remove_request(struct freq_qos_request *req);
+int freq_qos_apply(struct freq_qos_request *req,
+		   enum pm_qos_req_action action, s32 value);
 
 int freq_qos_add_notifier(struct freq_constraints *qos,
 			  enum freq_qos_req_type type,
 			  struct notifier_block *notifier);
 int freq_qos_remove_notifier(struct freq_constraints *qos,
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index a45cba7df0ae..83edf8698118 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -712,12 +712,14 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
 /**
  * freq_qos_apply - Add/modify/remove frequency QoS request.
  * @req: Constraint request to apply.
  * @action: Action to perform (add/update/remove).
  * @value: Value to assign to the QoS request.
+ *
+ * This is only meant to be called from inside pm_qos, not drivers.
  */
-static int freq_qos_apply(struct freq_qos_request *req,
+int freq_qos_apply(struct freq_qos_request *req,
 			  enum pm_qos_req_action action, s32 value)
 {
 	int ret;
 
 	switch(req->type) {
-- 
2.17.1

