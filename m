Return-Path: <linux-kselftest+bounces-42778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA5BB9301
	for <lists+linux-kselftest@lfdr.de>; Sun, 05 Oct 2025 01:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E114EE695
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E26261574;
	Sat,  4 Oct 2025 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knZ/FzS5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3E25CC42
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621846; cv=none; b=JLu/u3tLRgicdK6iGG/Zmy5GJMrlPr57okMNoTW96xd0R+m+SRgOyiCT7ZyOcsWLnrz7bnAMSNQEPa3HGvpIQ49yQo4MvOEnG8MUrTRM9dn9ZCEBor3cG8Dm464Y0qFublSsNtIj6jCIpc6EY/3Ba3iPMtAO2f7tMILyNt3KNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621846; c=relaxed/simple;
	bh=PwSbstcnj8nUvIHNmAbBLq7n/u1XUkkYoyy8GQo7W84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llXqmm+QqP2aDQn/L1g34RCQXaOv9mdXeXTprAOPpVH6LH4D3igJesinfRAuYjOQrtmPme89z9D7UnbaGLbcDvqnxBRnsg2MxMb2D7IbEx1FN7H13UODikvCg6Ke33v+5XyimIwvaI2u6l2NQ4lS5nwJXXGMHDUVbC1rxBf9mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knZ/FzS5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78f58f4230cso32497056d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621844; x=1760226644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Zg/1Y7tRoNadojvxskF2acevAo1Z1Xk2uqZsYRAJI=;
        b=knZ/FzS5Gzsj8O28KdwfvuudokosabHdZD01pTtPrpKyrftL3icpAZ9dY9ZSxfp/zB
         9S0VmUe3nre0RIB/8KRb6e9VL++6mbiYI52QGUrVTEmK/844S9x1X9sfhKqNj9JtXgBs
         OVu6hlmjfR2XhJtvDErhCbc9/AudOBaDCuNl2xOUXJqTwqAKypvymGYMvzZhh+LotgHx
         V5KchoWQo3+VkDdXIwpZ9XB3dUzZQbjaPOikmNQiEXgvSFUSDZLDrZonC51I0RDzA7x/
         /O+pAWiXwp+7VSVBthMHPH0oRkHX7XjQ5mon/800W5W8tqo1hRCCs59cpvx2D4Temfj1
         U6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621844; x=1760226644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5Zg/1Y7tRoNadojvxskF2acevAo1Z1Xk2uqZsYRAJI=;
        b=S4/phu+tEm93+U4meLDpQ26gLg//CJK4kmsiG6MpZD5M5vzazidGiwc9eMLoaGA8vD
         EtzpTiZjNSbwknEVyXSoAkhNlr7PysSGKnVDDylcSiKMcmrkkDa2Ef/CD0DNUfNzxbTt
         f/HbA/V3Puk96q8z2PHfRb2KQdNeKbJsKajsw1udBOfMTOQMFyimCm7qSbxzG2QtYwX5
         m2uM67ytFEpRgMAwu1feMKMid1mjXl/x0Swjik8Njllbebxz7/O5FkucE63mmQBtLKDw
         xicehxCZ5V6jnCbEjTAFS8JucBpDMGhWOfQwzN54c1qOnebDBMtNHsJXNc0CpIWbLbJm
         ei5w==
X-Forwarded-Encrypted: i=1; AJvYcCUL94f5pVy/1QxMaWT4vJ9n5Qo5/3rJgKaTQWWfhJX1cZb2dcPzA3qBdESq2sxLHnV42iCawnfUVcO0K0Q9WI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+B+3/OC/TlGiPFn3SRmg7feXkbN10nwCHpCmSmo54ieXFThH
	kCpG3+riBRLAtDutaSxuhIeQvllP7HOHqGw4jtZc5ie6ooOKQ7yYytj3
X-Gm-Gg: ASbGncv6kYm7XZGbqnDXyOqg+vEE7tvYdtHo/00ffLm04QiwR1KSQtVpgG8rN7BdeOF
	zXv1JrVTid3RLJgcz5XWPuOXcBGkdVJTUl4T0KIMIfusc4pbqRsyFeblpG13EAEiryBLiIieWap
	9a6MV8rTtAcIdJumCASt6IDRM1exnsGYoNoMaO72GAQAwJwFHCKWctIG6tDT3/QWoeEdQWJLWil
	TzdD0nDueeWpYL02Ijc0wa5kFzwLuEuEqh0m3vuwXWB67NPhKiVZu5QSUlNe3fA4WOG8ODZrmRv
	w7Rb6MAnXnKgHg3p13vw2gsPIvDIs7etvav9196PhR5uW55K1EqABmgHaFxWRpNDMQXvdBgKqxG
	JXHL5EIKF0ihabxNMvrvQpt3HUUmheJmwKlGbAMWaUM13o77YcJSedGQUyHCbvCGHVJqO9HYouq
	kS2C/Lyfcohd1mFQY=
X-Google-Smtp-Source: AGHT+IECC20UZjnBEUBrVIWpdj8P1aH96WApe+AVKUjSXUYa+YVIzdIMuaznQLxMCYBN3sW2e1+1jQ==
X-Received: by 2002:a05:6214:4108:b0:81c:b934:a01 with SMTP id 6a1803df08f44-879dc83ec30mr102513536d6.31.1759621843927;
        Sat, 04 Oct 2025 16:50:43 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:42 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 5/5] selftests/ftrace: dynevent: add reject cases
Date: Sun,  5 Oct 2025 08:46:59 +0900
Message-ID: <20251004235001.133111-6-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index fee479295e2f..720c0047c0ff 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event parser error log check
 # requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
@@ -95,6 +96,18 @@ fi
 # %return suffix errors
 check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 
+# New list/wildcard syntax errors
+if grep -q: ":exit" README; then
+check_error 'f ^vfs_read, do_sys_open'	# LIST_NEEDS_EVENT
+check_error 'f ^vfs_read,do_sys_open'	# LIST_NEEDS_EVENT
+check_error 'f:dyn/ret_forbid vfs_*^%return'	# WILDCARD_WITH_RETURN
+check_error 'f:dyn/ret_forbid vfs_read,do_sys_open^%return'	# LIST_WITH_RETURN
+check_error 'f:dyn/list_bad ^,vfs_read'		# LEADING_COMMA
+check_error 'f:dyn/list_bad vfs_read,^'		# TRAILING_COMMA
+check_error 'f:dyn/list_bad vfs_read,^,do_sys_open'	# EMPTY_TOKEN
+check_error 'f:dyn/mixed vfs_read%return^:exit'		# MIXED_SUFFIX
+
+
 # BTF arguments errors
 if grep -q "<argname>" README; then
 check_error 'f vfs_read args=^$arg*'		# BAD_VAR_ARGS
-- 
2.43.0


