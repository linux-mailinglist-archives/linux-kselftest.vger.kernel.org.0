Return-Path: <linux-kselftest+bounces-47519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE6FCB96D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1EB3050586
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7752DE1FE;
	Fri, 12 Dec 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Meavvcpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D852D7D42
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559835; cv=none; b=tQ6rz4/gyvVbYZJjeYeJO50BzvwmGIqwy+4hiddnRNYmvJN8lQkNpdv2IwQFd3eGgGNYDNLdy24MqqLIHQOK6cjcO6a5N4SgdNPbuHylmob2IFKFkZtIOAVnUp2/hj6TBF65heWaFEwbNGk594TtQrNxPsT7q9neBK6Y+e6Stwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559835; c=relaxed/simple;
	bh=Nv/iP0PPlu7PYFQwI+jBPI8ffRylYj1zxIf1qEKb0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4iGJvtEEOl4BMeOru/JbKwtF0xt7kAM2vIjS+g1eRRZlWZqyOaod7H97w9Qw9TxkptgO7hdAOO0g8Fefex4xKAj2knC9vIOqe0VDgUgktdG1r2H6nsdeKZZoTE6ozDEDVRBZPdLVfxwdWSAkwbvW5xI9G29/vsgEswJ/u9ZHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Meavvcpz; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-644746e3793so230079d50.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=MeavvcpzqdlJMYBcwBc0mnEyFxzNxocWJ59dX4c95+WZtAYMrwyaMfcFPDGLZ/eihr
         NztHHNDgvIZHwPiJG5+voyiZvS+8wiJcvRefxEeXLlWwg9rUa6lOYQWlFR1FWiClNduq
         X6+KDRgimp3CDNNXi+/49G+P2xZLlDqz21ezUocPJnBAU63uSXVfK4lgA3lN53aaLZNL
         uo3QbCyoX2IZshopKy9Ta2PDr7VXuYL6/zKr6zexJ95tSHQbzdUhk2NX8/OxY4iDKnbb
         TyZW2K93zyRmf4ggx/sosAWNE2PmTrDTpEraeG5oZdYnFO5CeGN6Z60Iorwhcw5lUbKd
         M6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=BghuBlzWOe8IdS9yxW4MHpt7zY9iDUezAoMuSSYYY19ppeKHkjQn7J0ZlkQsP7Zleo
         fEG/OFRPcFQe6xHqRmYmrjBbagUnA07138LU7WaqV81OJqanOk9mb2khKOv2IPEXY/x8
         bvqyXt17TQ0kS/ydjj4fp1N3ZXwnSq8zJW3ZuFlQ7XxuBF5osRl4AV8r25FwLTM4E8f6
         izvoYeK39NTrcFuAv517vUuCC5zZW1t6yOEZgO5nk6kAWc+6efXfy0vK/4GHJsDgX2m7
         tROwwzUM6mv050eAC1y1iP3cMLLVKgsh8+dWViwa1Isz+0Fu/qGb+XWfq8mv2Tbofg/i
         eqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/cVOt4PStNZmTD0G7c9l8umAIp4Dl1oEtJUEtfyVcADpzpETsg1Bjzsb9q32KScvPekqNZnv5XFLVAoN/imc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdquYMcujG6PODsBg1ZJKxagFDCzkltatH9SlWFk/6GSLJDqw
	TzK3bM4+0j4Bhpsj3pRleGlNP/UQ/6eOYZ6Gep2FyiCeuDKmZVNooW+Xl8U2YKfEJ4Z8y2w9qyJ
	2LZ8pJ0V7fA9KYWUB+kS1Gmom/R61AYfG9kIr
X-Gm-Gg: AY/fxX5w6WTPISZ8HuTQtHousQd/7zJKxeISdLy7s4u3d41ORrgO1Y/zp/Fc3oeyVOI
	bg0dbvdA5D2cv+07XHMGiojO5lmYdzlgWWuKby28v8L8ggB7fH0wxeWyaHaaY47qtoIf0WSGLWm
	KLhSCaiEj0M4fvtt7iWciVuk/cQeDjFQF3GnI+tuvOflvMki97DZGHUTcTRr4WiOvVxIkSfsXQ4
	+xPlr41YpNiFtwDHER9Q6VkpI6eWbA48rc+gd0POtd2LRnrFx4Lm0WluwNsVaZsTaE1RSGadgTm
	YkHIQTm+S9yS/4qd8nkePodZ3Tr8qsmZvt1GIwGyKJQv3/mZg1uECtfLbaZz7wtFTFHUlwTu8mk
	l0q30W2QBpjItw/YXZIdVzoCNc7yj8CUv7ZHYvjTTJw==
X-Google-Smtp-Source: AGHT+IFNTxmApTgusf4sfYV5PLHTCIAoG4zUHXYTcGDGNqkjjCZbCxVmDORyUEFBYVQ5XE3L2oQUlxV8Yis8
X-Received: by 2002:a05:690e:13c2:b0:63f:88f9:357e with SMTP id 956f58d0204a3-64555505a93mr1715261d50.0.1765559830171;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78e6a405735sm2336147b3.15.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3D00C34050E;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3AB55E4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/9] selftests: ublk: correct last_rw map type in seq_io.bt
Date: Fri, 12 Dec 2025 10:17:00 -0700
Message-ID: <20251212171707.1876250-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last_rw map is initialized with a value of 0 but later assigned the
value args.sector + args.nr_sector, which has type sector_t = u64.
bpftrace complains about the type mismatch between int64 and uint64:
trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
        @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);

Cast the initial value to uint64 so bpftrace will load the program.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 272ac54c9d5f..507a3ca05abf 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,11 +2,11 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
 */
 BEGIN {
-	@last_rw[$1, str($2)] = 0;
+	@last_rw[$1, str($2)] = (uint64)0;
 }
 tracepoint:block:block_rq_complete
 {
 	$dev = $1;
 	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-- 
2.45.2


