Return-Path: <linux-kselftest+bounces-33979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3BAC796A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF8F4A746D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA722256C6C;
	Thu, 29 May 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WST0yq8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CF212B3D;
	Thu, 29 May 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502357; cv=none; b=tC0eztd/+Yh4cPQ02cMhKXe87JE5jYY1wFk7RP8DxEys4vXjmFIkSIJ59uaFIwsn1NrP3SnCgunMVY+q6v4BygejrElcu0PN6cQLwbypI7+2TyAbAbtC66nomwtc/EHLhkWT27K2K85fk2X1d4EAjioXxxER8Yi3CZBnK/CXp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502357; c=relaxed/simple;
	bh=5TrVPrAK7rpTKSGugDGq+SZDZu+iXs6UclBSsVcDhNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUHlbeDXOsYQ2fM8PaL5+31P7lGh+xRWC7DZ8zZAd0f/DRZN1Gezf0Kk5JH0PGANeFyjDZK6wSNBNo+Mobf8AHgyXtdzo2xhJ8MoH7sRuoo6LmkXfk4JpamVVaZEbx9owuIVp5tvARQJpFE4ZyFrc05ZZdF4dcBjA41uM/2Z23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WST0yq8z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b170c99aa49so405089a12.1;
        Thu, 29 May 2025 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748502355; x=1749107155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vygoR3OW1EpaD6XWLfUQKQivNJs0wYN0BzwAQeCuCjI=;
        b=WST0yq8zQPpiGxKKZF8zN8Qi+TZkBONnL0IDT7g4GWwfxYWFqGH6yc9T7Ss7ijGIZL
         BjGv3zoj+yiBR1X/C8kp/yDVCS+CoJk/f3pq5vBlJX1SdDXR9i4VX96/+yi3l0jPclcZ
         YgL9Eu3M7qqjr9LmrEWvyohEzgLY4o3dAUI3QpbNm3VRw171sffHqYe3u2LtZ4+ocUif
         NlupAYN1YdvjZtUk2kMUiZhIX7eP72aeIWbtPtlX/pgSXjuFzh/jnm/SHQJfKCXoLg91
         z7h+7WqdTOVkDq7SHCrbtbFD5enQkbI7M2b9YHvX1b1mLq5dXmNWSq8Kk6zkxFCfCi3v
         MfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748502355; x=1749107155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vygoR3OW1EpaD6XWLfUQKQivNJs0wYN0BzwAQeCuCjI=;
        b=FlxdwQqfFrJ+wLPILEhayBJzHrWItk5X8XJ4RRvSrpigCg12dp74Xv8MkA5ko3qWOd
         2ANi242KylaSGqkujmqBkJ+J1zNhOYr4EA04PQuP0ZSXdMzXKyD5dIAlCfBrBAk46/Ks
         jB+yLKqHNuCVUg4dOKVdH+3PyDsoJbuITnKK6msq7DHVAwoFMhioHZxhVfRzSLF498rc
         qJGRphtnjPagCtA18gHcOb2I6RhfF/8l2vJdsuKRnBAp45NKGmQkn4chvsUkyaVctIIL
         TZIzYj8bgZwK3vJrLHgXkCGsRROtq7Z/hb1ibdZJ3l0gS6op8Y27kP6/SkgcS6kV9F8J
         vOOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/HcxeH2VOD0gpRTE705Q8/S4tN51S0T9Qt0yjBHuJsWiFraRSAepyDKr31qlz4FB9zCVlscghcCO4JDGkztkq@vger.kernel.org, AJvYcCUDhwuIx0Zfmbt+Msmisn40UPHOiRbEwRolWsgr9W0Er3QYdl9KI/EhfyGvJp+S9U5Hr+rAjAHVekWqa/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubcCqWM8oz3xub6krBofukR/qm9uDHvAuNEBT264gt75uoiz+
	PBLCcvbAWIlWO+AzshBn2WOrIOn3oiMDtFhL79Vu8MmiSwQZYkcMdUSuzMZytA==
X-Gm-Gg: ASbGncu1s/+iG8B1U89vIA0Wc6/EEcb1VvaRCmXyPtaMH4ny4lYbHq2F3qwbgmgAotH
	N7xHISHlmQdKNmJTV2eK+QyqU9wpTnLBrMed8jNzFygL8bcHZKVVHvWme5kkzhxDmXkW6W1ZgSq
	W3ieGqkUcEbre11f0kUraUh1UbKObcibyx/laeTmOeqYsLCzJl4gBwZYN7pMiwKrobY6JSAvFPl
	xwJDyVWRfweCyCdZoRYe8SFARFryDFbFWbFDhuHvAa9Oo9QU7Hk2hB6ofq4OVEyVRHOemVkJLde
	RkYkqTEaSCjMjHADp0CyT1vcUHG0RkzC54UZL2VyJf+WjeDm0ZinsY5YLgvbpQgd4lg=
X-Google-Smtp-Source: AGHT+IEkTYWVBJnJ84viQRHPGK9Qjw6ttcJ11tJRdotc+lhKyG+5oc6ulftZ2azWJ08KuGrUH4qDbQ==
X-Received: by 2002:a17:90a:d446:b0:311:df4b:4b8c with SMTP id 98e67ed59e1d1-3121dc3d302mr1735555a91.7.1748502354891;
        Thu, 29 May 2025 00:05:54 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:9a39:811d:64fd:12a7])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3121b71c7c4sm743070a91.13.2025.05.29.00.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 00:05:54 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Philip Li <philip.li@intel.com>,
	oliver.sang@intel.com,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net] selftests: net: build net/lib dependency in all target
Date: Thu, 29 May 2025 14:05:36 +0700
Message-ID: <20250529070536.84491-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only build net/lib dependency in install target. This
commit moves that to all target so that net/lib is included in in-tree
build and run_tests.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6aa11cd3db42..5b04d83ad9a1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -205,7 +205,7 @@ export KHDR_INCLUDES
 
 all:
 	@ret=1;							\
-	for TARGET in $(TARGETS); do				\
+	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do	\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
@@ -270,7 +270,7 @@ ifdef INSTALL_PATH
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
 	rm -f $(TEST_LIST)
 	@ret=1;	\
-	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
+	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
 				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
-- 
2.43.0


