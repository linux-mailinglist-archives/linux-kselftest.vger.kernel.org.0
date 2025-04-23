Return-Path: <linux-kselftest+bounces-31385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F9A983CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33E31B64D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA427CB0B;
	Wed, 23 Apr 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT9a5pGD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2726D4F6;
	Wed, 23 Apr 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397322; cv=none; b=sISeXJgiG6zr6tZwqAdvh7/bCx25wcQwLtTjD+xKSgM9gtwD3AXgtF0KXMVcky68VfNN2MdkM2fSDBXOId1011hm7jSHUG8bWUf+fdBLMnHaMC2hgP/MmLoxOjSykmRSVAz3aMIk4WXAjOCI2HbAhz1Ok+BvC/TRFyJl6J+0Umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397322; c=relaxed/simple;
	bh=BZSLijxSXMIiXrMszqB3BP92kAcntEir0dS6YlGxXnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IOjDzryE9CAlf9CQMY1C+6ccpLS1X4Qi47b5AE3jDqicJc51o0U3Cin2EZ+GLC1QbNkHLq+yH52xGgIVpnHAKf8raU3ctl7ZCbKuv+B8rkk3an9xQredbk5oAtgzWywN+ozICwhQF/YU1YAOKNvQbITHLO0rBgZiBpoKSLkoyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT9a5pGD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so4191001f8f.0;
        Wed, 23 Apr 2025 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745397319; x=1746002119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsqunO9lss/uBzeiIi4q3QDIiMQHRXAesVvljbjm2ZY=;
        b=hT9a5pGDmKHJ3LB/pYIbp31pmxgbdYvmxkrxlHunRsVyQmyyascqRwapaYXiEJ3+le
         fxON6MrJAMb1sbD4mR9A+MerAIdjotwQrUiRI4DO1fGu5YuYMpmuJ5LBbxe6R9fA9b2z
         JLJdITa1AVmbShhz2tPh3EB0fPQmnxIthd4eoMrnIHlgYztkSGqR65XGxRG6Pryil8vQ
         eOtIDpKfvw4JeA4a8wI0Ddl0qKSY+68jy8cxU7nPOG2fPAdhEzXpy6F2x8ok5tYZpOYK
         S245A2FxvJOHQKHQ7buSzYNhAAfPUhgB2B2bshTM97T9VZ0pGSi64Je70NQZVK5Gdpg1
         5O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745397319; x=1746002119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsqunO9lss/uBzeiIi4q3QDIiMQHRXAesVvljbjm2ZY=;
        b=oevYDj14rZsysqKNKG2vPuIbU4XsbmHKLw/7zrl6uxBGA2AuhXL5uCONZtRgJ9qFOu
         N+ZpfAuQB9lBvkbsIqZLTUExWO/sN3Z8c4x3nRNzYFwDHyh5drmCvpfgy73Qg/8SPESx
         sCU7B2AncxErC/rE1sV0HL2BmbZYYypc1TRnNcmBD76plgh+ZrOp12CZiINWKmSUnmS4
         h5ol4SLZIYluQTTf8DFIhAMkFsGuwmPcj+51DHny0D7vQjr00s+NR/486VpObTQJIN9l
         /dZXWoRtNsYFscgbWxg9x3T29liqoCH8pB/bWRUK6AVTxdjgRq3MXSeeQA8nlpVD6h6X
         rGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsCjA+IZL0UiTqozXwGVXSJnuUgg7etdTJYoiU6iMYlgf/fQzeaBCpgaWegDrnYIthoLYLax+sDfuKPs=@vger.kernel.org, AJvYcCVD1wjv6yAvGITN359Ov1y4Tayzl3ZOrVXoAJYOwla+DSrn+kHdMGhx4NiwINxE9d4rEKUmprnOLDTR5wwirW65@vger.kernel.org
X-Gm-Message-State: AOJu0YzlcItChbbWd3UGrQ4rJtBYsu+VQGWsdsL2yfxDjcgFYOKLfBQx
	1H6/uS9nzSXnjZl6RayO7MPDEpznbWBG5g7EjgJgn2chpDt8ME/2
X-Gm-Gg: ASbGncssUBPrmlTpwKZ3K7p63lP7BkWKdy1Eukr7KiyRJwjFs1W0WKy9GgpSEDv+oed
	fqtqwGi0Ec0pkK8htvrIR6EM3FPo1Eg8L//o2jPMY69rDqH+LeHkFS0rbic4S8qQgLXIXmzbJtM
	vbR3MVSx+welrApXV7b0Nevnw0M3fTnMNnjgQAI0+b0ntoHM8/FQN/cQ/mXTpnpsE9OzseMks5A
	GCfuzKjMAzcHLQzcoOtF35Vh1Ux71JVLk1UKxkDzuX0nFRrrvaptAFkwCVgBL78ckRwDuUfkDSv
	hdkRurCbMX+ITeACpy0t6oQJAaKxcW+p9vegaGQboyfBioacVJ7s
X-Google-Smtp-Source: AGHT+IHq+qc9wzwJk0+h6l/1r7L8EKtIf1dbPpgU53Uopd7ij6Jpyj36OOnzVIYCr9XQy8gtMHHv3w==
X-Received: by 2002:a05:6000:184c:b0:38f:4d40:358 with SMTP id ffacd0b85a97d-39efba39a4amr12792668f8f.9.1745397318513;
        Wed, 23 Apr 2025 01:35:18 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa4a517dsm17742256f8f.100.2025.04.23.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:35:18 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/perf_events: Fix spelling mistake "sycnhronize" -> "synchronize"
Date: Wed, 23 Apr 2025 09:35:11 +0100
Message-ID: <20250423083511.139896-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/perf_events/watermark_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..e03fe1b9bba2 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -75,7 +75,7 @@ TEST(watermark_signal)
 	if (waitpid(child, &child_status, WSTOPPED) != child ||
 	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
 		fprintf(stderr,
-			"failed to sycnhronize with child errno=%d status=%x\n",
+			"failed to synchronize with child errno=%d status=%x\n",
 			errno,
 			child_status);
 		goto cleanup;
-- 
2.49.0


