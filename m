Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4921F975
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGNSa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgGNSa0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 14:30:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCB8C061794
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 11:30:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so1915070pjc.4
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=W+8q1daBddAXvOtBFXAsV/dQeLyDputz9vwjDvvFrCo=;
        b=g6gZ1A4WuOIoYr8rxcyDj1SdE42QcHNevJm1VxLwaCiSS2uhXIbMQj4fbdrcNwyzHk
         KnvFuRPRUDe5Yf+Rh2mFTJTuON6B+mzDyipBnRMnXk3yrjPC9OfA6/+sq/1SZ4MYJwSq
         78eMkxt7DiIedoW1NofxUFgnmjqqoXHpk5SPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=W+8q1daBddAXvOtBFXAsV/dQeLyDputz9vwjDvvFrCo=;
        b=ghvGggrb855yGPZ+6g2hWgP4jyHMs3uvfgy4+Z0lbYvJUc3iOtxVQt+ldkgOc9Pa63
         KLNGDW2QR3/eUSYhsRnSIGHKen9UTHxnUogmPdfB4eIif3K0nKiTdQASw4oA5dnbu0KG
         MeBzRftsHKT8lUGYJEAdlKIkBExC6eqgisF0Iz3NfFiJvK+YlyyN4q/d+iOYx7Znp/ge
         XHouWXRXjg6/VnHNipVW50qsf5EXQAm3gZDkI2/hk5RnHu/hyFaW9XIjNlo6vHBr1mSh
         I73LrUXL3B7ngOqwS/8il/S1Nes8JE5abap0ORWyBgMvvh2dcMSGNNykfbnvIbFy1kRx
         emZQ==
X-Gm-Message-State: AOAM530nOSFrDI4Ka5qyzBk6gfVVcYsKFGEMHdfqJYoNVOUEZh4EkkCa
        Bsm8Z1EEIXOcW6lX93ORFi4s6A==
X-Google-Smtp-Source: ABdhPJya+EiWFEJrlE0qPDf2Gq7NOZdjqmit6Y9e6eKWmO2lnvPlzplAV/n+sFRa/06ifs0zFz25Lg==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr6190895pju.19.1594751425748;
        Tue, 14 Jul 2020 11:30:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e195sm17091209pfh.218.2020.07.14.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:30:24 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:30:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/harness: Limit step counter reporting
Message-ID: <202007141129.54335CEAC6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the selftest "step" counter grew beyond 255, non-fatal warnings
were being emitted, which is noisy and pointless. There are selftests
with more than 255 steps (especially those in loops, etc). Instead,
just cap "steps" to 254 and do not report the saturation.

Reported-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 935029d4fb21..4f78e4805633 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -680,7 +680,8 @@
 			__bail(_assert, _metadata->no_print, _metadata->step))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed && _metadata->step < 255) \
+	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
+	if (_metadata->passed && _metadata->step < 253) \
 		_metadata->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
@@ -976,12 +977,6 @@ void __run_test(struct __fixture_metadata *f,
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* Make sure step doesn't get lost in reporting */
-		if (t->step >= 255) {
-			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
-			t->step = 254;
-		}
-		/* Use 255 for SKIP */
 		if (t->skip)
 			_exit(255);
 		/* Pass is exit 0 */
-- 
2.25.1


-- 
Kees Cook
