Return-Path: <linux-kselftest+bounces-23102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5D9EB0DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82641162E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5711A08A3;
	Tue, 10 Dec 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDh3NiY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8919CD13;
	Tue, 10 Dec 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833944; cv=none; b=V4/ZYYboShL2ChRnvnu8ma5HrJgeCub0P3muN5zO07kpw+hFCpk4n5kQzlCnyCKoUnTD0vZVo5PvgQSAMZDUPkzBkSMWN2NM1qSgmd7ZWjIJqb0bUsgOWtnaCMkOzleIVgW3fecmNw6kWsFXY5O+BBJyZf6E73HJjX0dK6Srs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833944; c=relaxed/simple;
	bh=py3np8mHYZz5vYUgCa5rUnW1pPIUhzSTBVF5PY9xebo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IHtINuHXjC/pxj2HsNBQ3Cq6ulWDs0YbFsmovcCzENS6p4HiLzUdXHztjHeOxUwZylBq6M302SUfDUVIAAi0jY8idbxgc2ce2kLQd4PngbulU6jfvhCpOlAFsTprDRWxwgGR/zNw/iU7NQDJ3UZLZiphteAW+FKKAOgJ464+Ql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDh3NiY8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so4846698a91.1;
        Tue, 10 Dec 2024 04:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733833942; x=1734438742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOTtqR0B0g0QTJBEGHIuHVcLEEVxQ8VQCly/AUUGvUI=;
        b=hDh3NiY8ezH1+2z2HQYAp/ZLmBza+ISPxw5mMvG8+rXaUpyCUnxWcBb+wQVLMZhSlH
         UCLr502tuB2xskw9g8+Ueo1y2akb/j0dgqG7auxtIV/Gdy4YyRWy9P/iugVAS/7VwOis
         OM26nAhcGe4BF8sJrnV+69AWP6hH6/koHnFFU0+ofj6NPSN/Gzh3zTmZyEMBfDN0g8ho
         WBwEmfr2x4sRDINQFJiVPlDaXdKOc1xyFHXUJZmqL1E2ikIP+RTwuU6VcpZ57OSGZycR
         F47etWYuHEtBcGRP/YmmLh8l3hPnICYpMBOQ/kWn8HjS8Nvg68ogBl79ho+rxnZ4UXiw
         OXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733833942; x=1734438742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOTtqR0B0g0QTJBEGHIuHVcLEEVxQ8VQCly/AUUGvUI=;
        b=lABOV37R1RsGfUGXFii7J8AIGB9KzjiXRA92WSqhE/7HCRM5181I41lGqu9jEoYncp
         G3V6ybc3u5mY180fncMQBKLyAoWDBOCFgfGuymTwcbmiOsVg9mh4M6G35yXjTBxShc5B
         dIlAFNHQ7c5jXyzhlmm5swBJcW06bQNbfJ9QUqWBIIcVBUIgip0GH7oEJp4Hr4VZ3jmm
         bU0uoTVfa2AoqAdp19wMgahpGtGjfz9e5Uu2+Gwmi7MSNJDpa9bsfJjT8N5BaKpZVIHS
         LCov/rDWXTmjtt6FsGdU/U1zyJ5U7yStan1IIeHwTvLhmmqzDLxsGcGHP6ofttPidsPA
         C5iA==
X-Forwarded-Encrypted: i=1; AJvYcCWTt0YKoZbXH7sLFM0F+B2o2n7sE79T2GZ0NA4SR/T3hnChWf88ufftG0c01+gkq45F14WJqU2ixVOJh7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygl7fnRXLvZ3y92gudeT0AsYj9OyizzLq1kdf1YGZjv15Bbg4f
	zqiUZnaDtVI99BsBcaahD0QwwwjLifNa+OdPhx/57bmAIYQAcXeQFX7NZpGh
X-Gm-Gg: ASbGnctWoU6yMs0loGKH4/CsxykmhI3lwVFDPVOScfTq8Yi00res0VT5kST054Qebh5
	I5QySVspziM+LInVm1o7Fp+3NQCdlMrAoiifqZlQxl9kGhQDTt/CthPP5dWnrjIACGwXcZryan5
	j66L8u82SI0+kVs/jYdgd4XJCKR1jJ6SRHBXwBMYIIteHZCWT7MIS5i2h1NcajqGs2nBSy8e2XF
	QEGAJkfm+150L2WsR3Kzb9x+AhuX7deOQC2S4gwl94s84sS+/7ozhx8jbV0k0jrNKc=
X-Google-Smtp-Source: AGHT+IGUn8j7twuLplRI/encIM1pRzj3blVmgqOTNefBAL68KpSFLf+odcAYy1m5oHAqmTm4LjKx3g==
X-Received: by 2002:a17:90b:4a01:b0:2ee:c059:7de3 with SMTP id 98e67ed59e1d1-2efcf1cdc48mr6496313a91.18.1733833941957;
        Tue, 10 Dec 2024 04:32:21 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26f4ad0esm11564800a91.0.2024.12.10.04.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:32:21 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org,
	abdulrasaqolawani@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v2] selftests: acct: Add ksft_exit_skip if not running as root
Date: Tue, 10 Dec 2024 18:02:12 +0530
Message-Id: <20241210123212.332050-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the selftest is not running as root, it should skip not
fail and give an appropriate warning to the user. This patch adds
ksft_exit_skip() if the test is not running as root.

Logs:

Before change:

TAP version 13
1..1
ok 1 # SKIP This test needs root to run!

After change:

TAP version 13
1..1
ok 2 # SKIP This test needs root to run!
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---

v1->v2 : Replace ksft_exit_fail_msg -> ksft_exit_skip
v1 : https://lore.kernel.org/all/20241115191721.621381-1-cvam0000@gmail.com/

 tools/testing/selftests/acct/acct_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index e44e8fe1f4a3..87c044fb9293 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -24,7 +24,7 @@ int main(void)
 
 	// Check if test is run a root
 	if (geteuid()) {
-		ksft_test_result_skip("This test needs root to run!\n");
+		ksft_exit_skip("This test needs root to run!\n");
 		return 1;
 	}
 
-- 
2.34.1


