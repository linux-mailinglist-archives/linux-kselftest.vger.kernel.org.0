Return-Path: <linux-kselftest+bounces-48985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DC7D21862
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8595B301A83F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C13B52E9;
	Wed, 14 Jan 2026 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO4tddO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8563B5311
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428852; cv=none; b=Sf/SpetgrMlMpGq4NLvty1UGtVWoi9Xjxq1xi/CX1kOCGonUj6Ycg0ZCghn7Sc6soC+2UtArIvc5Qq8h2G0HPJ8wOrgfTVYcFxdLJZAjs6TI8CSMx2uUi09kANhPzdWEJThUH7TxZTnJ/U/Ybsf10aoxLawjI3jxvTW/hVfxqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428852; c=relaxed/simple;
	bh=IZqAGizxkk9ErROuOBGZmrieBz1ow5xW+bA7VsOBVFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svy4qKwsADClbqLoBNEQkN7mS8bityhchWxwCMomwDDKI/qkMcpTNKTsWJhqPy/5Zp9zKVjXrkztkjvtcZBlNG/UD3io2GShW78C7vR22Rg01gYcNN8SXATf8dt1xgT/7TCgL/z+BT8gwDKbYzwNiGm8PtQ+8VjfDg3JUBNu0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO4tddO7; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c52e25e644so26677385a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428827; x=1769033627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXFVdIECi6ilyP/TUQ5Ud/VbVwJbO6QDA7pbbRj1oPg=;
        b=WO4tddO7xAYYTf9hDsF5hBYqWylnDKYCtVCM3g5Bu2Ww9Xv17G0AZ3RiMCeQwCSxhU
         8kaIqew1Cj+bgucV+m8L8PZirehadkRbtJqDSRXPk6rEmt4UXf5ZLqLsN8FjeHxc2ucX
         rFRcPDiPwEPOQNe8SIkaXBwBbgvZJ7+vJ5fSAPZTG9rZ2gnmlRdiJ+kSSgGcfToaxhzH
         Efftzc2YdIxe+P/RPDi1LM553BI1MzUamD99yYorWtKzygvlAiqb3RSrYdqJeFvjy4og
         gTm3gpiSpRgyPK1krhxxxZE3LdXKsVKfVMiyPoamSL+EEuLS3ioJgR1gA/jh5qHQBMEU
         4hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428827; x=1769033627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXFVdIECi6ilyP/TUQ5Ud/VbVwJbO6QDA7pbbRj1oPg=;
        b=UtES5mJiwfOqZ6gB/XJJYicDdci+qTd8RLkMesGShYTYu7GSobGfNcK7X5mlTXZkBY
         z8rMw4dxtQU1Wlj9dW+zUQ/CMQX9enXNQI+nzUd9X9qw1Y2/VxqmcBgss7FrOpeoR9Rd
         kx2mCU1D8rsz5H9YfuG4Nwa8VOeXeKCP3W9UMu/pQ9B9CMjQAH8UHsYlTHvxtsqIPO04
         KQ0n4YzKkOA7qxRYWAX+tWJmWPq9TH0JfzxfnymqJB8UNb8q+eQrjQ8lZdAK1vXTtzv5
         lKJ49Kc2AwucNj72J+wAFXq9Y4wQspMVgpFsLNx5VHVceHx7ZRkuJi7H/XRQLMBoLulg
         lW5g==
X-Forwarded-Encrypted: i=1; AJvYcCUSRUods+VZ3nW4pUQoI+OE7uLnQFyyoGDIoD0UsvfHQmVgo2uK2UdPxLhoGKmDoOu7NR/NTpUXz11XMXMSQ28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHi3mZos07EHdY6PzWxB3/UqCHsHQ0rrZ4AgGsgqoZyoCmlvl5
	2y8fkNvTMimaf1/psVlxxCa6N6iZqsK4w7GWb/YbvlIbu57FSqaah9Yn
X-Gm-Gg: AY/fxX5VJkig7FjyASBWgfbmO8QN9Sst3qSdKf/n3nSH8rhhwQXmGJXWI7DFdgZOjro
	8MGXMQ+XUDanW1jGI4OAxTOsWX19XTCu2JoIbC3YMq52kTC3zFdh0cwrXiOo4cB3V1r3/6ErJuM
	sxmaSx3C+onZ2cFt7CZXepoTsM795Zan9uFmEV/AHd/bKgTiLFax+W3RVanN8fMLet2ocZvmCbF
	V+mfbNcHiVYunJmFPWbF+X7EmJkWX9on6oTeWxeZ39gyXLbPeufCgdXuylCviRzBS1OBTusbXbl
	08s8tdzV0LQbbQffvzUIOQkbMTdTO0WVzUglcT3kargySW6B+CMFozK62DPV9HxBogvAais1H2d
	R6XczUZHYn1ic9dqdayd7LCNI7EGZua6OAPYW3KS+FE4GS7QtQpdNBwL/5fXrCRL/Rkwov/L+4Y
	LKkjzuZ+W2QZ3roYgsgdOfUneinGrNNAup/Dt9Vih7GNeUq890/vQXW2iKcPgzku4E94kTdow=
X-Received: by 2002:a05:620a:29cc:b0:8b2:e1fa:6eab with SMTP id af79cd13be357-8c52fbb918bmr575020685a.62.1768428827000;
        Wed, 14 Jan 2026 14:13:47 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:46 -0800 (PST)
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
Subject: [PATCH v5 2/3] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Wed, 14 Jan 2026 17:13:39 -0500
Message-ID: <20260114221341.128038-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
 <20260114221341.128038-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..5efd9c374365 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -25,14 +25,19 @@ Synopsis of fprobe-events
 -------------------------
 ::
 
-  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
-  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
+  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]			: Probe on function entry
+  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS] : Probe on function exit
+  f[:[GRP1/][EVENT1] SYM[,[!]SYM[,...][:entry|:exit] [FETCHARGS] : Probe on
+  list/wildcard
   t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
 
  GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
  GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
  EVENT1         : Event name for fprobe. If omitted, the event name is
-                  "SYM__entry" or "SYM__exit".
+          - For a single literal symbol, the event name is
+            "SYM__entry" or "SYM__exit".
+          - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
+            required.
  EVENT2         : Event name for tprobe. If omitted, the event name is
                   the same as "TRACEPOINT", but if the "TRACEPOINT" starts
                   with a digit character, "_TRACEPOINT" is used.
@@ -40,6 +45,13 @@ Synopsis of fprobe-events
                   can be probed simultaneously, or 0 for the default value
                   as defined in Documentation/trace/fprobe.rst
 
+ SYM        : Function name or comma-separated list of symbols.
+          - SYM prefixed with "!" are exclusions.
+          - ":entry" suffix means it probes entry of given symbols
+            (default)
+          - ":exit" suffix means it probes exit of given symbols.
+          - "%return" suffix means it probes exit of SYM (single
+            symbol).
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function
                   entry or tracepoint.) (\*1)
-- 
2.43.0


