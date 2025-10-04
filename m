Return-Path: <linux-kselftest+bounces-42772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F5BB921D
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 23:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBB784E2778
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584B8634F;
	Sat,  4 Oct 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6whSd9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCF1862A
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759614454; cv=none; b=FpFbGkc8qfQ7fMJ4bHtWBVWE5nKJ+vpPFEFMytNvAK/+5Bka9cLrSmE4gLtGCPMOtmXLQPJ7ArfPRsSXSFpH2zFIi/oLVVMH3YakNiO7rYDaM9y5DXMTNkNI1jK/1YauJF1XBhHqDnB17on8TGRdCtYXZb79VIrGe5TKYD/Xh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759614454; c=relaxed/simple;
	bh=135EOhoKTKFqwmoxLeVvMWCOwk5PnK2lNA1ueQEBRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBi6whkg+1HzOnkgczfVJOv2TskX3mHD6PIR2VOCiQnCwInaeUedJ6XeWAUCc0E1+GnKTpWeOpWCdisO7nCl+z0opT6fsbXt37Ono5Q1xehskaOjrHJdgQEXeQNq9w/bqtht6M1KFjDIGPxge5xWz6gThxg1Lz+S6J/1iO0LVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6whSd9z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-789fb76b466so3165289b3a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759614453; x=1760219253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=K6whSd9zTxskxIP1/HWMWN5BjsEVeeYfDVDSzjhzsns4SeCEK6bSEAG6Ts/sYcrcmy
         QouEK5nTRmvKPDxcBrXR8YBPZ2Spa500Xf392uUpl+/efexvHu0m/uiy3vOie2IO8SKD
         opwdQFVopdaMBen7Ysm7MdNkDWdAFSLElbCi+pAjeq4XQlBp4t7xv6wupI2OS6xxx5fE
         tfFCD/GYjzNLqaMbXW1JZ9kxTa3RIaRLczOPEwmcgRd491esenwvB66yqopTig8fNQse
         ltOqY/e8BMixdo0Mv3jZ6PItMmyDNsnDVWNEg8Kf55r0oOS9ilM26hsqKMzqYSgfzhby
         w2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759614453; x=1760219253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=AgY+Bg642bfcQ2jStcoESIpD96u5vasyO13z8nSlVb4Fe3TZaO4TASQpKPMWM+V+cE
         vd7z24ADgouECJiY/bY1MoAYrY/+Dreih5b4Jx/60QS0cQSwD9nTc1YYr6sEVrZMFR1d
         3prZwvTgT/G73usfG8N1a4BOuDvYIlWe2Tyc1aPliHIL/cYMww5t6wpp6VWY19oCzPB5
         idjDM6K5hBWNAINXj2ZoBXwVpsYlWzBUc/Sbl1R0xIIoswLUmP5817s38b6HcAieEl8w
         SOsMcU6p/TThqp0j0Rthdqq699KjmdHfnyi5iMSFHIxSowwiRsZFjk9bdSbVA74TYOuN
         ws3Q==
X-Gm-Message-State: AOJu0YwppPn5LyMmiW03kwqFdadbfxSKJk9h4WpOkKFRuOjjXsgq/lBk
	KZ2i8m7zTkcuggW7sZbX9igrsLjSSxCUHwXXkQVhqy8wI1sAlE/Ar4Qz
X-Gm-Gg: ASbGncuVXmFBPJvWUstKyw5MhKySQ4B+27jPMnKL+4dbQDE2gyTYametk5YJTEuwYf5
	hps64oX3NpqCtA5O1V1sXtNLMnvHBaDs2F5w2SbgPJ1c8hrVQOTipFM0dgNjR+B+oaHAIU3SI2J
	ZsgR9ip7iMFKE1/YyeQiDNKxdbec/jOGykGQ1M58wuOOy8mfDmgIZA24BRH7xuVX0wygJfEk/9Z
	vx1f2TRnM8DdPU4N0BlqWKv+V48rrirW2djSa69wjyPb3WF+xP1AiJ9k5CjE8XmqKCDxvg5ee2U
	2pSSiJbvnAyPSJ9+oX5GmxNYPxeuD37Nnfp4R0tsVAqp/JWOpQTnD0kKTf72JXhkFESBfbAXwGe
	/VOtxaxrs0CSYB7D3DPsZdoUMTflERJV9G4FpRaOElYxZkk8A/1mOpox1lvg=
X-Google-Smtp-Source: AGHT+IGz6mhFK6fAuTtELr1lJpt66OJ1dv0uue/uWlvY8bvgOy1dnpl3I6auqwtpvKyYMtmKCTi39A==
X-Received: by 2002:a05:6300:210d:b0:2b6:3182:be1e with SMTP id adf61e73a8af0-32b61dfbde9mr9335033637.12.1759614452275;
        Sat, 04 Oct 2025 14:47:32 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0209005asm8614408b3a.81.2025.10.04.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 14:47:31 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH RESEND] selftests/cachestat: add tmpshmcstat file to .gitignore
Date: Sun,  5 Oct 2025 03:17:23 +0530
Message-ID: <20251004214723.1827194-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tmpshmcstat file to .gitignore to avoid
accidentally staging the build artifact

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
index d6c30b43a4bb..abbb13b6e96b 100644
--- a/tools/testing/selftests/cachestat/.gitignore
+++ b/tools/testing/selftests/cachestat/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_cachestat
+tmpshmcstat
-- 
2.51.0


