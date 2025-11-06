Return-Path: <linux-kselftest+bounces-44998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83CC3C133
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98AD3A5CC8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79ED292936;
	Thu,  6 Nov 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVgZ3Vcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB07285CBC;
	Thu,  6 Nov 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442851; cv=none; b=BGP3QmW6JeTHjI7Bg61ewtlnD3QFk8huAVlB2n8elUjTVGgmJunH5NoViJtRc1cZJWPZYFXI5pgi49/sJJSFhG4WICPpLxZw6dZWJ5h9Cw2dzdVOP37+RHmGrpHebdLWX/ObIZWx6CKHCLkydKJlQd1Y8gHU74SVoXdZurxSL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442851; c=relaxed/simple;
	bh=GZJO0mqOhLSQMonvKqfXrhL4G4CZm9kSIbw5nb64HL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TULf/hCVdkZJ+vG2Nyn6y9k6YsdmMr0WwuXzW/xFFK+8lIHQ2o5SglyJIGYg7CqOmYIEFZIQv0+zsT5SlS6TCe8GLwUwN5ElfOaOH1iFnuhl7IxNtWENJfnMqIZuUnbqTV7TSsC7q6Ji6TjJWaMUtkSFxPjmqvOAFeAmcIf9dI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVgZ3Vcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA66C19422;
	Thu,  6 Nov 2025 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442851;
	bh=GZJO0mqOhLSQMonvKqfXrhL4G4CZm9kSIbw5nb64HL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVgZ3VcgXUm1Vfifg+nUACrb949rRQWgwqaLhzAU+BpUX0a8E5VKAExuwogu3RmcU
	 z3wYAFpND5Lw37fEcgUHyI3n0AlBU+RHpQozNY5vQSSvyqstLI+JJwwExc3xitCW2m
	 /IGoTvjILYVg+cDeY6YkLMEVNK3AaU/MlvF1g1QcxAh9zMr6WnWXX8mhGhkFxCIdxJ
	 o4TZ7VFYicnKdoqNiBSqJmWTHPNhCgLjNMFFkD5CBqnmwxqe+RfqKXA4Tb55vuCwAp
	 wR1G2JwOv8uTn5ad+u0kAFuEn4tsoRn4oGqHPkMF+XQjE1UrChlicyFZ01YqLNspdG
	 bR1YV9pAe9JWA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 3/3] platform/chrome: cros_ec_chardev: Secure cros_ec_device via revocable
Date: Thu,  6 Nov 2025 23:27:12 +0800
Message-ID: <20251106152712.11850-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106152712.11850-1-tzungbi@kernel.org>
References: <20251106152712.11850-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miscdevice now supports revocable fops replacement.  Use it to secure
the cros_ec_device is available.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Modify the API usage accordingly.

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-8-tzungbi@kernel.org
- No primary changes but modify the API usage accordingly.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-8-tzungbi@kernel.org

 drivers/platform/chrome/cros_ec_chardev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..a7543e1bc07a 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -385,6 +385,7 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
 	misc->fops = &chardev_fops;
 	misc->name = ec_platform->ec_name;
 	misc->parent = pdev->dev.parent;
+	misc->revocable = true;
 
 	dev_set_drvdata(&pdev->dev, misc);
 
-- 
2.48.1


