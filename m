Return-Path: <linux-kselftest+bounces-9852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DA8C166E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5771F270C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2913B28A;
	Thu,  9 May 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBVVxbVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF513AD12
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284930; cv=none; b=Y/2gb3dQGogFhpldVH0QcO5N9PABEZwdqleFwqPsAEBEByIj30RKY/YLyevA/FKlJDqHGraq26yQE7QksIaK/NfP36YnMBbaa4Vi4u1o0A037JbrzLIae6VER10sD8B5AR/9HkwprLXSK1PBx6yhDb8y4vWyaTvajeBd90T6dmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284930; c=relaxed/simple;
	bh=16xQFZUemPEW+OmTRE/3AJIID4VuLDiTh8Uti+95Avc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pSoCoMUkwjvATake1DZ4IKNP/c4BhpY3MB/3qn6EsFYtJYKxm8LwiSgydMJnPoXHKmFukiDFA/AaHwoDwfggcXguGBjzhuyaV7lHhhBZNfbyd/FQWJij2luuvU8e0qXL9zGR8u8kne72u+Hsr3NoW8wsEfzfO76oo6/Smfhkn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBVVxbVp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b6847956so3120257276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284928; x=1715889728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4la0VxD3l5sUUAGJ4Eky+q6o3Kf635llpLjU0Q2ns=;
        b=XBVVxbVp0tDi1eejJVKANr+8xaxS/RZuT7cPK9azYrwtike+1VH1jwViW/jBCCJLsZ
         hupPKaiadKuVDG9F61e2VC7dz2WWlo1OJ0xyC3AZv/ehIs9gj7HSyrsnO+AKhQDAq8FI
         +0zVDs+SkVvFSnP86mwJg2loLZnsQjj6DrXYNwjXw5zCPhGFjOSbMKNxvI8QqP8c0oaH
         p5EQxr+oR2Qcz16c1EdviPH3wsgHREVRBM4YMZRAgpS8P0Squ52ocsQQeVXgt3ozvZtd
         LON1xSoAlM3uF+AtUiqyCkFCkd8BIZOP4/5H/FBtStBt6D8UzjR/IebYtdq88C0B3BqC
         QYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284928; x=1715889728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4la0VxD3l5sUUAGJ4Eky+q6o3Kf635llpLjU0Q2ns=;
        b=Cfv8lXdX1AYyld+5DaWsp19QOoaHFNURIgmTMyTN9+cpiWyacH+RjEucIrUwvel+kj
         bFiecp+OlDc8chgIjtea5lzzFy4aJoD5T8ZdQUJtniHQfnSXJgilGm6uqPdo67sWadjk
         EZ5JV4ZoZcGwYWpKSqDnwgH1lLQbH7lxM+um7/A9M2yTlj3MYNWlafP0zRO1qocoJFBw
         MUe0B4WcwK5pqoK3FW/G/JeMJf8bSm57Qq+Lxm2EFan9waRWqyRBCyHycT6dC/TgzrJM
         Pr6mo7LFEk7eb/6aQXAOiQAsekTHyOCSif2DqH7L8HZlApJ5ej3VoGCj8eK1Guhm2VyY
         HyUA==
X-Forwarded-Encrypted: i=1; AJvYcCVLX1WfZSWUECdRs1XntIC1q+oCuiy3hUaAXAnEtEaJ5n3nRgME4laQnEAzsEZITx4ljdmdDez0++sqJZ23QIC1LUZXXwCtPErsvJ0QigNI
X-Gm-Message-State: AOJu0YwP4O1MqObF20erbKOe7fgWIL7sJsuHNHkFkguF8Lkef/w00mWo
	3+jLOQ93UIXk7kLJpuhVj5LdKgBFu4IJSQXOFRYAcB3s2WeATXpRk6Omd2UPAiOel2vyga4waiU
	gxQ==
X-Google-Smtp-Source: AGHT+IH7mCutPVAsCyjnUwqjavBhEaHc72uO0KGnsx9I5mIx6c+B/OzfNxUabcxwf0ME6yuKTrwEQgs1qvI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b03:b0:dd9:20c1:85b6 with SMTP id
 3f1490d57ef6-dee4e48f302mr225691276.2.1715284928394; Thu, 09 May 2024
 13:02:08 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:21 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-30-edliaw@google.com>
Subject: [PATCH v3 29/68] selftests/membarrier: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h        | 1 -
 .../testing/selftests/membarrier/membarrier_test_multi_thread.c  | 1 -
 .../testing/selftests/membarrier/membarrier_test_single_thread.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..a8a60b6271a5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index 4e14dba81234..c00f380b2757 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index fa3f1d6c37a0..c399fbad8efd 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


