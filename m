Return-Path: <linux-kselftest+bounces-39358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED60B2D64D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2003A65BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8432D6E56;
	Wed, 20 Aug 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SggKk/fj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F491E9B08;
	Wed, 20 Aug 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678243; cv=none; b=EoLTgwxuoHsWls6sLukB3s/jrk8+IAFgi7E//9MuV+oDdNhaGs9D4rarPGawURROmO03uj7BG7ULk9/DqqnGPVrDrA5OGVfbiAH/0NzPGEKyUU4Q9VWMx5RqTBGgjpf4CAXxr6nwggfO/G9AqX65CFzF9kvD/dw5+ycjJvZU78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678243; c=relaxed/simple;
	bh=je5AHg/youKOa+xhCXnHlhnCi4E0rhPm8H3bXUt+7zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzlD5vV38M8CqlIUlpvhYd2ChjXIID3Nxq+od3UyUfd5zs3WFLt87ryOYytImUpbtaGVhDyGMAZ2wDgMi6/oNq2Rwc8wwlHjVi+yyGRjpMbEKAmBFB3uwztsPuqHMboimjref08K6ehiZfuzJ30oyDMqO0OIOSJrveb8SRLQqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SggKk/fj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458298aedso52940515ad.3;
        Wed, 20 Aug 2025 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755678241; x=1756283041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=SggKk/fjFabo/QTIPd0UKllDvdj/oV57ozlvOFITmnJuQAFgzqcEXu8kOchbTNb+7g
         GJY4MDPb31cg/bkoNB8R33m4pmUrjk8D4oN/AY2BjyFuScJxKPiMuiglVDOT9x7UNpk0
         irpMi/3w8lC8LRr8eMzPUojT9+yAts1OHRtD2X4e8uJVQ8By00jXT9mKCQ6URFcUWb0a
         pu4XrnF9ad4i1t5G0Pwdxjp24WR1JBpeFRQojW9vazyEOAxD2dXfIeix5dq60X4Vwgme
         W1onoI2UUKpDollO4dUCdGLERQK5kRTZ+AxZJV0uClPClAmQE4DkhN47SjlpFkgQdwBc
         WsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678241; x=1756283041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=FKWm4LIohOzvRboK6kwt5XMU2xvGsfNQ15OIo276LO05790qb+Z3JU9tFB1rEXcp8s
         egnbF//49BdpH5m5SzQqZmg9QY3U8SgWyuCVFlSq5aBbBelTI+bjLTSG/NHtJdbuy6ZP
         tqGpTgIn73gOqh0S2fesVaWQQ1rktobpNRMbP+I/03LW0LFs2nDJ5gV/5ZAQLLuxbiaq
         H+M3oH0KclSlDHcXyI1hUTXZ5azpNY4cCeVtZ4c0sgq1YeQEJBj7v23DLHjVKbJzKTj6
         FQSgpgBbZbP5TLWUaafu/KD7s3PbsJ2VspiT7V4Yel/VV7/rAuoOeHrCJrliNRy4s11y
         Ktqg==
X-Forwarded-Encrypted: i=1; AJvYcCX4OFjFvJbZgZyMwCPl0SYG1EucD1w6d/1MFIsHKGAwWhmkme2mkeqGzKA8DwW5T6nEGrZBkR/+9Beukn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaH4CLIaTJb9LDf6fW+fOU2ym9WgsV5NtsMo63F+n++FTks2Dw
	GvQ0spF04pDZySC7X3IhHsGCfOqW6xxIeWUTlqYIN88jt/Hvnvcvtg98XUvJfQ==
X-Gm-Gg: ASbGnctWsexeQ8Ilt+LIqhqHqxb/m9AXChYySOxktxa5uyH04SogURd5FIQ6I+xIRDo
	YRSzKJXMI1nu76gjDKFkmZ8eIGBOr5mmC3wJtGf/SeQ3l11DdsSfVZtpoiLL321FZKev/n49ygW
	GHiPUp/iDJBlmB4fTAA9f0ffApjlWaZDTuyCd7/Xsvf54PRdEBTsuZJOa8LoMPyn9Z0+elc2jY3
	kGqQEXZrtc7oKL5ZxlZv/LyAK4hLBY1CQuxvQOJIEpI/nAB9TjyF1czMXiX87Gd4bEun+2Ha74c
	WwNVagVh2Zvd2NKt4fVrLYXDgHuiuuJ8xj+bsDBLeTisqBv8z9FXBo4SCL4GMefDXnUZ9cEf4/M
	8Eig3krNB32sM9nrIjSqMbw808TEbrflOwg==
X-Google-Smtp-Source: AGHT+IFlm5s61pgSdw7v9rOpaowRSsn5eGN3T4tyYsqmKoKZaVsdZZhOhfRaA34jPoNlKINg6a7Y6w==
X-Received: by 2002:a17:903:230c:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-245ef2a3372mr22000055ad.55.1755678241177;
        Wed, 20 Aug 2025 01:24:01 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33d2a3sm19443145ad.12.2025.08.20.01.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:24:00 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: shuah@kernel.org,
	cvam0000@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] grammer correction
Date: Wed, 20 Aug 2025 13:53:50 +0530
Message-ID: <20250820082350.10180-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

corrected a minor grammer mistake

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..ee2894e4f7bc 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,7 +22,7 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
 		ksft_exit_skip("This test needs root to run!\n");
 		return 1;
-- 
2.43.0


