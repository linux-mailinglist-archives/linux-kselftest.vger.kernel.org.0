Return-Path: <linux-kselftest+bounces-39923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD9B35652
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 10:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8051B62247
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 08:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9212F39D7;
	Tue, 26 Aug 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrkuHSuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F76286D40;
	Tue, 26 Aug 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195482; cv=none; b=MhabYbxUwE+G01Q5PW12bj895Ec2T6SmK/a3yDK+JJ+bbi9qF8Z94epE3KhqegNde5JveeCqYlWYMesXFwPCwivzT1A2Ac2mEGHYTDYnqDIp95a2GUDPyj80P9+0lFgQEWp/ZxANqhbJZfzgs7+UVGP6XLLgBQcBbwT1wb3jwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195482; c=relaxed/simple;
	bh=itapDEk7hJq4kaK5uNPmqncQ17jlID1ipjvCF53tqtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkCFROehRNv58W0qNSgLCiVXMZnf5R3AOBM9/k+VXiwpSaQ938LepzFlVO5R24nsw0u1PN2hUScDW3hIF6uiCfALJmevSsdOup+rK4NmKjBSCEST2ucJ7heHteVfFQakpVxd5aDxm/qOkuzg8fyH7Xf8VwzCoMg2X9O91+ipJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrkuHSuD; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so945236a12.0;
        Tue, 26 Aug 2025 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195480; x=1756800280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s45MwIcECjk3z7eF/b3NhXLy4QyYeWkCmtUvb4S3n/E=;
        b=RrkuHSuD2L5iMHvomiG8I4MbihdMMoGcskBWfLlpQb4xYXdBDgEM56TpRFxlLYeXoA
         UfRjihvrRkkhP2nbAOmr9AxK5XVQHs0C5j3QSsvxBraIDK59YVRkO3XZFm2cQO28GkOG
         JvLv2O+mrUs5YWfoWZyBxE7Y0Kj2pO7LP3Df06sclGjU0bOTuzpDfg1h/yvPEXkoHC+7
         6rPThyzlFQnk6PUouXKN14SLQ3o6PWiyeiSRVdaS4r8I+FNlTwx5y2lp8n8L5n7P+/Cu
         mFuFaRPqtP1naGkpQhP9v9GiBGKcDOVI/Nk0byeWyVXCoB6219UE37fHeRgkLBlFLI28
         5X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195480; x=1756800280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s45MwIcECjk3z7eF/b3NhXLy4QyYeWkCmtUvb4S3n/E=;
        b=ujmMhn0o/C0jyUfQARS+NEmudfVPd8J++VA7oREVeT/2HDJNG/qfkk5jM4LriwvUTS
         LzdvjoCHykru7fUxvwFtpt8hZBDc8TxJTxgPP1OmvHZbwSpSKc7EKVUT6Ls/Qx0grPYo
         BAI1Ywf8EJunRZfOXZ3eEWqVa2aKCFbpm9Fqwq3j4kpxoTD9RztUI3l+uePGTMqAsuQE
         /vAhJ+whRXCCYuzYpMHbV/WHRbwZtAQyA/dJJJBH6oBFCkDv/4AXPHDJN4f467FytNMp
         ks1Zoh+ZfvXNDhbSoOc4DDiuNobiGgiyPZU2VNxDZjkHVaYwa9gIkZ93ZhXFceZfeRTX
         Z+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV7leCSGcPVyICCcmkE7wwR3klZ2nbGCcK5RQkJ/iymQMfodFhiquKMmuv/TYLpz/LdKk9kwtAWgxNQoBcg@vger.kernel.org, AJvYcCWwQ9fBWaBDCCdbikIjPovbb6CrjiSZ279X9iWdNSglrVNOdHuKG1pFqu8R2GPU4vdiyhCBpzP0/HfU7FezsbYs@vger.kernel.org, AJvYcCXzPvNbw2F7dAHHoPRNWALtefz/YG+Vc4W+2Odffgz4y39mxvOCcBSeeSSiXsy760tEG7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85Z2u5X6f2AjNNksuT7cQ0Ma1b0zmT9QPHaUc/WFTe+3SZuDE
	Ck+9ajZhxBK0rbVJ4Y0zRnyH0jWU0RR/ZmKjn/PEJWWdGKIS9HjrY12k
X-Gm-Gg: ASbGnctsMSO96FlUxCsEnTDnjqu34LrC2hWkKbMlQsvRlpRmpUXhVfMUOaNrYqyjZlx
	LntorWDAHsqIF6kAB2cHSCnerWfDZtuZ4FXyBRQxDjWvqomdgcG2yaqDrtcr6VZZhe4x/gMOs3T
	jgSFMfWG7vuNO4GB3p1pt46qkqRSHAt9dVZzFAm1pr3e8ravJgkGO5Tgks3TXsnXTd0Tpzr/YNZ
	cvQCN4Gsps4pmyU7m41KoTyID0AjFVfQCwif1acnuDj67z/lYPlJJgeIUEb/G59PaJf2oTboO7K
	JR9FNrPtxl6wJoZdLcOIHFjyBbI98kvlbRdtQu0gvJxIGNcNqnBMUq+Bs3sCUf22NyLN5n4Piuh
	aWrc7dv7rDJahukT2RRgPLsg=
X-Google-Smtp-Source: AGHT+IEe8ChMYgHFU42b04PAkJGRSuKMS+QCz2VEjQBaASmKEPHX/xzTD+o+WlaFMWMHDrnuGq5G3w==
X-Received: by 2002:a17:903:1b0c:b0:240:6fc0:3421 with SMTP id d9443c01a7336-248753a27acmr8209325ad.3.1756195480458;
        Tue, 26 Aug 2025 01:04:40 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466888037fsm88829485ad.125.2025.08.26.01.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:04:39 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: benchmark all symbols for kprobe-multi
Date: Tue, 26 Aug 2025 16:04:27 +0800
Message-ID: <20250826080430.79043-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the benchmark testcase "kprobe-multi-all", which will hook all the
kernel functions during the testing.

This series is separated out from [1].

Changes since V1:
* introduce trace_blacklist instead of copy-pasting strcmp in the 2nd
  patch
* use fprintf() instead of printf() in 3rd patch

Link: https://lore.kernel.org/bpf/20250817024607.296117-1-dongml2@chinatelecom.cn/ [1]
Menglong Dong (3):
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: skip recursive functions for kprobe_multi
  selftests/bpf: add benchmark testing for kprobe-multi-all

 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_trigger.c      |  53 ++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +---------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 234 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 7 files changed, 311 insertions(+), 219 deletions(-)

-- 
2.51.0


