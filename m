Return-Path: <linux-kselftest+bounces-38057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCAFB153A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A2718A8137
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E8270EA3;
	Tue, 29 Jul 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/KIx4UI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7B294A1B
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817850; cv=none; b=G73dpX9xFy1y4XyrKUY8pWehEExDNecbAWIKdcJF6XJnstdDB5iysorPFSfD0HeENFC/ZYdoO+Jq+8FtdHHG8qja1e98kPaRekPf/qanw34nMvOxhzTxIbgbcs7y6mrMblv8W2YY6w4quDQAuD58LyoiTpAiZIP+yt6Es7OQawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817850; c=relaxed/simple;
	bh=jhX5eow0ZtrlUzapU7IL/Q6GhPDQ4CJV2SBxgI99tOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTuit/tc/DB5vfYupUZuUQCNsabpkMRBDaNyZwD39jRaAhXKzseqNuCWBMFy9rVXmZgisVZJTac1tjgBgk1Ku984OuRSVuV+RSqKJM6OTYsiXAvbwNfgdxyeQcj/K4qcehypOMsAIgrShlLk80Grj+ibFGqRiKsPzJpMuCUmKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/KIx4UI; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-7074bad04efso4106696d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817848; x=1754422648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1I9IAjE7arvoHRD2CPgQ4vbTvzkjQYYPvGX27voj8U=;
        b=J/KIx4UIea1tUMPMWV9g/ZqgJ+4/7NZW7/mVyhzbAHVX+4kYvPUVV+0dRzw9CuG913
         Ieumr+GL6+fSSP6yv1Qi3iR4jHUNVC1rTyAqsjAwl8v5MLoVNRCMYoxm3hLS17bIaMNU
         vP2A35H+fjQrFWv2W8AXlXKMSpf8NYi2D4ixvLV5Bjqs2heEb7hD4/m9symv03v1YZt9
         y2lieE/YEHV5+EiM1Vh3Y4nTxOZhHkW2sPt3tGYpDU5vD32fo5npIkRyejSzbDEv6xlk
         MQWiPf1koQ5Pg9A0yC6PF+7owlc0EgQoFO8fWfqUBXNKTB2FzzGLUSGFvAD2yPnuuFwE
         nFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817848; x=1754422648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1I9IAjE7arvoHRD2CPgQ4vbTvzkjQYYPvGX27voj8U=;
        b=dpaXQNyeiv6U6xgSwTWLVaxIxJW2GLaLiXJISImHnEx0rMhNkesJT9C4e8eUC5MtBI
         231ZInTLQqb7uX+k6o6jlg4nT7dXhDAEaxTW1DMMYXSmA9sp/JlvloQcF+MWI6vxZvB8
         5iY/PZk9zWjtJ2JJ7Wzf2qL26FnAnZrtB5Hc5XqaZBE/5ZDltggSbDoyZHgOh1AUEP1c
         xnegBnlwZOX1U5guI9aa3cOomyzJGnBo96NE7RYsxhZVeMbQfRzIT+INPTrDUKlEjr32
         2wOB3NP221mByvAeIGKByN2+4D/36xGasJMLWHKbfNrF3G25gcbN1kV2s/j0c8LmYVlQ
         A3yA==
X-Forwarded-Encrypted: i=1; AJvYcCXbP88fUhLHC4jWhAryL2hqaWnC5Rf8ziEWx20ysONXp9ZgYfMbeCumLailOrvFN4B15y4srS+ztGQe3HGGe7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFhna4TmTuls8XRhqjwLjC1SmEJ3LzGyaWXRTFpZe0ZU7/SXO
	wJI/8Izbp03GmR8TtDRZBuTEzIA293fdPpiMG4TxloPm69qX/sgR2qVJ/ZXX116NPb2d1j3K6wC
	+AHZCxFtdsrZC5Q==
X-Google-Smtp-Source: AGHT+IHjdJ+C/GyichRcZO1+NLmayjPtkidhop6VuzgTrGXPN/gGzMzcDS6aLlPktjDxkrir6Ko3AJkF/wLcQQ==
X-Received: from qvsw1.prod.google.com ([2002:a05:6214:121:b0:6fd:5e45:e693])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ecc:0:b0:707:5046:6a1e with SMTP id 6a1803df08f44-70766139e40mr11981946d6.10.1753817844434;
 Tue, 29 Jul 2025 12:37:24 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:42 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-5-marievic@google.com>
Subject: [PATCH 4/9] kcsan: test: Update parameter generator to new signature
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch modifies `nthreads_gen_params` in kcsan_test.c
to accept an additional `struct kunit *test` argument.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index c2871180edcc..fc76648525ac 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
  * The thread counts are chosen to cover potentially interesting boundaries and
  * corner cases (2 to 5), and then stress the system with larger counts.
  */
-static const void *nthreads_gen_params(const void *prev, char *desc)
+static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
 {
 	long nthreads = (long)prev;
 
-- 
2.50.1.552.g942d659e1b-goog


