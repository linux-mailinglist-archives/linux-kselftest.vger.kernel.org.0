Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F39D109206
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfKYQmb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 11:42:31 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60954 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbfKYQmb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 11:42:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EE31A2004FB;
        Mon, 25 Nov 2019 17:42:28 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DFE0B2004E4;
        Mon, 25 Nov 2019 17:42:28 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EEE7204E6;
        Mon, 25 Nov 2019 17:42:28 +0100 (CET)
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
Subject: [PATCH v3 0/4] PM: QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Date:   Mon, 25 Nov 2019 18:42:15 +0200
Message-Id: <cover.1574699610.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support for frequency limits in dev_pm_qos was removed when cpufreq was
switched to freq_qos, this series attempts to restore it by
reimplementing on top of freq_qos.

Discussion about removal is here:
https://lore.kernel.org/linux-pm/VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com/T/#u

The cpufreq core switched away because it needs contraints at the level
of a "cpufreq_policy" which cover multiple cpus so dev_pm_qos coupling
to struct device was not useful. Cpufreq could only use dev_pm_qos by
implementing an additional layer of aggregation anyway.

However in the devfreq subsystem scaling is always performed on a per-device
basis so dev_pm_qos is a very good match. Support for dev_pm_qos in devfreq
core is here:

	https://patchwork.kernel.org/cover/11252409/

That series is RFC mostly because it needs these PM core patches.
Earlier versions got entangled in some locking cleanups but those are
not strictly necessary to get dev_pm_qos functionality.

In theory if freq_qos is extended to handle conflicting min/max values then
this sharing would be valuable. Right now freq_qos just ties two unrelated
pm_qos aggregations for min and max freq.

---
This is implemented by embeding a freq_qos_request inside dev_pm_qos_request:
the data field was already an union in order to deal with flag requests.

The internal freq_qos_apply is exported so that it can be called from
dev_pm_qos apply_constraints.

The dev_pm_qos_constraints_destroy function has no obvious equivalent in
freq_qos and the whole approach of "removing requests" is somewhat dubios:
request objects should be owned by consumers and the list of qos requests
should be empty when the target device is deleted.

Changes since v2:
* #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE FREQ_QOS_MAX_DEFAULT_VALUE
* #define FREQ_QOS_MAX_DEFAULT_VALUE S32_MAX (in new patch)
* Add initial kunit test for freq_qos, validating the MAX_DEFAULT_VALUE found
by Matthias.
Link to v2: https://patchwork.kernel.org/cover/11250413/

First two patches can be applied separated

Changes since v1:
* Don't rename or EXPORT_SYMBOL_GPL the freq_qos_apply function; just
drop the static marker.
Link to v1: https://patchwork.kernel.org/cover/11212887/

Leonard Crestez (4):
  PM / QoS: Initial kunit test
  PM / QOS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
  PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
  PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY

 drivers/base/Kconfig          |   4 ++
 drivers/base/power/Makefile   |   1 +
 drivers/base/power/qos-test.c | 116 ++++++++++++++++++++++++++++++++++
 drivers/base/power/qos.c      |  69 ++++++++++++++++++--
 include/linux/pm_qos.h        |  86 ++++++++++++++-----------
 kernel/power/qos.c            |   4 +-
 6 files changed, 237 insertions(+), 43 deletions(-)
 create mode 100644 drivers/base/power/qos-test.c

-- 
2.17.1

