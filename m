Return-Path: <linux-kselftest+bounces-23233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CC9EDC8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 01:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0DB1674A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16611CAB8;
	Thu, 12 Dec 2024 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pp9QeeFR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180EEAD0
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963531; cv=none; b=mRfPpj+4COrwF1RD12rDEDeuaz7kkH798NknMNQvf6p380+THUM+11qbfbz83LvSV8wK3tWkPSZCTqWZ9RGCgIzaZ4hhUq6kyjlaNSmltUs18n+rpmS7EronwtHl2lWZ4Spwu/bghQ33p6Zi4Oa1+XCVZwejhoyYmqzU5c4axno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963531; c=relaxed/simple;
	bh=Kd6noYu5kKaYuzY2in9AHzWwTWDE6GDZOmHXqRdwZq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmZ4foWDzP99VtJC4ljR5EIwEdVyfg+39f9MimSgGBxgiiuvdc5xc0O6kUuA3+BDOWy9ZdTXRYBuffiTzVaSRjxoCDG9EWHINTirPlWD8ddOOQ14c1uuuviwGlQTdl8pT6Wx/rVqmuRkVGMn3Lm9HGUCHQjv/ztD6iBSJj5qTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pp9QeeFR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216401de828so261165ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 16:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733963529; x=1734568329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGGmVpvyGZhHzPnoBu+k0MVypYw0iPNz1iJuuVrkK4k=;
        b=Pp9QeeFRfnoMlCiiurrzdJkSvsudEVGzZvOCuEawQ413F15UbpFsEzWHAww5e5YBX5
         fzCWEP/KFSJ7RgviBE8CpnHpjfbV+sw+1ub8DhqAACBAn4fWZ+CAKp7aZeRXNGOvM20T
         DtB+S+i+IszUzirH0wpt7FPHHPGK8XgUO9eLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963529; x=1734568329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGGmVpvyGZhHzPnoBu+k0MVypYw0iPNz1iJuuVrkK4k=;
        b=RsF2iO+sei1fpjHCnIuz7kZrBQoYZSn1gpXFHPLPMeW9KwGH235dXSDap5Ck5taFuf
         TueM5hixCNnGmSlyiSLNJSMKyi368tVyXdDScANKGoEXnz9tkb/tv05kjKlvVbvhbAuu
         bj+0u2FAmFPSRTlMVRs8aQHfh4S3KSSUO1bYAC9Ki7ZnxcgmVPG0oa2XvWI5/9linD61
         TO5S3/EqLzlWst7DP/Z09FMAEol9JTyqyavQPHGqxWL+bumVPzoJYMLWLj0MbemUCWWH
         Rzmj++eEqzhbF/LnPwyVhVjG04X2uMq+OvSNaL7NVqTq6/SktU5PLQ6NsMP8ToKizggG
         xbzw==
X-Forwarded-Encrypted: i=1; AJvYcCUZy0AyX+nVdcVoEjYjSv+gnaCg7b2JYRJGx/HpO613lmtRUW/mvXdzlaKCjRHkMoOw/7ELYsryyC+/rG5gRdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0Dz1K9irc6F8PnqJeJ8iQ3aOwHpDhBqxTr+PZW2VDtKdsSTU
	q5ZsJkoA7qKJLcL4o7hUZ4rj4sCfs0WcVMUpG0cGS3++mQQyE7/dmRVsRecPrQ==
X-Gm-Gg: ASbGncuolEPHzTqby7wTi4az+hkqRzDpD39sf0PoZXJua9A+gW0k22sMgyiMoLGOSFA
	rhpYr7pByABfWiZEiEape4gdS/rZscV8r7e1EE74KIFXz6EYZFOHOGSfDTmvm+O8GYoU5O5Cchj
	8H//LjI50cACONmGe2GcBHHK6HbTiSfjcOPtZTUKrtwoo/SOoaS9VMPNmYXhUEMJkGX3tqL1XrP
	PK1ssrH22SDPT75b0qbCmZ/hOVgqTzJc+whkfPGOgVVu4xCR0ji+tSSXwt82hvsUsGJd7+KbCVh
	9vfTN4sGv1vfW9i3iFM=
X-Google-Smtp-Source: AGHT+IFSuT2+ENL2AFZJMBD75mM9b3DCrYPiGx2+DNGXuCjKQhYTfFJJzw1Pi1HU4HlUFrZS1ojuOQ==
X-Received: by 2002:a17:902:ce92:b0:215:e685:fa25 with SMTP id d9443c01a7336-217783b7a08mr70313815ad.20.1733963529631;
        Wed, 11 Dec 2024 16:32:09 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21680814d6bsm25853825ad.157.2024.12.11.16.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 16:32:08 -0800 (PST)
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
Subject: [PATCH v2 1/3] drivers: base: Don't match devices with NULL of_node/fwnode/etc
Date: Wed, 11 Dec 2024 16:31:39 -0800
Message-ID: <20241212003201.2098123-2-briannorris@chromium.org>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

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
2.47.0.338.g60cca15819-goog


