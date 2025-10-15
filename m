Return-Path: <linux-kselftest+bounces-43203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B62BDED2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080C23C3FB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F178215191;
	Wed, 15 Oct 2025 13:46:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721202AC17;
	Wed, 15 Oct 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536006; cv=none; b=Xmdsjg9PZTUU3G2Lo2Zi/yucvl7TeVvarnFuhLCGApFS8+zxsX6e/ugGYY0wjRMzmvAkzoKB61XMXOSfAX1YLY1kfWT2jKvXSE45cCga5KKg0nlUhnzp6mEkWqpVnfBI3PZLQSRVsMMe2oO7pBbwBVjYiAJ9HcIYa2NH54qImPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536006; c=relaxed/simple;
	bh=WEgm8Jix5SexLmqNcXetfpvAsLT0GjAY1bksrk495lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rnw1QI76EMkPKULgHJ6sMJ8zxTfqY0nyM1qV9coIthQKM18aHZaVI6axnroKg42JuIc+9p/1xJyqQnCzxEqTCSYnntWBkKMIUF/zbteImtE2/b/izXowr0lKqsvhEKseOnqoPAZ+ccUyl1tzI1ZVw/5EU/8beguxKiv7wBqotOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC2F1106F;
	Wed, 15 Oct 2025 06:46:35 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33C873F6A8;
	Wed, 15 Oct 2025 06:46:42 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	corbet@lwn.net
Cc: rmoar@google.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH] Documentation: kunit: Fix kunit_device_register() example
Date: Wed, 15 Oct 2025 14:46:36 +0100
Message-Id: <766a96de401a2c4361867144567bbc31edcf1a9e.1760535996.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kunit_device_register() only returns error pointers, not NULL.
Furthermore for regular users who aren't testing the KUnit API
itself, errors most likely represent major system failure (e.g. OOM
or sysfs collision) beyond the scope of their own test conditions.
Replace the assert with straightforward error handling for clarity.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
This seemed the logical conclusion by inspection, but please do correct
me if I've misunderstood the intent...
---
 Documentation/dev-tools/kunit/usage.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 038f480074fd..3452c739dd44 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -873,7 +873,8 @@ For example:
 
 		// Create a fake device.
 		fake_device = kunit_device_register(test, "my_device");
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_device)
+		if (IS_ERR(fake_device))
+			return;
 
 		// Pass it to functions which need a device.
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
-- 
2.34.1


