Return-Path: <linux-kselftest+bounces-23235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADDB9EDC91
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 01:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB41167AF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA042AA6;
	Thu, 12 Dec 2024 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCm8BLgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EB2AF16
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963535; cv=none; b=Ky19mKRuPL8m/WAFK4xd9Fh4fPMFxPAgR0zPqLYHpA/Jxtwy6/tMQ7iZKArKsY6RPIg3sBl/yI4bi691g33GEoTs2RizZe+8zRZzhZxiuV7E7ZfxQEHqoVfQy2Y5JXhRMs1r0rgLaQjh2yr8qQyG5Rr4xSpN4UKC9KqftZKMD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963535; c=relaxed/simple;
	bh=y5nwWgTVBI2UXYuNENiRQFzqncmPN23qxZLRHMtG29c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJnkizfZXg6XZnOPJxPn67RhdAkw1HFhRPGx85SDa2RHlpJaIrQvRyKOjDjQjgcQR+QmEZsxWSJj8R793zkOJZvRjRs+1/OBprZm+8QUqTIFOMjsqixhFEU8Xrk1cgQzcYe779S9YNxKEPuA2IKRaL9GBtWxnhLua5ulXsrLBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCm8BLgy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216426b0865so372755ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 16:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733963533; x=1734568333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AVQu3QWop0H0c+IcZ6mMGnn73hEqL5BKjdosgsTiGA=;
        b=FCm8BLgyqZ79CS2uNCVdS/VBz04o89PGFfnlwXzBFac9Yb0nn6pKl4+cz+yP2qthbo
         TrVe2jYTHdVLDSH2VyerbPlA39oUCqOU35A/TkrNIOZy6/CRZTtR36vrCMqkzdFHRiSW
         Lo6JXXHTA0XlgC/kjG2a5d9O6t29PGw08nxKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963533; x=1734568333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AVQu3QWop0H0c+IcZ6mMGnn73hEqL5BKjdosgsTiGA=;
        b=svSa5WSF6oTyrLD4bYPbdsI8oUsXBlMsRTPM5PNUaDPEf2AS7SY3Zf85jkYe6syUBN
         NIoK3P6293Ngww/e3JpodU9j2mPaXfc4t1plWRXHngs8AQwbkm503jtI/9WMfU9LqGre
         b9/EYbDTIgFS5GJUJzV5rbitzAlUT9PW1TQVQITykbArxT2RpTOHQsh0jZmiAw/m1lVs
         1mre5dk6bA3g2B2ESpQwlblDEU2UbbKxeXjgh5o3+28I5PJhsvsT65BH1/Zm6S0L0wFF
         Z+T7czaXzM0nxoPvhCD5HlxAf+foZsNqd67cszFYRHdUMcxRup+Mxbr39w+tZZHyRU7z
         Qh3w==
X-Forwarded-Encrypted: i=1; AJvYcCXixNDZcfkzwaincsr44BmnVTp+WYxRRxGRnzu1Vmmkn6JqijBJQOo392gH5iNeTujtIvNUXY+TEqAKzQwcLMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnLRRsKECq9N8b3uheRlwsjsWRZWMKniUau/FlqBcNDb7xX7s
	e0Q6cT7kn3oYwo3yf+zhu74teM/oFCL83AtgMoTYdaPAri2KaOrb3lZJYf2BPg==
X-Gm-Gg: ASbGncvoJxko+tFobv5JCniJwBUDQ+p9YnF8pZtbbB7VD+On8/NM7MI01ICVzU9jVwa
	oji4526B/kMokwxdeEmc8L9GM01yuH810oEtIZ1RjkuGDBUukYR9mv6ksIeGHghNHXuQF/4YSmX
	nBXB4mWP+rnpdcROu2/7Opuw9iOfommhejKSjWcgpp+/8XT8M+EroGNAeZ1Q99CY0OMD7/hBIrV
	L3x4O/S2fORbRu03Go+OEAxfeJ5N7arPwkN7cdn52pe2ioZ1WBLZyebhM5nlTHW5bn5g2DyFHlz
	NBDWrt2JeK9qOWbKbtI=
X-Google-Smtp-Source: AGHT+IEGLgadsxVUtkYmrldWfxFt3dO7ayUdfAi8DTpzJjhNb3S1+xd9gbNu33I+qMnncuaz+9QyRQ==
X-Received: by 2002:a17:902:cecc:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21778395944mr84017305ad.6.1733963532911;
        Wed, 11 Dec 2024 16:32:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-216338fee40sm75395405ad.94.2024.12.11.16.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 16:32:12 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Maxime Ripard <mripard@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(... NULL) tests
Date: Wed, 11 Dec 2024 16:31:41 -0800
Message-ID: <20241212003201.2098123-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241212003201.2098123-1-briannorris@chromium.org>
References: <20241212003201.2098123-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently updated these device_match*() (and therefore, various
*find_device_by*()) functions to return a consistent 'false' value when
trying to match a NULL handle. Add tests for this.

This provides regression-testing coverage for the sorts of bugs that
underly commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device
only if one actually exists").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Keep "devm" and "match" tests in separate suites

 drivers/base/test/platform-device-test.c | 42 +++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index ea05b8785743..c8d4b0a385f2 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -3,6 +3,8 @@
 #include <kunit/resource.h>
 
 #include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #define DEVICE_NAME "test"
@@ -217,7 +219,45 @@ static struct kunit_suite platform_device_devm_test_suite = {
 	.test_cases = platform_device_devm_tests,
 };
 
-kunit_test_suite(platform_device_devm_test_suite);
+static void platform_device_find_by_null_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, of_find_device_by_node(NULL), NULL);
+
+	KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_of_node(&platform_bus_type, NULL), NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_fwnode(&platform_bus_type, NULL), NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_acpi_dev(&platform_bus_type, NULL), NULL);
+
+	KUNIT_EXPECT_FALSE(test, device_match_of_node(&pdev->dev, NULL));
+	KUNIT_EXPECT_FALSE(test, device_match_fwnode(&pdev->dev, NULL));
+	KUNIT_EXPECT_FALSE(test, device_match_acpi_dev(&pdev->dev, NULL));
+	KUNIT_EXPECT_FALSE(test, device_match_acpi_handle(&pdev->dev, NULL));
+
+	platform_device_unregister(pdev);
+}
+
+static struct kunit_case platform_device_match_tests[] = {
+	KUNIT_CASE(platform_device_find_by_null_test),
+	{}
+};
+
+static struct kunit_suite platform_device_match_test_suite = {
+	.name = "platform-device-match",
+	.test_cases = platform_device_match_tests,
+};
+
+kunit_test_suites(
+	&platform_device_devm_test_suite,
+	&platform_device_match_test_suite,
+);
 
 MODULE_DESCRIPTION("Test module for platform devices");
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
-- 
2.47.0.338.g60cca15819-goog


