Return-Path: <linux-kselftest+bounces-46540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2DC8B76B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5804E518F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9533CEBD;
	Wed, 26 Nov 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZXk5HKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146733C18B
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182499; cv=none; b=th1DHIiLfxhl62U1/hQhPKFUx6QLSnfP/OQgh0QqH/7HpQEFJ0IsmOeV/trtpqMqZxwxhOnP7dYlRvUGWvstmXA+iK2R6sLZGFHo68MJK2WUdSNkOVTmUVAsjFTQTDWgCR30yrQxQc5nj+QDD3nUtMF9uW3xeJjABDSkw0RXvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182499; c=relaxed/simple;
	bh=14sROXxsePSCyFjX+t2CW+D5fioa/3YjrCzjpOBgBnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX8KHC2z5rOKA3KtILAdmRKwwZKTRaL91wBwHj1+WJXMdhAXUxWtYjEJ9U6NbkojhuS2Vw8tVtVYBrrT9pvdwH2RAbG65rHqugwSm80mmFxsMQv0q+FQUNgMhTW1xmWsW3AoltitgDR4E9ywP5WIzMfjbCZcJKQo4CT6WE5i6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZXk5HKy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8824888ce97so604616d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182496; x=1764787296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah32JKLj65Tb10mc2SlvS0l93Wr7sJeVTGZD/RA6bqM=;
        b=OZXk5HKyKgHowc4hetOJTA5sM5PSZmoRdnTdv16sXymvQDPG5orRvvAOgGLkEReDp0
         FL2fGiqSCMM8WYVrwSdIVlVCK+Ala2vYIIpOMHdNdRZycOVmFVp2YFjO+i6LBMdFx0W8
         DrzGiZHhCCCMD3OnKGJHW+mupc4YmrzkSanivcXFJEnR728j7sJfe9ohAmwSS/m1ejcZ
         McUMKlGNij3iOlYRLIkErn2vn/0/msiO3h98C/LTxxbC1bdix2O9v+8tSpyYgZnWBHUH
         4/wbLhYIWtjEOG8jlYWWqTuDssCyx1LUQyiE7MjvvRyW9sZbgKefQH+18uTy3viweVN3
         uRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182496; x=1764787296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah32JKLj65Tb10mc2SlvS0l93Wr7sJeVTGZD/RA6bqM=;
        b=OcMYm3Jxh1SAAOClRs43Snwk+as7bq7Ebm+L4BFubU3BPHmrAuRS+Y4AxTFfdRp69Z
         sGd3ZCEAjgyDGrwVu0B72XVnj1wG7bfYT4guZTxvO+deAvQ5ZOW6bQRZpBRTyQN5sPn8
         x/i1H48sECocVauwMM3y1zrL7n5AD+dctp4jcbYSJjaxTmrzYzM18cSO38NvFoKXDl9V
         FmkWrsyzqaLS38OMuPJHTwzQvHSTaRvMqUzK6H0NVkYBYzarLWqoYvobMBw8jaNPre6O
         a2bEBznLMwPJjGg0doeTz5I7xYg1l2gZaQcwj0cIfyFG6pEeTqaXU7iTTRqfjCiF0OGh
         9KbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Rn6UiWO732oETpAUHDRn27s+YSuTS9EaR1HL6y2FOinTVd22ZGuI1gyJUWYEdbEQDMJ8ijdeUgaXLICfVqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0DB/R2zn9JR585I0Y7PFxUUo5/+S8zUf3+SD6TRro3jX9xSX
	P5ZUwzTDO5zVWj91bbrWHUnhfLmetOSiyqV462AwfKvZXuLw3O7xm+iK
X-Gm-Gg: ASbGncsLc1TWEqE/+KCE7Q8m3CPuUXZQjjKezToMD+CfBklCTySowx/DSiTdFbkBKeK
	g477M+tg4n1ORRIsNdUGZo/DWk6YJ7aKCCAyXZyjfh2qLNG/mOL4s6npYH1s3oWMUjri5RXej+c
	0+gx/1P0nN7SQr0jM9YtzaxF7/OIgVkJKlvuWz1QJC2+oZRL8xLTNpTbX8qoXQiGWg7QR7BW7Ck
	4mwFg0tTcEGIWMiHE2o/PVA9AHYafp1LrGk5A4E32VZL/yWfNk+KTR5610cMEU1oad0UCgjwRL7
	SI0m3urahv4wNclkEbwh74tEhr7RDF0APanWZCjQl6tm4mwBl379h+nX3InGAfz4x4HL6rnRGtP
	EZOMAiQ4YbuwgASBvEOma21NoN389TNZU4YWu5vMrr27kY+YO5i9lDo45RyAjxufzSmka5aqk3D
	5TSIHF+8fP+rh5LFtHptE7y98y5YTZjtOkt0eGNx1xubRTVLlO6J1H9pm0OuuBjgmhC2a8+zH6
X-Google-Smtp-Source: AGHT+IFEsCg1mSN32D+C3r/VHUzlAz2wwpRVuDST+GsfS6aHpdaamrLaRE/OphYPfzmTkQtgG/qgSQ==
X-Received: by 2002:a05:6214:3d05:b0:880:5bff:74d6 with SMTP id 6a1803df08f44-8847c536166mr305963936d6.51.1764182495821;
        Wed, 26 Nov 2025 10:41:35 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:35 -0800 (PST)
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
Subject: [PATCH v4 3/3] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Wed, 26 Nov 2025 13:41:10 -0500
Message-ID: <20251126184110.72241-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


