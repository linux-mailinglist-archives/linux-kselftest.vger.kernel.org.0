Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DA46C187
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 18:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhLGRUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 12:20:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:51627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239905AbhLGRUm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 12:20:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218312480"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="218312480"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="479591301"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2021 09:14:49 -0800
Received: from debox1-desk4.hsd1.or.comcast.net (unknown [10.251.18.198])
        by linux.intel.com (Postfix) with ESMTP id 35AC75805EC;
        Tue,  7 Dec 2021 09:14:49 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Date:   Tue,  7 Dec 2021 09:14:44 -0800
Message-Id: <20211207171448.799376-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207171448.799376-1-david.e.box@linux.intel.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds get/set driver data helpers for auxiliary devices.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Mark Gross <markgross@kernel.org>
---
V2
  - No changes

 include/linux/auxiliary_bus.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index fc51d45f106b..a8338d456e81 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -28,6 +28,16 @@ struct auxiliary_driver {
 	const struct auxiliary_device_id *id_table;
 };
 
+static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
+{
+	return dev_get_drvdata(&auxdev->dev);
+}
+
+static inline void auxiliary_set_drvdata(struct auxiliary_device *auxdev, void *data)
+{
+	dev_set_drvdata(&auxdev->dev, data);
+}
+
 static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
 {
 	return container_of(dev, struct auxiliary_device, dev);
-- 
2.25.1

