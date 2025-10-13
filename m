Return-Path: <linux-kselftest+bounces-42990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32BBD264C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 11:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D6D189A1CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A72FE068;
	Mon, 13 Oct 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GygZDbCz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F732FF159
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349297; cv=none; b=t8Dd0+q0RyaHUbxdy/z1wO8DNEgaOANvyMTZkhAW0n99qSZEYSb9135bBIFny2gfCKtM5xBVDSpQ2gyobycr5heY2XdABk4nG0elNYkMNBoTt6wOIez/5WK6oTWoOH5kXOO5Mgx2nk4Qdl6aREVVG30W8qOW57EF4H04C2NgLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349297; c=relaxed/simple;
	bh=135EOhoKTKFqwmoxLeVvMWCOwk5PnK2lNA1ueQEBRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBJZhvGWXKOb7JqHeQb2cLE2gqgpYnYrDQZlrfSEPYuQMXb+nqSuYgGX+ETo7J9RUb1tgo6ElwTCojgNTuH+hxFMilHKxO5iajQHKSGW1q3kqX0x1JjzLfJbzNt3qf/MBv13yxsbsjp7OscboYL6w19DdQMJ21e4IkDNlPvvFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GygZDbCz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-79af647cef2so1138504b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349296; x=1760954096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=GygZDbCzK6vE6txljvNPxQjYxdgzvscY/znuMmt0a8HxSDSPsR3yF+g6qHB3VvYQtp
         6LpEWEK+FzE706ZQEFFpT6WnP3wGeeMXVrHDgPR6nyL8WntxVHN5EDZ1Q8lRKbAnKmpD
         /gEb7JnpZPUvxx749+K3Jj42AYG3YyPzEK38qh4gXvf+beiJ8TcoiZBYRHsTFpajHAaz
         d2NKWOEwE+5tVk7lXopcty6Rodn6TnTuT1NoNb1+bXaFHeqNCDXb+aZ4uRUK+u/Jrrtx
         lTo4txFVdAh7VqgYbCO/P2VbgdZriTyqzfpRuT8BWnKQTMqZtPErn5MUEP4z2zKV1NcF
         Iyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349296; x=1760954096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=fSnsakWLj8VytS9XKOExnfpIees6WINmfj+OPGpckINdJwE6isPE+6mqF+FoWAQ08u
         Y9J1AOy6opUqHvLUMuylR6G7t91vKqJ+Wdi2e68RVEre5bzWC2eZAKHwFiUaKJfbg3xM
         i7X4JYOcfDWwENaxWuRCMGQ6CKMdpye7t8zVG80/yOa3hf4JmMiQeBmcU837edKtz0Dn
         8+FErsl4v2PqUnn3N/GqMvD3jEWHrfAc1sGeEElesQ9RF9zjx0x56hxcKr6xkZNy6PcI
         jt99bGRhm9GM8cvbatkzw9ev+e9Neg2NRFxRPyeZ3QbAuZHjAcnDJ3wBkW8ZcmguvE+R
         63Qw==
X-Gm-Message-State: AOJu0Yx0x10L65g5/clYfGWexlcahUyeE/qmO2mL5yeiXBkdB/tyY1/u
	GMm0FEPjqzBiNo2upkyheB4WSsn+2Ljitm24YVayBOSVyjBvmVwo5FsE
X-Gm-Gg: ASbGnctgbp5qQ7ER/yJyGhNdc466ZO/h1kmltGf+olGjLd965BU88nNtiqooWGLzE1P
	Q1UJiCMN/dyQ4Hy6rFTdfuKvpy53h7/4SA14vv8L1PR5y0lAktRVhpWQwLIrVK8oEvus4jP8bzg
	jlutoBNOd0sTzRNhGdaNOR2NHgocGRkNiWOeY+ekG8S+ADdgZzn++RGX+ZSgI0fWNeMm+Gkg5cn
	TV8RktG3XlbkQNQs+3ZOvcYLtF4vov8NJvhkjEaR3T90pMWBor/kC/pZwV4zqlg3YOL+Fr/NkI2
	Kh87g/LD7QI7zII+4qKfT5lxUkAu615kDYXtdpjoOqeFiKyogsyDi1Sra3l7NKCW1bQw+d81JdU
	NIdov41lE6P28Xs8OarR2OwDEqiycWB0NEypKvHLWejTrouItSe+3uIHlecttgVX+
X-Google-Smtp-Source: AGHT+IHCOC2UNw504vBDm8gMi8seqOaSIpg2GtFp/hPeTYk7Ed41YoQAxobGkgEagxM0zCsu3LNgjQ==
X-Received: by 2002:a05:6a20:3d1c:b0:245:ff00:5332 with SMTP id adf61e73a8af0-32da80da55dmr25664345637.7.1760349295737;
        Mon, 13 Oct 2025 02:54:55 -0700 (PDT)
Received: from archlinux ([36.255.84.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddfeb7fsm8975030a12.19.2025.10.13.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:54:55 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH RESEND] selftests/cachestat: add tmpshmcstat file to .gitignore
Date: Mon, 13 Oct 2025 15:21:49 +0530
Message-ID: <20251013095149.1386628-1-madhurkumar004@gmail.com>
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


