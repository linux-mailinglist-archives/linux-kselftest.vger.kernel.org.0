Return-Path: <linux-kselftest+bounces-26594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26166A3507B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A5D7A19C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31AA266B45;
	Thu, 13 Feb 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4PBQ1kg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEA28A2C1
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482145; cv=none; b=O/55rrVGWDKUZ2o2MkuH8mO60Z7vcPuc07j/VqYlupb29NqT9+8pv31o7jBCG/HTmY4cVDMd3CJbYA5+TwQfV8qwQZwcBAylgCp3vTVmBypleGix5qAiHWUBq9fRIbpS9iqrfxSHDbYz7th9vWslqWGqTkzYu2K4toUpS3mRj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482145; c=relaxed/simple;
	bh=7mAvqdA3BitZDxxMOm9fCP2kqIhpALIVRe54ECHYnqw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S8uyFCIrTZM5ZqI646FTTMAhPNynHu7lb/OM0z5u0T1SUw7huqjTJ390TtkRxdpfCZ9Pzx7WuPgcxfqM6YBIDNbiBlOP9TpmBGJSuceP2P5HkK9/BfOFU2EKlVEmm4bHPZ/W//tkVr2VWJkmZl4ZdslDjLLkFovwaN5Wg9Vhct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4PBQ1kg; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-727090df861so73813a34.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739482143; x=1740086943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1FBXAb5srspDKrWilGOZGvuqz4tU4bdToVFq+ezNEY=;
        b=P4PBQ1kgPk9YRAejvf8mkMsuJVQiWTB6j1+FYfVj24wGRmFbTVeCi8yvRAiwduQhHJ
         XMoWdKt5swf+YEoVGI5us5jQOf7OfYCq3b/2BGSrz7eK8ZZ2n8LnY/r5hJNyZqdO07p5
         jwhziAhQPRKHViooUX6gBFHIN8leWgRsI2Oa59h3/srTrFDEEaDGx71RjKF7Dg+anMZG
         Z90LEQ6vMQi4HSbvs6Ke/+/GsiE1/TicFKqrWoUePJvFOvatKTyXGklyb0Tn7TAsjFEE
         m5hg2hp04pDtIAy1PvImbXYYdK4pjj3L5NC8NpxJf/ZWuimru0rtBCIPv/dlOs7nj0xf
         Mg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739482143; x=1740086943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1FBXAb5srspDKrWilGOZGvuqz4tU4bdToVFq+ezNEY=;
        b=KGztF2ypfM0ENmiF5ZEe8I3DR2026DG+U/x1N2bl0mY9QAACgZ98rcNw7DbslHJcTh
         OiBcYIMUE4y9u1Qklf+9iC4KPOCjssLM2Q0CdzajErvv0KUWtTdaQ+k/1BkmM05FP2Im
         Wys2fUPsH1igRLLiZk9vFSj8Faopj0g1Ry7cMlIIJJWDllLU8zLHvm/ANgvmGOaEmDA4
         GP4OIG8njDuRl7OieR7KbMII2RtErnVM0HRSbI4VldP1Z1ome8iIBiGc2YizGsw1L1UD
         7Al2nFEE/xwPc34d6otPfvsEWkUejRI6m7leuT999PvYi6Os2Xa7aey8vZFiyO0yZov2
         F1kg==
X-Forwarded-Encrypted: i=1; AJvYcCX7bXYOFh6QOs1T/C+VkitfX0WaJMAp8G1sg5c6uAm/PMgCVJO+WArXKS+/71tljaaFN3Ur1b10vEUFkN98yxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOr+6iyI02P2syFnjjrHMvdd7p9/PnnHTU6jJOyuKkht+3Nk9
	nxduPARRiXnNfU807jwH4DyKRjbbhd1zd9z+kbnG2XuF4ZH9W/61aApsDw==
X-Gm-Gg: ASbGncs8XJeNiUkoHC+oLN6/Y1GuB+/ILZyMP+fr0S8xYYvjiJnCh4v2f/rwjgozpxS
	NRIH7FggrwizGUs89UsblY+yxfEeZKavrWn0h90/EURQei8DwosnHiKznLuCrsHfAWad+iKh8dr
	zONaBVSRo3iTUMKNdEA+i2ZVMfgkrCTjmtnmTawjq99EA861nTaYpu1QkIi8gA9tZqlw6DAsBLT
	avjpj/2n+M4YIr/9J2TRU7Aau+vsdDGH9FT312Z02nndvf951lm9zbpKTvEyL+yYxOrrbyQTtH1
	1Zcy
X-Google-Smtp-Source: AGHT+IGrE8kcnVtua7JCnT4TiZTDmJ+xb2mlVQaaqH8If8+LmJMG/pKRwOoEGLtU3JTxX2itlp4fKA==
X-Received: by 2002:a05:6830:6003:b0:71f:c1df:187e with SMTP id 46e09a7af769-726fe80fc89mr3012041a34.27.1739482142993;
        Thu, 13 Feb 2025 13:29:02 -0800 (PST)
Received: from fedora.. ([2804:14c:64:af90::1001])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001dc738sm950718a34.15.2025.02.13.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:29:02 -0800 (PST)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	martineau@kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] Adds colors to kselftest output
Date: Thu, 13 Feb 2025 18:28:16 -0300
Message-ID: <20250213212858.710884-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit improves the readability of kselftest results by adding
ANSI color codes to the [ OK ] and FAIL messages.

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 051e289d7967..7b55855ff788 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -83,7 +83,7 @@ mptcp_lib_print_err() {
 
 # shellcheck disable=SC2120 # parameters are optional
 mptcp_lib_pr_ok() {
-	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
+	mptcp_lib_print_ok "\033[32m[ OK ]\033[0m${1:+ ${*}}"
 }
 
 mptcp_lib_pr_skip() {
@@ -97,7 +97,7 @@ mptcp_lib_pr_fail() {
 		title="IGNO"
 		cmt=" (flaky)"
 	else
-		title="FAIL"
+		title="\033[31mFAIL\033[0m"
 	fi
 
 	mptcp_lib_print_err "[${title}]${cmt}${1:+ ${*}}"
-- 
2.48.1


