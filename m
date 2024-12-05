Return-Path: <linux-kselftest+bounces-22866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2579E548A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA228162751
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC2212B09;
	Thu,  5 Dec 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXocpIsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E2211701;
	Thu,  5 Dec 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399388; cv=none; b=NIWivpc/h9FEWKZRP/2pQ0pSe7ErF8rMBHEq8iHZgTldc8sdXrnVZe9YcAvgaelXBk4yyQS+Sa+daRpl72ktTKIUbE2hQ43wKXFF2vuSW3tvYvuX7M+iH9y7yN/JUOwSjv68cG6iMsazjAh0gpIii5uelRNGwoeEbv0O593wWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399388; c=relaxed/simple;
	bh=9OSjcPCO5Mbw3u+bSIQigrlr/jYsixpKH8Kkud4vmDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz0GAg6WWob03aC0HYh7ZoQG2EjexhlS7xO+oGAG2AMWDcQOzncecVcxP5VoSEe4LchS4nxxg/rxz/cgM5Z+J/adKGd+xc29cGQmEimejjvkscLtBEgjnaA/O3wacNOXjPtdboWwEGPO+qBdvakvdUwk7C7MUgdGLnUQaZYI7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXocpIsr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7242f559a9fso855137b3a.1;
        Thu, 05 Dec 2024 03:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399387; x=1734004187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8FAgB+dYFBwjAJ2SHtf/hi5z8cV2SIHrjso538Ujis=;
        b=hXocpIsrSMnKbZpvTaj8mrs12THzWQ6vNHPmRaeXbLvGB3UcQ07WoqT1X3EpzewD8L
         nva+wj1/yDEGugVnOUF5fTPj2we72odgHt1NpV3VciIcM+SRO5M0I2h3JNAwAN3BJkzK
         zxyWOXB91VnhvampCdjoNW58NNWgBmPuaMYDwWdrHa2fU/OwBcu6t4RBOyqQGB46Z9Yp
         sLhCdhtsM+Tysw19m3STImt6ZCv40QxdMpVADAPDMSltXiFkAjVWuTTdjJVPLF6cDmGK
         i0l4zu1scqY1temDCdJjoBgJD0T3+6cSA40IuDkwtpgeRpboEeInIoW36w23AMK/lfyI
         vCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399387; x=1734004187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8FAgB+dYFBwjAJ2SHtf/hi5z8cV2SIHrjso538Ujis=;
        b=omeU9IiJSESERfOQ+Rg6wT2OEYOwr4xviNKonhPvztdCOJqFBrJ2RAtcneSkTer+ss
         Va/e+aAu3LiR+I3+87j5UTUP2tJ/CUO5izgb80XuQBX0ylkvMjUQl1eYTqnaC4JPhpvE
         s594RtD1YQuaC3iqmXjUf6q5TfVz67/1WXHG6lEl0KOTGNpg5Le9ALHhDBVG8kYeXKQB
         Iim5+xujXJwPCiLadIwXUlMzFsSgvFtRBhMoupKOnVD0r0zWvU4WONPQ18FtzbhUD5N6
         CfxqZ2q5r5QJ5c4GGFuxi1uCkY2Hw7Rbp1nkvKij416Emr8WW5gQTZHa6vbgHzoXcEj8
         aJOA==
X-Forwarded-Encrypted: i=1; AJvYcCXsV/BkBL8ODGF7So0zIe5uahbz/AVvYARTWL/qjVEzvwdxFi25rsY0Yoe0n+d3a9BFPGXpOtvZt3lqWBk9V1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwl1sdcSM5vnjrpdD9Q4907FDj+ivZx0858tgDYPCO4EKdUx9g
	NvTA9IoWrfm1uWu4dfrbC3mob8XpPvZmKLkwcWpYnNXnA9k7dyEf
X-Gm-Gg: ASbGnct6qbfzINewXf3baIzX6xFT4JGwJyXDEJsj/ddZGQAgYH2QPehLuHrndKpSOpw
	VEwvBwulWzY8ye49Bhps/Umr6mEi+a/C38yj4xC4RQUPjw8LPCcA3OwIIj5NxAQd/YP2yHEpH3t
	GxPq3EZApnxnKvE0pERO+/x90sc2psa6PU8xC0MRqTpXNBj6M4BrmMymfJRS+7FXpeilLTT2udN
	ISe8TB/jRhtsm3NZMC50dnD2F5DrNMH5Gq/x4ma2gSKkAoRMNO3rMwIVw6Ll2fKq6hEACq5iAs=
X-Google-Smtp-Source: AGHT+IEJm/6y8y+puoS/wfQmfMSA0/Sy9yyfdJPJxEYupMGsXKLAgOrTM2SIv31v+BZdP0uPQY9lzg==
X-Received: by 2002:a17:902:e743:b0:215:4f98:da0d with SMTP id d9443c01a7336-215bd0d8968mr140384575ad.15.1733399386728;
        Thu, 05 Dec 2024 03:49:46 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e41e52sm10965545ad.3.2024.12.05.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:49:46 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	shuah@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests/livepatch: Check if required config options are enabled
Date: Thu,  5 Dec 2024 17:17:57 +0530
Message-Id: <20241205114757.5916-4-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205114757.5916-1-simeddon@gmail.com>
References: <20241205114757.5916-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_LIVEPATCH is disabled, compilation fails due to the
required structs from the livepatch header file being undefined.
This checks for whether CONFIG_LIVEPATCH and CONFIG_DYNAMIC_DEBUG
are enabled before compiling livepatch self-tests.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 tools/testing/selftests/livepatch/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215..14b5c60663cd 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -14,5 +14,6 @@ TEST_PROGS := \
 	test-kprobe.sh
 
 TEST_FILES := settings
+TEST_CONFIG_DEPS := CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG
 
 include ../lib.mk
-- 
2.39.5


