Return-Path: <linux-kselftest+bounces-33368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC1ABD1BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB454A2464
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40A25FA01;
	Tue, 20 May 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWtB8Yl8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AD1B4121
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729264; cv=none; b=us4HNnKnTCmnX+tKS97kMDHOEHMDKx1AoMtuCZc/vz7kM8TfNhbmkgKyb6m8J5bZJjxmybEoFYjwPB8qa9/oDySqBJW/zeZp+AWrVUU6rbDza+BHzRWQM+VS4e6ee7Cgz85fwrhphrRAIXt5irHKTw5kWDr2m9daD9s7DAB+qDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729264; c=relaxed/simple;
	bh=GrHVuS7UFt1rsKTJEPt+8SUAw+kOC3PLtnUTeaLhYkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrAAuIB1z/995fcv+WzPgfVGZVDf8V6gIxU+KVivJYjsLVbCqpHbnTptpfgKwg08hdaN7j5qZf1g7uTJWc9VxH7vR8U9nf4rM64aU8GZ9YZ7xYg2QkPn0a9QCx1x4Je+HAttBXFJ91hLj9T0pCr18yux+g2keDPDWqL01bXQjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWtB8Yl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46899C4CEE9;
	Tue, 20 May 2025 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729264;
	bh=GrHVuS7UFt1rsKTJEPt+8SUAw+kOC3PLtnUTeaLhYkk=;
	h=From:To:Cc:Subject:Date:From;
	b=lWtB8Yl8kanCAjHCiOv20BPLKjHmqYp2wjX2ntU8+2NUklWFCXOQBtMkmHRvW0haW
	 krTebr90KKtg0RD69x6KJFb+tnahGeW1zAnxkY0N5wML/RQKG+o1824K7poU+0A+3W
	 oVTdqQAD7af0pdTJFdo5nN4PEjMo//IIWVaspA8nOw/04GILu8+uEJkOjg/M90tEh9
	 4O5di3SJHL6HI4OgvjG0ZFLuqVac3tZGU6DRtqRHHH74pkNkVoolx7BFCM3laIbD7g
	 /k50IuO8jHkIbwbA6gDR48yqWc3nuSootcYRgEksr7y53c52jp1sQlb8QxIlyeQy9z
	 HFtHqlEgQSl3g==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: rmoar@google.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	tzungbi@kernel.org
Subject: [PATCH] kunit: Fix wrong parameter to kunit_deactivate_static_stub()
Date: Tue, 20 May 2025 08:20:49 +0000
Message-ID: <20250520082050.2254875-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kunit_deactivate_static_stub() accepts real_fn_addr instead of
replacement_addr.  In the case, it always passes NULL to
kunit_deactivate_static_stub().

Fix it.

Fixes: e047c5eaa763 ("kunit: Expose 'static stub' API to redirect functions")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 lib/kunit/static_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
index 92b2cccd5e76..484fd85251b4 100644
--- a/lib/kunit/static_stub.c
+++ b/lib/kunit/static_stub.c
@@ -96,7 +96,7 @@ void __kunit_activate_static_stub(struct kunit *test,
 
 	/* If the replacement address is NULL, deactivate the stub. */
 	if (!replacement_addr) {
-		kunit_deactivate_static_stub(test, replacement_addr);
+		kunit_deactivate_static_stub(test, real_fn_addr);
 		return;
 	}
 
-- 
2.49.0.1101.gccaa498523-goog


