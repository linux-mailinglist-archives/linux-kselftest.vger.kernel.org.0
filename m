Return-Path: <linux-kselftest+bounces-40721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2EB42F5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 04:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8F05E12DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE441D63C2;
	Thu,  4 Sep 2025 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea20puSw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A519DFA2;
	Thu,  4 Sep 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951823; cv=none; b=X0NYMyYjmwTnoN5236ZZ8y5HSaxk2kHzabQ7Wr/J9oaeiH/cM2SVWJsQ5BIFzXRrP7TvZBfv5jCpusNwl/wNqNi3h1/rG2N8dv2NnkdCsA3aXOImluCtlRz6RpDA4XaoN9wx1d5lcvshgNYKSznSsSoTfCEUoCMq1MmzV9jefSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951823; c=relaxed/simple;
	bh=eVDJfS2vmBwBj0ehU+kXujnjMgfdwYhD36j7tAij5nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQSQApx9qJ1qKJTmf75qD0oYwWaxHDAKpbcH7XMH+s9WKhlUcVA6bBkbmEhav195/baxS2J8zsgpI7alauTdaXyFop7f4te/pbVqPK8WVmqXeUWfeuTyOV8O4oK3HumyrjubHGHjuQed9uMUBOC/N4YbmJZjVHflieM7RvRpnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea20puSw; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77281ea2dc7so472947b3a.2;
        Wed, 03 Sep 2025 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756951821; x=1757556621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkUmNTikddeYTMML9G3HM9oCIw6tu9oOLJ0SSZ6TK2o=;
        b=Ea20puSwKnLEBIwx6mTz7SFghIiaP/va/qNI0NAzpsGiBUjv4T77N3XMC7Eq9XHaAZ
         0cRzPPJJgsFgmmNAktVaYSFmlqFWs/Im91LK9auFA8CxHJg3YnpPvGd1yFPuhoyjP0jH
         wLGokVj0kxkBMRh13wKKex4FpYvu3/limXTmp372KYCIw5iwEQBPRehBxRjCmfFszTU+
         sM18cZnwbOjV2jCY1YxC9LywIiYpEgg1N61ArDoaa7cSZyqmK6LhgnvnTpCMu7DQJl6F
         f9DyHLTr0k6l9No4gEj0edUd8MWhpSyiK5iocE1/qenjH3ixNkn2xfJsDJRL5y7Bm0dK
         WBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756951821; x=1757556621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkUmNTikddeYTMML9G3HM9oCIw6tu9oOLJ0SSZ6TK2o=;
        b=od7Gjbt+bwlbeWAT3+iDAgCS1OQlmxG4oHpx8PDIqzMvogNrCzoIy8m+ZPJy/tcX5O
         765Cvr/3fHrJb1O8D7FbEgv/6D/IQK7MAI7wiAb6ELBpRcdmkszcuUgFF/rwNI7M0PQU
         DvYuvu3RzNVp1jumwmJKhrYL46VbUbnBd6ojlkEHNacBF3CeMOagRgcNUZcvBTZG4Gja
         563Ls04VdgIjRgZRyAWkOkbEZQoRGRfj2reWv5QtEe3EyusY2KVnhpy5esYIo31en0Fd
         2qBLzHg1lwnjUxNHpmJpJxaWMJnuNO/HeSrH2sbOdIRyTRivOQFBj4HxIhF47cVMchfH
         gsbA==
X-Forwarded-Encrypted: i=1; AJvYcCVB4BBiqxjDTk2K6ilQwi33nXdp0RIMxiyT0OqQy1i6WD1QLCxncS5LDqr6JADsSSzmLpUGi8b5rzymGxat@vger.kernel.org, AJvYcCWbWbPrO1hoNhJ0nA+M3DwNif+l0eGNxix23RLFsyFzW3L4HdnJy5sS4F9qkPsERS2gCr2mq/95h9059CIYTZf/@vger.kernel.org, AJvYcCXdtMc5tQvVtcaCQohSmP9f0IzZBkpM1rbZiAJEjmAaBfEY2P2yu6kQfe3AFOVKoAi+Dsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLIVmxbmDnr/0bFTrMYkdg2iwISEcmFgcjj4nC7669TRcOszp
	2ac1Ww9zEkycsJDmvWQEl1XCpb7A7f5OdQ46urrI+hrD+UWMTKRWKjQ2
X-Gm-Gg: ASbGncsXhluiUWaFbBG50JLihrl3nQRsKs6IHosTcWu7HLs6yQAxo9BUca2/TzEwkfB
	5IrThMH76AtTb4PGi+zPZA8O+1yuTH/nSdtlLt47UJjCfpFnjuX61miC7gkLa84uYgXnQlqRON/
	seVBm/uTOPrvatN+gXEz1YgmvbYm8Qc6+Num8HR+YaxXw1JFl/19RgpZBTfzX33ix0Mfmlve+GA
	PzJaJviC6r9MSl3eTau67It0rh54xlxIU3DwuEFsp2xKvTm7+oNT+gyYln/zZ3B/BD4/WB9MfMZ
	VKtdVus+uFpu/11zwt4wgBfBBeISH9YbzMoXSrt77JXZkSfU0oA5uey2P6jsNKNVOL9NhtZPCaz
	kQHN0hsU5wG1Yt+8BfBNdNRkzP31dEOOtwsQMndos/EIB
X-Google-Smtp-Source: AGHT+IEyBn4BCZCibAuW4TNxDMV3C46peZ4KvWPoQudYzoj5KUtWqziKxoxGJljNQbxWKBAkLAwuKw==
X-Received: by 2002:a05:6a20:7fa0:b0:243:9845:4137 with SMTP id adf61e73a8af0-243d6e5b2edmr25172776637.26.1756951820856;
        Wed, 03 Sep 2025 19:10:20 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727822817asm5143014b3a.98.2025.09.03.19.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:10:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	olsajiri@gmail.com
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
Subject: [PATCH RESEND bpf-next v3 0/3] selftests/bpf: benchmark all symbols for kprobe-multi
Date: Thu,  4 Sep 2025 10:10:08 +0800
Message-ID: <20250904021011.14069-1-dongml2@chinatelecom.cn>
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

Changes since V2:
* add some comment to attach_ksyms_all, which notes that don't run the
  testing on a debug kernel

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
 .../selftests/bpf/benchs/bench_trigger.c      |  61 +++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +---------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 234 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 7 files changed, 319 insertions(+), 219 deletions(-)

-- 
2.51.0


