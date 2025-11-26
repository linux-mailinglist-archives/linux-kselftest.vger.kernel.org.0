Return-Path: <linux-kselftest+bounces-46537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10318C8B75C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBE71358663
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1CF31283D;
	Wed, 26 Nov 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUxRBjs5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A12E88BB
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182475; cv=none; b=qj5zymJgkPkF4rg3+H3tcbVJw5v8FXzeCL89z4LtkwnWfshbMDmB/lEk73X6dnr6EyMA7h6dwO8TJJJdT25NOK/8+psx8a/WpWy/VBj+OckyhbukTaptzg2tVbyjPfRIAsAvA8Szzradol+lT/xkcj5N7YxhJgBwDuadLaqQArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182475; c=relaxed/simple;
	bh=i23uuyAGDdzSRsmj/cUkhrMZq9aQGUA4+8iGZcYIbXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM7vs3kbIn8/XENRLQuj6zwtHLsa+cStRPlIfyIeMIWwfpB3kFUWdTZk0AGMf88zHJP4KlMYyp4Olf9G/YlUFCZEzI/tYQ3S9QfB2ubNorN1rFxTD0rNKXOhABDGxmY9C5tsW1423NmOgbXslE6vaZDg90mx7i/TarDb3yTcLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUxRBjs5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8823fa3bd95so10254496d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 10:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182473; x=1764787273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pL+BNJLCWGjhg/T7ReR52wEfwLq1p/DJmaJjs1qnoVo=;
        b=HUxRBjs5rM+E31gjKodm3rhQRKKQo0DdpjMIHp+p2mOQ06SY4lcTfqll5pAtqHmh+s
         qg8pQAFRZm/ujPq2H4/3kZLHdLucGNoATTLXm6S+QIdmWeUkRTBBFExAL0wQAnD3DS9e
         Y8ErfPSAHgakOrUwFSp1djTVDjB23N18HawYqZyS2eQCBvEMBHCLlnkb6TnFr82zSix2
         WWvavkoBpIcyomylTBuu0stNsjI1ExasBBOD/CP/j7a3MQ3Zweh4bRi25CkGdlTNoFfA
         urFhIMlck47NtpL0CPX5QXO8gQHxf9EKnOefk6uCJ2+I62GhoXa2t2V8O1bdvLdXXur7
         CyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182473; x=1764787273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+BNJLCWGjhg/T7ReR52wEfwLq1p/DJmaJjs1qnoVo=;
        b=RmH+Qz1OzTE92yOOnIHzLlOX3NfjjgtcupMzGb4xsYnpA880EqUO9w6Vay25Tnu7PN
         x5sNVyuAMCVKwInuV9ndaVteZOCyUDMzaGQFEZhjFj7olwHaJuw6fuksYGVyauq9QFv+
         d+m6f1bHZ4eO4yRPLLmRMOKhyAZq+4/5T6lXnCFiRMtMha8lLOIOuZRJDbBYVuRB6hbF
         /UDmRAB5xPutW4ca8w8jPxB9q5BiQRJwwrzt2e3xXJkfEQIFm4tWFpyo3tq+WK+7o/8O
         VKOLAFWG9eQ9soAztogBv1vgIq9zarECSisIHzCcvicGTMO33ATNhZfDtC4F2mi9jjvy
         gIzA==
X-Forwarded-Encrypted: i=1; AJvYcCVYl8QlSG2203jOrYsjDpBMpr+iY1A6WD79luVcEs/QwuHIz7NiVtLTeRaPDzGQ24PUOgiOPHqQ6iGwlHDG0WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmCrZBPtDZHdv8WP9WxxAXaQcxalZyJT3MoeZ+R5x9oN3fST2
	EQ+OmiXR/J2FBMcyRG28hgnkCWXxkp9T9uM0QSeQEAm4PvwuRhkyMH/ktJuBNK6ZpGE=
X-Gm-Gg: ASbGncuWpgptYb8LkHcUVZCs1TOba2VtcLcuQrnEXVzrOY78piGWz2b6hwyVLJ2DqyO
	rcxPfkpaLRutjPPAUs92iiP1VBGPP1EWD3RoY3rNsjY93mwgk6w9cb91QM9+fqnZxbPsC+NkH/X
	LCtKwC+gji8IlD/lL//c/CUOEHQS1FyuDa3jigp+QF05feZZ0McoJh0HKzbscU7s+kC9NvCHij5
	YMGGyCC1UbFo1//9mY1YcUsg1kX4Hs4UaKsQHjNslkMZrwvfTo84knu6PSpLAGXkD/PsdwUvED+
	/ZGzQ9cstr2LC0tXxhLqrAjfeD87Hx2lH0i/wK/zuCLKjJlODIHirVhMRx/vmq2gWwJj9BGJ4vm
	boXUBSJlTt5FkfwUuvNoX/clue3FAoO8ubgxgs5ad2XsqfdGH4RaHbPgk60dzqWM8IYRIumRrQz
	gBtkmQ05nVCBctwlw+V7B/ZBwjPiROtmL8KTBVAGeoM9XR2936aIstlGP5nxYA5+1o3IIeekXm
X-Google-Smtp-Source: AGHT+IEHMh2eH6r4vuI+wSTnrrZC7V0tb2D683WfXr+VMa3P9wT14HS3nFOcOhfoANcpVL7LdtkX3Q==
X-Received: by 2002:a05:6214:20cc:b0:880:3eb3:3b0a with SMTP id 6a1803df08f44-88470080384mr407156846d6.4.1764182472895;
        Wed, 26 Nov 2025 10:41:12 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:12 -0800 (PST)
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
Subject: [PATCH v4 0/3] Support comma-separated symbols and :entry/:exit
Date: Wed, 26 Nov 2025 13:41:07 -0500
Message-ID: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend fprobe to support list-style filters and explicit entry/exit suffixes.
Currentyl, fprobe only supports a single symbol (or wildcard) per event.
This patch allows users to specify a comma-separated list of symbols.

New Syntax:
- f:[GRP/][EVENT] func1,func2,func3:entry
- f:[GRP/][EVENT] func1,func2,func3:exit

Logic changes:
- Refactor parsing logic into 'parse_fprobe_spec'
- Support '!' prefix for exclusion
- Disable BTF lookup ('ctx->funcname = NULL') when a list or wildcard is used,
  as a single function signature cannot apply to multiple functions.
- Reject legacy '%return' suffix when used with lists or wildcards
- Update tracefs/README

Testing:
Verified on x86_64 via QEMU. Checked registration of lists, exclusions, and
explicit suffixes. Verified rejection of invalid syntax including trailing
commas and mixed legacy/new syntax.

Seokwoo Chung (Ryan) (3):
  docs: tracing/fprobe: Document list filters and :entry/:exit
  tracing/fprobe: Support comma-separated symbols and :entry/:exit
  selftests/ftrace: Add accept cases for fprobe list syntax

Changes in v4:
- Added validation to reject trailing commas (empty tokens) in symbol lists
- Added vaildation to reject mixed of list syntax with %return suffix
- Refactored parse_fprobe_spec to user __free(kfree) for automatic memory
  cleanup
- Removed the now-unused parse_symbol_and_return function to avoid compiler
  warnings.
- Tigtened %return detection to ensure it only matches as a strict suffix, not a
  substring
- Link to v3: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/

 Documentation/trace/fprobetrace.rst           |  17 +-
 kernel/trace/trace.c                          |   3 +-
 kernel/trace/trace_fprobe.c                   | 209 ++++++++++++++----
 .../ftrace/test.d/dynevent/fprobe_list.tc     |  92 ++++++++
 4 files changed, 269 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc

-- 
2.43.0


