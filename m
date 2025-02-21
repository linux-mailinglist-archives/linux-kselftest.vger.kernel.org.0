Return-Path: <linux-kselftest+bounces-27218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0CA3FEC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFBA42253E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5E254B01;
	Fri, 21 Feb 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TalJd2Ez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89325290B
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162368; cv=none; b=U+CE473NnoEiq0GoKpjR5ffnNhemOXsHDcbeqTNj+a1HcRsTXok0mcMWoNtk69F6tn0vwUlcVXLEJOJTT4F3RH53yexkq/YBZTxTt4eavo9sO/Mk0d+PTWkVNf4N6eS3PPLD/fvAx+l0VJyTDZACNWcFhMHT+CR4fiEKPEpp8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162368; c=relaxed/simple;
	bh=uRBelfvaEdQdCkhdUYmMVXt6DODojaVENI1CAnkwNhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YwX9CCd3/ZJaDKrjWFKZ2EFN1mKTU7QDKI6J9fGv/BY+d6S7YzrUTZqoaSX3+peqsNkyFHssX+eks+kBp1mLwTNfyWbCEmsJG6R12wpKCMbpTqXUG2n5xu86kyVuzOBfUKjs4xR+e5nk9oMqinaWaeKgrOnoytXJwvej64mYG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TalJd2Ez; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso1778356f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162365; x=1740767165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2e7w9nwzCjzPZWGspc8NxDnIM4geLXbTYJr2yLaA18Q=;
        b=TalJd2EzeNeJTKsnPTE2/02Pr2LR7lCOH4QL9WvF0uUV86muqHQt3DUp78pF6HWguh
         E3CMTNLn/bEg4cnq1dlihaKpFQBZ3F+jv44sK7SFYlaPv8hN5DG6gaT0OaMBnoTzYSNt
         YV+tyD7e8HBqLEWG0/x5KgOvJo5pjBdQ8smP2Pved+bIG/kVlMK9Y6oP86PbugVqP1YH
         UA/m9tskXQDQMx8hC80M6ehCUHKoulyq/O6vfN5s9z5x3dj4C9TOmcFe7ErNluSBjTFN
         0EypmFzua0WBvP6CqkZQWyN+k+4oFCcBgJVP8H+ijE7ToBZWZMlrBa2xWenEWQ5a6WIi
         2HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162365; x=1740767165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e7w9nwzCjzPZWGspc8NxDnIM4geLXbTYJr2yLaA18Q=;
        b=D/ghSl9gLSPQsCyvuG+OANfonSgwb24edgCJtoiaX2dYEXzx0XO5Kw5LCT2hlwrJYl
         WqxrfcWLfnV+9tpwKABMVYhOswbgfbh6/CF/ORcNawHBU4h2FNqbsz7Z/+WfYt9JP/WA
         1b2CEEY4jewgV71+jASJxSSaixQm8+3dPBR8vFx2dVeQXdVNJOOTU37BvmDxOa+kfjpb
         Nx5o2PnNfwEZ30eub1PdE93Pc5jgMHDBOKdMQl/M+G+ugVAtsp0mmR/PK2MqCW92f10V
         MaerGD0vvjdUik+c/1Efxl+YGgi1vmUea+DUzYjej+Hyo8+TIUhoxEp8ueyUWMfdB3MQ
         o2UA==
X-Forwarded-Encrypted: i=1; AJvYcCVNAq3Wmio1VlIZd7nCqFfNFEClfRbrus5sMfbmclaRPR+f5OU5lwTZ1qFudSBTlgkoBmhxjV2RYdy3AGyZNI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5v/TPbtsCFb/KRFxJOD8q0/KrwZHPhNW1XN8+b7EjuWF81Ek8
	68582nIRZO8oBcdZVsVhmGgY0Mj+D4yQPAMJSQBTygQUxxJ4X6FV0n0Rl+tKTaj12NYW9ObzLvY
	0U1R7+kbbLg==
X-Google-Smtp-Source: AGHT+IHKAN4X1WE6vOVXmZ8oqu4LMSySVfvQR6MA9h9oN5ISJfTl+vRicPSeLj0ewNqzdhKSvvV9TtuuixKmEw==
X-Received: from wmbay18.prod.google.com ([2002:a05:600c:1e12:b0:439:7e67:ca7b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6486:0:b0:38d:dffc:c14f with SMTP id ffacd0b85a97d-38f6149915fmr7561482f8f.1.1740162365263;
 Fri, 21 Feb 2025 10:26:05 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:48 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-9-28c4d66383c5@google.com>
Subject: [PATCH v2 9/9] selftests/mm: Skip gup_longerm tests on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Some filesystems don't support funtract()ing unlinked files. They return
ENOENT. In that case, skip the test.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 879e9e4e8cce8127656fabe098abf7db5f6c5e23..d2c33dd9da9cd43cc6666e5d9ffd3ff9e62dbb27 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -96,7 +96,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	int ret;
 
 	if (ftruncate(fd, size)) {
-		ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		if (errno == ENOENT) {
+			/*
+			 * This can happen if the file has been unlinked and the
+			 * filesystem doesn't support truncating unlinked files.
+			 */
+			ksft_test_result_skip("ftruncate() failed with ENOENT");
+		} else {
+			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		}
 		return;
 	}
 

-- 
2.48.1.601.g30ceb7b040-goog


