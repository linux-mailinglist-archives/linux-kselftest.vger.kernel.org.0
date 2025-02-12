Return-Path: <linux-kselftest+bounces-26449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EAA31E24
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 06:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DEB1623C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DB1F8BCA;
	Wed, 12 Feb 2025 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J57u1PKq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521CB1F8ADB
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339054; cv=none; b=l+XDESVr0fq2lfR1qZc6oYqxrfWaKiUXH74dhIM/4FRH2cLXfYwjVsEQvqYba22i6k7MC5KcQRm5onm3UbxTp+r7z8x88WaNInbXInbuEd2XsNysjAXrgORJHuFvnXn2jzaiYWi9fBbz0d2T1gvO8Pdkqhr+bbULfPsi+1nN8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339054; c=relaxed/simple;
	bh=V31QGzTKdittKrZ3aMRv7ryJK1V5ss1ZHiuTJ3vecAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBRz5ldl5PBU5JxBFHD+aLmfae6ebpypK7VMpIr9iMAnDuaXxPBNy4nikcy1fJHmezyFR9qmUvO8oRAHYPulmfn0jtSeU6czwN+DFQgqTUwF4IRd2KOqKQksfkAFmDuQ6OC0fdnx5w+JvzaDiYlBdmF8vAbA2wI4AG2nde8+O/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J57u1PKq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so527239a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 21:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739339052; x=1739943852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUyF6DpPsCEUmNdZi2XEJgFOvze8NsqDYdne0FtU7cU=;
        b=J57u1PKqvZlcwZDs/dpfulFdUjqlAMh48jrQPhe06Bk2w/Xnsq7GSIg7myH8f82gtM
         S53VhzdhtE/0lfEAQtd5u0rZZwJ05+R1OHUmyfNGHq/DUaVsib+YgZRPdb97a6Ji10Pb
         lc3gJE0HWXqVu+J3jhGCc77uaEs7meyDL1LQre0lUxE1CP2m1bhioxJQ6wSau857x8rS
         nAphKSqjs9rusa1FmDQkN4mi1Zj8njIom/rZJGWRWn4cELGzg5a4k6yXGetDAvgGOZkY
         XlMbibGDr5pkXAg7qqs7C0GYivEweLWoTUxq4KXwpBt5JNzkhWHAEVFExvbOWu3KBNl9
         GelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739339052; x=1739943852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUyF6DpPsCEUmNdZi2XEJgFOvze8NsqDYdne0FtU7cU=;
        b=K2TSpY06aUUPWylz456eYmlY55DI9wi6D0Rxb6C4hCu3eHpm4hp+P9DZ+EYuffxeaq
         jGDN937/8rZJmpC6VV+6pJUcwPYFxi5batcrGAJIP5l4ZKDTcUZFTXceuDJFYdauF3hK
         /WUrfGHCBAJTOq42LKCDHoyoblc30Em7+cZAWtedXiULCI1vjK4dWLgX+aNLOzL46UAx
         ks/8d+WTKsgECb6b3ak5vWUemcfTUTm1bluu+oymxIvNRUJAXuipRAFyGtOG9XeaZOW6
         X0bkxyIOpHlmIm+1PNyVgLd/07R/KLT3FNLJQJzHFFtiy0oh8kTkL1zY6ZzfROvvIWUa
         R0PQ==
X-Gm-Message-State: AOJu0YzcrUyFNVzEzyWcLWYBFuN5hng2NLcPnJdi39slyX62424ogYXS
	/4/wTV1P+ld8MW8YzsSb7rkKthmUM/imcxs+Eec/5u4htW5BAsLL
X-Gm-Gg: ASbGncvOD3fOI23Xcl7z44+lsV5mEKmW64kx1QW+mJvmQu+E4P+AmIvlsBuaLHm3vfT
	RHYpC07X5qAgPdffG3NnPnqErWJFq/VK8hEtyqnJ6ScZVZxFcGIHlaT80F7N/oQhM/PRsscxNhZ
	jlQRxUD3vUZAqlkfU5ebD8T3k+W6uBnRi6GSOudA7d36/7jAcAtuNe+BSYoVxyDtku5nYrDxZtM
	IqjQGDeAIWh1a8BaBBw3xs8Bwcd5mM4FuAu6VtfLq4bv0StLHkfhaChSWmDl6a3LpeKQgO1wqOa
	klQW/JZtTcrqvphYc4pdEP29jRJXInWv3mA=
X-Google-Smtp-Source: AGHT+IGAf2W/iUvVdXurPH6g2n7X82uDf9DuEqqo5vOB2NvDdGhpv/kvQPgR19aih/3lDcGnS096MQ==
X-Received: by 2002:a17:90a:f946:b0:2f9:9ddd:689c with SMTP id 98e67ed59e1d1-2fbf5c5e9fdmr3155438a91.25.1739339052385;
        Tue, 11 Feb 2025 21:44:12 -0800 (PST)
Received: from forest.jssaten.edu ([210.212.85.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d65esm105467355ad.127.2025.02.11.21.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 21:44:11 -0800 (PST)
From: Rohit Yadav <rohityadavconnect@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	Rohit Yadav <rohityadavconnect@gmail.com>
Subject: [PATCH] selftests: timers: Improve clarity in time difference message
Date: Wed, 12 Feb 2025 11:13:50 +0530
Message-ID: <20250212054350.12387-1-rohityadavconnect@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rohit Yadav <rohityadavconnect@gmail.com>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 9814b3a1c77d..f6e3730c63b5 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -88,7 +88,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff += (end.tv_sec - start.tv_sec) * USEC_PER_SEC;
 
 	if (llabs(diff - DELAY * USEC_PER_SEC) > USEC_PER_SEC / 2) {
-		printf("Diff too high: %lld..", diff);
+		printf("Time difference too high: %lld\n", diff);
 		return -1;
 	}
 
-- 
2.43.0


