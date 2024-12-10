Return-Path: <linux-kselftest+bounces-23120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADA9EB9EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 20:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C2718854D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EFE214211;
	Tue, 10 Dec 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RM9p7KhX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05111C3F13
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858052; cv=none; b=Pt+boTPJuVL7/HlMRhPK593bZoh0RA70kh0Ayc+mp69euLQncsJeFoqXoxVkLI8Ba6JEr570jHpa1/azQXWrOZDWfO399Zl3wKPUvpDct2H2U+uMr9vaDK2lsMmJJOt3hdRAHz8XrhzuFzowvih2s6A52VDyhOQ4vnekWg+c0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858052; c=relaxed/simple;
	bh=LMzslre59gBSKbdGtmcX0vce8kxfJLik/pThTrlPDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBbMNjgBu7hf6/pFNo5T3sFIZD+mGy2GTsbWziwhmGkxbU/UzP4gTi1WGnSlrFVhND0pHDtWPp0SSkJAQZ+677HJ+AVV7X3WvnGwuWBLy9oEwB3fZhMCMpEdXSbs0PZcNbpgxUDYPZSJ5sNgCJXo5UPANWPBv306sIY4UR3bBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RM9p7KhX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163bd70069so28752295ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858050; x=1734462850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1VV7jv6a8iTXSgTXT3A313mUq1AvY1/xt0iu6Jh1cU=;
        b=RM9p7KhXbG7UG1Of1i4R+n5+d8vVJzeyCJq2QPh6Wb1H2ypCegcHUHbAQ4/gPNU2C9
         yKeB//7Mspd6DeIIUZe4KWftJCTwBNjEE6abjqNGiz1GmUxwHgr2ZUjSDjEhednwTjsX
         qjV26SJDXiKLJ/wR1UsH/lgwwIxGj119p0HmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858050; x=1734462850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1VV7jv6a8iTXSgTXT3A313mUq1AvY1/xt0iu6Jh1cU=;
        b=kABh5hKO4DmhLRIwdSZVJuCjCmRnVPJYLSn2ftyDkL8QB6xKQQKeWrF1LC+6QQcka6
         A6IDkXyHges63rdUGjKao751/6jbUn1Xz+NLxnRqXaeY7njHZyHlB3vvTBnXtj2mpm/i
         XTFxdMqXqDj2a5geIkwoJ1KQd14TxKrkR/kfj90vuonyC+2qGlAGbuT5naZm/hjGNCm+
         VLgj9fAuTzChDUNqn9gD2h3RLSvRIhKJHTVASN/JQPUNpzbwFDt/kvgSOrmNKFf5NmQb
         USOEtX+VZujLy+aiU2mYJjkOFYccJfQ88n3ClEu8Sye+54+4HRkIe5lKP9VtWfhPTlWn
         r1uw==
X-Forwarded-Encrypted: i=1; AJvYcCUfrFFVshfFN3psQD9bFGFZOgZqWq8lB9C+vi2dhnmemeFgi3/1FWyC+6XDxILixck0zMsGYoWPV8sBEsBf4tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqdVgjMv4qrQk+02EpSgg9qLlp+wYbkLF1jLVger8f/io9gA8
	R4IA4U1ehty8dI4mB/sPf79v/6J85y4WNtglG/1ztfdHDk5Smd+v6iJeZE9x1A==
X-Gm-Gg: ASbGncuIYA+SjMymCMWQ/23LklFL0xQNydDx7jsBo9Bo6Fpn+KwcGDr3siquU0SSdCG
	+gaWZ8EtnKMfiJxyqp1ut76gX3IuA+AqLulZ6nM6jouAm1CRhgWHhOlCCw2/c/YzqA4LaqIVIJc
	Yk7wcypOHR9+1qSQ05aJbqiqkuxbmXIdx0g8id36UvdJ43hdAIp2YEmFfW/yPuLt8gct2w5wQKV
	PeI4vSY75gjs94xnzJxsiUMtVExuroGT3UvXbiKCXsISeI9HYvIgdn6eqzJAgeAu0NoF0SSDgjn
	LF/pyFKgmnkqg9UA
X-Google-Smtp-Source: AGHT+IE6haXYh8F2R8TB8U0iP9CV9F+e16h/v+MqPXwC2fQ7dKZF73gUnBnR/i+bSQwBHLpqHOAl6w==
X-Received: by 2002:a17:902:d481:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-217786a9bb7mr3112145ad.47.1733858050369;
        Tue, 10 Dec 2024 11:14:10 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-216353ab708sm53576155ad.182.2024.12.10.11.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:10 -0800 (PST)
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
Subject: [PATCH 1/4] drivers: base: Don't match devices with NULL of_node/fwnode/etc
Date: Tue, 10 Dec 2024 11:13:30 -0800
Message-ID: <20241210191353.533801-2-briannorris@chromium.org>
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

of_find_device_by_node(), bus_find_device_by_of_node(),
bus_find_device_by_fwnode(), ..., all produce arbitrary results when
provided with a NULL of_node, fwnode, ACPI handle, etc. This is
counterintuitive, and the source of a few bugs, such as the one fixed by
commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
one actually exists").

It's hard to imagine a good reason that these device_match_*() APIs
should return 'true' for a NULL argument. Augment these to return 0
(false).

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 94865c9d8adc..2b7b13fc36d7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5246,13 +5246,13 @@ EXPORT_SYMBOL_GPL(device_match_name);
 
 int device_match_of_node(struct device *dev, const void *np)
 {
-	return dev->of_node == np;
+	return np && dev->of_node == np;
 }
 EXPORT_SYMBOL_GPL(device_match_of_node);
 
 int device_match_fwnode(struct device *dev, const void *fwnode)
 {
-	return dev_fwnode(dev) == fwnode;
+	return fwnode && dev_fwnode(dev) == fwnode;
 }
 EXPORT_SYMBOL_GPL(device_match_fwnode);
 
@@ -5264,13 +5264,13 @@ EXPORT_SYMBOL_GPL(device_match_devt);
 
 int device_match_acpi_dev(struct device *dev, const void *adev)
 {
-	return ACPI_COMPANION(dev) == adev;
+	return adev && ACPI_COMPANION(dev) == adev;
 }
 EXPORT_SYMBOL(device_match_acpi_dev);
 
 int device_match_acpi_handle(struct device *dev, const void *handle)
 {
-	return ACPI_HANDLE(dev) == handle;
+	return handle && ACPI_HANDLE(dev) == handle;
 }
 EXPORT_SYMBOL(device_match_acpi_handle);
 
-- 
2.47.0.338.g60cca15819-goog


