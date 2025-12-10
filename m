Return-Path: <linux-kselftest+bounces-47362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B5CB281C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A91F30C5B8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDED3019D1;
	Wed, 10 Dec 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UllJiRjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE521C9EA
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358055; cv=none; b=hf/K8D0qIaX6W8774gJiOCnaPlN5qBMj3LdMsoh01xseUvhPSAYWHhHPSGmFFGGEMa8wL40az3UvCFp6b8IDjb9ayi1lvrYR55nXtYQ+tnAwPStt0X36ISOCfYy9qRIKAfabDIss+eFG+qv8vs5TQzXD6Rp9uPGNkzF6ZvZS1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358055; c=relaxed/simple;
	bh=qA8etQBYMVx7IE9HjB0d2PDyzFeEHh6dA5fDZxxGkug=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GW8a4oiDbtGY9qunXGbQHtwDBEuiKP3Asq+tj1MxAL6w8LuDab60CyyFx9+x90BXWWL8fWX9lOJe7XZLeycALb4q8SbBOAuBA17ktXsfOcv3v+U/y6d7qcoilHlqhXUjW1JFbUlw+rS1hmgAhI8ZvsaZ5oBYjHWGcujuRiYRa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UllJiRjn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f587dc2eso88854555ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765358052; x=1765962852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJ+diNdvdoAjNwW4/UoG9jb3p4kgQF7Wid7xBQKDtGQ=;
        b=UllJiRjn/llHvkBJ7E+vHb/ubBJ4APyHD6L83HvpPROVNzvrrBaUGYK1uuCdXcDfs+
         I0bJQCpKvqpaFlDssphPz4udOTiv5ZyGtRd8LqfKNT9dQdv6tAAPARHkaaTUYTQOXmoq
         A/oIpF6RIVz3G/uMeFkkqBSYl2DXa7Gho82/aHL34AI9tnej1UkJiHRJItk6PI5Q4dp0
         sRLp7uiJGk87sPbH4vk1HffgZyvvZpyh8cApNQ6fV+MbCG1922mq1gv0vtiEG1l1YUKY
         Eag9uGW0LfiLSKCslKjl/QGzBKlMP/kvz4ZuEkhZl5iJLXth0kY+TfvTxklAR8vae7m/
         1Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765358052; x=1765962852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ+diNdvdoAjNwW4/UoG9jb3p4kgQF7Wid7xBQKDtGQ=;
        b=l9zflYOFfNNEwOE4xngqakWI+dssj1Qamm3xjEBVz9S8fnQMEVWcQrqVP24NbQXT0D
         o8pYqVFqDg35UUe0k1u2xekrpV6DE9MAk2wpt5klrZ4S3CVGKuv/zN7jXAZkKJOhcZB4
         3C3b5M8WjPJXoyA79c8Nb4e9/zygWAI8OzweTlDfXzA9AYmwcsOkMOE2nYkQXm6ttF+E
         mHhuxFrSW/SeFdkautRN9HE0UhAKbuxoz7nJmRMUp1dX0Fd1j5YijHzSjYwhr2m+QT7E
         1inTjA3oVDpHlI41qwkPhCkFQbxChebs3jcsuKrlk/hMacjKrhrQz8KbKrIKI9l2epXb
         widQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw7gieO4nQB2KoSYHeRuYUfvhW2TTl4HVXnS2GkEhgbcjtSSdXCNjN2Wz1qB1IrfJHzO4U6rh5yyLDjVDEhoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxb7D5jOS8lIWnSaGyiw6WpGJv2AYKmfRcUh1OdInnbyULf3f
	AVEUFe1Xr+aea8iVC56CpyRLtezAfDtumzB1gfRoLRALHLQ+LMeYXIZJ8y5tvbr20UA6wIUf7H6
	fXQ==
X-Google-Smtp-Source: AGHT+IEu6z3l2QX6KuLU3Q6OFfDJ0FX6A27zVmwG9FygHINtFnYd4ff1NV1/k8xr34jkmCShD9fTkvGN/A==
X-Received: from plij11.prod.google.com ([2002:a17:903:380b:b0:290:28e2:ce65])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d482:b0:295:4d97:84fc
 with SMTP id d9443c01a7336-29ec2484bcemr16730975ad.32.1765358052034; Wed, 10
 Dec 2025 01:14:12 -0800 (PST)
Date: Wed, 10 Dec 2025 17:14:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210091408.3781445-1-wakel@google.com>
Subject: [PATCH] selftests/mm: Fix thread state check in uffd-unit-tests
From: Wake Liu <wakel@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

In the thread_state_get() function, the logic to find the thread's state
character was using `sizeof(header) - 1` to calculate the offset from
the "State:\t" string.

The `header` variable is a `const char *` pointer. `sizeof()` on a
pointer returns the size of the pointer itself, not the length of the
string literal it points to. This makes the code's behavior dependent
on the architecture's pointer size.

This bug was identified on a 32-bit ARM build (`gsi_tv_arm`) for
Android, running on an ARMv8-based device, compiled with Clang 19.0.1.

On this 32-bit architecture, `sizeof(char *)` is 4. The expression
`sizeof(header) - 1` resulted in an incorrect offset of 3, causing the
test to read the wrong character from `/proc/[tid]/status` and fail.

On 64-bit architectures, `sizeof(char *)` is 8, so the expression
coincidentally evaluates to 7, which matches the length of "State:\t".
This is why the bug likely remained hidden on 64-bit builds.

To fix this and make the code portable and correct across all
architectures, this patch replaces `sizeof(header) - 1` with
`strlen(header)`. The `strlen()` function correctly calculates the
string's length, ensuring the correct offset is always used.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index f4807242c5b2..6f5e404a446c 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1317,7 +1317,7 @@ static thread_state thread_state_get(pid_t tid)
 		p = strstr(tmp, header);
 		if (p) {
 			/* For example, "State:\tD (disk sleep)" */
-			c = *(p + sizeof(header) - 1);
+			c = *(p + strlen(header));
 			return c == 'D' ?
 			    THR_STATE_UNINTERRUPTIBLE : THR_STATE_UNKNOWN;
 		}
-- 
2.52.0.223.gf5cc29aaa4-goog


