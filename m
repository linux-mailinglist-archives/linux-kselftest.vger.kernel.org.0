Return-Path: <linux-kselftest+bounces-31738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63481A9E22E
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B351895322
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76224BC04;
	Sun, 27 Apr 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kfr9RpCh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9724BD1F
	for <linux-kselftest@vger.kernel.org>; Sun, 27 Apr 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745746893; cv=none; b=Fh4v6H/dXBnuleeOsfPJ2qcBuHD+Eu/2GZgdCtd4rhMfDjMUTN8Lv0xKqvaL/OkB5c6Q7oAN5YtasyrGOaVmxQUOpUHM5BlFmviwzJsIf2OaH1TTEaCAyOqaRma/QRBYWY4CZ4fHI5hHeLAdYP307kUASgkXDv65Fkd/O9bq5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745746893; c=relaxed/simple;
	bh=Mc4hvb9z5CZb7t4r+oQuV2pkKLHcxELRJOCzuGN9B3E=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=eEbGn0O26XxRSLTl8+5M803vEGnNdvr3abwJR8gHiUFhKK4072mdmoUZL+w4MbeXVAyf+QwU07eYbQaAMszRsQ1JCG8bdco+E9x1vu8i8Xh/u5hXifq800JXmbm2b8ZyoxhLUF9OtaGejHbD1VHe/DrNYB2O7r4j16IWTMpsxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kfr9RpCh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0b2de67d6aso4022715a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Apr 2025 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745746890; x=1746351690; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1QzW8ASYWJaLvx5FFC5RLETegsZ39C1u79HEntZtqU=;
        b=Kfr9RpChJyS8JGnhW6NdoVZl9OSN6mHz3jND6V2MdMbPnLYVQPd+V+O0PN0wmJXcDm
         KTJM50mTef01g5Gq1Vgf5NNyDNMmephsyZB9v//xmstl2qF3ObQ87deAyGDAKiCeb60P
         XOWzQTTXBGk1xxLf3Y5INxRcwFwapGXVyGmzO7pSz4eUj1dEM8BH+kfKs+/kNfSwz5Tg
         bUPIhmcZjzgbsCS4jMBu7YSRB9WJ0yo2JA/mkE42NMUAQiP2kkxM8qxJ0HLUU0ZnfNBY
         qbqMy1usruIEQh0zWY0wUpzmDBDNMmlMfs+H3gjRoYMLeonrmI9WQKuk+kaFPsLMcFPy
         1cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745746890; x=1746351690;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1QzW8ASYWJaLvx5FFC5RLETegsZ39C1u79HEntZtqU=;
        b=UiE9Wdxz/vxekOvaa9FYhHljebn9KT3p6vwr0Nv1eU92FecfMJz89FxcA6KBo3VQI4
         /sCFGIzHRsGTy5b1O/Ut1x9a1PlCbKbuFUQpVR+bN8DMdpy4Eg04+4opeBCCInCkOwEO
         WYr6vizCgH5RqcAtWd1u6H8EQteukVCmFMhUDac3+8gZcnitFY+nm+TAfSIDHy/EOLwN
         b+YchtV8HK9IDavuyNMgzz2lXJgvrLQSpdbyVBxlCHoFnOHalS+jfQlSSlZOFXiAonXY
         MRV4Ciit22fz0YZXlkWtAkqpF4B/L8zG0+tzWmRs3LvlJ3q9BezSuIu2/qjF/imoJlg6
         iQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCVOuc06z37GlQ0vQcuVdXeA+bsnEp1h3uVjh5D4BDD2tkTxhcJRQ1o6ppddvtlD/9EkZwQ4yrjdDVzoHIwoWlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZE6fVcHnXjNWw54Tok0D1uZ+pB6U/o+tedJMkLeO4G2mK7Os4
	+BkNbwTeH707sSctL/UazRZkhjgIZBsRzv4B+q1ikmoYArSkgIcxC9zYH0N34iEEhWeEwJjInLv
	JTiuJ5w==
X-Google-Smtp-Source: AGHT+IE+YOK4bUXyeUihTdfe88MG12kjU7NJjnEZ1UiwKcYDjmIUXUZlOWiD5yJB6YrhY981Gpkc3u2UM024
X-Received: from pgbcp4.prod.google.com ([2002:a05:6a02:4004:b0:b11:14a9:1d8c])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998c:b0:1f5:8903:860f
 with SMTP id adf61e73a8af0-2045b6ebb88mr12037759637.14.1745746890050; Sun, 27
 Apr 2025 02:41:30 -0700 (PDT)
Date: Sun, 27 Apr 2025 09:40:58 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250427094103.3488304-2-nkapron@google.com>
Subject: [PATCH RESEND] selftests/seccomp: fix syscall_restart test for arm compat
From: Neill Kapron <nkapron@google.com>
Cc: nkapron@google.com, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The inconsistencies in the systcall ABI between arm and arm-compat can
can cause a failure in the syscall_restart test due to the logic
attempting to work around the differences. The 'machine' field for an
ARM64 device running in compat mode can report 'armv8l' or 'armv8b'
which matches with the string 'arm' when only examining the first three
characters of the string.

This change adds additional validation to the workaround logic to make
sure we only take the arm path when running natively, not in arm-compat.

Fixes: 256d0afb11d6 ("selftests/seccomp: build and pass on arm64")
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b2f76a52215a..53bf6a9c801f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3166,12 +3166,15 @@ TEST(syscall_restart)
 	ret = get_syscall(_metadata, child_pid);
 #if defined(__arm__)
 	/*
-	 * FIXME:
 	 * - native ARM registers do NOT expose true syscall.
 	 * - compat ARM registers on ARM64 DO expose true syscall.
+	 * - values of utsbuf.machine include 'armv8l' or 'armb8b'
+	 *   for ARM64 running in compat mode.
 	 */
 	ASSERT_EQ(0, uname(&utsbuf));
-	if (strncmp(utsbuf.machine, "arm", 3) == 0) {
+	if ((strncmp(utsbuf.machine, "arm", 3) == 0) &&
+	    (strncmp(utsbuf.machine, "armv8l", 6) != 0) &&
+	    (strncmp(utsbuf.machine, "armv8b", 6) != 0)) {
 		EXPECT_EQ(__NR_nanosleep, ret);
 	} else
 #endif
-- 
2.49.0.850.g28803427d3-goog


