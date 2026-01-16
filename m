Return-Path: <linux-kselftest+bounces-49105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A964D2DC4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F41330A8389
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB22F1FFE;
	Fri, 16 Jan 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikzfgt9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246A2EDD57;
	Fri, 16 Jan 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551070; cv=none; b=OxF1DajeOlY9RdvVOlaPw6Tzsnd2XXhNxgfxm+btAIjQjJzGsoEhTME9R96iKLTIG4aAkvqplUhd5sNArpuJ+gH5n4MavPCkQ4XKiDRdVIgQy/mrpbJ4hKy1AUJMVRUarj/1Ue6GOppKLTXuJZYGBAhXlyyX+UhyOUuN4Btf9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551070; c=relaxed/simple;
	bh=NaRA1uc76ad6S3cdm3cYzD/8X6vYxOm/vKCplm42B0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPwEW/4T6fYrCHPTjKeSU1sugVabKueLE8Fd6YlGQZsOgHge20PaBrYh+7G0YsY519ADeZniwO9AR0QI/7pBI/GpOdsO/mAM/dtJ4NVp2nMYubLwYTkQvZ9Ha53P91jxVjYq5HiZB6BqKUNKi1aQBaUixSJtPAZtZN3o3qIc8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikzfgt9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ADC19425;
	Fri, 16 Jan 2026 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551070;
	bh=NaRA1uc76ad6S3cdm3cYzD/8X6vYxOm/vKCplm42B0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikzfgt9v3EEPMDDgymCkftGRcMvUTHk2iKLjpzF5CTSJNIRpl6yexOby2ZyhyiLCI
	 9qNfRG+aoc8yCngd4/IDH24Sq51yhPhYsG6mVdUi39NW5+r+hDdYYkFDOb+qg21e5s
	 7Id2RAIt+3bPNUL9hZAQmlhzuCLqsBXgejKNXUBdy8Tw5kiNa2VriybRosxrbW+IKH
	 4MwZS1Ce8nKe6zshkz7F8Zj7nrv6Gq9phHXAk8XPQV8viUmSzCNoWSde3UCvCsrNPS
	 /6foe1FJ1jyZcVZFH3uyjZ40+h/dOC3FMY3wpu197vQ10WJthSs87hSasc8J8vWlH0
	 75C2AkKtb/bDA==
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
	linux-gpio@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for `kobj->name`
Date: Fri, 16 Jan 2026 08:10:14 +0000
Message-ID: <20260116081036.352286-2-tzungbi@kernel.org>
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

`kobj->name` should be freed by kfree_const()[1][2].  Correct it.

[1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
[2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695

Cc: stable@vger.kernel.org
Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix kmemleak")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5eb918da7ea2..ba9323432e3a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 err_free_descs:
 	kfree(gdev->descs);
 err_free_dev_name:
-	kfree(dev_name(&gdev->dev));
+	kfree_const(dev_name(&gdev->dev));
 err_free_ida:
 	ida_free(&gpio_ida, gdev->id);
 err_free_gdev:
-- 
2.52.0.457.g6b5491de43-goog


