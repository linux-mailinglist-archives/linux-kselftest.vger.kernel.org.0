Return-Path: <linux-kselftest+bounces-20834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F889B3A28
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4C31F22622
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B391E1C34;
	Mon, 28 Oct 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrwARFaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D881E1A2D;
	Mon, 28 Oct 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142549; cv=none; b=bvOnPPiOSSj+CKeBZJWZsrFwtUwP/CgBzFzAkokvDSUDlGcjXask7Nm5YgAjNj5ZilPbcvy8Tl+HtUfcgu/eXYcf0NICCBm3aFUSr4r0/Os2DQ1WFMtV2zv5HyYDpWBoSX77MDZLksdO1ctkB1Fx8ZVfID+Je1AMCGn9+pDBacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142549; c=relaxed/simple;
	bh=dDq6kphTgCW2WMRnN/jFCBhC/kVZkBsOe/mTYXc0bJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJLWLwEwz72DfzJ7WpCcYDEph2wNEmzVgy4IveWr/s79a07MTW4XaR+GoxzFO/KXGb8pnX1I/pWvtC3UqYtnpf68qwGGascSx7OPZF/pDYRzfyOxBbuGTPsdi+tqqrUKZ3GwLELPbqZiwLcDbjSLPQYHq8ffvmWADruxwd4V5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrwARFaH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so3165044f8f.1;
        Mon, 28 Oct 2024 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730142546; x=1730747346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T57U1br5OER9E6JOMq37nd4OrpRSXTFt3KvDpfzt6r0=;
        b=PrwARFaHKpiQ+ToPTt9M7hjqvBDjrQXSsBUMilr81oPBv6DXP7yQTAzMCV9xKUhvOF
         arvskKoT0bm/GlW4JHV2KWYyubD+JswQWyrF6grnaci161VthOn4TvXINrGEVMcZvkdO
         jp8lpcCKHmvVPRAusssnTUCPkBOEv8Ntgcd8tNqZHrga/Oc0mM2RlpVtNaHyGuHgWKNU
         5oK9WHojiuqk3UrMHaWPUBjdQrUZd97udu/zYgcJdMkT//aWrnH2no+muNkxa5GBcvb9
         ajz/eWSbe4wXASvsBVf34yZaZoZBGdP6Vo6Yux3y3kRpQhSHBOie06gkQt1g6rv88ctc
         3OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142546; x=1730747346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T57U1br5OER9E6JOMq37nd4OrpRSXTFt3KvDpfzt6r0=;
        b=aiYLocIAT2woZyQ0OTl90qQdO+pH4i5rgpHeCGP3A1GSFDzPdGfWta2PvHnI/gaFhT
         ot5EZLQEUDbNqqQ2tPGLzk9ZEHgWpUFEbACVVZ8bCDHpBMozpdFSlqBiSNLcmNvFFYa/
         J9qclSaOnN27bUgTcGVob1pOZ9OvEcUynsNzOJ2/oOb9G5DWlHrtL0xKrXnvKUutMHgc
         BFiessmFhKzJtt4YUfFygvYYnDHDhU/M/Mf5wpXHPG7I5vorh0modFtmyMgmzf+VCjzP
         ICQTumbXXsPe4o7IwmxtH33pmcQbc8HcQTt4N6YVJvcW00EYJAp21iYsytMUjpNz2kuh
         4Glw==
X-Forwarded-Encrypted: i=1; AJvYcCX0yIdVJPWW14nBsmp/MNa1771Oq9pgkY76Wsu8IxhZ00AWVRj2Zpx2U7eZGi0QaVns7O162D4tCdBTtAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2/T06C0LRqqZsElui7UzQQAcgzeXai4uqPA09aAQupMHQEHh
	89thLGWtFTzw/N5t6BwznRFoZSZt2r+ELHrw2C2PjmdK6N7xseFuo2S3lfT7
X-Google-Smtp-Source: AGHT+IHhCMAEgqQCGgxaB6xQiFxHeIC+H4kR3eiAZF+NqG8A2ReHuhJCJJvRcwN/emnyiIHC7Bm0Lw==
X-Received: by 2002:a5d:6083:0:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-380610f2575mr6772285f8f.3.1730142545872;
        Mon, 28 Oct 2024 12:09:05 -0700 (PDT)
Received: from localhost.localdomain ([78.210.79.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c69esm10314398f8f.13.2024.10.28.12.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:09:05 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Alessandro Zanni <alessandro.zanni87@gmail.com>
Subject: [PATCH 2/2] selftests/intel_pstate: cpupower command not found
Date: Mon, 28 Oct 2024 20:08:44 +0100
Message-ID: <cc01753c8dab0f33669a5a0fc162544078055bd1.1730141362.git.alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730141362.git.alessandro.zanni87@gmail.com>
References: <cover.1730141362.git.alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make kselftest TARGETS=intel_pstate" results in the
following errors:
- ./run.sh: line 89: cpupower: command not found
- ./run.sh: line 91: cpupower: command not found
if the cpupower is not installed.

Since the test depends on cpupower, this patch stops the test if the
cpupower is not installed.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index 0c1b6c1308a4..6a3b8503264e 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -44,6 +44,11 @@ if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
     exit $ksft_skip
 fi
 
+if ! command -v cpupower &> /dev/null; then
+	echo $msg cpupower could not be found, please install it >&2
+	exit $ksft_skip
+fi
+
 max_cpus=$(($(nproc)-1))
 
 function run_test () {
-- 
2.43.0


