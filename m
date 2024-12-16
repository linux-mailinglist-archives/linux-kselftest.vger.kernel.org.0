Return-Path: <linux-kselftest+bounces-23430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7929F3A7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 21:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DA2161BD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C283D1D4341;
	Mon, 16 Dec 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CNdanyNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B01CDA15
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379921; cv=none; b=fn0fbZoByfWJv8X7Rky/OlOcoe+apDD0p3nL+R0qR/PIdnqAlC4bNTrrSlSguQ/FnrOXpNJ3bdNjnJNC0WYHaWzembDCEKjSS/KKIwFztNiw/RXKc0CLFE/nFRCX7F76sYHCBaw1oreicM4RdDTEs0D5ju5VFDQqLJLAh/Vm3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379921; c=relaxed/simple;
	bh=7jxU4hpAwSWmevfX99YkDoTD1JGxKAVZgzPD8jgn35M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCHt8Jbl8phvdbYMLVkf9iWvFQCbrS8rWe7Sbm4b2kjYQsY+nLaqPHgBvQXAWs7VdfNfIqzqL+ieSkRrmA/hWGS5BVJo1n3wfNZd/xP4e0u5jrmWE/1wouY84613e4P+EQobyUWub5kWq3PfoUnP/HffBxq1thEVUWKwxNpvLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CNdanyNU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725e71a11f7so4091047b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734379919; x=1734984719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rqa++bQfJwX3ua/s3cRo3Ckug/2w2jf2s5usPRs7cJ8=;
        b=CNdanyNUq4OPpiruLbQnSyqtd0ycqSKEQxMIWRqYCAScBtfZEnK6Tjy9U3l7hErlNH
         tIgU500AGccqO4DY3FmhY6Tvk9j6RTNs9C+AJE/ufTzIjYMCqvZ0HzdpaojP2FrhRImq
         4ZJu5yKy6pyFMHRA//y+PJflXxBL4BCEaczSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379919; x=1734984719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rqa++bQfJwX3ua/s3cRo3Ckug/2w2jf2s5usPRs7cJ8=;
        b=otvMQrX4tl+/tUlV9UFIrTycaypb0do1wkJlDDcP4m6aN3fB5e3upHvFeHS124Ymbh
         NMPYIJf3ZpJE5uqGFFjxvmN6Ym7HlHAs+HAgAaZ1tMUvX6Z5BjH87WI1ZN2gaFXgesSR
         GP6YfRumX8jeOQ0R2lkbaW0tT1WCrH2Fmc6nxL13KpV3lKZ9yQUBVrQMVTAn2Zj9TD95
         YxU8gWvGNB6NdJmBeMktOUOtvMztHH7cvzv1Pc/M6Nxj7rgftXhOaETKgZlhDvhWQLIR
         9moHLlZvJ8EuDHN8rbMg+w5CiI7n2mY9U712o/CiodHSZ5Vokbcrl7FDZmL2eUrA985m
         YR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMlna6Nh5Ja/eHf6eK62lM0mMdbzB2AhIqMPsQwZJxrdhCEQxEamNP6H4tvm3x8u3DO7TiHVe7zqqzw4nxOPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFokqmx+a4L4HDLRoaP6mgMn0jk50begosdRrEN0I7g47W+EEk
	BkJOjBJYRA1foXnxnM5OuQ/XXlOHugM4pbzYvL9mAJl+2H983l259/wdnd48pg==
X-Gm-Gg: ASbGncuaypREvf9H3Xh5G/Z8cSPlSP9VS4lkG9lZPpbkuBtb9Pb0bPRgMMbrCc7SUXf
	ZcEu2GdjdDdO8xgb4/gdaP6FnJFfJUjN7soMMEOCq3kvMD3LGV0yKNC0zte2wROgFoc1EwkWXn+
	v+FXApu6XFfbrNPfhF3LQBCD6KIehfjB/sTQp5vJREAqFISJSNuwuLkFHNi0lIFNRbmYqMVGK7q
	URMaty928Z23IlXJD21032XXsBIkbScHqNBveZukQMeylC6xRuV2JTlcKG1lYcEYshD7wELWeeJ
	xQwweqE6roIUUl7BZw==
X-Google-Smtp-Source: AGHT+IFgqfe+kqsUtZy9+xGWMGhOgzZuAgj5lfe6mAr4/ZjzImfvHLnClnHam5X0h2CYqu1MJB3xkw==
X-Received: by 2002:a17:90b:51cf:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f2d883bf1emr990096a91.14.1734379919583;
        Mon, 16 Dec 2024 12:11:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:953:5b91:a52c:e817])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f142d90bcdsm8423943a91.5.2024.12.16.12.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:11:59 -0800 (PST)
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
	Brian Norris <briannorris@chromium.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 1/3] drivers: base: Don't match devices with NULL of_node/fwnode/etc
Date: Mon, 16 Dec 2024 12:11:42 -0800
Message-ID: <20241216201148.535115-2-briannorris@chromium.org>
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

of_find_device_by_node(), bus_find_device_by_of_node(),
bus_find_device_by_fwnode(), ..., all produce arbitrary results when
provided with a NULL of_node, fwnode, ACPI handle, etc. This is
counterintuitive, and the source of a few bugs, such as the one fixed by
commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
one actually exists").

It's hard to imagine a good reason that these device_match_*() APIs
should return 'true' for a NULL argument. Augment these to return 0
(false).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * Add Rafael's Acked-by

Changes in v2:
 * Add Rob's Reviewed-by

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
2.47.1.613.gc27f4b7a9f-goog


