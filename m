Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0842CE160
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 23:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgLCWLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 17:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgLCWLM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 17:11:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB23C061A51
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 14:10:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x20so2294591pfm.6
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 14:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=nhqHUHB81FfDRC5Dmlf7b4++uLFouwQ+DbxloM/znL0=;
        b=lET6kU1tz5H9yxZDEMqtRCf0/SXFWhxbeju2hpUgYSr+oZtUv3MSgLpla0i95J2qJI
         PSPfEfKEw9TU9+Imn0OgG4helXYWBDiPTs1+ljRX3netRIyP+hnUHagTew6Ng0EU+Htj
         jzS9VjM74iL8Kc0sS1och2P1Fv99LwUIEqkKy4Ek9Z7laEnGeQZN5usI12k+ZtIt/iIA
         sAdWUr1GwY3xpT5d6ZAGX00/Pt4s9aY5tIqhW/x2OGKt1cUTl3qydSk/XRoM3oOMDu+u
         f/A+sDLNUnjiPkT85OxmChzqP1tdwTfbCKa2Q6Hy9+6DRnsngLpPwVgH+Sz78C40hzIh
         kHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=nhqHUHB81FfDRC5Dmlf7b4++uLFouwQ+DbxloM/znL0=;
        b=EF0RqyjYfmnArt7JJzy8v5DRjSCNYXC+Na6LSkbvFVC4174XvhR6eI3KiHA2FbGFjE
         AxTDW8dQ0yMozZdfXT6iyPH3tlUtxFWtf5iW6mlCGr3U9B8ol8/oGTK/sbGwBTmHzjva
         QEL315CLEwLfL0I1Jt+cBO+oESdRAuY0DPnl7RsAKmxI2eeUuF3uVmD4o6VQ7c8iK7HF
         Le5HysoVviPdD1zeG9UNZYd/jVwxEYHniPcIvZ4IFmGjN68nWCfr/75TwVxxcJxO4ulD
         V8YDPa8xoTCSKYvcDfdCuSn6V7rHqotSGsUND0y7AO6aZiTMzCg43ilPmwOtZ+jmioJi
         hmmg==
X-Gm-Message-State: AOAM5300VLlRbfQdKHEpaIn0rjnZv5eOoc46Se+0A+PQAJ4zoksNUvIe
        tnRRN22IrQ1fuXL5HfMfSPteSV9o6w==
X-Google-Smtp-Source: ABdhPJyoDq63rkO5+ydSicpI3O4b+U4VThB8sabazPQvgaChurpclUhtXF0OEbx+DbHTiwjGGtS95ozEFg==
Sender: "adelg via sendgmr" <adelg@adelg.c.googlers.com>
X-Received: from adelg.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:a16])
 (user=adelg job=sendgmr) by 2002:a17:90a:460a:: with SMTP id
 w10mr96452pjg.1.1607033431208; Thu, 03 Dec 2020 14:10:31 -0800 (PST)
Date:   Thu,  3 Dec 2020 22:10:05 +0000
Message-Id: <20201203221005.2813159-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] selftests: propagate CC to selftest submakes
From:   Andrew Delgadillo <adelg@google.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Andrew Delgadillo <adelg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

lib.mk defaults to gcc when CC is not set. When building selftests
as part of a kernel compilation, MAKEFLAGS is cleared to allow implicit
build rules to be used. This has the side-effect of clearing the CC
variable, which will cause selftests to be built with gcc regardless of
if we are using gcc or clang. To remedy this, propagate the CC variable
when clearing makeflags to ensure the correct compiler is used.

Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
 tools/testing/selftests/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c283503159..a4dd6d7e8276 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -90,10 +90,12 @@ FORCE_TARGETS ?=
 
 # Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
 # implicit rules to sub-test Makefiles which avoids build failures in test
-# Makefile that don't have explicit build rules.
+# Makefile that don't have explicit build rules. Since lib.mk defaults to
+# using gcc for compilation when the CC variable is not set, we propagate the
+# CC variable so if clang is being used, selftests will build with clang.
 ifeq (,$(LINK.c))
 override LDFLAGS =
-override MAKEFLAGS =
+override MAKEFLAGS = CC=$(CC)
 endif
 
 # Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
-- 
2.29.2.576.ga3fc446d84-goog

