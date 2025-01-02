Return-Path: <linux-kselftest+bounces-23826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F009FFEAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 19:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1982B1881457
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808591ADFEB;
	Thu,  2 Jan 2025 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETmSoDKl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA196FB0;
	Thu,  2 Jan 2025 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843351; cv=none; b=Nukd7YP+dPdvC77TOm32Yfxr9Z3yHBTDNJ1DbtbovtBI3tBHjL2xseSBrjdq0Ya2BiRs0PDGueKaC6IUZDmuWmiSAOReplYz0PKXHj1iW+cz/diF8shjXQ3za9PQms+uLedhlywYkZR4seParF+rkl5FBjBIOZYf+zPISn/WRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843351; c=relaxed/simple;
	bh=2fCQBfaMA+dX/hOUUXqrmaVGH9026JBLur88fkz6xB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RkYnwavD+2IkogQi3R6ZqVhEqXOjmQs3v8qGLGTvVlMg0Uxc4hQHlGr9ZG9n1NKHGhL1NgwiIhRu5s8C50IJnq/ajrFsIC+PDhCYGhABBxHBRLWEW4Uc+N8tF6J4YqHeMMWSphDnLqd/PTGggKNlPOVEOfgeytRcYjcgJjSF/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETmSoDKl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21631789fcdso118783795ad.1;
        Thu, 02 Jan 2025 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735843349; x=1736448149; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8+guBa2vYF78Y9a6WnbdeCz6jmaMPON7tTCk11772o=;
        b=ETmSoDKlbe6eOD3xdjhqXEmJrD4xEIHzBubJt43gw0xDz2im1Rl7uFfNjeq3b9HDkc
         bHOUVm0rJZWgRz3ayNmeCcgDqrGTGqSJp3lj4mZBhlCho3yC4YyJ6nOQcZ1FkBAYDv98
         cqWO3prwoFziAxjrrjSbcSsHXIiw/OvCaAIBmWPCzVEm86H1eelM5rIk7AI9LIoEvkeS
         2WcxLs6ZHpDodMbTVtx720yJTIxrve3GEnrOA7a/y/fV0uIjxQ9pbx8dAULzQya9yBfR
         lsxtHP/MydATSDmCnu4EDxSwltMuUIRnoy5qSuulNAjpVD0+MoZVtnU3gpED7EZwAv9m
         8cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735843349; x=1736448149;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8+guBa2vYF78Y9a6WnbdeCz6jmaMPON7tTCk11772o=;
        b=ws9Se8vQ98KF9eZFT8zqeeU8e8MSI4sTh5rwOlVILLOHxD4RwV2dvcQIRMGyxW3Byl
         LL26O897ZXZsb2pm5DP8F+CglB19XjoGL+UbBmX2TEFUqSHUA7COpYfnQpf96cmIs7ii
         EdBPebkW5g3B+U8iMOqC0cUoETibuWygF55lhuSpazEB39u5y7+qRY4QGwXef2KyDNv3
         wkx+VsnGj/APRhGFj3VOhQf+uyn4uTNxB8ChyevuDnN5tjKkYMAQY9TNzuY3ULRCIXpy
         iz7yrC3hlVuWhB/+SvfVXDu9YDoNk8ON07FM1+Ady5MvzBWwu8NWY6aQK7y3Xb/aY3V4
         xIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv5ntyUE5OQgsD2w5ewGy8Gw+dQK/k1Pz7zh6JByePu63feVtB31Joh6jKc1zFAdNvfl/uhkc78sjUIvY=@vger.kernel.org, AJvYcCXew6S0g4ZzPz6bvdEUDhTZ2SYAzc2YZ/WnHtRmdBTA5Yk2nb1gsYEdhHeCT/viAXTXML7RpyyM8HRtpiSFh62n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JVPMtgnCF2/6oe+p0578eWEImA0+ruid6HYtSWbSh7ZwK5/1
	7HfszsAFhcLoghqafY00rhS+4fX93Frua/9JJRDkXnR61hj2YORg
X-Gm-Gg: ASbGncv3sPBgpP91hFBWGBJOIjDDqVZVr3gsluDsj6zofPK2LdXEM8VVi6rcNp5NBnM
	NwqqdEIR8n+5YpWcuKRbVkw9Dtm74J9UIBVdehC+M7IAwHoQCBLa/3xo95qtIOGHxXko9m9FY0C
	owZT51Ng4QrJMv6lY3EJtTtGjGGGhsIiEeIun/zmcBUseFU4Pfax3Zjk/GVQYt+JxEXjh/GviUe
	uWNHrgMpAV/tMOW/gVgLyrdSW/mPbMc1sqTiR06J9K67vpqiebbdLXm9bg+cniR
X-Google-Smtp-Source: AGHT+IGjSuCfoDo/5IQL7f0Ab7wkNdHqJCohdmhiSuauCE4obBzVFQuuWyIMkkTDB8bqi8H50+ZIlw==
X-Received: by 2002:a05:6a20:6a08:b0:1e0:d0b9:9a90 with SMTP id adf61e73a8af0-1e5c6f15f19mr81424099637.13.1735843349199;
        Thu, 02 Jan 2025 10:42:29 -0800 (PST)
Received: from fedora.local ([2804:d57:4e50:a700:a12d:2a91:966f:2aae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c182sm25505325b3a.189.2025.01.02.10.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:42:28 -0800 (PST)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Thu, 02 Jan 2025 15:42:10 -0300
Subject: [PATCH] selftests: livepatch: test if ftrace can trace a
 livepatched function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAHedmcC/x3MQQqDMBBG4avIrB3ICNXSqxQXMfmjA2IlE0QQ7
 27o8lu8d5EhK4w+zUUZh5r+tgppGwqL32awxmrqXPdy4oRTyT6ADWsqsMKrHth9CQtLL2kahjg
 hvqn2e0bS8//+jvf9AKt6FfFrAAAA
X-Change-ID: 20250101-ftrace-selftest-livepatch-161fb77dbed8
To: Marcos Paulo de Souza <mpdesouza@suse.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felipe Xavier <felipe_life@live.com>, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

This new test makes sure that ftrace can trace a
function that was introduced by a livepatch.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
 tools/testing/selftests/livepatch/test-ftrace.sh | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index fe14f248913acbec46fb6c0fec38a2fc84209d39..5f0d5308c88669e84210393ce7b8aa138b694ebd 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -61,4 +61,41 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
+# - verify livepatch can load
+# - check traces if have a patched function
+# - unload livepatch and reset trace
+
+start_test "livepatch trace patched function and check that the live patch remains in effect"
+
+TRACE_FILE="$SYSFS_DEBUG_DIR/tracing/trace"
+FUNCTION_NAME="livepatch_cmdline_proc_show"
+
+load_lp $MOD_LIVEPATCH
+
+echo $FUNCTION_NAME > $SYSFS_DEBUG_DIR/tracing/set_ftrace_filter
+echo "function" > $SYSFS_DEBUG_DIR/tracing/current_tracer
+echo "" > $TRACE_FILE
+
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+grep -q $FUNCTION_NAME $TRACE_FILE
+FOUND=$?
+
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+# Reset tracing
+echo "nop" > $SYSFS_DEBUG_DIR/tracing/current_tracer
+echo "" > $SYSFS_DEBUG_DIR/tracing/set_ftrace_filter
+echo "" > $TRACE_FILE
+
+if [ "$FOUND" -eq 1 ]; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+
 exit 0

---
base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
change-id: 20250101-ftrace-selftest-livepatch-161fb77dbed8

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


