Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B661E542
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 00:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfENWmZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 18:42:25 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52657 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfENWmZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 18:42:25 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so24535itg.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/+UqoVyOLSQ0y8e5yE4txVnGHYAUO/Sws7YS3mRmnI=;
        b=cZl74vcnzPif//MhMVWyBs4L+OD+iNvZ9PMrJIAd8U6gbRh78KDyX4Ie6vEssxk3qW
         6RnVzdW5rufKwjHPvOu3iE6v4+P5P5nTfBUEoMZ4Xmn3kBzhJ2wz289Sq4IDi5s5ObU0
         N9B21WD5Dse36ePurthR+gIP6Xuf9Gj+rHnME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/+UqoVyOLSQ0y8e5yE4txVnGHYAUO/Sws7YS3mRmnI=;
        b=JPgAw1z+0q06kukzpxfE6wPl/B74LpcdqM6zq+mXTY+7yDZM8HzJAscaNoIqDVjM1n
         2xd5n4+InfmIwvMLkDc9+5I0/SkwO+GrAoo2zeKN1Xg6fRNsG42oyIrLWcoJMM4SdErX
         l6dzQsOkmx5vF3WMjoW/V3/gOnx06q152OGU2jL6Bbm48PIY9W+kv5oUNklUHlU8X6A/
         7ZGdDUhTgh1nQF23yPryq0cGpKncXMiaAyhmRJytgHKzIduh6pMfurx1A2KdFJ/AL3F0
         CQVmMphH2Oe1TwCzlVvo1O9k/jqRgGLbZbNQ0wzNt57IRP7+a9EWamTEkJyXrMmGdzX+
         At3g==
X-Gm-Message-State: APjAAAV8dU3Kv0emNjODr3Q47O1s4yKttzEVIWjiX2Fc3mqOHLbMeMlW
        7+o1xQDvC1V+tnaJhHnCHjojjQ==
X-Google-Smtp-Source: APXvYqxHEpysOT+P5y8GAeYLfwQvzn2kRXUmfcK22Ut1cMilZdKlx1zEvZd6eCAoEiOsSheerXzRUw==
X-Received: by 2002:a02:694f:: with SMTP id e76mr25889586jac.111.1557873744534;
        Tue, 14 May 2019 15:42:24 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u134sm213608itb.32.2019.05.14.15.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:42:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: avoid KBUILD_OUTPUT dir cluttering with selftest objects
Date:   Tue, 14 May 2019 16:42:22 -0600
Message-Id: <20190514224222.31310-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Running "make kselftest" or building selftests when KBUILD_OUTPUT
is set, will create selftest objects in the KBUILD_OUTPUT directory.
This could be undesirable especially when user didn't intend to
relocate selftest objects.

Use KBUILD_OUTPUT/kselftest to create selftest objects instead of
cluttering the main directory.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c71a63b923d4..9781ca79794a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -71,6 +71,9 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
+# Append kselftest to KBUILD_OUTPUT to avoid cluttering
+# KBUILD_OUTPUT with selftest objects and headers installed
+# by selftests Makefile or lib.mk.
 ifneq ($(KBUILD_SRC),)
 override LDFLAGS =
 endif
@@ -79,7 +82,7 @@ ifneq ($(O),)
 	BUILD := $(O)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)
+		BUILD := $(KBUILD_OUTPUT)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
-- 
2.17.1

