Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA728F1D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgJOMI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgJOMI5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 08:08:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEFCC0613D3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 05:08:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id y198so2133430qka.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQCnc1kT4X0rScHBlHIsBu1n631S09tQozQXpWQBp88=;
        b=Jpxx71PqIJw5HtnGe3yI6um31Ic6Lg7W3j67tcXbUfPv0lQ7aqem+RbXuSnkEQwpMv
         YBcNsdwlx1RWwUQvdO2/Lu5h/sAB/C398QH5nCZa9CNodfJ4zVQzNCI1SwxY7G67rDkH
         eg8yRtkP6DKztGMkh9KgxvaixgfObHKtvn6ulRdx2ff0IRGsLIOZ1g2vixRCUDewP9iu
         w7QOLOf0mZmmlQtfFhc/2eTpWqIwyuWPus3UVsy5JEyPs3tel9h6v/XVsqfwg0NxI4OY
         iFrft2fb7/lnFwjZwLcdsJY4X6sULq5fIuXpkv2xaGfiOkd2DA2T9U6VshZPR5mWnJNe
         x0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQCnc1kT4X0rScHBlHIsBu1n631S09tQozQXpWQBp88=;
        b=VR/lZay0mIWRmKvUYB0epuyqKpJwa47fIgqM15NrnXo6FT4D1IW4dDweSIIi2gb+LU
         k2T9+uEWYaZ4MvnTdVBkcd8a7Kq0gxU7Y9mP1FLCNxJgXgJj6xUNVOXsttodajFSXfXW
         TuI3wvL8nviMtIyF742MqI2+BrO9LDq0bSvt0QZsoJdAFVUdaIIIkFGd2YBA5c/PoVKF
         8bDGDdeLynnSmyNwCEMq/V0/YloSz4CmsrHoV7CPCO03ickG94fcy3nvN1yr2jrvTPi0
         ry/LEhsGKnkMjp8PCrcX5aYDQ89r6V8ezExn0/3Ulrin+ojZ6awslWR/Gpl1e/JAfGyt
         G0SQ==
X-Gm-Message-State: AOAM531MD8LVg0s8+Fq3XBRNFSarBzRSKrN9CXKpoXu2CIybyqwF4J3E
        4pSjAYy01izKT3Z5sdG1eV+9iw==
X-Google-Smtp-Source: ABdhPJxCINnDLk7Akc7ItVHO/kczk3TZJd90eFchjG6pzINskpyBQpZJsp895Zc8y/tkzYcHWsAPlQ==
X-Received: by 2002:a37:b782:: with SMTP id h124mr3705031qkf.169.1602763736095;
        Thu, 15 Oct 2020 05:08:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7cb:5e0b:6f3d:fca0:306c:a15d])
        by smtp.gmail.com with ESMTPSA id 124sm1045375qkn.47.2020.10.15.05.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:08:55 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     sfr@canb.auug.org.au, skhan@linuxfoundation.org,
        brendanhiggins@google.com, kunit-dev@googlegroups.com,
        johannes@sipsolutions.net
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] lib: kunit: Fix compilation test when using TEST_BIT_FIELD_COMPILE
Date:   Thu, 15 Oct 2020 09:08:51 -0300
Message-Id: <20201015120851.229242-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A build condition was missing around a compilation test, this compilation
test comes from the original test_bitfield code.

And removed unnecessary code for this test.

Fixes: d2585f5164c2 ("lib: kunit: add bitfield test conversion to KUnit")
Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Link: https://lore.kernel.org/linux-next/20201015163056.56fcc835@canb.auug.org.au/
---
 lib/bitfield_kunit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitfield_kunit.c b/lib/bitfield_kunit.c
index d63a2be5aff8..1473d8b4bf0f 100644
--- a/lib/bitfield_kunit.c
+++ b/lib/bitfield_kunit.c
@@ -125,7 +125,7 @@ static void __init test_bitfields_variables(struct kunit *context)
 	CHECK(u64, 0x0000001f8000000ull);
 }
 
-
+#ifdef TEST_BITFIELD_COMPILE
 static void __init test_bitfields_compile(struct kunit *context)
 {
 	/* these should fail compilation */
@@ -135,13 +135,11 @@ static void __init test_bitfields_compile(struct kunit *context)
 	/* this should at least give a warning */
 	u16_encode_bits(0, 0x60000);
 }
+#endif
 
 static struct kunit_case __refdata bitfields_test_cases[] = {
 	KUNIT_CASE(test_bitfields_constants),
 	KUNIT_CASE(test_bitfields_variables),
-#ifdef TEST_BITFIELD_COMPILE
-	KUNIT_CASE(test_bitfields_compile),
-#endif
 	{}
 };
 

base-commit: d2585f5164c298aaaed14c2c8d313cbe7bd5b253
-- 
2.26.2

