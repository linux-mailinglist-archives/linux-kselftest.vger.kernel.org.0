Return-Path: <linux-kselftest+bounces-28742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF3A5C24F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515771887527
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4FF1D7E26;
	Tue, 11 Mar 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJkL+yO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442C1D5ABA
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699113; cv=none; b=uFLOkfl2qF9j0UfcHs9B5y7T8mRIlbX/trE6mgn+XMPOjvUzkzkejlL8gzAvqxjEgewOyU2dYvmBr2NhDQH2qV+Ljwc8TBoNWFGmyXQdupkt8D91VsqxWobtiM1qoE5PI0UNo0yXPc50MkM92u/DxSfQqwoJglTxhQdcoV2AUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699113; c=relaxed/simple;
	bh=WQLjLeaas6WAwWHU6F3llD+u+5uqTYbAeh753X/DebM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSmJh8ykMwAx3VJraBD91NOh7nzHMjfPrBI7h28zNJKBCd9Qw6ayjZlyIlHI1CojoaWGay/nXVwzX+5B2JvjwZ2UNsdoK8x3AVbjqQ6FzvlU8aQOTdWpg/GTGPkvxKrIwgtzce5Nh4Y/vHn40nzG7SZSUFbfX6n/dGuWmDyMnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJkL+yO3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso27387615e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699110; x=1742303910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6JjfJOQBkddVu8mbUCQ3JSQzc9s8ZEC60spagx9Tws=;
        b=wJkL+yO3fIf93hkxRU4CwbWrCDY5tFDTWFNH6DBMUqPtX7rKwvOgdqCAngYBtCNlng
         //5MUduIipEG+b2DFVYOxnw0VBrABqm6/i3pe3da5sSdbssLKWKHedQ2GLcwyAznD1Lw
         LOjkPWj0d+EpmzVC4bSoEuA/xMzAQQ2K95WADFDbFIPQ+YFIH/guvc5vQvhrHSGhx5Dv
         efLIy4K0NukjDKXvA4nEKXGhd/Sbe5mDJQ6BFJzkuqVUtNB4Pnz3D4L/s4li+YHCMUhq
         bqSzsW7qQNSLlzkqf5AZO6j/VJCoCMvAyUJavYLrR3ZvTC7T8YuO9WyJFziS5jUa3Wgu
         s6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699110; x=1742303910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6JjfJOQBkddVu8mbUCQ3JSQzc9s8ZEC60spagx9Tws=;
        b=FZ8SbKi94oRiTx8EWUuaJ2Hn4ZmAlPb6xja52CIuvAPrh/NUUvT3XFDXgs86M+PCKb
         nOIQ9lFROIiiXEoCb++GqMJCp/4gUBVvHow+INnBvlfycuaKhsL3o5lI2iFeNV4UCA9Q
         2+shDZE/EIw1pvZGKKDg5bNI9wF1/J9rkT1Q6m7NEkiXBBj6YTCqaEIh8xgTybjcnt4c
         dGXP4Ah4Btj0/v9cBawlmBDRR0PPu76kaJhi/KEY3VYPsCtjq3lXVKtRIHVy7uz1n7qo
         iUqAuvXd3+RudqXLBP8P8ABmAdYAnYU/ErqxzltUPDoVJ6qFI/fZkEYwoyg+e0s0lLgp
         d6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUGSoDxLGby5a7/pV0DEX0wu6fzt+GKmME62mZRoUmWJUKNvoRM1I5caqDTSwC+KUkAu9/vmdhUxJ251wm2Rbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U3fjyRclZV6ySH1CInnSKgb32YdFGbCPQ3e5/sBkDfvlPa6e
	LcaDyki4xhRgNjiUOKeG/Duugs7WhQgTNfCFdu/lwKXDmaSU7lYu1hQkGFD0CVgorDCYakgReo1
	IfoWNfH8aNA==
X-Google-Smtp-Source: AGHT+IEIWvgrPAdW1aYeAn80KnMmveyrFiqXf2KEYlIp8fmgFPw+5h8vHeMIpGYZnJb/sky5I2oxhtfkiMAT0Q==
X-Received: from wmbbe8.prod.google.com ([2002:a05:600c:1e88:b0:43c:faa1:bb58])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4316:b0:43c:e70d:44f9 with SMTP id 5b1f17b1804b1-43ce70d46f4mr104149745e9.18.1741699110016;
 Tue, 11 Mar 2025 06:18:30 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:17 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-6-dec210a658f5@google.com>
Subject: [PATCH v4 06/12] selftests/mm: Don't fail uffd-stress if too many CPUs
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="utf-8"

This calculation divides a fixed parameter by an environment-dependent
parameter i.e. the number of CPUs.

The simple way to avoid machine-specific failures here is to just put a
cap on the max value of the latter.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 4ba5bf13a0108435ce8b53340b9e17ccd47e859e..40af7f67c4074d901be6608e5d64bd0490026dae 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -435,6 +435,7 @@ static void sigalrm(int sig)
 
 int main(int argc, char **argv)
 {
+	unsigned long nr_cpus;
 	size_t bytes;
 
 	if (argc < 4)
@@ -453,7 +454,15 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	nr_parallel = sysconf(_SC_NPROCESSORS_ONLN);
+	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus > 32) {
+		/* Don't let calculation below go to zero. */
+		ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
+			       nr_cpus);
+		nr_parallel = 32;
+	} else {
+		nr_parallel = nr_cpus;
+	}
 
 	nr_pages_per_cpu = bytes / page_size / nr_parallel;
 	if (!nr_pages_per_cpu) {

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


