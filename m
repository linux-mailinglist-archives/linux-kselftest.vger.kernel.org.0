Return-Path: <linux-kselftest+bounces-20707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887509B1155
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5761C21D31
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350F2161E4;
	Fri, 25 Oct 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiQzOasf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78BE215C57;
	Fri, 25 Oct 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890252; cv=none; b=W0vfnNGsW41s3yk2kDQF8XQANaP+t00cJub0gT1WI8H17gnuiTUu7R1cnIhlqP0vkxlqwM2sKvhZaUoiTPOwAxmrhjkINBOdr+QUgWnRvsg8+0c5aJgINmkANLsOCVnpMWW6E8EY3XjOtMRdyPcWUd4lnyj+ZGBieXiR/FeEwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890252; c=relaxed/simple;
	bh=Jxmn0a09bYemFLfrW2DTbbdvDTTlIeGxQHPWXzKjUSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q64Fsgd3mkBV0xUHsR55h+l/xcRmiXqZmidfRuXc0qP5Qn5KKv/jtLBZS5QB8zRsfTePMLnJPpyZvovAGBwyw43fwyvj/D2WaGwxRnPh2JBJZl3IsVNcZD/xO6TJs0XVdb//mZNlOVOvFGR2Ls9OAnfrmaEDlE8R/DGtRBOD05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiQzOasf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b14554468fso159820785a.1;
        Fri, 25 Oct 2024 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729890249; x=1730495049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb+dSAVB+gCBHU4Z6scAiWCZx92W1Nb8NhAE30zLAkM=;
        b=JiQzOasf6EipJ4xJfia0O2hAWkV7vTKn7G70D/GrGgY91HxkiuKV6PGl2n+lu1OIM9
         4j6v2pAS30kEn2KbrmJ0VC212L4Yl7yc0j3FQUIcwHZ4K2f/wlcgztAHo4ESHKlhHXnh
         lGQcTrv1JR7iTN/ojd23Pq4Gev616c9CvHMca5MpfQdJ9A9UScM0X25o7Ia9xeFxPDhe
         gXlvr/h7zMNQjZUHBg4TBTHHNOCJychal3qe1SbX6008aexqMig2aZDLqxeSIXZmA/5S
         2RBEaOSiigR6LsjvvsIQnxJ0TWvbOK3Atqtot6scf6YPGLP2BKXNFGMZ2oVF1Lsguvom
         Vwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890249; x=1730495049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb+dSAVB+gCBHU4Z6scAiWCZx92W1Nb8NhAE30zLAkM=;
        b=Q3bnstIP0Sl5xnIhsU1vom5u6deOQArTKS0S+3gb+AAsDM/tKWlGom4s6KW64f3CFC
         3HKSZg96SeC+9QsRGN1TZT8m/z+/0XHlsag7FW2846wZvb2bNQLhdcuDj3URPgJDtqjJ
         8Hale+MBjSjo/ne6Pp8S1wLm9OqNOhuCt49Dmp4ScU8OAb9OcF65iReSyFL68hG3cWBe
         LzDAdAgY4mDoWjR6RXMravMM2xWYKt7c2uouUxHpSaxW2A2ZOx7E07zMya8P7nn9H+Zh
         exoc7K2/VIXncTWR37LZUEjxH+QJn0C8Bpuam+y/Q57zreXSahlrm1IyoRlEwzOU26Z0
         xzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN+ve1QkvTtZlxU1cF4RxjWte1wpbEeBuVqFTnt+LpqGiEgDPucVI7gzSNwPwz2HZxXS5FkuX6XcMHAik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3T5xoPtJBlaiGhc5xS7XT1J5mhsopaw8YtLZwTS0P+slp5oj
	rt2NDP8flB9kuIvow/t41epHIupBPVck1UJ4zJyLqrLrw66yppGp
X-Google-Smtp-Source: AGHT+IH8L9/0rtobajUBOw2/btZFyeZko50tCrA6wcjD0N//1LtgZ+aaGCaBb9AmvrXomIZNNeEv3w==
X-Received: by 2002:a05:620a:2a06:b0:7b1:4fab:9fc2 with SMTP id af79cd13be357-7b193f38665mr101477185a.50.1729890249551;
        Fri, 25 Oct 2024 14:04:09 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa (pool-100-37-170-231.nycmny.fios.verizon.net. [100.37.170.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27be4csm91036185a.15.2024.10.25.14.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:04:08 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Oct 2024 17:03:53 -0400
Subject: [PATCH 1/2] kunit: add fallback for os.sched_getaffinity
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-kunit-qemu-accel-macos-v1-1-2f30c26192d4@gmail.com>
References: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
In-Reply-To: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Python 3.13 added os.process_cpu_count as a cross-platform alternative
for the Linux-only os.sched_getaffinity. Use it when it's available and
provide a fallback when it's not.

This allows kunit to run on macOS.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 tools/testing/kunit/kunit.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bc74088c458aee20b1a21fdeb9f3cb01ab20fec4..3a8cbb868ac559f68d047e38be92f7c64a3314ea 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -303,7 +303,16 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
 	return list(map(massage_arg, argv))
 
 def get_default_jobs() -> int:
-	return len(os.sched_getaffinity(0))
+	if sys.version_info >= (3, 13):
+		if (ncpu := os.process_cpu_count()) is not None:
+			return ncpu
+		raise RuntimeError("os.process_cpu_count() returned None")
+	 # See https://github.com/python/cpython/blob/b61fece/Lib/os.py#L1175-L1186.
+	if sys.platform != "darwin":
+		return len(os.sched_getaffinity(0))
+	if (ncpu := os.cpu_count()) is not None:
+		return ncpu
+	raise RuntimeError("os.cpu_count() returned None")
 
 def add_common_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--build_dir',

-- 
2.47.0


