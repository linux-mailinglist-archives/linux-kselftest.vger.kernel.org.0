Return-Path: <linux-kselftest+bounces-49245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9314D39208
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 02:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A783012DEF
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570191D6195;
	Sun, 18 Jan 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmc6wRa1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779F17C77
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699104; cv=none; b=L5lI7q71wBJ9mZYBEdnbPfgttvCOtG/VMQMMm8IQrC3JRWadhGY4JPqTGBmEx1LvIOvTuYwY+83bU1V8Q+xWOxHIAl+aQvHne0ODEJUzH0n8RKFtspP1P6Ajq8L5eQ9DMAR+r8yAG5lr0ivB5SC5QvUAW8y3nNwVpjDdM+RCfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699104; c=relaxed/simple;
	bh=o255kqj9N8oeGK/I9xWWmtlxK6I+tQ2294asnIjtCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okyS3rMTEFubvMEg/9R8KEBxSwTMA7x1bgqLly33DsKXQva08pEI9aN/DRMEqdrEISTwl1xgK13WsJlxho04O5Jg/IIp4WpxaCJ2yx/ks9ScNcHyMguw0JdgiCKktg4PekpZiBsVxASI70A73tPcA4lEyV6MlvMvemxV5UMBoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmc6wRa1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c52c67f64cso349889185a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Jan 2026 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768699100; x=1769303900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHdYO4hylg5Fck4tzGsglyFOuT/7NqghvPt+ikirSH0=;
        b=Nmc6wRa1BxZf6HAPU0ZjvSP03equlZEDZ+2RxwoMXkSCvmMzJZmpNHg5hkcJl80AMs
         CMkiPLhzMp/f5PUBV9eZ1TmB8Oowu1EDKa4lCBhD0KDjdMdr3dW4AWVQq4tr5zOCMk4U
         98phJzvZhttnyPNI9LxU1sgMX0MjK0VdaAAgnfXio6eUQ4WDm1HkNUNtW9AcgC99O4wt
         kuyNIuNIxM7mYQuSc5bR1fvjHddY2MFJ34sJpYq8CkHMNrfxGenQCqhmJWWq/2AMRTLj
         oFSPFI/x+ykKdyCCs0QVmLfah+WaxDs1G161opInE80VZ/sFiBL9qTNFZdR3+SkRm+DD
         Fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699100; x=1769303900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHdYO4hylg5Fck4tzGsglyFOuT/7NqghvPt+ikirSH0=;
        b=XWJqSVtxNDhFV5uCTFYkVbhxLUmt/hwHnjhtOA0eAbqI4MjL51C/OvlUvPvOCXtD24
         9lKTyFEzfrD7YaIoVaSE4+aEVq1PQl53Ce0Iqe9mygg277t+ZB1eDqUzDIglbTK0avyF
         dnWMpsGDg9bmTqKtwJe4eQESuL3TP/G/c322MD+JLrkikE1zbiYN0p3nZoR5IYBbrzS5
         qFK77ET7lPabRpZ6r+k68Tkdm+qM74FW0DKvwqQkSJUAwwQiNpSk/3nlVqktUzVFHC7c
         wXhCcvNOkC9O+6N+kqDSmYRuXE31cEjPRJpV6B02qx0FyYbcyGugpwcjAMTfVv+WZKbo
         bI0w==
X-Forwarded-Encrypted: i=1; AJvYcCUhtETsjh/etqCcvew+jZYYxVpvPn+xYy4SBTlfMxPZ4JtIN/taDqk5wHLRecmVth/LleS3J/7brndsFyr3gnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97HEXjpfyiLtP74alySSKYSbP43taLdiFeWaKeZ5TXO5ZbQNv
	MYgxdN2uqY7euZjMeVCFHplXyX2luqLbY74MdZmElXkZXbM8f51OPjhU
X-Gm-Gg: AY/fxX523Px2BNRA+f0vG1DwV36/s7M8oeO0TpyzI2820DwOek/wap+biOVIU+uzuuO
	4SXiUTIBKDBszN3VstixtqJmXg5/m7KQAZ7Ag4FqU6eYJOq4JhoQTyumZxyMroIcHpDgyKCKnCj
	UXmQb+4ZNYJ/R4hOfTf08TfnGyYVpdZ0rGSUhtICCGJ7OjE754GlLK5PcHOVzNoh5KPi+S8OoXy
	vMTsSQijjxop+3x9Cn/NaJ96454+2BPyp0u+pbxM8xU9mSr/0kici2yjbg4amwSYfD6PIbp42vB
	Pvgu067i5EBu0lJaxHzjDvIL749Whm/h70hnPXG8D9rewEDROT4MwYv/6OpaYdCBvbbVhm3XukH
	keW7Y6umLivgCcLSX7W6d0Ir348iwfIYUK3x0UDngT5BizISU2GV2A+Ft582JGnPfxoIFUuTu8k
	STLhdYSW4aG0TJj/hPF4MotVtmFFG7Ovan2MopVgysnOtS1Oxt0AAIagLfqtKCuW/bTxnuxqw=
X-Received: by 2002:a05:620a:3953:b0:8c6:a5aa:465c with SMTP id af79cd13be357-8c6a676df81mr1041091985a.55.1768699100327;
        Sat, 17 Jan 2026 17:18:20 -0800 (PST)
Received: from pc.tail882856.ts.net ([2600:4041:4491:2000:8a64:ec6b:4:f1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm512290285a.46.2026.01.17.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:18:19 -0800 (PST)
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
Subject: [PATCH v5 v5 0/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Sat, 17 Jan 2026 20:18:12 -0500
Message-ID: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends fprobe dynamic events to accept a comma-separated list of
symbols and explicit/suffixes.

Currently, fprobe only supports a single symbol (or wildcard) per event. This
series allow users to specify a comma-separated list of symbols, including
exclusions, and to select entry/exit explicitly using /

Examples:
- f:[GRP/][EVENT] func1,func2,func3
- f:[GRP/][EVENT] func1,!func2,func3 (exclude with '!')

Logic changes:
- Refactor parsing logic into parse_fprobe_spec()
- Support comma-separated lists and '!' exclusions
- Add / suffixes for explicit entry/exit selection
- Preserve legacy single-symbol behavior (single symbols still accept %return)
- Disable BTF-based signature lookup when list/wildcard is used, since one
  function signature cannot apply to multiple functions
- Reject mixed legacy/new syntax where applicable (e.g. list + %return)
- Update tracefs/README and fprobe documentation
- Add ftrace selftests covering accepted list syntax cases

*Patch order is adjusted: code first, then docs, then selftest

Changes in v5:
- Reordered patches (code->docs->selftests) as suggested
- Addressed review feedback on README help text to show both legacy and list
  syntaxes
- Added missing traceprobe error IDs used by the new validation and fixed
  parsing/bracing issues found by automated builds
- Removed the dedicated list_mode field and infer list behavior from presence of
  filter/nofilter and keep struct trace_probe as the last member
- Link to v4: https://lore.kernel.org/linux-trace-kernel/20251127151218.4763b25c751bb2aac4b1ee36@kernel.org/

I am not fully confident the runtime testing coverage that I did is sufficient
across configs/architectures, so additional verification would be appreciated.

Best regards,
Ryan Chung


Seokwoo Chung (Ryan) (3):
  docs: tracing/fprobe: Document list filters and :entry/:exit
  tracing/fprobe: Support comma-separated symbols and :entry/:exit
  selftests/ftrace: Add accept cases for fprobe list syntax

 Documentation/trace/fprobetrace.rst           |  17 +-
 kernel/trace/trace.c                          |   3 +-
 kernel/trace/trace_fprobe.c                   | 209 ++++++++++++++----
 .../ftrace/test.d/dynevent/fprobe_list.tc     |  92 ++++++++
 4 files changed, 269 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc

-- 
2.43.0


