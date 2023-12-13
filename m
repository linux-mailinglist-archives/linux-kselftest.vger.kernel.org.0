Return-Path: <linux-kselftest+bounces-1854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05294811F2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 20:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC96B2118B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E36828D;
	Wed, 13 Dec 2023 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jx3AMrlg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E39EB
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:44:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e27479b6e2so17985587b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496667; x=1703101467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZ3eBLJoXN0Zb334Rc/oMDoovJgn3OQlnIJlBZWmysw=;
        b=jx3AMrlgOr+eD/lfzdIvqCV046Y6JH+gGEf6Vn29MLPFUx3JjnjEhV5tn/GWk0nd4+
         CjNohCdWyRwDnfXoCNc0KRt4yHu+vN8bVqDTEjIiYlcKHpawyST/lWJlGYMxbB8mDEX/
         QDAOBYourpvnBtVWQy0RIqhd9kVftn8KRR0g1f3mBPhyvCQINmQdDEXNncYI18KXa69S
         UkDqRfHMwSHwY5XD3uWntwBw4FM0YGZSdb+EgtBtM1WKgX7EeX8H942euN38tFFeoVv5
         ZDO2nSDVBNEkc3ZxpEVLtFOcPa4g5yQhgOQPfz/NzUvvoZxa98rPWadPDC8JvQlyRB2c
         PLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496667; x=1703101467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ3eBLJoXN0Zb334Rc/oMDoovJgn3OQlnIJlBZWmysw=;
        b=WzwZykile5N2d70C+6Oj33LKlr3cDPLI0fF95YCxqQE/UDtO35KFajKrFx3dBjKfns
         uQs+ZBrMOvFEdjAuum6vg4gRNtrmZ8PGhHRpe3P7j/JMAxH/ebIcF5TG7hR8mPfCwAaC
         goHa5x1hq4KScVU753AgEcqNcyERJKemo1TaJ3wpDgB8OIU72GpUGvZbUbA+c/WDwasf
         bYc4tt+B0z1LHME5Xft+z4U62CkxXCj6bQe5RKVp8NJgschGRZ5j8F1Wh86lwEYx7BQe
         TvfBt13RimgJVi4nj/9XCS1Is/VSxuyNSqC7ig6QK3AF57zHoIQuMgs9AuI1838oaYk7
         gKEw==
X-Gm-Message-State: AOJu0Yz0b2W+dLYJwZRoSbB161gWdHm9XWfNDvcT8lLYIkAQOqw+AQ8m
	kWLUSO9kKg+6Hgtn+Xs6tYVCArIQCQ==
X-Google-Smtp-Source: AGHT+IHUpke9zQYYoRhy3jSBDvuiZMWqdS9EZXOxv1azcDgbxZdKFBM1RfilmtUnk9IB8wj22/cc+5W6EQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:9705:0:b0:db5:45eb:75b0 with SMTP id
 d5-20020a259705000000b00db545eb75b0mr69766ybo.6.1702496666790; Wed, 13 Dec
 2023 11:44:26 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:16 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-1-rmoar@google.com>
Subject: [PATCH v5 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
into DATA_DATA.

Data for KUnit tests does not need to be in the init section.

In order to run tests again after boot the KUnit data cannot be labeled as
init data as the kernel could write over it.

Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
data/functions.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..1107905d37fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -370,7 +370,8 @@
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	KUNIT_TABLE()
 
 /*
  * Data section helpers
@@ -699,8 +700,7 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()						\
-	KUNIT_TABLE()
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\

base-commit: b285ba6f8cc1b2bfece0b4350fdb92c8780bc698
-- 
2.43.0.472.g3155946c3a-goog


