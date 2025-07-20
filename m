Return-Path: <linux-kselftest+bounces-37697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E5B0B728
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5CB1641EA
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488F23183C;
	Sun, 20 Jul 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di9WADvY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D322127B;
	Sun, 20 Jul 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031827; cv=none; b=X9iNbB9IkdmTEqbHbQI+S8j8PdS4Bl34XVukokgpSNTaTt06H6Qv3WZ0FUP6Z4P8p0XFTqNRX3+fqIBrDbrLcKHkB1CbZDuhCol2yzPOMjhAxDhXb2IHLqalNczDyKKX49AyYXZBGOhOK4WB7GU4zQGL0DPFTBrVnzagv8sNXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031827; c=relaxed/simple;
	bh=DFNV//C+QgXrmI/GjL4BHGLlAxbvvBZJy/zmKoFxFVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9baeGpnWiQdKgHdt2xKl86cN0kfugE1TQSh7UzWDkJNpZp3SS9b9/T1ly6eD+o9WUx4N+YrOxlQxSDcw3gsTbPG+KRRFBFxQCyh2++vrU9WqtzDLV7blpog/xSdl6Ct2Qvdoc/kWnxGSqPOLY4bBzB+Ypo9i7HMbWxVxgIgIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di9WADvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA08C4CEEB;
	Sun, 20 Jul 2025 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031827;
	bh=DFNV//C+QgXrmI/GjL4BHGLlAxbvvBZJy/zmKoFxFVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=di9WADvYirNrmIHFOoFdaneoNUmciL7vfeLzP0zHhw8eM4z8KMtTpSuz3tve5AZTC
	 4X/MJJHeS0utc3yaINYE52XskbfBBE3gop98m6oUkijfvU/FxOustKTCb9HSLgquBK
	 e0lgPamXMEZzhDsg1XmMBbi/OYh89i2SBg5YpET8vze7KK68xDzrh7evUZjBuKgW/d
	 WWlY7RT94Ho/JZ0TYI9uUnFZaTLAS6gs0Sy85TGrcuqKqHLrqwSjmYR69SdM5HjQwu
	 JgBU49Qky+++R/GM6g3nyD4tzNg4ymM+lSVslv8MGSnfpS/j+UjE3C3UcLEXZr1qJW
	 k5noQ7PgrDq0w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/22] selftests/damon/drgn_dump_damon_status: dump ctx->ops.id
Date: Sun, 20 Jul 2025 10:16:40 -0700
Message-Id: <20250720171652.92309-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status.py is a script for dumping DAMON internal status
in json format.  It is being used for seeing if DAMON parameters that
are set using _damon_sysfs.py are actually passed to DAMON in the kernel
space.  It is, however, not dumping full DAMON internal status, and it
makes increasing test coverage difficult.  Add ctx->ops.id dumping for
more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 8db081f965f5..cf5d492670d8 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -25,6 +25,11 @@ def to_dict(object, attr_name_converter):
         d[attr_name] = converter(getattr(object, attr_name))
     return d
 
+def ops_to_dict(ops):
+    return to_dict(ops, [
+        ['id', int],
+        ])
+
 def intervals_goal_to_dict(goal):
     return to_dict(goal, [
         ['access_bp', int],
@@ -148,6 +153,7 @@ def schemes_to_list(schemes):
 
 def damon_ctx_to_dict(ctx):
     return to_dict(ctx, [
+        ['ops', ops_to_dict],
         ['attrs', attrs_to_dict],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
-- 
2.39.5

