Return-Path: <linux-kselftest+bounces-30156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B48A7C875
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A07C173712
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5A1D47B4;
	Sat,  5 Apr 2025 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp121cBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95A1C3BFC;
	Sat,  5 Apr 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743844761; cv=none; b=lu88Sa2NehZ/SYxDWFc0zlHtLg1HHquFjP5D4wILYUmoN3/Z0NJrKtM5qEmUGMbI0XTvtJb2mDshgIJ5ln68cLZ5A8OlKRfB4rtGtX8OwoYGN+d05OVVit2nqQcOZ6IHDT6Js6Fz3xRc6bxtAgUQpBd0Urhmbd8KmcnIx1x5QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743844761; c=relaxed/simple;
	bh=H9WDufCkKvv1yyD00jKAJKAOHScBQ80qVwCNVNT5D84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljED0C6xtmv+ktIl7xhaQBpOSE3gFlvmGa6a4afx/UIMLJYt54Qx4III/fv9wDAw2SWTTCV9YxjvG8ajoAynBH4EXSFgUxfYyH30/H4RiOO6nzF1SApLe+op+vfhJujtgqG4l9Y9+w5w8O7v2BdJkmHTNmCcUXoPdyCAcD/gk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp121cBK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ad51f427054so1936201a12.1;
        Sat, 05 Apr 2025 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743844758; x=1744449558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzjWMcByQzCFfTzUirTtuGeFU5cuYUdBA9J+kXb3PX0=;
        b=mp121cBKuQUAT4egySKMgkkdQH9z5llNlCaNKXxnNSfojDJ2WXMUk4jT4FWv2R8Zqm
         hytTwZe5NP0IaoFGXGtazgJDmgL2SKGfdv1VcbX3GnuRpXXj0Bj1sVQ5WAI5gbNDS4nz
         rtXToH6caLcu32MwIFOItq2fdhHj/5rdhivHh4yGRnwjUHdCdzhvGRe7JfdxBuKkbW/X
         vqOjxkGfbyLBd7vYMbQxiTs0UasHTaVCfA3H0WVutubOGkaK/YH94mv0KKXWdDusPlXo
         4ph0xUrIP3oGM6HnF4Who1S1BldMXFYe2FpDxXcQDMV3UFaBddydna6iYQFmXVJXRnro
         YO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743844758; x=1744449558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzjWMcByQzCFfTzUirTtuGeFU5cuYUdBA9J+kXb3PX0=;
        b=CMksB6LCLH9db1tv3xVrPsazr0mmRZieoD1hw7IO9dozTOdQp67jX5tn3FHJ9KXPGF
         vi/Sy26B1d8rJhDgQioI3Qx0YVyILQ+rpJx9ZCw10gsibnF772j3YRbJ92cP/netZZsn
         gjxZ0sl9FsTY+EZINVcD37l5jYorfJU7c9zVyN//1El6Ff5whvlywTslKVUuJ37mP8qd
         spqkjRqpT+V4lvciNtdDpBZ0ycq5ApD8NIcsZpxC9kfab2h8MiaXq3D3zQP+BmEtn/7X
         edtykjFnLKDDmiLKdZv7vw4XccrHng5biMJk2DAgo/WidM6ibqpQ9JUQzCNbfscGoGjx
         weng==
X-Forwarded-Encrypted: i=1; AJvYcCWsqPIucYKjkneij6f2Yo/9Jc9GB86noFR5ycbaQjMhgASTZnzuKGFh5Xn48shDv6kGkMicDffm+eAR5QvVpbsO@vger.kernel.org, AJvYcCXmNgzGrVu/pHMgdmfTuthLaAk+q2jFuclRytyLcQrEYVZAak1w7zjgIb+hLcEpR2aPFRAcMlwtZygMABk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEh6Mu6E/49BcwqabGZebgVQaL1W1mNCZPQ4L8vSejMSyOoaB
	9hii+2q2jNg3EGir0MHCuCA7tibkUDxD87vspfZcoq1HKPSs+EWn
X-Gm-Gg: ASbGnctcGTKl6o2WFoTUCJqzrRc3aPYAcJEQlX5wlZMTyQG1hmiMRNk8ZOrcp6ppUvB
	NItwH38/9kjqdN1F/MOxiAM2uszzu+m9xRPJ0620K8Z/yLGv0A/ptyFRMJtcqI1IJkB3rZKy+Wq
	OmFWI3lTxxD44zthNbRap+m3k4VnQzzExVnkj1GJxlW46VOnFrNhyzNKvoGyqfZ1B9VHwyZcylj
	kBF+tdONj2cQtTDqi7NH++HZLDd+MJ13DCu1anR2R5jq6bYe19ENm32A18RrlrQemk2JVCf3xCI
	R/kLbS9YZBM3+Q9hlifTEk5MATbGTqEsHiEzLevBBA70HZIgMFpA/LU26ARmi+ZG/4DZ18JvabE
	=
X-Google-Smtp-Source: AGHT+IH17D2a2ZK/K/Wp3XUSIp0F/QFxG9KvTsV0bCesZDJ28V7J0x++vHHbGclvEnu/zom73oy1Qw==
X-Received: by 2002:a17:903:1b6d:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22a8a1b8c79mr79312175ad.39.1743844758295;
        Sat, 05 Apr 2025 02:19:18 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:309d:74e8:7ab1:1579])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1ccsm45815275ad.174.2025.04.05.02.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:19:17 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] selftests/mm: Add missing gitignore file
Date: Sat,  5 Apr 2025 17:19:13 +0800
Message-ID: <20250405091913.520889-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "guard-pages" binary file into .gitignore.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 tools/testing/selftests/mm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index c5241b193db8..c9fd69ece95c 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -58,3 +58,4 @@ hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-regions
+guard-pages
-- 
2.43.0


