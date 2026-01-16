Return-Path: <linux-kselftest+bounces-49122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B4D2DD16
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A38A309FF46
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1315304BB3;
	Fri, 16 Jan 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6UgG//i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B22F8BCA;
	Fri, 16 Jan 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551122; cv=none; b=UQuejwD5HC0iT0kgn5kzUKkwAt1b9Sj3RwKqnJjHQjpWFoQWMcR/RWUne1MJhN9qVvgCi8/MJBz6zbEDXemYM/oAvs5Hlgian+8zqpk+o61G/hvniCX21iW8INiwy/DC52Z/gU1KK68jxUBY4LviQdTo09brLs46wI2fhenjYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551122; c=relaxed/simple;
	bh=M97oTgnSw1sfrxSklOHkGQxBKG5c3HS0FDf1iP0ruEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZyMJJHrhWF6bLMYWnYwO083x1TsmCEv8BsmgAY9xACUev9/U5cXg8RqSiQadAxbL5ig1L7joQ2PDfu9U55WrmPMLKRyr0rMix/qizAsCrsLIxhA/havUA7r1RXpeNf3o78LNPA3FKBUtx6Nm6C5swhaz4xrE7d+hA9KK0wezrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6UgG//i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7501C116C6;
	Fri, 16 Jan 2026 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551122;
	bh=M97oTgnSw1sfrxSklOHkGQxBKG5c3HS0FDf1iP0ruEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6UgG//iLeUIMluCggL3whL1Zmotux70J3SW+L+WErFMIyvBdcvfE04jj1OX3fbRH
	 UYuAXwPx+wWPo+/7SIw9YFu1tm48Ug6pRH9cRfQhvx2KghKCoVBNYIt13z8mz3EA8L
	 ecRms+75hOxbfG/O9hykqcOy/AbAVdbg+/vH5wRoqOqhkhRA/XTP+Ka0tQY9LRkZTz
	 6FsHEnMdc4/++tM7JqEV0Nl2t9R0T/kWWOk4yn8vphGy1p6WWcJAVsLbwoqM229/75
	 LknmArbRz5R1i3yfS7ms/sgJxSedLHRBWIrL/AXsd7iTrLypcsiKN0LX5FDw9TRp6w
	 jK6x18bF/Knug==
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
Subject: [PATCH 18/23] gpiolib: Leverage revocable for gpiolib_sops
Date: Fri, 16 Jan 2026 08:10:31 +0000
Message-ID: <20260116081036.352286-19-tzungbi@kernel.org>
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

Struct gpio_device now provides a revocable provider to the underlying
struct gpio_chip.  Leverage revocable for gpiolib_sops so that it
doesn't need to handle the synchronization by accessing the SRCU
explicitly.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6226dc738281..cd18ff42b610 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5376,6 +5376,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 struct gpiolib_seq_priv {
 	bool newline;
 	int idx;
+	struct revocable *chip_rev;
 };
 
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
@@ -5397,8 +5398,12 @@ static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
-		if (index-- == 0)
+		if (index-- == 0) {
+			priv->chip_rev = revocable_alloc(gdev->chip_rp);
+			if (!priv->chip_rev)
+				return NULL;
 			return gdev;
+		}
 	}
 
 	return NULL;
@@ -5425,6 +5430,8 @@ static void gpiolib_seq_stop(struct seq_file *s, void *v)
 	if (!priv)
 		return;
 
+	if (priv->chip_rev)
+		revocable_free(priv->chip_rev);
 	srcu_read_unlock(&gpio_devices_srcu, priv->idx);
 	kfree(priv);
 }
@@ -5439,9 +5446,7 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 	if (priv->newline)
 		seq_putc(s, '\n');
 
-	guard(srcu)(&gdev->srcu);
-
-	gc = srcu_dereference(gdev->chip, &gdev->srcu);
+	REVOCABLE_TRY_ACCESS_WITH(priv->chip_rev, gc);
 	if (!gc) {
 		seq_printf(s, "%s: (dangling chip)\n", dev_name(&gdev->dev));
 		return 0;
-- 
2.52.0.457.g6b5491de43-goog


