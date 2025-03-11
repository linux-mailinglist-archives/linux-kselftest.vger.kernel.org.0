Return-Path: <linux-kselftest+bounces-28744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93609A5C253
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514A23B2486
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7E254875;
	Tue, 11 Mar 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yu471ND5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FE2222BD
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699117; cv=none; b=nCLaUjAuf5lEWsMa0SQ4aeovvp7FteOmtAFN0G4J95BDCv7wtj78+KtG+ZJl1867cmvy2mt0ojQ8BAuQy9t0SvbE1Hv2mteIZDejn8vsfspoNOdWFvthZmAklOIY0mjY9mIClA0wMK/pE5CPbsBusdlhlEtHAGJOaAn7DuFJtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699117; c=relaxed/simple;
	bh=0ffvNk6pyNEvDSJ71JGiz95WEqGo3Pzu7Vx603nXPak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Da94of0uo1eLjB5KQt70zmEaf/29txrscNSQPswrzb6o17x0UD4wMqU1RzwWLLilDvOzeseS6haAQbMGdnVgn4lEneMEeodQfUxuvDnBQdF48DGzklZLN83UauoPqd0e3CrLj5ZXNPVAReiTUoATX8p4DLtL5PFJ6w/joSldYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yu471ND5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so38647005e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699114; x=1742303914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEpPGTTI1xwsz2Fyvp18/EwqSXfTpjR75q3+Kl9ryQ0=;
        b=yu471ND5enBTBqHrJbxY8o/M7TppQgg9d+D0V12Zxwykl9xD1ialBSGin3kbi5NWpd
         2b23svAeQEQY/mP1iC1+pahEfXx/nvQUHMnK+A0gquSZwGApqdNXkbmW88P1qmHJhbw4
         uGTtn1MNsoS5GGwlfPVxJO49kirfmqg9/3hTVTbeCfsFsaSUYiYmJ21EpS2ikFg0a7+9
         mlssHdfiimWgVZNzWf8Uv2QxYhmt6T6CvkczgNFacudosMfBLVlopW+6SuJCznZJ8ZwV
         oP/6rKQdZnhE2oqTJsnhv8qkJq6wAl/I8eL6ie8eIACrvrYd2Q+83gdmoY9yUX4h6pDm
         j/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699114; x=1742303914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEpPGTTI1xwsz2Fyvp18/EwqSXfTpjR75q3+Kl9ryQ0=;
        b=lgqBjthPQDu9QB1HeZwar1SsGe67T6pSZbZpWXnpg86/nBm8DojWXTTwr56nFzP3Nv
         oR/hVwNDW/TWtqMN2CKRLplbIYO0Y2zzsxxJNyFenfRlR7HKsCtvIJC4AHOiTSCQmsC3
         LFJErHTOZ9pxNB3Onx1nWZY04eqSBet/JOTDjEo9Gm3OrgFdUTi/VW/UrdWoB16f4viT
         any6+cQQHHKADrKRshDtvy1X2kDsTLhB18nbCaMiQSL9nlgmPg+dyK+xE/4BVWrDAxD4
         J4/3gP7NhY4Br3pUOCalyoieGF4eA9oAzwGdnPoMYg9p4dYfP9QgQZNaeZFgmqk2XsRX
         FY2A==
X-Forwarded-Encrypted: i=1; AJvYcCWy5XnHT9/E0LMvuufBtO/ICH4S0YTWklVv0z3eMYzkdE/gQ+nQEfv/VSYKOxZwdty1wv5PODtvt1sIDwZWl6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyarUFJWj+qQJ9d/BIRNWyEcdcY8C6sw++6j+sayqdmtl786eM
	lwEPkHLDqIWuWCzKUl+qN85tlwqaVL8FHEg4Nn5TdNX4K7BuS47R5voxAIxAoVnqUTT4rC7Y9yC
	gASzk4AckhA==
X-Google-Smtp-Source: AGHT+IF4wKnonit+EpSv5UW7OYNEJNWqpKGUxuJH1HQv+WZ5yf0iB3xBzk58+Z6A+0FjREeEmIvwD2nZ9cCRYA==
X-Received: from wmgg10.prod.google.com ([2002:a05:600d:a:b0:43d:10b:2c42])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1547:b0:43c:fceb:91f with SMTP id 5b1f17b1804b1-43cfceb0aedmr83968355e9.11.1741699114176;
 Tue, 11 Mar 2025 06:18:34 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:19 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-8-dec210a658f5@google.com>
Subject: [PATCH v4 08/12] selftests/mm: Skip gup_longterm tests on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Some filesystems don't support ftruncate()ing unlinked files. They return
ENOENT. In that case, skip the test.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 15335820656b1c143b440b8a1065a025378e22a2..03271442aae5aed060fd44010df552a2eedcdafc 100644
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
+			ksft_test_result_skip("ftruncate() failed with ENOENT\n");
+		} else {
+			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+		}
 		return;
 	}
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


