Return-Path: <linux-kselftest+bounces-42777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A41BB92F5
	for <lists+linux-kselftest@lfdr.de>; Sun, 05 Oct 2025 01:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0873C1B7D
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC742580FF;
	Sat,  4 Oct 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmr2ExC/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDF2571C7
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621842; cv=none; b=OC8l7Kq0Tm8CdSCbaqJRyAapbK1c7ZYo35vaFj3vtYDj32RjJg/XwWfbcUK6BMNOfqs6CpyMzkcohQaw7Btny80+YwNENwHFAkaI80csDp7L0E9CGKEtnFSpYcG4HyJnWpl12DhKvSY+dJzY3ayvZw9+FcEuWBK3J4YTC+1Uyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621842; c=relaxed/simple;
	bh=EXyB3no/ZYQZiw4k2sIVnM4eV2neGR0XKhmW6028cdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsf5a50Fx9ilwMffBeUdM6j6rOY0ewUc4dzW5ghmW+pjLmk99AJbz0r90YICPhG1tXhhqvuNUc1QroW82QMR5ioSoxbhUE4RH3o94SQ7GDxuwldLNpAOwqt78ygLaDVMMgYmH/CSrQPwf9oOW1/i8dZM/nVQZ2sqpK7iqyXyrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmr2ExC/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78eba712e89so31873506d6.3
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621840; x=1760226640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjU7oe93mN2yk67x3/TWExFFSzr4kO2WctOACXz9uio=;
        b=Gmr2ExC/ahizGo5cxeQXkFW86dwTO8nMHPObyB+wxLcnWNJ5HdwutrgO0Mltfvv/Wp
         3DpJQx02gbKTeEWPIPcqSZQZ8hZQyQU37b8iulUUG40wb1orggxB4lxiAmQGXdHi7VEg
         Bt/ja8gkzGcXVn510StpEomHonNZ7vA0Tyi1qKzXtntCsPDRxNApu/t0wo1+2M74qprP
         ny0gyr5oZsCrQH8lZJQUIfUnJYjMgPXtQf8/GsKY8akZeD885AmLqo514VWemvjZCD5o
         ODaUnyYMNiG7Y6AVn858kvmzM9f0IPom2W2Lwbw9Pvf0qjT7YRVevUkhPqu95vC8q4tu
         g67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621840; x=1760226640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjU7oe93mN2yk67x3/TWExFFSzr4kO2WctOACXz9uio=;
        b=vqL+DUXIC67c/qnZlcQSlZHzqZWyabXaMZVjVe+9hIkKp4VORx5uSfigpHeScCeRQz
         ff7Tx19IodoSMhwIlEXCpX+xCj1cZsFj7i+GuzXLKFUyyJqDQjTm95BIGGOrQf4JZBoR
         tdOd8rihlXoxEiMgQ7ooxhxFUQ9cPdQaEA8ohKD1KbIInmMGTqWmWUW1k3kWFxgI50lp
         7P1J8+15W7ycTmoiTJd82437o7LSXUe5osjcKK6nulNgY+B1QD/vS99RaF/oAMU+85rF
         FzbGD3jopEd1MNqzd8r4zbB0WlxjACkuzbNgur5Qtj2ANgPwgKD8r5OffbBi6F5DMPg4
         cHZA==
X-Forwarded-Encrypted: i=1; AJvYcCU/MuKoCrn1j2GpFPQmJnZKKwQZ4Bslbe8qQafMwtT/kG9Xf7KxLMFDdsSRLPSTjSjklbuJKzzIqhA9M9ivjtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmspmYlIOEhKmrk/38ccfMu2dMGq+OM7bOSMsd4lKZL3Hot4G
	6m/whDICDWn1OhAWTdsX5FBy2APdMRPPJmUumO0UANL389/PXG08RBEg
X-Gm-Gg: ASbGncslMJsuXsRo7DCMvH63zNiXoKvOI/0bkIcZ1BYZlgmMHqUOoK6C1V3IVmzdeOY
	s85433xHaazjaVjCy81zCiNEGkYOqCLPyVPKe79YwtB9yON/D+6TgCE/0hsRlW32zRpqJRz3kOo
	aGw50NPBoYmLWWT/GJWvDYXS2uVT9ckYGnmDouJ79mbeUs165AB023lyzHILWggvYnQ5hS4FfZs
	QVn1lPguclBjUuVZnm4GMdV8+gtdZWwiaiYGa8A9kV8DwB10SsdPFpsCXCVU3OEbG3KZ+6asCfI
	fA1+YirGcGiOQsqdm8vOQ3C38Hsk4d7vsb5MjSBSMImom6SOCBU+0kMOVPrGQvSLU6BIunYbyto
	7yKt4sS19PvZtG9uDBjVs4RAYx7IbEhz7cpjjeMkqAJvXBk8pE+m3NX4/rqD58xkqNKzWJ7krnp
	9ePAVrPcZ8cCLp/cY=
X-Google-Smtp-Source: AGHT+IEUWXDZx+IAlNDV8Mu+BE5kMa9E4iKCTAQ71zUHKPBS5QeBaFqes3mcBdLmYCHeSFsI3jGX4w==
X-Received: by 2002:a05:6214:230f:b0:796:bfca:9c68 with SMTP id 6a1803df08f44-879dc77b87bmr86391786d6.3.1759621839475;
        Sat, 04 Oct 2025 16:50:39 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:39 -0700 (PDT)
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
Subject: [PATCH v3 4/5] selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
Date: Sun,  5 Oct 2025 08:46:58 +0900
Message-ID: <20251004235001.133111-5-seokwoo.chung130@gmail.com>
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
 .../test.d/dynevent/add_remove_fprobe.tc      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 2506f464811b..d5761d31217c 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove fprobe events
 # requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+# Note: list-style specs and :entry/:exit may be unavailable on older kernels.
+# These tests auto-skip at runtime if the list form is rejected by tracefs.
 
 echo 0 > events/enable
 echo > dynamic_events
@@ -89,4 +91,123 @@ if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
+# ---- New accept cases for list syntax with :entry/:exit and !-exclusions ----
+if echo "f:test/__list_check $PLACE,$PLACE3" >> dynamic_events 2> /dev/null; then
+	# Clean the probe added by the guard
+	echo "-:test/__list_check" >> dynamic_events
+
+	# List default (entry) with exclusion, explicit group/event
+	echo "f:test/list_entry $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+	grep -q "test/list_entry" dynamic_events
+	test -d events/test/list_entry
+
+	echo 1 > events/test/list_entry/enable
+	# Should attach to PLACE and PLACE3, but not PLACE2
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable and remove; count should be back to baseline
+	echo 0 > events/test/list_entry/enable
+	echo "-:test/list_entry" >> dynamic_events
+	! grep -q "test/list_entry" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# List with explicit :entry suffix (same behavior as default)
+	echo "f:test/list_entry_exp $PLACE,!$PLACE2,$PLACE3:entry" >> dynamic_events
+	grep -q "test/list_entry_exp" dynamic_events
+	test -d events/test/list_entry_exp
+
+	echo 1 > events/test/list_entry_exp/enable
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	echo 0 > events/test/list_entry_exp/enable
+	echo "-:test/list_entry_exp" >> dynamic_events
+	! grep -q "test/list_entry_exp" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# List with :exit suffix across the same set
+	echo "f:test/list_exit $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+	grep -q "test/list_exit" dynamic_events
+	test -d events/test/list_exit
+
+	echo 1 > events/test/list_exit/enable
+	# On return probes, enabled_functions still reflects attached functions.
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	echo 0 > events/test/list_exit/enable
+	echo "-:test/list_exit" >> dynamic_events
+	! grep -q "test/list_exit" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# Enabling entry and exit together does not double-count functions
+	echo "f:test/list_both_e $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+	echo "f:test/list_both_x $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+	grep -q "test/list_both_e" dynamic_events
+	grep -q "test/list_both_x" dynamic_events
+	test -d events/test/list_both_e
+	test -d events/test/list_both_x
+
+	echo 1 > events/test/list_both_e/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Enabling :exit for the same set should keep the count the same
+	echo 1 > events/test/list_both_x/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable one; count should remain (the other still holds the attach)
+	echo 0 > events/test/list_both_e/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable the other; count returns to baseline
+	echo 0 > events/test/list_both_x/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# Remove both definitions
+	echo "-:test/list_both_e" >> dynamic_events
+	echo "-:test/list_both_x" >> dynamic_events
+	! grep -q "test/list_both_e" dynamic_events
+	! grep -q "test/list_both_x" dynamic_events
+else
+	# List-form not supported; skip silently
+	:
+fi
+
 clear_trace
-- 
2.43.0


