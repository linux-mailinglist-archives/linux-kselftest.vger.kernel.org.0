Return-Path: <linux-kselftest+bounces-18980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF098F8C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D753B283C13
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B81B85D7;
	Thu,  3 Oct 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cKKd8VO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B7748D
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990249; cv=none; b=YZ0uUBumJT9SfgwHZD3QjMVxl8l5VJ0z5KuHi3Qi8dQlmdXpPhiRqUvfe1yZdcLRq4Rru1eitCrWIoWnfexPveAUFmZks03EIpRBlA46aMv5max6xpsnclpsBMkFGBUqC5KR+7xxEKYpMwSVD8NoYlCmuuAEoXB7kyWlXk3WDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990249; c=relaxed/simple;
	bh=5CxlFKBNAnY0L5cms+ig50SKqjgs7CYRL21hDw0X7ec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VXdkmPOs4b8g8RbcKwtl6bjyk2ysDPHD4dmAAUaUP+QwMlFKTN/mTk5wEuaYFHCSXiu2nhxcMBpccDsz+921YklvhudNgEdP5GxuUkLoWEngiEwhpkWpddhFwfS/EbgnNrH3aV0D8Dp7FB6mvNONkTE2qQ0u52SeBDOuTPFLZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cKKd8VO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7e6c40a5795so833822a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990246; x=1728595046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UcHV8WURcnYuTep7jYDWQX5sxa0kfFCRTwwcajmItvQ=;
        b=3cKKd8VOZOl5qCUCnhamcDI9ihqDnDqEsrPVaJktdB8tnIMJbrzROxNsf14bon6t3s
         XsbDshKOVW8IAdFePMozQE61e2uElWxbGBUTkjAtnTDNBiW9PSVYdQJ8FtDZHbWafRMm
         S1GXn+oiwCS24i4shsrjZnVzXU24kSvwrQ9XUcRtXNRchITJ6RSmHDLZUhHEwZfl/zyl
         5I//Su7jz+tKRTQlcreCT7HSAiQzVr56a1ePhPS29moRQ0b7tIodg2/yEJlL34YqCp5n
         fq2nqiWzYK3r6SbiZYErVTon5qP1tPjKHE1Cu9zpyfwoi1ZWqIWUmntRVuV4hEAuUm4d
         pMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990246; x=1728595046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcHV8WURcnYuTep7jYDWQX5sxa0kfFCRTwwcajmItvQ=;
        b=HhAF3WgcGVHkZUYtNcb3gcdJRdSJH7S7dim1AAmbkQiGZrIXcneUp/dzh4M8c2EBKw
         FKh2esz3GKYtGokRQ5A+Hvh6UD884LDuagaHmEbYYvx1Rzp04UcmZkjdPOro8qp2tJFX
         T0fq5nyyebPOU5bD4QtRhaATeP/EhPBSfjVqKgOM+SFh5a1jVAxn3ghNtQYQE2d6Tzbz
         riC1HVLOtXyr3Bt6Gf5FZXDeA1ZKCb7UsNNGi3PXY5QpjLHYkGpSMGIlroi+E2loAbuT
         vpXIIQohIpB5alnrI1cYYPCUG8jt/QpdCgl+KjuCbmP6EGk1yxd9tQrA3lqqF3UQwjXl
         AufQ==
X-Gm-Message-State: AOJu0Yw/6bdf3LJRbOX1jANYNYvoL9CR4cZ9qN7CVQenRNZRPkO7Meoc
	BYmZ0f3mWIv1icC7pmteOXXb/0Blq5+xGqEuEUYZn9gKOoqSfyoNSw6kuMUeuLSXT1m2zyMSkAh
	3CYRjS34R1uLSEI02kmmHY2Jp72vIT0LNBeSkTm1yEoH6OAGgVfqPcGb2iTbClcZBxDlx4GNDzm
	/mrQG9vXGB7ChIoBj0ccPE433qPsSyZK5iIO4CefT969i8
X-Google-Smtp-Source: AGHT+IG5hVqNff98quNB5O4IO0Yjm/qlW0YAQSi7ApmuRiktThVtGG3FOUNL8wWJTpELBRqtrcCttJhelDY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:fc1d:0:b0:7cd:8b5f:2567 with SMTP id
 41be03b00d2f7-7e9e59bb2ccmr1656a12.4.1727990245571; Thu, 03 Oct 2024 14:17:25
 -0700 (PDT)
Date: Thu,  3 Oct 2024 21:17:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003211716.371786-1-edliaw@google.com>
Subject: [PATCH 0/2] selftests/mm: fix deadlock after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Android arm, pthread_create followed by a fork caused a deadlock in
the case where the fork required work to be completed by the created
thread.

Updated the synchronization primitive to use pthread_barrier instead of
atomic_bool.

Applied the same fix to the wp-fork-with-event test.

Edward Liaw (2):
  selftests/mm: replace atomic_bool with pthread_barrier_t
  selftests/mm: fix deadlock for fork after pthread_create on ARM

 tools/testing/selftests/mm/uffd-common.c     |  5 +++--
 tools/testing/selftests/mm/uffd-common.h     |  3 +--
 tools/testing/selftests/mm/uffd-unit-tests.c | 21 ++++++++++++++------
 3 files changed, 19 insertions(+), 10 deletions(-)

--
2.46.1.824.gd892dcdcdd-goog


