Return-Path: <linux-kselftest+bounces-23432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242C9F3A84
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 21:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F51889D3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370491D5175;
	Mon, 16 Dec 2024 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idTMj13b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC401D5143
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379925; cv=none; b=Kkee2721QA1iZbPP4TJACL0P0/pCMnAdlzzZVJXS43cZdkHFNBNIx81TzQhCo4AH5yKrEURbmVKVPsozGA1lF9J1xESVwRyuy97DBES8p+T9SqHPeI+KlE3OAubCv6be2rDpLEAoxIu0lieWjVchNSODTQgYgQNqOPSwxWalGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379925; c=relaxed/simple;
	bh=H6OpmDmtDpO2Zw9oPoveIwfU5S4mQl0QvewtjG8lnI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc4fRtVcwkKd62aZ3T4zqDmWdUfdYY9TtWvYMq6Iv7QAKb/vqgALjItYeUP0qWH6vKmcn3/sE88TWY4haeTUfQoPX+7hK+PhqTEwbLtUbKcxF4o+0GZNjANN0Fc22/YR/q2LmC3QS22icR+sxN1qKTBv4ssa2JuMgzWBzSegAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=idTMj13b; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso3512611a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 12:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734379923; x=1734984723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djvMV74okcAY/0lAlFHYz0uZLVdKOBaTEOPTBRi9sN4=;
        b=idTMj13bH3WLlPjKnPfPxQy6icNRx5Eo3xCf847jUnA8aJR7pZcF3bHgB7K9qR2o09
         3vmWy6pB9uazkqDyc/hromm4TA8eu9D3LlTPfjlTeO7GhjHNABLwnLtMZgKpGIupCQOp
         nBwkiWGsGGJHuB25kMdKdDK/Vr4yvvJ+VLXHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379923; x=1734984723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djvMV74okcAY/0lAlFHYz0uZLVdKOBaTEOPTBRi9sN4=;
        b=fi8Cabl8TWOIOTeKr4F8fB5XwY3VUOwNTT4HMbkLYexI4Ww0A/zZI8OtIdPhysPVZ0
         ZP8QgnKfvCsErzKSMLXUXZ9XVC1+b2YuIaRrttcbEuxju/04Lj1bJXTHMwwgWjA7YJtm
         OpBHRcsgXWD/8EEffgd5kI0LtkScGN42QTCIOUn/t36cqAaGR8Aq19SMuC7vQkg6zUEc
         hpL8vw7cIJLdpKjVwhs2TW42Gb6guajN6zxjIEB34sgwgbklv5IxQxWjL9C0FiSYCAa6
         1X/P7DMz4/Io7yhCFrH1LegVqI4R0qm153ns3mlh2EMV6yLhIv6cG4Vz0WyqZRQfCcQF
         NVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6HMw3iO+UJlLrX1nP+5AQFnDMteOfjYQ2MDvx5CqdQkQiKV9noIfC3HBWyaCDhKpn7n8tKLXZxHOs6IzMcco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyLHrlrPMWY7fzTi2uehVxpOx0BavJrEqsZJrh7GfXZKaG1aT
	e95ryNAFBNafnIehW4pBHj85KWM+qqpYJeeqQNsjpyKN2AfmQwxg6NBZr9XEHsmYIs0cKHq9RRk
	=
X-Gm-Gg: ASbGncvqWKBFygAYtYsd/5/w2zspuw6Xwmzt+APh5d8FrohfgHmipfplUTVfeBSDKIu
	ZEZ66D0h7wc6sSD4k7CjhhyseFERbUaH6WRwTrHrVcAORBqeFbXYmmyRzv94xb1t0yr5cnEh0FE
	f0bbBRTuU39oDE1E3mKCTjQqrv2qn0XHERUTThTupVY+E1bAsGPNYYbAhx9KfnkGmWngPT9xN+S
	WPMsAaWA84+YuPx1mOTYg1NbaDXBlFodHtYJP7MSdkNxi0P3DhD/+eNZlTBGcKbNyAk/C+E5zP0
	sSUiPROYukecqfcl/Q==
X-Google-Smtp-Source: AGHT+IEis0SU953jTVyxT2H0yo03Me4jIuEsbijattQtH7vbZS2FTiO7qBvoO1t0qS6vmyUZ86ypdQ==
X-Received: by 2002:a17:90b:180b:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2f28fb71a7emr22546306a91.16.1734379923047;
        Mon, 16 Dec 2024 12:12:03 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:953:5b91:a52c:e817])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2a1e7e07bsm5122503a91.1.2024.12.16.12.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:12:02 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	linux-acpi@vger.kernel.org,
	Rae Moar <rmoar@google.com>,
	Rob Herring <robh@kernel.org>,
	David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 3/3] drivers: base: test: Add ...find_device_by...(... NULL) tests
Date: Mon, 16 Dec 2024 12:11:44 -0800
Message-ID: <20241216201148.535115-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241216201148.535115-1-briannorris@chromium.org>
References: <20241216201148.535115-1-briannorris@chromium.org>
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

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * Fix potential leak in test error case
 * Add Maxime's Reviewed-by

Changes in v2:
 * Keep "devm" and "match" tests in separate suites

 drivers/base/test/platform-device-test.c | 41 +++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index ea05b8785743..6355a2231b74 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <kunit/platform_device.h>
 #include <kunit/resource.h>
 
 #include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #define DEVICE_NAME "test"
@@ -217,7 +220,43 @@ static struct kunit_suite platform_device_devm_test_suite = {
 	.test_cases = platform_device_devm_tests,
 };
 
-kunit_test_suite(platform_device_devm_test_suite);
+static void platform_device_find_by_null_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = kunit_platform_device_alloc(test, DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = kunit_platform_device_add(test, pdev);
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
2.47.1.613.gc27f4b7a9f-goog


