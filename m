Return-Path: <linux-kselftest+bounces-26591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3799A35049
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856C016C2D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120A266B72;
	Thu, 13 Feb 2025 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MMIRveN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF78266B55
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481152; cv=none; b=DhuyLteSRhfKbAiPROcHc4VJ8YBRA2nbJtI8/HrjRUQPmtSQGALYOUSCdoCy8ENXwa4E7GHdfOFpqA79ImDeri4yYBD6sZ4IGR9ovjDylCJR+VPRwWInsHY8l1+1NumASz78i89Ri5TuCT1+aWRDeBC1bRjTWvrwhil9yj6qLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481152; c=relaxed/simple;
	bh=N+TdL3KilayS4rRbQWLK74G3+DHz/OaIh9BFAsERWeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JjKruzXmo7SAWWGzEejoEA2TYsIu0ujFtVg9XKhIcgrcpggDMmR4AQ15Dd+Mr3j1YMIgoJcJDPvjxli0AnOdBXuiON+XThK5PvdKIg9dYec1F3qqV1Uaf6GqLkZqUVCM0cH33RQY8nwiEA47V5OCJoU4zMu/d9Fkkk6wZNLcIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MMIRveN+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d39a5627so19058185ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739481150; x=1740085950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXY8NgkO9E3uv8b+GWlibE4IZm1ibJ8iHuQXl96QOdc=;
        b=MMIRveN+Y7OpyvlZEoKdUWtG87Vofp6UWcbWO/eCRWpDBZN52n5sKUxl6h47Pgfnjp
         7uBILTaaqniiP06H+xNcqNwFmarjLkE8jgxJ9VLWepJ+hOuFkUHWom4KejhPGDRsz9nt
         NqMZ0guocwcue8HbjnD+L8xR9yFxeFSN8tC6lH81zOLjHQ5aS9jfziLHXbMInpSTxzjV
         tXNx1wPaXl5wLXRanVKSmkwTmbp7pyKXTiRcUopictL4qrpslXx1KlGYbzfWKu/RZsvV
         327CdwvI7ayDBPOqhtUJ/NKSFON9vWUz/k7e/g+Ropnagtgli+q9XtbYpuI7B7/7o+zJ
         7ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739481150; x=1740085950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXY8NgkO9E3uv8b+GWlibE4IZm1ibJ8iHuQXl96QOdc=;
        b=vUak7+Ri55ETiydh3ShTiyTHKA5b4nxZNWw18oLwqgJJ/6Czqzte37LECSabu452fZ
         TzekNNN8iidC4F+So6zau8X/aJ3x3RGb/mAoM3+l8tmk2OqRAZTQS0E2d2ACScbeSGnA
         UXyC7+N338DHMXlYlvVCWcGU/uN38woHnFZpcvHseGzDC4THY6i7zA3rj0IugfRZ7Xww
         mZL4ujlpaPgR8h+uYIZRWFkbkeUO3H5WJxkFdGaUDAzVJNKMfaE1MP77Mrl80y0FhjK7
         czSYN1uOV5BAkmOUoK/+J2qxf2WeSdKS6SWKXxiKYoEAkEQyAiR7dLuu2Fh/vJOjRX9e
         LIYA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmxJISsFzIQxuv/JdR6oaGIllOLGUe83UoVUDTqM1GMdEH4e0YE34RlkoRdhoz+A1sCrAOXqNwt6mhPYAgcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yF4+YWuF9yqAgtAftFPmIunmS6idI5Be71HBdPz2Z7uFyWw2
	jIRqeBJ/lKgK+TkLJrKW0K2EzOxXe2woTJ4oC0ws2R1JUl2AXT+VMuIw4/VWeRE=
X-Gm-Gg: ASbGncvoJWxcLRILZUhkGCBaQ9vmquQs7WPOfmPKGHPM3XCX8Uizro1QEjJXecvQoTT
	lwhMAQTtsvTJQ2lH3tZ5QU21EHniN2tlsw51B38cOkVhVDaQhe2GZWimGnwOUOBm9KS1DV0n8Em
	xV+HYldiL11M6ws3QNG+LP1F9IkZukbR4aZjXyJjK3KpU7V+FeTKSZwWxQjwAHbDN3k+5KUWVIy
	osAtCb+Xc/ZNtLaqcyknihCZPDy1e0Dfx5L0uiIRjSrbWgTZmbiw5KUagkNEsOCLYuwMjMQpsB1
	mWjV1e+pBhGmAEcPkbA6Qz7py5+SqyY=
X-Google-Smtp-Source: AGHT+IGRfpGhkXpROr2LFCZmjQ6yXJEuPu44ieVdu48ptWPwcDLD7uVHhk1j5n/6iukOJOuvsriMzA==
X-Received: by 2002:a05:6a20:d81b:b0:1ed:e7f0:3136 with SMTP id adf61e73a8af0-1ee5e5b9674mr13835109637.20.1739481149808;
        Thu, 13 Feb 2025 13:12:29 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324257fdd6sm1758072b3a.76.2025.02.13.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:12:29 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] tools: Unify top-level quiet infrastructure
Date: Thu, 13 Feb 2025 13:06:20 -0800
Message-Id: <20250213-quiet_tools-v3-0-07de4482a581@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxermcC/23MQQ6CMBCF4auQrq1phxSpK+9hjCllKpMoxRYbD
 eHuFlZqXL6XfP/EIgbCyPbFxAImiuT7PMpNwWxn+gtyavNmIEAJECW/PwjH8+j9NXJtKjS6rZS
 RmmUxBHT0XGvHU94dxdGH1xpPcnn/d5LkgregbK1VhUqbQ6DkI/V2a/2NLakEH1yKbw6ZN+Bkb
 Ru3A+N++DzPb70vNXnoAAAA
X-Change-ID: 20250203-quiet_tools-9a6ea9d65a19
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=N+TdL3KilayS4rRbQWLK74G3+DHz/OaIh9BFAsERWeg=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/q6BGMzp13l9kbP6i7tPBtgfEP7jKEat8aaz8/72Utvv
 1LZsSy4o5SFQYyLQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIlwbGNkeFDJ1KS3ZuONPxV1
 Gc+dMgMPTPvtWOlb6PJ39/RoNm8nQUaGm980TC2lch90aD+sPHuCfzbPa80kTdN4vXi19ImzZ7e
 xAwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The quiet infrastructure was moved out of Makefile.build to accomidate
the new syscall table generation scripts in perf. Syscall table
generation wanted to also be able to be quiet, so instead of again
copying the code to set the quiet variables, the code was moved into
Makefile.perf to be used globally. This was not the right solution. It
should have been moved even further upwards in the call chain.
Makefile.include is imported in many files so this seems like a proper
place to put it.

To: 

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Add back erroneously removed "silent=1" (Jiri)
- Link to v2: https://lore.kernel.org/r/20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com

Changes in v2:
- Fix spacing around Q= (Andrii)
- Link to v1: https://lore.kernel.org/r/20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com

---
Charlie Jenkins (2):
      tools: Unify top-level quiet infrastructure
      tools: Remove redundant quiet setup

 tools/arch/arm64/tools/Makefile           |  6 -----
 tools/bpf/Makefile                        |  6 -----
 tools/bpf/bpftool/Documentation/Makefile  |  6 -----
 tools/bpf/bpftool/Makefile                |  6 -----
 tools/bpf/resolve_btfids/Makefile         |  2 --
 tools/bpf/runqslower/Makefile             |  5 +---
 tools/build/Makefile                      |  8 +-----
 tools/lib/bpf/Makefile                    | 13 ----------
 tools/lib/perf/Makefile                   | 13 ----------
 tools/lib/thermal/Makefile                | 13 ----------
 tools/objtool/Makefile                    |  6 -----
 tools/perf/Makefile.perf                  | 41 -------------------------------
 tools/scripts/Makefile.include            | 30 ++++++++++++++++++++++
 tools/testing/selftests/bpf/Makefile.docs |  6 -----
 tools/testing/selftests/hid/Makefile      |  2 --
 tools/thermal/lib/Makefile                | 13 ----------
 tools/tracing/latency/Makefile            |  6 -----
 tools/tracing/rtla/Makefile               |  6 -----
 tools/verification/rv/Makefile            |  6 -----
 19 files changed, 32 insertions(+), 162 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250203-quiet_tools-9a6ea9d65a19
-- 
- Charlie


