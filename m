Return-Path: <linux-kselftest+bounces-49108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F95D2DC13
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A86C6301C389
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8A2F5461;
	Fri, 16 Jan 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3XUOT9x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81412F1FFE;
	Fri, 16 Jan 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551080; cv=none; b=QPfnGJgiLtiw0d5pmPx+31iH1nrcdp95H1Regc1Gpkq4EoE5DZ/NmraCM9vKAo+KevJLzPkfBSoW65HgdsPZId23rRFkMQi+5fBtIcWurTcp6yT5DDjR/6I2+nbBcypJlr2oa++UsglbGwduIcdJDN17OgtTa3wDYL4StAaHR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551080; c=relaxed/simple;
	bh=+pdsJdnw0e6CgNzg4q3pECB1UCPt4pkMgJeLtx5zHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl0ZkKNIcppmVLJzgS/W4fuEXZ8semiiqCPUTxLVQDV/PplVLdem4UK5hjNjHp4OjfpjcWmMbZYwlugUegnDFZjjQinw7lPb0kOJ8YOSYxhLn35FXzB3167L6cNBxxxH+UyDMvPbN/BKe3PX/p8WL8WcUd+9Mx7VGac0FNVGnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3XUOT9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB24C116C6;
	Fri, 16 Jan 2026 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551079;
	bh=+pdsJdnw0e6CgNzg4q3pECB1UCPt4pkMgJeLtx5zHPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3XUOT9xkwKqkmdAffSWXldXJj0/+eo4FlbnGu9FSNVe23hh4Yci+1vufQ1v7M2Qf
	 yMBri8mq3HgNjuPUkmu7CEeyx/28lMXjbzAOUspPGN2oo0yeXdcxPOJKessZWrIVdO
	 RASo0ccdkF/obM744J79YH6y3oqKxwOB1CvMgdqf4mEo5ZhbqT8NRjj3CcNS6xnq9X
	 h/2lsQsbbrLQytmCMTle/47vpetVTJDItPOA2d+BUYuS2VeJYlO7UA1oE0QKSHpZAR
	 gmcMdlaYwnY/DgNJSaRJq31wKKrHF+/ovN2xZ23DBp9qtbxe0vgaJJY8ge6gmdZSdF
	 BOsNZ2a7SB8yg==
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
Subject: [PATCH 04/23] gpiolib: Fix resource leaks on errors in lineinfo_changed_notify()
Date: Fri, 16 Jan 2026 08:10:17 +0000
Message-ID: <20260116081036.352286-5-tzungbi@kernel.org>
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

On error handling paths, lineinfo_changed_notify() doesn't free the
allocated resources which results leaks.  Fix it.

Cc: stable@vger.kernel.org
Fixes: d4cd0902c156 ("gpio: cdev: make sure the cdev fd is still active before emitting events")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ba1eae15852d..6196aab5ed74 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2549,7 +2549,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx) {
 		pr_err("Failed to allocate memory for line info notification\n");
-		return NOTIFY_DONE;
+		goto err_put_fp;
 	}
 
 	ctx->chg.event_type = action;
@@ -2563,6 +2563,9 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	queue_work(ctx->gdev->line_state_wq, &ctx->work);
 
 	return NOTIFY_OK;
+err_put_fp:
+	fput(fp);
+	return NOTIFY_DONE;
 }
 
 static int gpio_device_unregistered_notify(struct notifier_block *nb,
-- 
2.52.0.457.g6b5491de43-goog


