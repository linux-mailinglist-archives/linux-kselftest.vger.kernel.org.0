Return-Path: <linux-kselftest+bounces-27216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C985A3FEC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B46A17D93E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504B253F27;
	Fri, 21 Feb 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lW/+39Rw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF4253F10
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162364; cv=none; b=m140Ino6wd2Kld+58Hk8QnMbRdQaTu4jOhsK6/mDGFbPwmFIxpXuZ9fH9Y1cb21/mOO0H3DeLcZc2nJyA76ptNmst007P8nvq2VSS0seF+lm0vPsZ39qjlCpJHiN6yR6Rc1Y3xoFwqiS2Q8YNdy2tW15C4YOwZXdILpEADdCKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162364; c=relaxed/simple;
	bh=0ixIkjkOL34y3eG+6JnRx3HpyEoFjaPmFiUpYG0o8X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLR27mqDhq/p0UnNllhKOTNqHdE5LgPQzBn7Os9NYCb4dhepFw2gKkCyT8xn2aZkfDna7emYwRvwTKyXy4sXFvXfbQVizjfv9mgdyfgTlfcupylrPoighMJt7pEX7bM7eWLJ0Ipu7eRIeLE1ctUvk8Qefh84xjnhzcHhOrCwBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lW/+39Rw; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so1158621f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162361; x=1740767161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUbh6bo0YX556uViMnNFSN2+o8CrzMcR/+eYIWbI+KE=;
        b=lW/+39Rwy1ke3rWDcfzNUyW1cwycG4QN0VX6u+4JIsKdtVtZ4dZyj9I9CDFgBwu07D
         K0pP44YLDMgEEt59VAXG+9SOR+cSGYf2QRNNCkOuG+MyoOCqf5C/G2IQRedJzjdjS7rM
         5gAi8fjbkNaBWXz06d/Y8E9gPYNJpmCQoGbM26OlIkUSnVzzwbIwRuC2ePmx7Smit4aR
         3X0tZnumkcUryInGwbLLZKLluFZ2+0lXxvoEjXS853DWoU8VeiPmOm0ky9Nwh5BhBCY1
         EEioXpM9XVVXcQMmLc4ZPOVfoC/1stS0w/aiHIC/Ik6G2qz7L4DlthIF4TdW8uh0bnWy
         jLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162361; x=1740767161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUbh6bo0YX556uViMnNFSN2+o8CrzMcR/+eYIWbI+KE=;
        b=evp4R7CiQJakhFW6TEOd42TXHfPyCBNapNdLS6TaEeuxd9BCYYuW1ILclFYAraMPbj
         1RX1vRJWG2uBecaUDK1QYLksfisX5EPxSwYz0BAa8vo0EcHqZ/Qt0HXVHGrQtD/qN7FH
         ODdFcBdaYefa56XQUHQzGIGXGjgz4Vh72OcCa5UyXdmIYMvFYL/oluM43TPsoG+W7Z42
         oF43phWTwbcP1E3PRQ7iLfo1CP3MDc4LVpBU+mdwPFDqu2EANNLbPtjt1ER28fAQOidR
         kBbZ+hs8nnIcqqSpgNhwbc0hWqAulwW5qf7PyKFOo7M9HwYAzk1jqP+7cZJLAGekna7A
         IA8g==
X-Forwarded-Encrypted: i=1; AJvYcCUH9O6zseDlzDk493yg9bnf3+1u3zrlhZg44GwsCl6bG1cK763NJ/qoaMTJTe3qhaqLKk+5eJ3224rTz6Hcolw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWvWzSis7JsUe3ZpgqS99To/hgSA/c6MWYj7IwEicK4G4bShJ
	PIgYKYFfpgAl2BrreQJR4FazpJzZ0e1EV/CMdIQUVR0W3bzEN5geGlYj88s27jVLg2c/C9IYwx7
	I+CRQ/W2EiQ==
X-Google-Smtp-Source: AGHT+IE/bG8bUxR8y1P5xtIPuQD4Hhm3QWPdc3EgR4sjxsIVd86HrK8cKBFQtHlEYVxpNKR3bI3d8S9EnfxaWg==
X-Received: from wmgg25.prod.google.com ([2002:a05:600d:19:b0:439:997a:8b94])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:584b:0:b0:38f:3b41:c952 with SMTP id ffacd0b85a97d-38f6e754b82mr3343613f8f.4.1740162361345;
 Fri, 21 Feb 2025 10:26:01 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:46 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-7-28c4d66383c5@google.com>
Subject: [PATCH v2 7/9] selftests/mm: Don't fail uffd-stress if too many CPUs
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
index be0c93f24fccd618f52d54ff36d9a5540f420e46..cfadac801ed43e8b6dc331b343b6dc4030048f9b 100644
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
2.48.1.601.g30ceb7b040-goog


