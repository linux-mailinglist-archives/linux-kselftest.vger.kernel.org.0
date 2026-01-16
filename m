Return-Path: <linux-kselftest+bounces-49110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889CD2DC2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33CAF301F4BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F02FB962;
	Fri, 16 Jan 2026 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU2JTU3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B32F1FEA;
	Fri, 16 Jan 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551086; cv=none; b=m0CNhDJP+WCgDYEHD8+e3l6rSK88piadDUkHAdcIIgh7ilCETAQ0rX4H/kxHA+dxbYer+XdxxrsFblC6i0sV/n8Y+FmMrXOsfujqTKYgJ/4kBg5Omk9OyzQNZfZm00U2XXiTPTNEzui6wHEWL/zPVoctcwErw2QcCHGPf7CcUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551086; c=relaxed/simple;
	bh=fTYVnQxEYS1t/0ZMJZL2v8EXREbfgEEsWwMOvi95LOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw2riRgI0dmnrs/wjQp4NU0AtQs4Zww/DKFpD+6qoO3pdTOjsL8LKjVuBvPSgUI7izggYXAMZLeHeAj7vnWVWF/FxfSx3NUihvzucWrcW0dhIHa/kOoeIflLIm9f+0ecLM1aJfcxpOOsXJVzoC9sVtJbUSvQWb3KcH1n7pPD/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU2JTU3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2462DC19421;
	Fri, 16 Jan 2026 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551085;
	bh=fTYVnQxEYS1t/0ZMJZL2v8EXREbfgEEsWwMOvi95LOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZU2JTU3UikNeUg/65/kqPwX/u1kBvveAHxU438lR+3bUHn1nhxH18nRJX9nPzXrXe
	 LDE3Y5+LEGxcbo9G8P73eTVmb4ALiGokX1r3yE6m/De5mouLJagO3yE4wp/7lJrxP1
	 ELB/F6VrET77PcnGz11YbVAx6CvfDzQL/h94GkPwSbqqzQw3pjC37N+HFWDE3Igdpb
	 NG+nHOYqNGNilS4RECr6HVTDGLiAl7YWubPSEX0lSIqvLyyUFIcmOejlvUivobH3vM
	 1zJyrt69fPkeFgsaFG4xQEeWxGnMEbZYQujnTO1388gnjCuak+I+kAZNU+8Z8nqaMD
	 gsUVkCUlFGnhw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH 06/23] gpiolib: Access `gpio_bus_type` in gpiochip_setup_dev()
Date: Fri, 16 Jan 2026 08:10:19 +0000
Message-ID: <20260116081036.352286-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
References: <20260116081036.352286-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make the intent clear, access `gpio_bus_type` only when it's ready in
gpiochip_setup_dev().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6fac59716405..3242644eebc6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -902,6 +902,8 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	int ret;
 
+	gdev->dev.bus = &gpio_bus_type;
+
 	/*
 	 * If fwnode doesn't belong to another device, it's safe to clear its
 	 * initialized flag.
@@ -1096,7 +1098,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	device_initialize(&gdev->dev);
 	/* From this point, the .release() function cleans up gdev->dev */
 	gdev->dev.type = &gpio_dev_type;
-	gdev->dev.bus = &gpio_bus_type;
 	gdev->dev.parent = gc->parent;
 	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
 
@@ -1217,8 +1218,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 * we get a device node entry in sysfs under
 	 * /sys/bus/gpio/devices/gpiochipN/dev that can be used for
 	 * coldplug of device nodes and other udev business.
-	 * We can do this only if gpiolib has been initialized.
-	 * Otherwise, defer until later.
+	 * We can do this only if gpiolib has been initialized
+	 * (i.e., `gpio_bus_type` is ready).  Otherwise, defer until later.
 	 */
 	if (gpiolib_initialized) {
 		ret = gpiochip_setup_dev(gdev);
-- 
2.52.0.457.g6b5491de43-goog


