Return-Path: <linux-kselftest+bounces-49111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B5D2DD2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3294C303C21E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6352F83A2;
	Fri, 16 Jan 2026 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3rRea7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9492F3C3A;
	Fri, 16 Jan 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551089; cv=none; b=RxnprBzWAj/xmePa4Lx9weLRTD3T9fkVPJLCo0m80ICwPvIVZi/Qe5NP+Pw5OTNAPRvQajfnzQnjm//XhN1xnBd4oxZr4lhKdB0vJHoTyaLq1kZY8I3Ggt5b9DSJZVTL6S9ZlREDA3FkmIKjCtQPe97j89qHNxIRzMmKIkfD9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551089; c=relaxed/simple;
	bh=GC/uWzNd9Cgwf0kvxoP9hdlYQkvXpoHMVq0emgkNJDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b93pKrKka0J6d1msrUL2I0dnw5t1iLg6StLGQD8kBfrSFJ6EEULiRfWyth/TidVCgEeSC3GxAqQtrRV+S/N2QlCHtGxCCTpuTtWaesQNlAZbrB5QVJK8kpCOAgemtrECAhJft+T9MHLwDvQ3vsoCoZYfkJND0MUW0JwpWrdd/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3rRea7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BA2C116C6;
	Fri, 16 Jan 2026 08:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551088;
	bh=GC/uWzNd9Cgwf0kvxoP9hdlYQkvXpoHMVq0emgkNJDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3rRea7UQvNpjGQKVy26dBK2ld16DMixcF/0WfCpLFYNRF9Su3HyvDBJF+e6UU52S
	 HZYXU6x3YqxhlLhvPNg5FmsAKyHFaOUmGwkKdxz43sd1W2NWPnNtMV5mia09HXYdZN
	 PiKj5hq2w43pRuzySTW5zr/8JjccO+UoO0fPB5nRUW5Ae6ZSpWHYlMKhgJ6VT74ApF
	 TTB3Q3kC0m3jT712aTF0NDlAwkSXCEcD9uSrR5y+qNt5A9SzUmEFdM1H20D/jISxY1
	 BtuoSvTQnAVIGco2/7u0/K2AXXcJA9AhzyKZKRZLItO2KE8dKeasHIPi/UX3Lvb2RL
	 AfiZWDBunif8A==
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
Subject: [PATCH 07/23] gpiolib: Remove redundant check for struct gpio_chip
Date: Fri, 16 Jan 2026 08:10:20 +0000
Message-ID: <20260116081036.352286-8-tzungbi@kernel.org>
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

gpiolib_dbg_show() is only called by gpiolib_seq_show() which has
ensured the struct gpio_chip.  Remove the redundant check in
gpiolib_dbg_show().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3242644eebc6..42da3bbc5ab8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5313,23 +5313,14 @@ core_initcall(gpiolib_dev_init);
 
 #ifdef CONFIG_DEBUG_FS
 
-static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
+static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
 	bool active_low, is_irq, is_out;
 	struct gpio_desc *desc;
 	unsigned int gpio = 0;
-	struct gpio_chip *gc;
 	unsigned long flags;
 	int value;
 
-	guard(srcu)(&gdev->srcu);
-
-	gc = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!gc) {
-		seq_puts(s, "Underlying GPIO chip is gone\n");
-		return;
-	}
-
 	for_each_gpio_desc(gc, desc) {
 		guard(srcu)(&desc->gdev->desc_srcu);
 		flags = READ_ONCE(desc->flags);
@@ -5442,7 +5433,7 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 	if (gc->dbg_show)
 		gc->dbg_show(s, gc);
 	else
-		gpiolib_dbg_show(s, gdev);
+		gpiolib_dbg_show(s, gc);
 
 	return 0;
 }
-- 
2.52.0.457.g6b5491de43-goog


