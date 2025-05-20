Return-Path: <linux-kselftest+bounces-33366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BFABD180
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A828A5ADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9972566F9;
	Tue, 20 May 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPfKI2pi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06277102;
	Tue, 20 May 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728430; cv=none; b=tXrjDmBhyCu5wZUITcbN3hJYeLtk06bl7hgDc7uk9Jje6W68DIcNLruy7VLlKT+ra55HzWyz8ncJE3Vsr8pJF3Zjw1YYfUtSBQ0sP59txg6N543U99OHfOIp2ASRLBFqXgyME75upGmD+OQFKz20BEMgD5odK0nRJDScQe7ZyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728430; c=relaxed/simple;
	bh=D0OYHWZOSrzkqmr4CoGzl8bVmgydg3QT4qWndKfE0rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEd1zaQ16oW84v7WBIt+JO8OAX9lwn56Zb+Mq5OfppSWgAcQRCpo3AlQY3vOHmBfZm+lzSpcSuQV0MsLMuMC1rvFkApFF+WnkaBXOtLCuTvOSKmSU+hfkMumMk4oas/8hm46JgB8DrHnGEIrAwtn1HTzk1AMSVfl/3Zi17reWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPfKI2pi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a36e0d22c1so1435375f8f.2;
        Tue, 20 May 2025 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747728427; x=1748333227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpHRU034TQkb5cjOdrpKQYdzGgIm3GbrQjUM4K94oQI=;
        b=gPfKI2pi7sK+SHfShhXu60VN6Dm+vixB1h8KToPUWCnPpa0kP7lL/i4b4doTHdufCa
         dHUCMd+yPHSYmKnIQ9+8PzLfJjhHviqZjIAR61oqqkCaY5pHiFpocOgMMC9mIiisP5V8
         v8BYY6sIalj3WlYtnk/2dKujKaJwWTTam7x0JL0150PFsOjpmFSGD8YvEUIcE9UTaF6I
         C4v7HlWU0DGcf4E5IGSDsLhGX/aRR76N27kHcbkxdQ90FIxI993S5g2K4acGeEft7b2S
         jV6K6g6goWZiRXeT2YcKw+QKO1nyFWVinjy+DifhPOdqKm/8lvSv/F4PkmX8vlnDlJOl
         OUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747728427; x=1748333227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpHRU034TQkb5cjOdrpKQYdzGgIm3GbrQjUM4K94oQI=;
        b=sBE4O4jA5lk8cpF/L8q7Y8gg8jy1DQfm+NSTRJUvsIYh4JXrUJIoZ2CuREWvBT4+pf
         03bzG7Lj8ZBTTIYv404PsOjx1qhT8KZ/fOj7nTVt+Ysj8WKmdk48648PE5OWE2InaaGD
         UP8cgykxCpl6L8kZ9rlcpBTqn/HPpRmxpuUS7MbgMIDua83Nkr0oAgC1GonnqYAxVYCh
         slT+GCV/5NwojOvAcnj5iOASHBA2vN/AsEFvrJb+qpOhEqeymqtijfeqbvrUZ/E4KMkU
         PjYJUuSbMksBV6NIiYbtvLpw24klG2XtKpjkYQIWBKvju+4C1h8CJq/ZlNStdtORvkGB
         6Szg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBgUS58t3JWj9T2YhdyRnh3THsTQsWVzuiErhWcnCBIrMhjeY+g2Zir7Oz1S87GOtLIyfr7DZFMcmKXM=@vger.kernel.org, AJvYcCVqPXGjmCFjzaFyCY0wmQh06Nop6FYXeMGXyyudj4bL7kcSNhhVXgzI7/LmzgFsXPXOhVlqvurPebvBXv6wzx11@vger.kernel.org
X-Gm-Message-State: AOJu0Yznf+RcL8MgTlzAvdSnO3KIL3sJQsaiGptXCC85A8BifZswFJqN
	6Tt8DnF5HadHebTS+iRyT2cx7Xuv/anmbgHac+6kgYemz7fHDzVuxlMs5h4Pu2g7T+8=
X-Gm-Gg: ASbGnctdEAjd8+BwA8TXoStgcqmjplj25abbCGNFn6jVVJOkDKSMD4oo7v0ej68IpyU
	3tqXYZUBZVZ9WQuI5tje0vNGJ7aqewz8dv/WiYBdR5Y+4MCzgPK8NQjX0BYHdCO6jOEhjQNXcHv
	PH+yqCJ3Asg0YnCPebRqDukWnjiY3FnpjYkW9zESm8i6nPBZylvAywd6k6mROzSdXM2fi0OiUOS
	9fOjQg4la7TRMVu6PkZnsR8PFzJaIKvjiFiDiOK9tRmfT4F1wyp8qsoGUngAGT1pNPvSPJNsroq
	EcqVw+68FS8/3T4qzyUgfJM+IqSMdreYV2yCilIv+ZEFtaZmBLYUcnQOIKtJ
X-Google-Smtp-Source: AGHT+IEZ7lcvAfHdwaoGw0Hd9SkgRJNTKmilJ5RpAOMDo+EDUFFvKvZhoDQePz24CUemumYdt/bp8g==
X-Received: by 2002:a05:6000:2210:b0:3a3:7bbc:d959 with SMTP id ffacd0b85a97d-3a37bbcdac1mr758115f8f.18.1747728427231;
        Tue, 20 May 2025 01:07:07 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca88899sm15280174f8f.80.2025.05.20.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:07:06 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/futex: Fix spelling mistake "unitiliazed" -> "uninitialized"
Date: Tue, 20 May 2025 09:06:57 +0100
Message-ID: <20250520080657.30726-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a fail error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index dd70532f293e..8864c610f165 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -181,7 +181,7 @@ int main(int argc, char *argv[])
 	test_futex(futex_ptr, 0);
 
 	if (futex_numa->numa == FUTEX_NO_NODE) {
-		fail("NUMA node is left unitiliazed\n");
+		fail("NUMA node is left uninitialized\n");
 		return 1;
 	}
 
-- 
2.49.0


