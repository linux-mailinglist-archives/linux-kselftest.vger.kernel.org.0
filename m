Return-Path: <linux-kselftest+bounces-48982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2351D2186B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46EAC3069632
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD9B3B8BA4;
	Wed, 14 Jan 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4h4GaQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA93AEF3E
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428834; cv=none; b=U6DSpn/XggRxYSMOjyIkI0olm4i/+kp5aoF4VTb2GJNjhISA7wn+IJR5na4Uix60cCWT6nt2B95Q9CIH/nTu0QDZsJWZyXhpe5Bomc3fejnf2eM4a+oJsIiuTWhfEZxf1Il7CEvuGfH9RwuqtSpp25FIwC15AuoDefuhObEFUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428834; c=relaxed/simple;
	bh=v/6ny77OEhOTDZTQ79j46inEoAHozIzSVLV54SqB5XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqzHJUK0ESE6HHyPiXgfP+ypftNfe/8UpFk5aOS3lK9Ztm33P8YnhE0n7tqacgTTHN9xt8lRIr/rdRYE8atfpCF7fkD8f6WLVZI8wba3iaX+PenkKT2GUFDEtVk/fpYk5TYSc+ZNQVp7YSLK01A2GE+skTv9KTIaRzV2fC3LFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4h4GaQm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso20871485a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428824; x=1769033624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=m4h4GaQmLps4eYd+p4N8j6XD1Cn4yDY+z9viJPYK/P+7okqaz4kgiHMQVVLTpYl7sz
         Vin+8Oo9UpDsZ3/tdYEkI9Py1gE1HcvaO7yMETh1JSO+9Z4B26oquOgunOjvWnMaDNk9
         xAPjkEds2ZuXntNuS7WHeS4jYhh+BuTKuOqkn67bUgGZdPFCxtHBSf+vjO/UnaMWSYyZ
         1BPPXCp7y6xPsm7SFLbfFbzzY7hr3fRsEWPHohX+/gr+kpIdga+RcYbfIxP61168F4+Y
         wKQ0d1Is3/aPyE7mTZhHua2wI/suXEBtiFaRzAj9TN5t69EcbZTnfkhTJmc59V+TEoFm
         ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428824; x=1769033624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=kdAGd/e9dB+RnwAPoG0kNEFc0hcimD0DgnpguBsinxCKYQ5bABk3IT8oOYJHKF9RK/
         E381e2lBVhq18ls4AOOiD8kWvqUcWbBCne6SWHRSpXcG3ShKDWkn0qYd4j+3FI+tkm5z
         H4rJXrlAn51vnn5+C1bCylVKOQko8QbAHA+yBSLA/7b7XZtEASMnpWo4dSgTqbP4m8ZY
         X/KGL7uMl+UK6CpZCt/q4dTTBVLQ2AulXyNMrGWZdyCdjPh7JMGxLDFG/OrdFvp6DuJJ
         3FF68ZgZLS6jY31x3Yv+eG43IJSi9rk4F/ytHVKxxpINfjavu2Hif8OU7F8GvaLM/BMY
         4P5w==
X-Forwarded-Encrypted: i=1; AJvYcCXj/9sR1cR16Bzex2lWFS5S+2w1hiItlAYEfn7B5gM3nPnV0hD8Gw8RlyXCIuwtextWx47jHlBEx6oCJqhIyFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qklClnXx1YTAXi4JLG906L8Afx4CJByILr99Mojld5enGGb4
	iITF7z5efQ/B1hASgZxtx8JumPBYirD3F8QP0//NNsIWUr1XFs9vV+1P
X-Gm-Gg: AY/fxX45ASRXi4iYw+1iPqve3WFQPgCPofryzKsyv321dc06CXY3FkR6Z1IWRR2n+iK
	/4N60GyjOvZQHcWlbcBJ08/bIH+wmWIbfEHgmBpGI9BaGF1U9s+hdiXkHG2MVzL+JYgGrFncr0h
	M5snCJVA8yLocvXJsRwOK27YZAZLyTYqAgO9x5eKbdiI6D3jWIB9aR868eX9N57CZLMeGgttryY
	7OBqynDawSQMTIoGI/mSJQtaaGJC6k/BUad5ls6N2Hizzbqky0j5zpLWKzQRXIM/75xGMTDTz9Y
	EwLPeOB/ByTA85Z9UXSp7LHiyajJSYvq7cuolkCAyrlP6NVTsk0k99NoBddQI6+Rkx66phdyeyX
	GdNt3uCLma+SXvOgNE8kpf9XJADcQP7ztW/Tg1NEg76ksQwZWiSBKf+DrugRbHoBklOefEi/7Ig
	y9FVWe0e2yYa7qXqhOvvm4OSrRif7WgEJ26FmqvsY/spCF941QCYYV/E7RDAQmdfdRS//sh6To4
	gPe2DcxDg==
X-Received: by 2002:a05:620a:4052:b0:8b2:e5da:d312 with SMTP id af79cd13be357-8c591a02e83mr164610885a.39.1768428823769;
        Wed, 14 Jan 2026 14:13:43 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:43 -0800 (PST)
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
Subject: [PATCH v5 0/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Wed, 14 Jan 2026 17:13:37 -0500
Message-ID: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
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
  tracing/fprobe: Support comma-separated symbols and :entry/:exit
  docs: tracing/fprobe: Document list filters and :entry/:exit
  selftests/ftrace: Add accept cases for fprobe list syntax

 Documentation/trace/fprobetrace.rst           | 18 +++++--
 kernel/trace/trace.c                          |  4 +-
 kernel/trace/trace_fprobe.c                   | 49 ++++++++++---------
 kernel/trace/trace_probe.h                    |  2 +
 .../ftrace/test.d/dynevent/fprobe_list.tc     |  2 +-
 5 files changed, 47 insertions(+), 28 deletions(-)


base-commit: f0c13b210e4366e03bd9e8967347b06b227e20a4
-- 
2.43.0


