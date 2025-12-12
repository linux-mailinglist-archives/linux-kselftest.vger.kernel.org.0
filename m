Return-Path: <linux-kselftest+bounces-47522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0FCB96E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2831630C53EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3682E7BC3;
	Fri, 12 Dec 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EhJnjFcl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF672D7DC2
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559835; cv=none; b=Y+6UweZlLsuAovEknckjL1rSxthV8MqpoCzc0qVY0Y9t5pTlTwNocejE2aDXv46f5B/ZpRRWHKDmnY5kWcPfzaGl1I2hLw6PopyNjZHvpJAIkyP+NBTXR7rGb44fgX5vpntJKsGhy75Uq41X4uzkJU0Xkeo6ISChB62FYPXeZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559835; c=relaxed/simple;
	bh=10p2JvkCz7yhrUBuz2Ld/a2/xjutHAlTWQJCwGsKMAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4+vo1LNUKbMemiViWdVStc29yDLBvri42BatFUKtlG3Q1vHIWrGuznmueF50XDnLGcflarIC4PtG5BaM1viKv1Ibb3Oiz8ud9HG/6qE+5yALP/Grg95z/IDAEfFjD5i0i/Srm4NjJ9sqQXR7D+Xtjqjyn5MjYfefnPtt1aNbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EhJnjFcl; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7ba92341f07so125401b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t84ae89m7Sn7pboO/Zmlj4sDWg4NpM9693HZfHYO+4A=;
        b=EhJnjFclCHrZGPamfpV64lrtpMsmtHWIlt5vqsQjZRY6l89v3XBzsiiqftc619dW7W
         vYCFpaRKGfVEmib3Wc0ReXPAz+WxSEVcESQyGNmM06Yte7hH2UQHv0FBYN8R1J3JmWHH
         w+uDHNcl6Rfub+ocfXN+6n7A1VACpaa+oe8jNCNwvghstYRzKxzuXuHbMU0hfYqKwd2u
         4luLyM0p2oeIH1HUivSOkydSyTks6u9Yg7Er1XtMevXPz3I5OfePgZFsXCrIDJ3QtT8n
         lvgCz6xyOqY6Rx2+HL9w1EXA4QZmCrIS9hIIIBrP7FT7rojAehrsmzFRiQhp1tHvX0DA
         rziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t84ae89m7Sn7pboO/Zmlj4sDWg4NpM9693HZfHYO+4A=;
        b=eBZRfYh+GUFPLn0n3GRUVvxUO53TmN62DYuTljyr4erjqYRzLltdn9Qr+7D7SXagrA
         bbZFFoGdQA27zN5cL7yshhmJNTOZ+yX1TmZ3ayEqy+tID8ToplypyZvYZHpZmO2sw7iD
         Jr5rZukgLkd3MYgVJPa8Qhlq9JziSKAcCSsNMUGo4JIUFjgI1EvddS9Bbr5NPz3C5W2b
         Y5Ne6Uixnqs3w3L3ErmujVdeC+ogab0XuyEiT70sfai3nuqOm3X4LvOaYFCITsthBeOX
         7ukhd49PCs80A6hHXlgGX6KtPVZh0hTbu2hwNKX1Kgm/yiQ2B/fZlOJKudMy3lWx0O91
         fZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTJFgsT+hSsQ1stYCgpbiZekjXTyhXAsBOWBK6ZJcB+myhSWUjK/fEYlC92P+nOpp75c/Zusu9NUEdBRVjAhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsyd5pSN88ls/P4mvvS2a7ZWj2xzZ2PmnrCpzWBcdvsSSMnIkm
	l5Xq0zoLvvQybnCdElyOEgkaqFvaDO0oZm9VIqSGG/5sAJC4UIvm0OuY6VUF+yuNw0IpQOAWsEJ
	Zn2f5M6a2oZA02jZgIZ3K7GXrlCaSVQ+3LAFH
X-Gm-Gg: AY/fxX6Qz7EITHvkD4vvWq18sdfQVufm4+DwbDeWRsEbO/MI0UqMBmCmX+R4JmeQArY
	8nrcsqXIdNBxpUoJGwOiJm6CG4McFz4fDuLx/8BOmBzQOPRqOo0wbaSDhgineZTPzxemAyoNtzG
	jl26141aJOH5ibu5i1M/ixFE2zCqdBsF9IEC2Dw/RpijWsrzvxNY8hBggI/7CZDebuEb1ssPIM6
	gaVxp/G0xzaHnTMTJ6Tkt565PO4Kp9K+Mk34c/kYUeEcBXcaxH0egNDGM880qBKDyFqcI2RA4kU
	sOrdTo0TDFDiSh+aB6YLoalhKYer5oTCmc+vwmlqXhP1fvX5Cm3mnr6I9fkh3aRGBavePVe+Si/
	4fpCY7JaMApHPp/CzlI1mgYIl9p3iFQu06ExGwFHXBg==
X-Google-Smtp-Source: AGHT+IFD5gHVVNWG6BaOT7P35MqSA1ymiemgVdEAiw2PQWit2v+TxRzmrZWLm3GqNrYoDxOX0x77xoAqfsLx
X-Received: by 2002:a05:6a00:3d10:b0:7a2:864b:9c8e with SMTP id d2e1a72fcca58-7f6694a97f3mr2099355b3a.3.1765559830496;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7f4bf6beb28sm871869b3a.0.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A452A3409F2;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A272EE4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 5/9] selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
Date: Fri, 12 Dec 2025 10:17:03 -0700
Message-ID: <20251212171707.1876250-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stress_04 is described as "run IO and kill ublk server(zero copy)" but
the --per_io_tasks tests cases don't use zero copy. Plus, one of the
test cases is duplicated. Add --auto_zc to these test cases and
--auto_zc_fallback to one of the duplicated ones. This matches the test
cases in stress_03.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 3f901db4d09d..c0c926ce0539 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
-	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
-	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 fi
 wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2


