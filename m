Return-Path: <linux-kselftest+bounces-49246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC405D39211
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 02:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD3DD302B109
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804941A83F9;
	Sun, 18 Jan 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2a/e9nS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DA1DF27F
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699108; cv=none; b=NSey9Njk96UHxTatTJZ1qDCkZ2SLRr9cpgS9CgS7KU0utq1nTgQwOyuT0K9dMrfQx8Q2za9BKUsnvZ1koXExIkhW8QWr2PVLc6wyLAVwO2olOW9J4qh1ySKghc/pVNk3DPeyakjT6Ya6kV89iZ0fSv7pv8pCK1zDMljxyqLIN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699108; c=relaxed/simple;
	bh=dfSf90CX2fFuCBXs9FEXQJWwoweCuaJmCw5t3YHWiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1EwB7ile9vxi2Ex8x0Y9gMEydFZGi3fTdas2edglExGC8vH/LreOijC0bMLldaIQE5HLIvm5dIwJ2QJwttnHQLfhXXQMvOMduL1tyynyXO5koDGyGgDcqnHRQUY/y76p2YJiB6BElbw+rrZoKTJq48+c+fukb+QOJR+4fX41Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2a/e9nS; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c59bce68a1so210257285a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Jan 2026 17:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768699104; x=1769303904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=h2a/e9nSut3T9bIWO0kthXjxhHwLDoDsmipbNksu8DHVIoxaPmx9oofgNhIjBqenQl
         dN+zDz603mq1S5dRHk8TMWrQ58Yymi9I5Qg8XpYN8DQhJCGc+4P9J5Sbt4CxAZnnKmEe
         PALtArlPAxHrQl0EUIwpENv82N3XHuxSvHzwTq5oohi45dVQuzG5Ssd1MQGru4i/MNUH
         /xMYDjglX8ayPeTRkQQbw19LvdrfYAPcS23LTrgCIoyjxJEXOaYljMyhm/tFBk1aLTky
         lPw/raTGziaDUJuoP7aaxzrGXlXrabwPCTcKO71qMMPY2Q09+RrmxFkP6J4V3AYfuc7G
         4AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699104; x=1769303904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=oPNXj3LvOPLGza8dYTzvy697+7lTKth10yT8yi3ft0GjsmHxspb1T/Wv9OHPFjqln9
         JVCkfny4UQc2L1VRq3atktLSk0RLfMt1+EKpXW2JEpxhb7UGJelgkwMzr2+VTkNoyCc0
         5KKniyOt8XSBJAASru2NESsHewGkhEsuqYm2Udl8FrYWG5JnIl/D61NTYi8OHA1M5sH2
         giNQXoIf3FOv0AntnWFgkIwH2IV2JvpXHKiRYyqShjuYRCCkZ2wB2A7Tspy7SuuqvQtV
         XAwyk1wi03Jp6vHe6j8X2S8MisxnGRtKLRS5Q1zoyM/Sr9WxZP7DFhC1c9E7jw1a+K29
         bTSg==
X-Forwarded-Encrypted: i=1; AJvYcCXmpM8U4hrHXsBF1Bfqi/lB47SsgqB4750AS3x2tAL0DsB9auioMJYBmexJW5X1r8PUHKr+37sJDUQrFW/3mUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxO8gMT4KVzmDuY1AhTKhcqbmmNR0Sl/o5cgNZ+CTKwNHIj+O
	Tn98rWxsKPPgTtGHQgYrjcFeKFKiIHfFcgI5U5QKSI+bgH7ULYQ50ildoIVAiSE1
X-Gm-Gg: AY/fxX5yCg53jKAtHKN7b3b7jgqg1vlcY7QO8DSrKVpZbzlAdKLmuovjCBn0kQYPUwD
	GA+YhIE9D+BbywALz6WQxFjJsM0j51Ud6soOkvbFPbzYOp5uRsMgDZcU8B6g/1I/7FK/IJQE4Pf
	riQt75sP+F/XFhRY/+smlnzZk9rd1Uwk4QzbAsd4T33BY537Hr1/cITb3m6EpOSR4GeOFd1M04A
	wlP7s4Ow6O3o/dnPHY2aiOm0cVVAEfJ4lTDupX7R+MNUhw7u73CKpBk0zG1gPT0XYFHBs6/mIHF
	JICyf0TNOpg2MFgi0N6EkunCnNSxkwfAii9ohbUjoP1at9rA93GoM860GCUUCW9YFi+YHWL/14U
	MuQiK19UcBl+/dj1cxdxhe8VTDARpPrkQy3PpCWpluSgteqhbQR/bxrvUIuqkxibPBTnffvKFJc
	LXnxWlGNbCWep8pCNrcx66Flsm+8bx7SzyL8o4SdjwOC54L1FGyUrMfzvjiz4fIoGsJQTPC98=
X-Received: by 2002:a05:620a:7082:b0:8c5:3881:da8e with SMTP id af79cd13be357-8c6a67b0933mr1054464285a.65.1768699103670;
        Sat, 17 Jan 2026 17:18:23 -0800 (PST)
Received: from pc.tail882856.ts.net ([2600:4041:4491:2000:8a64:ec6b:4:f1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm512290285a.46.2026.01.17.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:18:22 -0800 (PST)
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
Subject: [PATCH v5 v5 1/3] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Sat, 17 Jan 2026 20:18:13 -0500
Message-ID: <20260118011815.56516-2-seokwoo.chung130@gmail.com>
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

Update fprobe event documentation to describe comma-separated symbol lists,
exclusions, and explicit suffixes.

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..bbcfd57f0005 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -25,14 +25,18 @@ Synopsis of fprobe-events
 -------------------------
 ::
 
-  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
-  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
+  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]		    : Single function
+  f[:[GRP1/][EVENT1]] SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS] :Multiple
+  function
   t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
 
  GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
  GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
  EVENT1         : Event name for fprobe. If omitted, the event name is
-                  "SYM__entry" or "SYM__exit".
+		  - For a single literal symbol, the event name is
+		    "SYM__entry" or "SYM__exit".
+		  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
+		    required; otherwise the parser rejects it.
  EVENT2         : Event name for tprobe. If omitted, the event name is
                   the same as "TRACEPOINT", but if the "TRACEPOINT" starts
                   with a digit character, "_TRACEPOINT" is used.
@@ -40,6 +44,13 @@ Synopsis of fprobe-events
                   can be probed simultaneously, or 0 for the default value
                   as defined in Documentation/trace/fprobe.rst
 
+ SYM		: Function name or comma-separated list of symbols.
+		  - SYM prefixed with "!" are exclusions.
+		  - ":entry" suffix means it probes entry of given symbols
+		    (default)
+		  - ":exit" suffix means it probes exit of given symbols.
+		  - "%return" suffix means it probes exit of SYM (single
+		    symbol).
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function
                   entry or tracepoint.) (\*1)
-- 
2.43.0


