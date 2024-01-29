Return-Path: <linux-kselftest+bounces-3694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE20840B8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 17:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6AB1F23CDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F29157035;
	Mon, 29 Jan 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZlHoyrt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6A157043;
	Mon, 29 Jan 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545756; cv=none; b=RT+mOiA89R4/UuUCR0Lg3ODP0fLP0+TFvAjWx5iM+oIAEvynu+P9NJn0SzamowmU7xCeyBRuV9WDRAWw/h9wrndSnB6gLuHaFcF5gowfZ07AOL5ZsxezqgAVgAMBKQVqDqbi1CuU+mHihUdNrto/c+qujsD/mkZ1hz9q/K6WKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545756; c=relaxed/simple;
	bh=+INxXA+sGgvh1Q/k988NqOX38wZyZZlhJW4AzbbZvFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWWF11TCfpVcGajj/Pqb1o7jNS1myXx7BMpeqIjqigtVw5YyFwdrnUmwScG5Q7pPzLwJLh1NXDUMckGUQ8jsNU+0ry7rrdehJF6zmzrAkRDX0tPYkZCxuUZovvn9WJuckhFBwteUvMoxayZopNLfMocpBe/oQbYtDgTdyZ1KdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZlHoyrt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de3141f041so386011b3a.0;
        Mon, 29 Jan 2024 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545754; x=1707150554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myZaihACyUJUsgUkXKOA1oofUNHQVfAkH1R/0fTWfv4=;
        b=CZlHoyrtF7lT+TcLDezERfppRPM4ZB1Qq3GLtgwtRoqWTgpx9cXsGPDkLFcN8p+8Ho
         0raIo6Al1ALl+6qxO/S/Pc5s9yDm1+/zNd+IL0BUK8aHeyxJhYIC6k60nPYEb53zfLmr
         C8TmTPc1+9Lejl4iE2HLgQ9W+1R1VpGXRhjdEH8doDPe5uevT99fHsrNoOU4RB59b35q
         H6FcCOtF/fnuUEI2q3u+1Acsx/y20U8cDcpmiAvQtv6xIL2O9iJNz6mTiQ6IvPaRdc5/
         dNzl2EK0pSKPFWTgGacriyl+e8n06A6w+/ik7VgzR3BSpAkn1GSQmeAAWyKQ7wvzl6PY
         Ij3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545754; x=1707150554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myZaihACyUJUsgUkXKOA1oofUNHQVfAkH1R/0fTWfv4=;
        b=TU3ik+R7BacH4dG66ldVuR0HLVRyvynt0AfpfLJgki8QUaJrtaTvU65ceXhz1IxPaV
         Trxi0DyE3/naXNidf4yPGDloHKRiadRjBTvZc4fmDjAVbRAfbfamZFZAu2eGe8M/SfEK
         vS+kFJm3jvIe7dgvom/cI5OnpJyMOJbXNS4QGoyt6hVjk2KdzIxRA1BTggb2yi3Q1Sqd
         eCO+svNeOwwKNR2Y+PaRmVH8Syr4YyATuYtM7AQcKwKbX8bxLMBtH9R9URbXF6qQk4Ri
         ieI77MCXdt+4KeZMIp1cBI15hrl1qJ7dWItOkKt7FtZUtxVVh19apZbAeQ5pUclThoGa
         MgAA==
X-Gm-Message-State: AOJu0Ywif3W2ZpsjDmQcGo04MVUTwH1lxSnchEuVllqGgYiYdCMMKNwt
	Mwjg1xAcvlOJSpd59Oxv1eA6Q3pnyc+lIo818u/wqRnKug//aY+74+0/nSRxdok=
X-Google-Smtp-Source: AGHT+IEVDk5kfmQa+NB3FpC/nBGh3Jt4V2HODqGFNvRKZekPIrnVgxVPfs86wVngMdsvNPTtiEjN5A==
X-Received: by 2002:a05:6a00:4f08:b0:6db:d986:5c1a with SMTP id lb8-20020a056a004f0800b006dbd9865c1amr2487945pfb.25.1706545753738;
        Mon, 29 Jan 2024 08:29:13 -0800 (PST)
Received: from kousik.local ([2405:201:c006:31fd:e71f:2351:f8bc:8b88])
        by smtp.gmail.com with ESMTPSA id gx20-20020a056a001e1400b006dde04c10dasm6021864pfb.217.2024.01.29.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:29:13 -0800 (PST)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] selftest/ftrace: fix typo in ftracetest script
Date: Mon, 29 Jan 2024 21:58:07 +0530
Message-ID: <20240129162841.57979-1-five231003@gmail.com>
X-Mailer: git-send-email 2.43.0.443.g6965527da0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in ftracetest script which is run when running the kselftests
for ftrace.

s/faii/fail

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 tools/testing/selftests/ftrace/ftracetest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index c778d4dcc17e..25d4e0fca385 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -504,7 +504,7 @@ prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
 if [ "$KTAP" = "1" ]; then
   echo -n "# Totals:"
   echo -n " pass:"`echo $PASSED_CASES | wc -w`
-  echo -n " faii:"`echo $FAILED_CASES | wc -w`
+  echo -n " fail:"`echo $FAILED_CASES | wc -w`
   echo -n " xfail:"`echo $XFAILED_CASES | wc -w`
   echo -n " xpass:0"
   echo -n " skip:"`echo $UNTESTED_CASES $UNSUPPORTED_CASES | wc -w`
-- 
2.43.0.443.g6965527da0


