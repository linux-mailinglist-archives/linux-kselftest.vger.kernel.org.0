Return-Path: <linux-kselftest+bounces-20158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5C9A4474
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB61C22948
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BADF204007;
	Fri, 18 Oct 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccCiWrKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96800202F8D
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271883; cv=none; b=AYJioxt0jVr8nHclkBG1soXnZfvha4uLRsXLBdFLZqVebUNAP7S3XIp/EjOhcwtoeegKrZHWDj3ZgqbAF7oJwMYoW4BpQKJDDk6rU2/RlvIeSeKW6ZLwFnYNyd9ILvk26Og1AWrNVa2yCGIKD/agjhnqQUiOv9fuzHnf8KuTVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271883; c=relaxed/simple;
	bh=6zIv8qaC2MF0PAeithobf6McIrhz33xdEzcVAo2qmaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=adCh+4gsBjjgnECQciU4zIYkgou0NKUQVqhQAM7TGQl3HAXisROFXdmdhaVxwBmO8hFKHojobpZtppHBC1X6v0Vz40j0i4j6M6GiffJ0MY8tpjb2k4kW6sEtv6Oq7miiNqAeJkRI6Qgid/IVP8EcaI7HRnL772d6fH9sagqgN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccCiWrKX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8baba4d5so2663986a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271881; x=1729876681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fTNVYPiWjX5aJw3gbHhx/dfN4r2wbZRz9L5hpyoPWtU=;
        b=ccCiWrKXk6N+et7ClJcpJJ/ici88/VgRIgSfRPBo4hQFHxIMQmkhuaCEvh80O0LbuT
         tUAog1kbtC/B3S37y7bZN2kQCDwwkXUMSnW/eMByIKShx0bICIH63gGNKW91jQPgvA+c
         SRAOBTomlFOSXXdRK3K6sGl1bUhtrTYC+D5hT7Jn4Dv/tN0CZDLtsCE1e1fzZQ2dv9a/
         IqwgQOPhXsos505LIyCgYnoXKRio/6ULfPcd66rHu3b5TpscgzokNrY7Nf3zCiEyWPD9
         UsizTj0ZUvJ4xWb/1tLzknRiMrKS1Tz4VyzqGm9/omHbH3hKNa1GX3nqG3mEKrTD+mg+
         V1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271881; x=1729876681;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTNVYPiWjX5aJw3gbHhx/dfN4r2wbZRz9L5hpyoPWtU=;
        b=m0h4w8SHE8wWe1tY1Jt6bd8qK1q6PbOwmyR5tsiHj3g/MN2bKCGPSukTaKMhtN+CSH
         3fSO7tGESORBVYzKc0UKMkzH9MAnzzP+1CcvYoJmNOzm3MpL/sUp1VH1JwMrWYTPeIlR
         yFR4fi10cimr1K3E43HgSRby6bJNkHC2csJfS/VLhBWhYWCUAtK4BRNjk4VfNyqmm0C5
         JODR0xrminsA7/F1iif58Nh96gYR7tKQYClIpAO8wFjX/LeUFV5qs5E++rRAx5F2om0L
         JY0tWrmOG9uVB7FoUGk17167uLTEEhKAMHgujuh6shhDSeaQFOEAYAwOrmq7e5ZZLf/Q
         Jp0w==
X-Gm-Message-State: AOJu0YwBRDAW6mTkbhXNr+goJBC3mPaX80u8X7XWMG61c2ABrrpcpnva
	1Twp+Li+Gy35sS/KHNw8qZaXSKCQT3P/fRSXvYCCHFsDQNu3nbeVo3BPiovXYctYuE4qs/XRLC4
	M1eUXuyR7PXaKNbs1Yd7f4DLS4gZiak4yvAPEcoj8/h4s2oOvo06+0dnqS+urBbUhC5+Iqugg/l
	gOZX9BXVTXXNqCgmEkGlya7YzXsDGTUOlZpC1PypdrSXCF
X-Google-Smtp-Source: AGHT+IGUfl9GQSQppEfYTWqLUY/W6PAOeXf37xtPPG6ChQb9EBzsCyY3TVPop9oY9SIr1FcimBbACvDURRc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9552:0:b0:7db:1b12:5e08 with SMTP id
 41be03b00d2f7-7eacc6fcf3emr3491a12.4.1729271880505; Fri, 18 Oct 2024 10:18:00
 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:21 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-1-edliaw@google.com>
Subject: [PATCH 0/3] selftests/mm: revert pthread_barrier change and
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Android arm, pthread_create followed by a fork caused a deadlock in
the case where the fork required work to be completed by the created
thread.

The previous patches incorrectly assumed that the parent would
always initialize the pthread_barrier for the child thread.  This
reverts the change and replaces the fix for wp-fork-with-event with the
original use of atomic_bool.

Edward Liaw (3):
  Revert "selftests/mm: fix deadlock for fork after pthread_create on
    ARM"
  Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"
  selftests/mm: fix deadlock for fork after pthread_create with
    atomic_bool

 tools/testing/selftests/mm/uffd-common.c     |  5 ++--
 tools/testing/selftests/mm/uffd-common.h     |  3 ++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 24 ++++++++------------
 3 files changed, 14 insertions(+), 18 deletions(-)

--
2.47.0.105.g07ac214952-goog


