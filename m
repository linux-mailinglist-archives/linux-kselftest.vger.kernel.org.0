Return-Path: <linux-kselftest+bounces-8801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101158B10F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01E328B28F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869616EBF3;
	Wed, 24 Apr 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN6PsVgY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367816E88D;
	Wed, 24 Apr 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979492; cv=none; b=csq1amXV7cZfl6hf3MXZ2FlCrDp4ldw2I0i2y37g7oacwa1f6XVjdx9GS0BgSrAfifFWBxmyDwc4AKVRAVSiXe6NXt11YsQe3xZRIuKqGSr8GcWM4knNWity70Xs7Z3GtMB09MEAc18dqLqR/71z/FPiI9a/1s6s1Qv8n8FbO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979492; c=relaxed/simple;
	bh=opc/avona9eW/rM3roW/voeHSXTty1uKIg/G6um8klI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0/oHFuUSBehHLg/7fjdNGzQ9HjeelXH1lYjUNdioDTKTWgoy3zGU5wPyJM71KD488Pit++7tSWUNEp7tT5BnZFbIdp5B+aZFXopWxTNh3jsWjrjE0/cZp8YtrRBd/wVW6X4AZEMTZjCaT9MKiAmvJzgwln1HQTtYBgRiKwACD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN6PsVgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583A9C4AF0E;
	Wed, 24 Apr 2024 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979492;
	bh=opc/avona9eW/rM3roW/voeHSXTty1uKIg/G6um8klI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UN6PsVgYRWhbxPqKK2/Ai7IUcQDxfQEaMTGFCytdrOCHkBtBH2+2a/HKEtoNYb9bR
	 ddAHN0CvMVcOxCLtU7c/3l6Z/g/9rozme40fPzmeV/MRRlJwRICRDK3FpMiLlsXLOV
	 IhtCGYQNnb7Iv8O3fpo7Bz/pazhQHoWNSKT4fdb2adVAdgCc4784kT0OfC417td/Y3
	 ZAO0wgCHnbUQidhCcANVz6uVqnYuNMbAu/tTf3hT2bjIAOXG6Z6JK8vYyI7W4+sU9Q
	 /PHNTgY+G3X3j2LfMRHAzhh4FZnTb7vCMP1wRuS2zYhYd0fzeUvbn1MHmZBfSMz8RZ
	 AGmP7wiyz6KXA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:12 -0700
Subject: [PATCH v2 09/10] selftests: x86: ksft_exit_pass() does not return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-9-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=nathan@kernel.org;
 h=from:subject:message-id; bh=opc/avona9eW/rM3roW/voeHSXTty1uKIg/G6um8klI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDnHBa269iNZUCrt6y+ioYi5X+9cjZ4Jc3tUlcrGUZ
 2wviG3sKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABNxFmL4XxL7rdlJ7UVvQXKj
 ObuDQVe3ybKK+lMx++raThe+jJy6j5FhV9uKpxo6JxZt71291f4v+3W11ys+pX0TazYVT33wd34
 fGwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the call to ksft_exit_pass(), as __noreturn prevents the
compiler from warning that a caller of ksft_exit_pass() does not return
a value because the program will terminate upon calling these functions.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/x86/lam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 215b8150b7cc..820db4864292 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1237,5 +1237,5 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(tests_cnt);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

-- 
2.44.0


