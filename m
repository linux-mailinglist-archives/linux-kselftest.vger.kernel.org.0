Return-Path: <linux-kselftest+bounces-45242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E5C486EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CE63B25E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8FF2E62CF;
	Mon, 10 Nov 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQL8oL+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AD2D8362
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797126; cv=none; b=L9HzbHwauVsqe9DipZa/1hgiQsAIENj+3FFi9ZdPp3pVY66Gx10DgD+66Hi++CW274xHQRWQpvj7zihgJnttkG2RHK5DTTTdtD0HI3XylHqhZbGQnrOOCNZDCBLb1W2xpZ/ikKlWBkwUrtqd3dilRofk9wqVDs6VgvRj7Q7s7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797126; c=relaxed/simple;
	bh=18iCxCQ3O0qRTg/t+FbPHrusaU1hdTgsM9+QofYy+2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=toHOM4+fK3GiWY5eRMB4MWVZQQ4ZGXgKVIzMEm9UkzMywgtjdlljRNr2r2fRpNX0Gjjiaff/cjz5c90FZzBecFLFdu2+uXnVTH+72E/4oQGeCMDFk8mi8+PrCSGC5jlB5qb2MGC8sy2fIHhGALKyPaQqPFzSt+XLHvtA4zCiedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQL8oL+z; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a153ba0009so7420773b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762797123; x=1763401923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VOdTjIkCGcjxXz668t416NZ85KBy/IPkSb6VbZHK7cY=;
        b=yQL8oL+zfamQQS5LtJzLYPxzRlIxv6kWNKMqcnSntgK4JllfZIhHu/wW+Q3pRIMRx/
         OqBcKXSzePF9IMDqBHv40mxjUmK3DAvDKd5+Ss0CMe6ijsHjq7pRayntlo1CVpCJDGTJ
         k4WtYxskGPe0BaQX7ZjU0M9x//FxRGUHqLNsyITZMGmYolCuCjjWxEeZHcl0ebn9XsUC
         TGtmPrRsfAPSmFPXfKbSPZV7KbsyIAYdsDuo1gRNy5pI3SpBTOYGpGUBJJnjz8cgm2q9
         8LqnW4zQpymgP3lNLE7alFoOO6hLGo39xz/WjuthxbuTIYsDIKwds6WTdzAvesj8XE4R
         fGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797123; x=1763401923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOdTjIkCGcjxXz668t416NZ85KBy/IPkSb6VbZHK7cY=;
        b=G3XWaCXvS9zEIxlLykfdD8WCD4XFOdz5ckHEBsyhN83o4Gob8Ns8RWMkqe8SdkHVZp
         0UF9Tc6lm4PQJh73E5HHpsLWffBzPPHPTa1O7wPtK2rX3HcRW2EB6cCTBbjijoKsfkSs
         N+S3P0Fqn25emXTyZ6Sp+SYtRKuGZjigZ2ZPns2QL2AMOj2wcmHnN/e2AREWrjjNNI79
         d6siUr3W1qHj006NhzaC2kB1whTp3u+zKCAzM2me1JcAdu7AVhG+sBDQsE3yvlVhrvew
         TNQztfMohr+qogSu6+dN+olN6dy7R5HZYdve7XzSblT68ZCVE1lPon105N9vfeZbq9/V
         IqKg==
X-Forwarded-Encrypted: i=1; AJvYcCVo63niFMbVJmBcih5Fsb4KbPvwjJax+9FghP8IxUP7n/f7fptj6L/bU0jnkHu3kPIn/3SGp7JPAP7KN1UUKGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lMnxxw3pVFA3tSlcUzawQWF/OhCaAvqNsUah4kkGyORcMQBW
	jAuluy37VqHcuntcgw8QHUyJqb30E2ltbEZXpYjXaZvs2rl7ajirETwmyusAO8Rbfwsk3YJSIhy
	ujg==
X-Google-Smtp-Source: AGHT+IHWYBTESQqB9OP6+smLsVWuqBi/TvADneKuVwr5HuxTOJDLAGYUSWDls+iD4ejGoWboD+KQ8QxyUQ==
X-Received: from pfbdn8.prod.google.com ([2002:a05:6a00:4988:b0:793:b157:af51])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2307:b0:7a2:7930:6854
 with SMTP id d2e1a72fcca58-7b225b61a51mr10573564b3a.13.1762797123012; Mon, 10
 Nov 2025 09:52:03 -0800 (PST)
Date: Tue, 11 Nov 2025 01:51:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110175155.1314757-1-wakel@google.com>
Subject: [PATCH] mm/selftests: Fix -Wtautological-compare warning in mremap_test.c
From: Wake Liu <wakel@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The compiler warns about a tautological comparison in mremap_test.c:
"pointer comparison always evaluates to false [-Wtautological-compare]"

This occurs when checking for unsigned overflow:
  if (addr + c.dest_alignment < addr)

Cast 'addr' to 'unsigned long long' to ensure the comparison is performed
with a wider type, correctly detecting potential overflow and resolving
the warning.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bf2863b102e3..c4933f4cbd48 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -1032,7 +1032,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Don't destroy existing mappings unless expected to overlap */
 	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
 		/* Check for unsigned overflow */
-		if (addr + c.dest_alignment < addr) {
+		if ((unsigned long long)addr + c.dest_alignment < (unsigned long long)addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
 			goto clean_up_src;
-- 
2.51.2.1041.gc1ab5b90ca-goog


