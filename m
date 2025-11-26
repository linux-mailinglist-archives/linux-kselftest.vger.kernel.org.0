Return-Path: <linux-kselftest+bounces-46538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91AC8B765
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E049357DC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076DC315D5E;
	Wed, 26 Nov 2025 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjfPpbkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE01326D6E
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182493; cv=none; b=PtswPNktlT6xRoZhMcXH13pXqU0f3lwItzH3/8Adk904S9+AFGhjyS21PQdv0elQXTjg0EZ95vCSCBxDsMM16VdWc6DGhP4pd5BwB4VHT0Zh/efwwb+5l8z60wiiewF2M5PZJOgFD9ra5lDpQwq6b93HpTUElhOsLUqhntrCNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182493; c=relaxed/simple;
	bh=dfSf90CX2fFuCBXs9FEXQJWwoweCuaJmCw5t3YHWiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr669E+prGv2BqOM87Qbhww/g4mEHayjj1NWyWcL36RFflzd3DFumIfg/Oazb+97ii4ty2o3IY6IJVlEsIUnGo917bXxf+y9FElvCSOgyAldzZ/lMJfCLorvt4R6h3zGXuxNQT3JDTjJ4Tp3n0F5TkXxI4yc9BQdcgptodgaAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjfPpbkw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2f2c5ec36so4775685a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182491; x=1764787291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=gjfPpbkwOlrreZCEjmzJFa/R/wub4LdHPIMHP/DljKl/gh+tnk7nnaB71CB6MpaU0I
         WQhT89k71G8Ii2kHFy33z0IyZ/o8pNH0lzrIB5LwsrLLN/Ib5Sem/1wkkxRbHYqRIfkY
         Gmn3/lAqaV9UPMIJmLJSp3D7+bmrkls/by8LN/hYp4bVZy2vie66Jf9xaPzQtYwnTvgU
         EIWGbzPtvfmbbTXyB8UJhumiBvQm2tS03GZ2oqR6otnuKC75YWO7zRMp9Pth+UZvyBHj
         8sf3zW/t2NYUA3+8zL0ZFS4++Px4JvxoNYjtI5sZXuLiCzkBPXJ2x1lkjtuKanDygwCN
         28VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182491; x=1764787291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=GGEgZ48g/7NPvjKcJUhBx7jhgiu6a6uleow+RG/x3ulSyBE25xoAlTeQSGzP/4gOMD
         d64L6vlYHx9W5dOl6FF6wUg3bnRlGnsPRHFkoLCakgOpqodi9uRnFTGXN5CaZka1N9Q3
         qNUPynUGmsgF+FFj/xoVjCA2y2oD0ZJ6zOY95KmXMv9b6nFLQYxTXC+60ad7cZrTtOqU
         ira51tudP0BUj7ULPstE5adEPVNuve1+vc0t+2vOJAUs/uDgg1U/qUx7cjzseOz8ucot
         Jj4dFUIQf9ptOHA31OL055Ltnz8O/tmCXvBF/uMlvRyL15V8iOrceztFd/jmJpKeOhQe
         OkUA==
X-Forwarded-Encrypted: i=1; AJvYcCVvXSxMxzPqRSi8PO8I4n/mYs4ON72QluEFM537RbXhOAon+tR+myNaE1Da7qT55PSpPFCfXDpqb+5Iu7slw48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7c4tiDaDQwsCuUOqs3BhLwxvgmD7EVEx/GUs1HC00M88ehWi
	JcPJRh4VnzpTMB7Hz6ow9Jn4Ho1W37QYLb8BJ/ygpXS1EYhthSlANfZD
X-Gm-Gg: ASbGncurBatd+FmuvmOIHZku3WCnlsjGhio1P6a2IH2vjK9C4KU7f1slpxB1pOZOGXz
	ol35KVEpDpUJvyn1+8sx20mwtfXYKeKMulZKIcXHYJqS0CNgUc1fg1a1WCADwXDXSDh5MOpuAO7
	JWTb3FYHOWJVhsYQpcNubwP4JHSku5Zvtyym59YefPcEG1LInMJU/LijrMgTgYrGdLF12NDQ3/j
	3xx1/vUO9ZzakWGmJx1KA3K/xNVeh5wKVUoslT9rimcnR8GYKjVCrHi/sLihNu/51iruHojIBbj
	awAoRmT1GMCv7iKFRu3BmL29IvDXg4FeZzyPqosPTrqh3UcHhrk0OQkpql2cNg18MglGmm/GUQ6
	wwT9bphGnfCk2ECRnQtkYRP9M08Eo7oyIMWJmIfECShOxQqh0I8VnxlKU5/61VWfSmaUDRwi7to
	yBSQB5zzL02fFxA7PLpCUvAQt38zi/+W/QIM4yIDQE+p6X2Z4PlWEK+FKSRjKqt1gVcNS9I4hm
X-Google-Smtp-Source: AGHT+IHqQ4vHalOGeJgi5wHcgOQIKhyE2K/ufYLvIbCrYdKKtu2YqgKcr53BfJEZTMvq2GMt0PmGbw==
X-Received: by 2002:a05:620a:1a9f:b0:890:62b7:5ae2 with SMTP id af79cd13be357-8b33d4cfacdmr2481832785a.46.1764182490954;
        Wed, 26 Nov 2025 10:41:30 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:30 -0800 (PST)
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
Subject: [PATCH v4 1/3] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Wed, 26 Nov 2025 13:41:08 -0500
Message-ID: <20251126184110.72241-2-seokwoo.chung130@gmail.com>
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


