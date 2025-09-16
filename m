Return-Path: <linux-kselftest+bounces-41623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B43B5BEF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C05524E64
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B8298CB7;
	Tue, 16 Sep 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GiEOpzmm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f229.google.com (mail-pl1-f229.google.com [209.85.214.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A23274FDE
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060372; cv=none; b=rhDpSFLP2x56553YAwK0fZFL0ZWZsQuEskiVytF/ZANi8y5YBtlJG4fEdFvksRnV2QL4zbC7gZkZ7A+8q7TztI+iDtZLldipYOTZJEG8CBOU4BVbtSd657EKnMl69Fk504D8qafBOwZEwOmAxqD68RDh7nka32IaMgoVMsnqdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060372; c=relaxed/simple;
	bh=Dlk+Oewhzc94sbibKhlkOgC+Y4VS05JHCp7u906DoAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbBTaJFn9ILCHPGxmfgfohAgTA+qLFAj0WqL3p12yFiDmjJcIvUV47/P2FEte5LyrymOj+S54PeB20S/sjuTO9HuyZaK22j1xRLfY4+AuOakG3aApaYng6+/BYHPpUGF/fw21NRAIt1Nq2BfoXsUGXVFlh2qKXrMqWy2Daw6K+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GiEOpzmm; arc=none smtp.client-ip=209.85.214.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f229.google.com with SMTP id d9443c01a7336-26058a9e3b5so28814805ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsZQAdC9OI0Rh5GwGUr4F2H2VDgxQJ1oYUQ+4QI9neI=;
        b=GiEOpzmm146jS+vUcOSY7qfUF3ppLfDs5XrQ9048hXO9D8g3ZVFYdhcDW/VGm9YNb4
         dsNilTqG0PRzVAEC6sff0cQfMaJK0NGm2U6Ci63mO7E/T1jmO59wsHCVMcz8MmHEQOIx
         U2r9aQ9x9Z72eQ3qZ5T9hYUZq47M4ooBeJwqxUFym0PXpVhcT11Kc8pk4M1QZt0KlJQI
         muQ2fJV7oFFJZxUQYvyzlRPs4NE0c/bzzxeG0Sj8k7w5w73sXiVh3hywVU/ahfUJKf5z
         GD1Cr0CRyBN17/DFpSA6u5UlT3QNR89jtE6aC4PMpr1iGKDjK2HJwoMBDhrGYlS+w1l2
         aukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsZQAdC9OI0Rh5GwGUr4F2H2VDgxQJ1oYUQ+4QI9neI=;
        b=GIR2Xa53hhns9p4EfDND+5uQLF4M2QfMEoGUdSsvgUe2M9ip4zcr9t5tq80F09qX/Z
         1RQ/WBn92lcQWcksPOmoipY/Ja74eYgtx4tK/xJ1uuy0vq3x8IE9t1zODijAIxNmxfAV
         /0JupMatrlKRNPYDxl+FDDLuGD7YxGguWTjgHLYDCozxt0S+GIF1a8GLvAbrMqIgQWOI
         XqfLRwDzQxQx3oAvvv6rWbPqjyD35cBHqtBw5Ip/tLQiLWp3+ki6NVV4CliRe+wCh5dE
         hPpPKVXI2Me3vngqtvziyJ2RjbKW/+qqZRRacwHEAEHTorxgl1GRFxVDWZY1dUeD43kH
         kcgw==
X-Forwarded-Encrypted: i=1; AJvYcCWxXPuezk2OP1Lb3w1ODda9CZ1MfWcskeeaVcVETF1RQrZuhL/ZUf+m1B7hUY16RMFOAtZoqfnWFAWueISz3To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrBd5Lt7gbVmPl1MWyilYzQzMgtXQKFATne9NkOmdfa3TTcQw
	q7roL2oX33QxrCndNRya0lqszrQMJSlfNJiP5sVVV6qayPwbSm/3r+0D7fWUHMAXdiJ0Rp/z5OI
	b/lGQyIKDU64L6vLscbfONQ7rwzs6NhQwbzyuWu5cmjsngr4l4iXY
X-Gm-Gg: ASbGncubTzcFax5aX16Vaa0fBYItqEZjU14H+qs5rRK03I5RxektGsNELIrEg5VNl7m
	WbGjAcC0CC8pwMYtUL6M+i+N5C0DadXWxrj6ThljLKHMnY76h9l2lCBZFsT6XxxbqC4tP9QyiV5
	6295LqkslCLWfosQ5D0DI3gx2wBt9HXGx/UMdcOqrxtJShOnburJg5iHwSgGz/m2bexOOOu35db
	eHHAj31otpVQjh9GGoF8jBd3UX+MR7Iwr3RfZR24XAiIJKcMlb0fyr39XV0t4TScKFwd8wKdXzU
	PxMPtKBsR2Lhm4SOu3GkPbsKc1Z1+6G6B8xmiYOFuE+v182NF/r39Vga1Aw=
X-Google-Smtp-Source: AGHT+IGiJoUhPEuZtFF4wpQYOfXhxSk41Sg03uqDc+U/rjhi5emgbi/g/GBhLda0R/YDZKF9WeQoPhy4MKQY
X-Received: by 2002:a17:903:2985:b0:266:63de:eefc with SMTP id d9443c01a7336-26663defc4fmr95694425ad.14.1758060369683;
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-265dc1db297sm8154155ad.26.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C48DA34023F;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D4C4DE41772; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:05:57 -0600
Subject: [PATCH 3/3] selftests: ublk: add test to verify that feat_map is
 complete
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_features-v1-3-52014be9cde5@purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
In-Reply-To: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Add a test that verifies that the currently running kernel does not
report support for any features that are unrecognized by kublk. This
should catch cases where features are added without updating kublk's
feat_map accordingly, which has happened multiple times in the past (see
[1], [2]).

Note that this new test may fail if the test suite is older than the
kernel, and the newer kernel contains a newly introduced feature. I
believe this is not a use case we currently care about - we only care
about newer test suites passing on older kernels.

[1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@purestorage.com/t/#u
[2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/test_generic_13.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..770269efe42ab460366485ccc80abfa145a0c57b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
+TEST_PROGS += test_generic_13.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
new file mode 100755
index 0000000000000000000000000000000000000000..ff5f22b078ddd08bc19f82aa66da6a44fa073f6f
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_13"
+ERR_CODE=0
+
+_prep_test "null" "check that feature list is complete"
+
+if ${UBLK_PROG} features | grep -q unknown; then
+        ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE

-- 
2.34.1


