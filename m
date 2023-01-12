Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B2667FA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjALTyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 14:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbjALTxu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877228D
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 11:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63C5EB82021
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 19:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23154C4339B;
        Thu, 12 Jan 2023 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553140;
        bh=nY4bpK4Ck7cDPkgC/IhOZ5jeJAItWSvowi3Q3Mk3wv0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NNyFLjafIIfmG/gmmbTNu/sXFUWW2nPT/KF0tXmUf8A3AsiLcW9+1yqBPEcgaq+8+
         QqPdHymz+hxT3GCnsmAGQ2wGYfFuEhCtAAbUYsFAaedjYVEyC2meZKaCRvVgMNAuuw
         sxiKH80CbvDPN5B+1JsTtjuLcBtk4IdGgbCnYoP4KJYHClSkQ08AiXuJlBEu2xqFjd
         ClvLXMQV3SSS0JNCe0vzKYqeUzAblrYxUX7y6H0r/9C+ndpH0TLWId3blT+zVHIQa6
         YlE8vMzX0HFOIdotQSTVLc2TylT321+OJfq1mzSXi2FdRupSHb0qUjE42aE7Tbao/5
         KUJfanang4v3w==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 12 Jan 2023 19:51:48 +0000
Subject: [PATCH 2/6] kselftest/arm64: Remove redundant _start labels from FP tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-arm64-kselftest-clang-v1-2-89c69d377727@kernel.org>
References: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
In-Reply-To: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nY4bpK4Ck7cDPkgC/IhOZ5jeJAItWSvowi3Q3Mk3wv0=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuQDKS/Tgr6kfuizvHC94dEytQWuQkccqq0Mlh5nTwwU1HUL
 2MfWyWjEwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBM5CQ3+zelOVpO9stT91Zbx8uUHu
 y5stvlk278sn8i95caPpnuXjOtQJS3Umhrhqn8XqufdgGfO764Wyw6EH1bfOmlfjsVlTjp+4XJK7+o
 /z7az+JRaTeHITw+XjSY4+nJ6eqWB65tL2bdYF6f8i75oubCe/zV/S92WmqKbuzfIX6CoXYO08c9Ts
 VrTlxI9OL6zbyv+vrG3zmTC295SlsXVKs/ls4JmiPmnGoq+7pou9kOZU2V8rmOUfXddU7RnxgmHLII
 UrdxevtN/dj+kngPebn9upIr+fgZXZxKflvbXCzK6tpmau++f+GKvm1HPmQy25pLKx8qKj1WwOH24E
 f4N3FGR8G13Tf3mBUpXsj5yg8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are a number of freestanding static executables used in floating
point testing that have no runtime at all. These all define the main entry
point as:

   .globl _start
   function _start
   _start:

but clang's integrated assembler complains that:

  error: symbol '_start' is already defined

due to having both a label and function directive. Remove the label to
allow building with clang.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-pidbench.S | 1 -
 tools/testing/selftests/arm64/fp/fpsimd-test.S | 1 -
 tools/testing/selftests/arm64/fp/sve-test.S    | 1 -
 tools/testing/selftests/arm64/fp/za-test.S     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-pidbench.S b/tools/testing/selftests/arm64/fp/fp-pidbench.S
index 16a436389bfc..73830f6bc99b 100644
--- a/tools/testing/selftests/arm64/fp/fp-pidbench.S
+++ b/tools/testing/selftests/arm64/fp/fp-pidbench.S
@@ -31,7 +31,6 @@
 // Main program entry point
 .globl _start
 function _start
-_start:
 	puts	"Iterations per test: "
 	mov	x20, #10000
 	lsl	x20, x20, #8
diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index 918d04885a33..8b960d01ed2e 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -215,7 +215,6 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
-_start:
 	mov	x23, #0		// signal count
 
 	mov	w0, #SIGINT
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 2a18cb4c528c..4328895dfc87 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -378,7 +378,6 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
-_start:
 	mov	x23, #0		// Irritation signal count
 
 	mov	w0, #SIGINT
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 53c54af65704..9dcd70911397 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -231,7 +231,6 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
-_start:
 	mov	x23, #0		// signal count
 
 	mov	w0, #SIGINT

-- 
2.30.2
