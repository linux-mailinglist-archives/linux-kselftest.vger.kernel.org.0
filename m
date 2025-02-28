Return-Path: <linux-kselftest+bounces-27930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5888BA49F8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC423BBCF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173D280A5B;
	Fri, 28 Feb 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yanSTDwU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4B280A39
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761711; cv=none; b=LFg/yJ3lbQDt5/t1Am8tra785VyfJDbmWTIPAwrQ1ZmJUhopE7eqUm6f0rqE4djv088NW9Ua77AyS5/RKZuDJYmUu2M/CV9T/Cf5WVsCtcBnuMC9pMxXKenzI3xlBiydrG0aa6WuB3ixBD7qqGO3SxiuiwP8edhiAQqSMbtLxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761711; c=relaxed/simple;
	bh=PKjIjTL+Xm1qQO4L3MUY1vCQdQ2UWrGB2a6naRLAZVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VAq7wCxxtbsOXMzlFPNnN8cdJDBYVZhlckhf3XyjTL/5Lk+n1r8vKDP7hT9tjPhEz1tSftXBm+TH4EpIjyFhq60SbpokCYdgz7/X/q5gGARALKKGVs70y0EIGacisk8ZciO9t3q5tDhI8/0nplRtjf4pMfOiR8R0HDJmGIM5OWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yanSTDwU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-439a0e28cfaso13663295e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761708; x=1741366508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xd35kCXpRSECxF8AHgzbuHae7VKgf19dDjA8//S6B4=;
        b=yanSTDwUZemNcnsHj5ZIso9CJXS1yl2AbGCt0mGfO/WBawWQaqNRdttsh39+8FwaaQ
         jJnwvXc6E+kdsfJv4GHb6DeBH6UiAQl93IVqlZUZRnpd9KuZQBOmbT8sRH9MFKLgYm+b
         0b7gpD3lV/UxUZCkMQYqlAB08YewwQrajBGjmGYbvwS7x/Z4qs+pcKfocdic4ulU0wKG
         133CmBbK3zoADwhFNoTOV70T9T91qDQujrJOolW+4LcrkkQBbqHo0WiraMV2LH23lrzL
         uiisOjXo4SP5GRdE9Nr9CfcWizDpCH8pQc9b8qlNKbHFmnY5KukDBOClDJ4Hv/FsimWL
         +XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761708; x=1741366508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xd35kCXpRSECxF8AHgzbuHae7VKgf19dDjA8//S6B4=;
        b=m/ilKRBQno6F5LyVmCpGkss103E1KoQFr8tu4/KYsLtDqo3h9jzvXA1HkZUjlNnqjy
         AvGr2uPPpTBJNtyL7116b0Q28bG8EnVrh5gfkGxmmHzKyz3q5KgE7VFntEhgZXF/oze1
         ccsb8VpRcB55yhpErpNJWzlgVzjfibgBdB1Tjd38+9yJM37UGiyxfRbB/z7pNeMJeaff
         JSTIG4x36ZFFF0JyARZi724qc05kUxul6ftkez9wI1h14Rbh73lfqasWum01s5NARvlW
         lYfgtM8GXwSlf5mzuCYlGbkHJJeSvCWZlgOA4P6c6CujrYenaC3xszHEdtlUMwOUYax0
         jIYg==
X-Forwarded-Encrypted: i=1; AJvYcCWiesfVQfvf4afyvRJ9lTR4FpvTE8mG50HpaoIqnQSMkJop4h7Td1z1pKaBUHf6pdafe3vHBr1UJTxuOxCdtU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/kMDsRO4E4hxRtIVA4/oEY0qDFWXxgea2MWqms06LpWzDmNx
	Ic8jQWiFTVH/9dcfsZO4T0/hP2LtZt3vRsFVKHb34akffB1s6vFMxJ7HsZC1BWNQyIVA9nM2YXD
	fLgTkUvbYow==
X-Google-Smtp-Source: AGHT+IH0ZM4UbMAKoXYRYVdsI8CLX+kx9xcCfgVmPw0K5PMtIeLgyJejHV/DAB6TfrrXG9WhtZl/va8I0oxrQA==
X-Received: from wmqa14.prod.google.com ([2002:a05:600c:348e:b0:43b:6943:f013])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444d:b0:43b:8198:f6fc with SMTP id 5b1f17b1804b1-43ba66e6d07mr42105885e9.11.1740761708569;
 Fri, 28 Feb 2025 08:55:08 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:54 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
Subject: [PATCH v3 06/10] selftests/mm: Don't fail uffd-stress if too many CPUs
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
index efe2051c393096e237d942c04a264b6611a6e127..5656128590373ed376b3b5d9259e5ca3867a4099 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -434,6 +434,7 @@ static void sigalrm(int sig)
 
 int main(int argc, char **argv)
 {
+	unsigned long nr_cpus;
 	size_t bytes;
 
 	if (argc < 4)
@@ -452,7 +453,15 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
+	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus > 32) {
+		/* Don't let calculation below go to zero. */
+		ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
+			       nr_cpus);
+		nr_threads = 32;
+	} else {
+		nr_cpus = nr_threads;
+	}
 
 	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {

-- 
2.48.1.711.g2feabab25a-goog


