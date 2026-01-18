Return-Path: <linux-kselftest+bounces-49248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF5D3920C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 02:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF8013015003
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA11DC997;
	Sun, 18 Jan 2026 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5jsxLwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF91D6195
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699112; cv=none; b=O6auKHAdAybebJfh3Eq2meuJjZ+fyKLwUIKlqy+xPm8wOAY9GyBf0Mvku5y+FeLrMyLs+9baIpsuJDYvweizSIHaqO1EGdc+bi4nxNSpTIu5JE5zyWp1OULaB/2E66BbRmOrjxjY2ADPXyKW5rnmXWiQJBDnKJJr7TTg7fNr0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699112; c=relaxed/simple;
	bh=ZDrrQk7+ZbCO+fyU001b1FgFHm9Go+TFY1C20mho8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZdiyv21RQlZg3dcLAYe7fXUwRbZzZGoPsrX+lJ6m6QlDXzXaZym91XmLfDv9s2fRYNpf/j7lRSXj5MJqahoZKyTldZUTLwuYEfI0nki4UM2Ll08ZJPBrcMG84C3gIkHG06GOiuX1/MJ+AN9s/s00rZgv6CzxSMpZSyr9Salrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5jsxLwi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c5320536bfso355358585a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Jan 2026 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768699109; x=1769303909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tho2VqUNeLqQMboUEaDyPNZ6VVJ6gB0GGd5RNkCMkk=;
        b=N5jsxLwiT0SL5Wdimo9JYVPftYjVKiGF3mRlvZvV98W+RJYJXT81Jrr4xusGkvsEe0
         QmxS83+jvp5HAR2+VItnIK4E0rDDPPYNndfGcseZyevAiuPzSnsp32TywbQOAz5xXSJt
         ANv2TE+DjMBvKpdXJ87a4Pr3l8WL+pAzxZEDLMXBwzNXrW8dGZ2linDwqEHmjcAYBpTJ
         83kYXOTX0RRGJ20j00kB3rwNQZqAlqGc2f8jFJxglTjVwPnVwkzvtFQhiBXEBT9NpCLw
         YDU7J3R5EwPvWZtDoEEvERjJ75LxZQl3QXtcFZoHiW6dS0HjlCDIpl5nSCCV6hdXR5NA
         EUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699109; x=1769303909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Tho2VqUNeLqQMboUEaDyPNZ6VVJ6gB0GGd5RNkCMkk=;
        b=DlXttydDXPYPnm8rjYfNVx1kNxT1xBw0uz+VM00nAey24f8K+Pv6/ETWmwLpFAQB0m
         RpIe/LalfGnhoiVJPd2LlZrOb50AONI0fsULocwFLqD8Ba0QV7ibQAJxu3vNE0TO9YP+
         qcWNsWO0/tjKUuYl+kglGBHjPK1E0AENXXgpV/dx0JeY7iP5Sr4dPhs/3XMJ0DB90Ng5
         hUosX9TfPh6gJ+0unMt4+IkG8y+yy37rQUE1AkSGkKkK9LYt4ualepT3HcA9iQR//PFc
         BNjOjl7KKy7qyaVjjf1bxZgX5RwkVKYToQi4937N0KvfVjOSAiGgkjGq+lTCREXEVn7f
         C+aw==
X-Forwarded-Encrypted: i=1; AJvYcCV0YysFVOHID9qWwsSHTPXQnNtSH2I4kZjzmxkrr2pOF4gC+LeTLVEGF+DxLNbVfP7wtgu6drmQrxxCY+1ph3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYQbuWd1kLb153S7y3lqhFP8xrDDOCEo0mcDw+pZEvLRSFwqw
	KOWlz9z3CEAUD/yF5t1ZAmW4XKmyY5QVk94xv+M/FS3tfeayz8f7hxoSPiKw3w==
X-Gm-Gg: AY/fxX5+TpCpmtfOzOF7kBYE/ghd9jPT+/rE2Ag+XRf+nlhNXaO+o78qBg6MmrsMPIt
	Sm87i87xAG+oAAG6mAV6Mv28MBaVEFEfq9siJsdVG3Fj6RFfpBu7Wpbq335LGo7AMEjthKdtPIz
	5dmR+WTYEUEKC93VYMwaqfkBVlpMEuNq8V2b716qikzvI6RLwY4fvrzssIZkeQw3p4+bDWYefVc
	glypx6Y0HusMA3RHNdCyllQA9dR163NO4h9nQSNRcnZL6zLjfD37qPMI/RnHSGLwnKlZGgd6Hn9
	k7j387Z46PiCHH0aXfOnXWhmvHp9Fbk6BzRSAZFZz0Yp2rRYgz/HnE9G9eO8gsfc+RQDmlIUe42
	zb+/8Ihvm0pTZXww8ax/Uils5vhsdwN99OzAjmXTev4AzFD/bP+sIKYHLYfiIIZCjYhrhFT7YQy
	bIzI3YDGQT2RtwzVf390tScQ+G1xc2Bf+6RemWNYJ3HHP9oEjKELWtKNvW+VaYcC7LneJT3jg=
X-Received: by 2002:a05:620a:191e:b0:8b2:ec00:7840 with SMTP id af79cd13be357-8c6a6704482mr1057363685a.27.1768699109428;
        Sat, 17 Jan 2026 17:18:29 -0800 (PST)
Received: from pc.tail882856.ts.net ([2600:4041:4491:2000:8a64:ec6b:4:f1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm512290285a.46.2026.01.17.17.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:18:28 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 v5 3/3] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Sat, 17 Jan 2026 20:18:15 -0500
Message-ID: <20260118011815.56516-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest for comma-separated symbol lists, exclusion (!), and explicit
:entry/:exit suffixes. Verify that excluded symbols are not attached and
that enabled_functions shows the correct probes.

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 .../ftrace/test.d/dynevent/fprobe_list.tc     | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
new file mode 100644
index 000000000000..45e57c6f487d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
@@ -0,0 +1,92 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event list syntax and :entry/:exit suffixes
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
+
+# Setup symbols to test. These are common kernel functions.
+PLACE=vfs_read
+PLACE2=vfs_write
+PLACE3=vfs_open
+
+echo 0 > events/enable
+echo > dynamic_events
+
+# Get baseline count of enabled functions (should be 0 if clean, but be safe)
+if [ -f enabled_functions ]; then
+	ocnt=`cat enabled_functions | wc -l`
+else
+	ocnt=0
+fi
+
+# Test 1: List default (entry) with exclusion
+# Target: Trace vfs_read and vfs_open, but EXCLUDE vfs_write
+echo "f:test/list_entry $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+grep -q "test/list_entry" dynamic_events
+test -d events/test/list_entry
+
+echo 1 > events/test/list_entry/enable
+
+grep -q "$PLACE" enabled_functions
+grep -q "$PLACE3" enabled_functions
+! grep -q "$PLACE2" enabled_functions
+
+# Check count (Baseline + 2 new functions)
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $((ocnt + 2)) ]; then
+	exit_fail
+fi
+
+# Cleanup Test 1
+echo 0 > events/test/list_entry/enable
+echo "-:test/list_entry" >> dynamic_events
+! grep -q "test/list_entry" dynamic_events
+
+# Count should return to baseline
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $ocnt ]; then
+	exit_fail
+fi
+
+# Test 2: List with explicit :entry suffix
+# (Should behave exactly like Test 1)
+echo "f:test/list_entry_exp $PLACE,!$PLACE2,$PLACE3:entry" >> dynamic_events
+grep -q "test/list_entry_exp" dynamic_events
+test -d events/test/list_entry_exp
+
+echo 1 > events/test/list_entry_exp/enable
+
+grep -q "$PLACE" enabled_functions
+grep -q "$PLACE3" enabled_functions
+! grep -q "$PLACE2" enabled_functions
+
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $((ocnt + 2)) ]; then
+	exit_fail
+fi
+
+# Cleanup Test 2
+echo 0 > events/test/list_entry_exp/enable
+echo "-:test/list_entry_exp" >> dynamic_events
+
+# Test 3: List with :exit suffix
+echo "f:test/list_exit $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+grep -q "test/list_exit" dynamic_events
+test -d events/test/list_exit
+
+echo 1 > events/test/list_exit/enable
+
+# Even for return probes, enabled_functions lists the attached symbols
+grep -q "$PLACE" enabled_functions
+grep -q "$PLACE3" enabled_functions
+! grep -q "$PLACE2" enabled_functions
+
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $((ocnt + 2)) ]; then
+	exit_fail
+fi
+
+# Cleanup Test 3
+echo 0 > events/test/list_exit/enable
+echo "-:test/list_exit" >> dynamic_events
+
+clear_trace
-- 
2.43.0


