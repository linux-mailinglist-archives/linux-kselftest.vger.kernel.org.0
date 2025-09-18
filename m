Return-Path: <linux-kselftest+bounces-41892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347CCB86B3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE903466E23
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843222DCC13;
	Thu, 18 Sep 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C8uDV37Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f104.google.com (mail-io1-f104.google.com [209.85.166.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2642D8791
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224057; cv=none; b=Buq17iISzzFYoKRATO1/2GcvvlbMwqLBlqMOJPj4ovjSqN8GmRBDgewy3fapznEHHpw58R1nxsc6Fxx9jEeTOCJy5fs+5dgipdimTsiKrli+m6fV/Wb8fayJ78z9cJ///EsbsO4Pz7xBUuVSN3ewkWxunYyi3s+MxUbJf0a313w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224057; c=relaxed/simple;
	bh=kqKHD5ehZXD1Rt9JUSSGS9cTnlizM80DHb0RRMG6eqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBa5l/tq/5g8klZa6+pqNA3iVP/DID+3CAcjB6XIVfKl3E3dc4z+bYCQdgnB4ui30xVX1VxMo068eCnUsvNUTQXqTsc2ETGbAhdaBg4ZLZ+Vwfsu0POzw2HUYyD8l8PLMLeLW8iFchH3T9P9wXLGn9+kbhQCkPZMEEy8N2F+yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C8uDV37Y; arc=none smtp.client-ip=209.85.166.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f104.google.com with SMTP id ca18e2360f4ac-88432e1af6dso108806739f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qfla8bZUs3WSTY0zGPzDgRTSRNvs3BA8rlHoMH79c3A=;
        b=C8uDV37Y2VswDKnS+t0TMJnfJNOIvf6AItaCMVr71z8IBBquG2BS0qtyDwlCjK0t/u
         lvowz64VnudEGWKK39HAqnaI/IPXcbFLNLkEJE/qlF3CZlOS0MlevOADdQ1upRNMDptW
         naoqZMArCUlbqT8DLPqSS/Ni6ZobTPHAycmy5EY0CbNd77qRX5RCHE7z5nRvyvCQAR+s
         kgFvWM6dGnBwAg0DSfjX0/Y1aRAC3hPZYw/VzHNvluSBcf+HL/lBLI6qW4KPzyxEw7Su
         dxpmJN/PtM74hkj9TaxekQ0iBpZbMt5PpkbM2aWywxi31xrWqyf8aQ6ZVciCvtQGbFDN
         thzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfla8bZUs3WSTY0zGPzDgRTSRNvs3BA8rlHoMH79c3A=;
        b=IqAVzp+waz/liZZFF7oOFgR9RsboMPlPTRhM+B5jWNd/1eGQTs6A5MAScOJpLLp2nz
         d3dC01B+BvANJZVhmqyGkSVwYGGPFV46jFqp82FuJPxq/Na1Phzd9B45rE2z0PPuBSrO
         a/0cHjAwo7DKSnf8/xvNyIkSCG6X8jVLWLOyCm8+RE1cueYnBJjPRVsOp/COBFTl4Nd/
         krwonFlwuMAqBdVUI7YDE/BWpulpgLuLCG5L7aiIgw3o7HzHO57l74zTqHISvGJLBxqH
         jC8GOhKvyWftA8bY18ljPaV2nkvugdzyjFtOszFA3oukmcJbV4qTiBr2Fc81yn3O0I5c
         zLVw==
X-Forwarded-Encrypted: i=1; AJvYcCUj3oCNd2999H7E6w5nitCM/TzZxjg7C00besdMKS1H8SlKaZk5GWSdaV/8bZ457mWe5ZJWw/VegBLy2PC34EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiyYkWgELXRsGnWlz583s3FMKt1PCUUikj8TnnIqeS7EDcUFmL
	6m1t2rjaP1hjsqufsS8BRvL0NBv+1QQ1gVPqvsg/Dxy6G5gjADaN0M7WPPXDGlPm+XU4LHFkq7g
	DykhBK+7v7vJ5ti3k/DLD2rKX5Yhooi0tD4i1
X-Gm-Gg: ASbGnctIo9MuI0UCZffdFi5ABZoCxzv96+ueai/mK+ByGHANBU+NoFezoWDVYK2Gw+c
	725ohK3LYBn7Xaj9jbdsgLgu93OVTHHZ699wIhR0cK9apJM/VfUo5WHWv1muOhEssS2QeevAp8f
	Hmr4EF7hN1BAYxUzRHG/pH5hOWNP59Oq9GaaWCZhqgLAm7YedPwcWCXmnMxzTncuQDr70rxDZ9p
	Hg61K68fh7eOa7+xKh166swR2si3TWlRonAWev+NzNAt+a5owWnOzv0bhh7JH7l8D4ixBXTo7R3
	7fXRVIF+V2MbDsF3mtwAk5HTYu2l0rgvU9lIoqwPs5oPv2douKR4TsnRUKr8ze3AukQkjQNr4A=
	=
X-Google-Smtp-Source: AGHT+IElwU4J+0k5G0xjwarOPJhNJ8IHRnrr1sD6xBB+QeAq7JN53s/aglucgmQ+/5PoOoj3mnPaBPT+Q8cE
X-Received: by 2002:a05:6e02:2509:b0:410:f09a:28a6 with SMTP id e9e14a558f8ab-42481925dd8mr13628105ab.13.1758224052667;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4247353db28sm1480915ab.32.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 370BC34142D;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0F0EEE541CB; Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 18 Sep 2025 13:34:09 -0600
Subject: [PATCH v2 3/3] selftests: ublk: add test to verify that feat_map
 is complete
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
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
 tools/testing/selftests/ublk/test_generic_13.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 0000000000000000000000000000000000000000..b7aa90b1cb74615dd4727187a6a5aa9ed93088f7
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -0,0 +1,20 @@
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
+        echo "# unknown feature detected!"
+        echo "# did you add a feature and forget to update feat_map in kublk?"
+        echo "# this failure is expected if running an older test suite against"
+        echo "# a newer kernel with new features added"
+        ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE

-- 
2.34.1


