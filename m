Return-Path: <linux-kselftest+bounces-21339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB79B9FE5
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F46C1C20BB7
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C228189BA8;
	Sat,  2 Nov 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGpnJqU9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204C189917;
	Sat,  2 Nov 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730549409; cv=none; b=cswGvNJFOTdzoINUkWFlrde8HFcqVlvRelCZpQ8PTFjv3EpCiEIVKba12nOsrA+zvRrpcP7SU51bmGzcixdjhUrsRU7jXDakmQcyvESPEtaH2Aoe0QuwQgws4LHFZIvoxkidgYC+QB00Z2CkIakEN3BGeeKq2q9V2BY0N0fztS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730549409; c=relaxed/simple;
	bh=Jxmn0a09bYemFLfrW2DTbbdvDTTlIeGxQHPWXzKjUSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiZvK1FDpW5ufxcAKLZJsijDG+vO0dsz9leeRLmu0xoyQmcl2KMEsl7v5DBURRs7kUZOjRZ1np0cDLUPTgpOdPMiauHsclWBEPRzV+Sy4n2cNF5xhIQhpabEKmFZMIEwHgFljU/YEJwqweAAkNgI0lywJduPOPgmzbSwdGEOdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGpnJqU9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e29327636f3so2477636276.2;
        Sat, 02 Nov 2024 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730549407; x=1731154207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb+dSAVB+gCBHU4Z6scAiWCZx92W1Nb8NhAE30zLAkM=;
        b=lGpnJqU9TuzL67L6MHvKe9nBtBlpF8Y75yFdQxZBgxflf7KxbU+9AQzmN7a5TiHoYN
         p6s/Bsx/exti2USX2R9zPkHRqqO5VMThhnG02tS2I/7Ivs9Tu/IyAO/8cVt16CMoWqFU
         D/rHK7oexFcggEWXP9XVfXfcDx3ZCg8GQeHwJF59hdesl/wRYxMbHcWZ90FNo/00mEwi
         YvrJk/Fh+HlWXMRNw3nUdNBTxpbm/ZkcBNOadxoQoICp9wgwjY7VO+yj7C7M7fLLhRIC
         sDPeoWQR/bnAgD1VrvYXcEMoXxzNSXcLWpr46Dt+GEZmLWmMK/POMukC+pxRJ5qJoX4R
         IaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730549407; x=1731154207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb+dSAVB+gCBHU4Z6scAiWCZx92W1Nb8NhAE30zLAkM=;
        b=SA529Oh6zlBaHpjM+Oc8Pxn7QnvJiVDC/dxLPya8tRmaKBUE2UrgDC5TS9HOAB6d3O
         ptDTOaoupWbsYaYv5iM44enbfIIeX8YwuvQsLMGNXC/h/N8BTZOf3VuZQDhcptlSW4zI
         LPhrqcbitDntzcVEZVJfIjsxfEQUrzy7IicchNyBeZGW23s07sgKZ1QCkHLvNysbthys
         zf5XbVtnZ28PISvdGv4n06IXn/7CqREB8zntJLWC592ogGa7p1Pw1TAAWFzgaMsGfHoU
         OilomGn7oOQ5qiJCtifbJb8qEymuSWsvKwPz0u0IidE82ciVZ4q1qe5I06jvEGpFrym1
         TbMg==
X-Forwarded-Encrypted: i=1; AJvYcCUbg9JwFUJkAVBhZ9rFWq8h92BwnGwLtZUVL5ZWrDG/J6k1VRWMSe8z7Jue0UiG21Nr4AFvQaF+3oL6wEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoEptMhShZfRTUzHCltABmxrqPiYwiTKOHdD2dU7sZP1H6BXIM
	WkyF/hszMBma5KwzUBjmEksbNFBo3M/FE45ItCRIN7Vm/z2p7ChVw+rhYxYWTGI=
X-Google-Smtp-Source: AGHT+IHdhIcg50hxTMTYzx99Cj+1BVVYgg7b6c4dyjvRiID1ZrUxyMBWCstlqfkomK0dbaArl5v1IQ==
X-Received: by 2002:a05:6902:18d4:b0:e30:df1f:8926 with SMTP id 3f1490d57ef6-e3302540d2emr6246182276.12.1730549406715;
        Sat, 02 Nov 2024 05:10:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (186-189-35-150.setardsl.aw. [186.189.35.150])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8adf9ecsm1139393276.59.2024.11.02.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:10:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 02 Nov 2024 08:09:48 -0400
Subject: [PATCH v2 1/2] kunit: add fallback for os.sched_getaffinity
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-kunit-qemu-accel-macos-v2-1-9d4579fddd20@gmail.com>
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
In-Reply-To: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Alyssa Ross <hi@alyssa.is>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
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


