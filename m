Return-Path: <linux-kselftest+bounces-675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C707FAE72
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915421C20B04
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593849F6A;
	Mon, 27 Nov 2023 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ix3kpH7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C2AD64;
	Mon, 27 Nov 2023 15:36:17 -0800 (PST)
Received: from notapiano.myfiosgateway.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B1A766022D1;
	Mon, 27 Nov 2023 23:36:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701128175;
	bh=xYJ3In0iFK7Rcw0FOkP/TEyWe5yZLvjkyvqOPva+JBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ix3kpH7jTiBVkuKQ1dmDso9tRjXE28w//G9DdXw/6B7Uw2wTROqGkt2dX89n3o4W7
	 yCLpsBmIkqRNenY4BP4WqGT48QWEj9a2aV4ARC8o83Oi8QGCfiafcYg0QYcLMgHpXy
	 09Pb4beislAGqv4qWguMm1UYEBGWZgosZcJdJDPFlqCmMyjKabWgpVHuCEn9oCYq0b
	 atwJYBeuVlkbAn16I+k5ogfZmftDZeWvu859AAmytcalrcCGLJzlRXQdo3S0Uj/e/G
	 8JuujBR67bpOg1x/zDxGKW+GrSnXePPvdGHIbM/d9cPtbg56t9ftdnqDX/cl9/QzgO
	 mVT1qIS06Squg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	kernelci@lists.linux.dev,
	David Gow <davidgow@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org,
	kernel@collabora.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for google,spherion
Date: Mon, 27 Nov 2023 18:34:07 -0500
Message-ID: <20231127233558.868365-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231127233558.868365-1-nfraprado@collabora.com>
References: <20231127233558.868365-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a sample board file describing the file's format and with the list
of devices expected to be probed on the google,spherion machine as an
example.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 .../testing/selftests/devices/boards/google,spherion | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion

diff --git a/tools/testing/selftests/devices/boards/google,spherion b/tools/testing/selftests/devices/boards/google,spherion
new file mode 100644
index 000000000000..db9a17cccd03
--- /dev/null
+++ b/tools/testing/selftests/devices/boards/google,spherion
@@ -0,0 +1,12 @@
+# Example test definition for Google Spherion Chromebook
+#
+# Format:
+#   usb|pci test_name number_of_matches field=value [ field=value ... ]
+#
+# The available match fields vary by bus. The field-value match pairs for a
+# device can be retrieved from the device's modalias attribute in sysfs. A
+# subset of the fields may be used to make the match more generic so it can work
+# with the different hardware variants of a device on the machine.
+usb camera 1 ic=0e isc=01 ip=00
+usb bluetooth 1 ic=e0 isc=01 ip=01 in=00
+pci wifi 1 v=14c3 d=7961
-- 
2.42.1


