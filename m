Return-Path: <linux-kselftest+bounces-23123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBDF9EB9E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61469167941
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22728214235;
	Tue, 10 Dec 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aCIj2G0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF24214228
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858058; cv=none; b=XM9tpzBR8xMdU/Q3uwzvOScvQjybMHp+Ou5NFYmOQWc6ubmKbiRmgkhYBdz0KuWjKBfUvGdz9NU7LGiHReeiHTVrAeXO1g447Nzp4AgQ0TjhqdIMJDv1OBUP8G+yR3zlJPY0mu1lf3cNRPa7Yw9JLhy439G5odP8PZPmTCRRUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858058; c=relaxed/simple;
	bh=NLP51W0TMbF+X/IdSKOCuEkPNumCeamZMXG9xpfX5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2CeoYjEHzATWc3iVUThAAWiSdwasROWgQSAlZQMZHJKEUTd6Ejcb9qxElavYcj6MTXdVC4EjBpqeydsVE/XRpbu2/39DDLuSI2nrwslAEXCGioxNdnilAu8VEyIKaVBcujJI/IoA7V1unFQXmVW/dmQxElotIr1VAHe4VHVxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aCIj2G0X; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21661be2c2dso17831495ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858056; x=1734462856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kNBPAUQqn1SlMteLp0cLp4n0uTA6dQm9HM53DlHwKA=;
        b=aCIj2G0XlgDBZR3Arw8z4zE6aLrErUBMwC13oxZ5uvCnDc6iqIGg7i86aY7WcFijzh
         HrdlMfYOvgdnLC/IDYcV1hxwJiP2BPCrrr5+qSmZm7/NAs5ptn2OprwtdICvFjab8bC2
         eKd8sJaC+dgEh2fBbPIRTV2VECunpVbv31FIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858056; x=1734462856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kNBPAUQqn1SlMteLp0cLp4n0uTA6dQm9HM53DlHwKA=;
        b=AjCqz8c3JGDqNOgHkRc5OhGUKuY3VnX4cuKbXlH4yD7guaARymPOPakDtr/MU737ls
         Kho2inGoqAujQdkWsUShBQcrsC8BcZ6srTAWwfx9lxglxa0h/iooRnKZuUcVq6v9iJBB
         X13q1XQC99f6YyB8NueOlXjwSK/muhRHK/7cj1f+xvhzNOGvE1HS08aT2MiYy7bC7Aur
         At3MY9L62etopEnIJOSCo0Mw5qOZALhZOqihWpEh/0Ze8RAOo5PzysSoB+Dc/suSwFwv
         YNbEzBlTiTn2wH/CLTh+2KmP36aZmNNNTyHCm6Van8oQU2MZ1EMQFC1Q3t3wDGT0ed9f
         r6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5dGO9qvzOCrS9858780NHeAHQZRNJz8LFzQKgFPSuI/sasHxljHpVfDdquPXttLIkf1pmzoWLhVS+Bn4wZQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzl24JRHsVuzz+WYEEu3s8Bf4EotkeYBiJN9jtjqyJIKWJ44S
	8r3G2RWkelFYURvl8Jos7rO+Yz6355pneK6NdL81y3GcoRSOwmUN0fP4UIjETA==
X-Gm-Gg: ASbGncv7dQHfL3XTU4E/CMvRjy0rw0kJDL10Lt4jZ4eXWgo8si1LGtjUk64EIHIHQAY
	tQKPfqC4NantJK30+EnYYdpYxlqnZsJzwuMKikPssqj50PyCfx3sJDZzu4bDzEpncE5+bWawvBO
	X3pnhyt9k1ruCoSid2CRaVGddaDsp7zlXL2HTkuE+3tUVHCZYok6mEfn/1O/mC8QNUxIpQYQcIk
	itgT8/kNfuqAwU12D/hd3U8GtuF3ugPI3jWHSJuq5LoE7x5FhG99uUf5hlbOVTvvcxSk9hyaTxj
	QLu2bWPCfFIEC9Hj
X-Google-Smtp-Source: AGHT+IFcWIgqQVS1ad8XvDlZW1SpkmPZ4PPE2Z6bjTkyVgR7q6YqNhJGD2CRAjafvPEWFkkLP8m7xw==
X-Received: by 2002:a17:903:1cd:b0:216:526a:53df with SMTP id d9443c01a7336-217786a2d42mr3306145ad.54.1733858055890;
        Tue, 10 Dec 2024 11:14:15 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21659e7b7eesm33797255ad.9.2024.12.10.11.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:15 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Rob Herring <robh@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-acpi@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] drivers: base: test: Add ...find_device_by...(... NULL) tests
Date: Tue, 10 Dec 2024 11:13:33 -0800
Message-ID: <20241210191353.533801-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210191353.533801-1-briannorris@chromium.org>
References: <20241210191353.533801-1-briannorris@chromium.org>
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

 drivers/base/test/platform-device-test.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index fd871bb9e143..f9d1a269a479 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -2,7 +2,9 @@
 
 #include <kunit/resource.h>
 
+#include <linux/device/bus.h>
 #include <linux/device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #define DEVICE_NAME "test"
@@ -203,11 +205,37 @@ static void probed_platform_device_devm_register_get_unregister_with_devm_test(s
 	platform_driver_unregister(&fake_driver);
 }
 
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
 static struct kunit_case platform_device_tests[] = {
 	KUNIT_CASE(platform_device_devm_register_unregister_test),
 	KUNIT_CASE(platform_device_devm_register_get_unregister_with_devm_test),
 	KUNIT_CASE(probed_platform_device_devm_register_unregister_test),
 	KUNIT_CASE(probed_platform_device_devm_register_get_unregister_with_devm_test),
+	KUNIT_CASE(platform_device_find_by_null_test),
 	{}
 };
 
-- 
2.47.0.338.g60cca15819-goog


