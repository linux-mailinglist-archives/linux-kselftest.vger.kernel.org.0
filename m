Return-Path: <linux-kselftest+bounces-11265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878598FD9EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29976283D1D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBD16078F;
	Wed,  5 Jun 2024 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgme9dCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84163155356
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627012; cv=none; b=cw/mKsDMxn6zjBtOoi5ss2J5D/Zpsns+JdRKTHVU5je3pQvNMDPZ0YEZPdQL6y8dfiKu1PC1BgvMv3EAQXWJTeaDNcPJkEVeLjiPAtYgwE4asOlDWOTchSfL9+w8q/vGor635pdFs3QxYqpWuCKmn7n2Tt5JAGHBu7wSBiMtbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627012; c=relaxed/simple;
	bh=FAxq/WJA3jAwur4ufatkzAyl90jSZN079xQn1B8hIQo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cf160vgEEZPA20Asa0ScCIQlSg2tWbVbZzEQopDyb9IisXjgPN0GlpgxAN6fEVg9MkNfY2Cybgi1a4b0j1tnnfU01RXd9/v9/aAqu1SG5U60JsRz39LM0gbhSz28WiwRWY8rkxkaHc01ki7XFA+3Q7fd4FIh1cKkY0jy62MpJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgme9dCS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e4afa326so4222217b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627008; x=1718231808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDMXqeIeVKqn4Qjsv0IGaXMAVsD6Gi7Ax4kHrxCoB1Q=;
        b=dgme9dCS7bxFo79XggJO1kNtpxaKsww73MwHScbgnSVRhbu+P6wHnFe5TJcY6QpNIt
         WMnNKSwrveL3ZNJC8WT5mIR5cBhzN/a7Z+wGiR7zRM+HuH5/0iRqJozcUUqnmrun6pPq
         FRjWM3YpziB1wzNcAjNbLqHf9/nHr7p74CNDogTCBWtX102Ui564OqPWNLz6lpP0+CIy
         XrWm0IdBAJTLMsAgE7suGqH+uFx270W26lQBjWR0mepLDJLdZArHw75hgZoD6xMuoNP5
         jgvWQM5SRNLxcBFgf7c5EmXcVR+csM2PMY4UmaOwz2ddwxxB5cHnYtHqvwDkwqmMjQin
         ceTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627008; x=1718231808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDMXqeIeVKqn4Qjsv0IGaXMAVsD6Gi7Ax4kHrxCoB1Q=;
        b=NI16hIZ/mr75R7cXFFUBvqcJcTOM5ofUcx2kBM8zce3czkGGeOVfjcvv4mqTFz/2rL
         h1L+iaGbGxn6RpFr7fPGLoMTNl1szOPsLN6aFxUDaKuawFMR8LQ97Fvhe0loM+nVAW0R
         bcxXQ9wERyVQqDBUElTEihSQqo0FXUBBlNtEYwTlNTtu2Z4L/ikhTfqGNod+AQYfBdu/
         SZlXY9LyYi0z3EakbmrMi8rWXKdIw1z6KHk02HdtKWW9pCtco5L4fpG5drrxGdAAcgjb
         PZRZrelMSLtTMwzVmyfNkUId94j8bnHK52YYd4MDpusx0nrD/GdZnTn49jZWEgZ+/yJy
         KS3A==
X-Forwarded-Encrypted: i=1; AJvYcCVRHNPqmTlXir9gpLqY3tFbohjXiGKBxXJhLPm/W8gm+oOakn6R8/43bIOhFuvYFhIWdVA0TKUSbrIJ9Q474nl/DVnByjRZ7nzjTCpyKveP
X-Gm-Message-State: AOJu0YzIJ8g1eovNn73Igg0BD7R/nObH4U3VEohRYPdVN3cZUu3PI/ek
	tg9vsmFMp5FFwvXFJpdlvfxE0Oy6YcLUWDYrpaZOEVz4qia1hIEGnTIuf01tEvep1Hc9DEteJcx
	DZg==
X-Google-Smtp-Source: AGHT+IFVehH9WFewQGik+Dl0yz205/vF46via66nugJeD3HwTwVLDF4W27JfIYCAwQuhN1N8YQzQilb3Kio=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:38c:b0:627:a961:caee with SMTP id
 00721157ae682-62cbb4cd151mr5405207b3.4.1717627008528; Wed, 05 Jun 2024
 15:36:48 -0700 (PDT)
Date: Wed,  5 Jun 2024 22:36:33 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605223637.1374969-1-edliaw@google.com>
Subject: [PATCH v1 0/2] selftests/mm: thuge-gen defines
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: cmllamas@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

When compiling with Android bionic, the MAP_HUGE_* and SHM_HUGE_* macros
are redefined because they are included from the uapi by sys/mman.h and
sys/shm.h:

INFO: From Compiling common/tools/testing/selftests/mm/thuge-gen.c:
common/tools/testing/selftests/mm/thuge-gen.c:32:9: warning: 'MAP_HUGE_2MB' macro redefined [-Wmacro-redefined]
   32 | #define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
      |         ^
external/_main~_repo_rules~prebuilt_ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/linux/mman.h:38:9: note: previous definition is here
   38 | #define MAP_HUGE_2MB HUGETLB_FLAG_ENCODE_2MB
      |         ^
common/tools/testing/selftests/mm/thuge-gen.c:33:9: warning: 'MAP_HUGE_1GB' macro redefined [-Wmacro-redefined]
   33 | #define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
      |         ^
external/_main~_repo_rules~prebuilt_ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/linux/mman.h:44:9: note: previous definition is here

This test should probably use the uapi definitions instead of redefining
them.  However, glibc gets struct redefinitions when including sys/shm.h
and linux/shm.h together.  So, add guards for the SHM_HUGE_* macros
instead.

Edward Liaw (2):
  selftests/mm: Include linux/mman.h
  selftests/mm: Guard defines from shm

 tools/testing/selftests/mm/thuge-gen.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--
2.45.1.467.gbab1589fc0-goog


