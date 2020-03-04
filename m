Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662A8179B8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 23:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgCDWOM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 17:14:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43469 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgCDWOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:11 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so4185211ioo.10
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9gZ3FjUdWgi81CXN9D2iQAnH+lo6JPqrg04R4qEP/8=;
        b=gZXX9JmFv2DJctPsp75DNG3g9p5eWyxIrIAFUCbjj3XGgwnMcqZvgFvkYd7Xd9sfeI
         zZEQWmhYX3g7EGtLUCtQBUuPzHEkzgpNKBYXKTAwk0TH8EBhCHvC9IlWnCXxm2mILo4G
         uqEGWEe60u9mIN2p34S1eJ2s6E8iJvEzG2zy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9gZ3FjUdWgi81CXN9D2iQAnH+lo6JPqrg04R4qEP/8=;
        b=sIl+RR0XjF4Ijed0z+B2dHEBQt6OBJkFCpmtKcv9PXJlZNLF/WwEHDIzaB1JlTtWXg
         ASwCdq0I1rCvWDgakPu+aEmCJg+a/Bu5SvozsXGhC3UugsiPLJpsn3D9tO5XjvmQVWUL
         iEhr0yJScEPT+gBpgQgFWkoRgvDwNlngOarCg9DCgMzPyaYixzTDyLUFQQL4CDXn0o1K
         uFVP62h1jj4+yy5Qae42L0jutQDwEMbT51HH7ykbAWHmqv8X1W9NHjnfxTlnzq3+KPeN
         EbfIrNt/XpSPfLRMLXtzvciMZEQKFzPe5lI4Uq+rNFg/+1DfW9utq/5xOeT1SscgZomp
         rP8w==
X-Gm-Message-State: ANhLgQ2lvDyOEUiRENiYEDyGX/l2e2aGCDfNUO7/GgEHPHyJiG17EMHy
        WrtEmUUUU0fK0f+OtoVzRT+oFA==
X-Google-Smtp-Source: ADFU+vvGc+yswzBxxepbZQqv/WGJj2Qwy8fRbC0QftbuZTZFLG36VzQ2QAbYELI6s/iSwvWfdmZTyg==
X-Received: by 2002:a6b:660d:: with SMTP id a13mr3690456ioc.18.1583360049769;
        Wed, 04 Mar 2020 14:14:09 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:09 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] selftests: Fix kselftest O=objdir build from cluttering top level objdir
Date:   Wed,  4 Mar 2020 15:13:32 -0700
Message-Id: <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

make kselftest-all O=objdir builds create generated objects in objdir.
This clutters the top level directory with kselftest objects. Fix it
to create sub-directory under objdir for kselftest objects.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6ec503912bea..cd77df3e6bb8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,7 +91,7 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
-# Append kselftest to KBUILD_OUTPUT to avoid cluttering
+# Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
 # KBUILD_OUTPUT with selftest objects and headers installed
 # by selftests Makefile or lib.mk.
 ifdef building_out_of_srctree
@@ -99,7 +99,7 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(O)
+	BUILD := $(O)/kselftest
 else
 	ifneq ($(KBUILD_OUTPUT),)
 		BUILD := $(KBUILD_OUTPUT)/kselftest
-- 
2.20.1

