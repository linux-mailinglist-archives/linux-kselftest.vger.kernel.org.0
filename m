Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668F410A109
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKZPRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 10:17:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55170 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfKZPRW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 10:17:22 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C80E71A0396;
        Tue, 26 Nov 2019 16:17:19 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B10E31A0118;
        Tue, 26 Nov 2019 16:17:19 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2635320506;
        Tue, 26 Nov 2019 16:17:19 +0100 (CET)
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
Subject: [PATCH v4 0/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Date:   Tue, 26 Nov 2019 17:17:09 +0200
Message-Id: <cover.1574781196.git.leonard.crestez@nxp.com>
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
core is here (latest version, no dependencies outside this series):

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
will most likely be empty when the target device is deleted. Series follows
current pattern for dev_pm_qos.

First two patches can be applied separately.

Changes since v3:
* Fix s/QOS/QoS in patch 2 title
* Improves comments in kunit test
* Fix assertions after freq_qos_remove_request
* Remove (c) from NXP copyright header
* Wrap long lines in qos.c to be under 80 chars. This fixes checkpatch but the
rule is already broken by code in the files.
* Collect reviews
Link to v3: https://patchwork.kernel.org/cover/11260627/

Changes since v2:
* #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE FREQ_QOS_MAX_DEFAULT_VALUE
* #define FREQ_QOS_MAX_DEFAULT_VALUE S32_MAX (in new patch)
* Add initial kunit test for freq_qos, validating the MAX_DEFAULT_VALUE found
by Matthias and another recent fix. Testing this should be easier!
Link to v2: https://patchwork.kernel.org/cover/11250413/

Changes since v1:
* Don't rename or EXPORT_SYMBOL_GPL the freq_qos_apply function; just
drop the static marker.
Link to v1: https://patchwork.kernel.org/cover/11212887/

Leonard Crestez (4):
  PM / QoS: Initial kunit test
  PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
  PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
  PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY

 drivers/base/Kconfig          |   4 ++
 drivers/base/power/Makefile   |   1 +
 drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++
 drivers/base/power/qos.c      |  73 +++++++++++++++++++--
 include/linux/pm_qos.h        |  86 ++++++++++++++-----------
 kernel/power/qos.c            |   4 +-
 6 files changed, 242 insertions(+), 43 deletions(-)
 create mode 100644 drivers/base/power/qos-test.c

-- 
2.17.1

