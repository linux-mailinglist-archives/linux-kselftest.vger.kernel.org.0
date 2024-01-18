Return-Path: <linux-kselftest+bounces-3190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736583162F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399D11C221E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BC91F92D;
	Thu, 18 Jan 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dw21sRWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B31B978
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571469; cv=none; b=nOncpc6gf+cB7M4zush/SbRdJVulFBr523TOQfUysvCOQKhJaQ3wni80eHtJr9j11APFeYTG5++/e7bk6I0nTEFI3Hr27bgHRgEwjkCVeTRtcwo9X6OFxhydTn+J3Ghe75Q27QeE/SsRNKBihNHjO8ojKRYqt3fIMKn303LYa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571469; c=relaxed/simple;
	bh=s3vUMJLFHAD51DC2yFRfx7iE/+ob/GznEz4ar3z3+bk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=tvDyLH32LLbH9z9ODx2oJPI2hjKoF3SzhVVUU7hLij/T+rx6hr9D4cgXZgEM1P6CHt9fPlUR2G4idPCH9tivqNigWOTQVO1+tOAqflFl4Looe1C87iRDuGaapArInETVcVlP552/soOdi2qVI6kgGyyUAF9kilv+DPsIOTyuNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dw21sRWg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff85fabbecso8166787b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705571467; x=1706176267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RO6rdO7yon9JVy5o6uihMLS4VCKN6/zkfcB4kXn3j3k=;
        b=Dw21sRWgO25P5sGKQLu6OP4DyJdA36g7iapH1YdNEM0JzusJTk4F+HyTIVlF7CGt21
         B9rNP3gSAJ7iz81cw6MPcslp6AnPGlf9LVU/C/A2N4UxGtBg1c+DzVnra4c5Dss3XBN7
         pji35wkNFln3yfIGos8mRnGJzZW+ZnHJY9gncqHC+UdE+vSBDhORG0yyzUqqFsv/MWX9
         t6AZ1AeGYWcwlj2ob+wXQ/8d5F7mrGLHfU4JpC7FpoLTiLWSaRchAQW3tDu9zPcPs7rH
         YzjtVCIKPa6DvRxsb2rWt0Xgnz+cYfgQ52YMSlfiNE9JBoTg4G1hRidCRcLcX9xEJEW8
         iA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705571467; x=1706176267;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RO6rdO7yon9JVy5o6uihMLS4VCKN6/zkfcB4kXn3j3k=;
        b=LJzUON6lDOmL1Fizx1pWBctd1AxCgUsFG9hAP35J3GuyrKfM09C6lyMlHKYb8RvI1M
         Y9GRBdyRG7KRm6ru9OV6DslMxYIyBl0pHGj2QxhvFhyylmRyGkbqzVV/D3YkgsZJVKbn
         uw6LqNu4heUc1sW6w+fS0grykCOGnx7gA6kv+fxHekrlx6HpY3V6cAqeP41et3p8AbcS
         fdtj8Ivpb8bPmoZL8LEILGv+I8gIkv7Ky2YkC4mlSY9/JpCHdjjEe1g2a676E2YPzQVa
         5vUoWbIZBwF/esn+BFSr9H7mx+lGqLjeaG0NQwYx1lxVdln0UlGhBDIu8h/dc3uXJ5XH
         +0eg==
X-Gm-Message-State: AOJu0Yw4rBhuFqTL0Ra3CqS8lMEJXo6/bPWxmVjG/qH1enG4KeNI0KKq
	cyx2Yi4bmCXdf3FMJj9naxjL5kjAr+9s8CoRMzp6R/dsSHj1VYX0ESXrE1yfBtcnXJ/mVRZ5tW9
	V8hwlQg==
X-Google-Smtp-Source: AGHT+IGe18viwrppfstJfi4AUcP2ZanhxP9sww14HmVAsZgEBU6B1iIqZG6+djVghvja7wuNIfkQ57OeetYp
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1b13])
 (user=gthelen job=sendgmr) by 2002:a25:b112:0:b0:dbe:32b0:9250 with SMTP id
 g18-20020a25b112000000b00dbe32b09250mr27546ybj.0.1705571466906; Thu, 18 Jan
 2024 01:51:06 -0800 (PST)
Date: Thu, 18 Jan 2024 01:50:57 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118095057.677544-1-gthelen@google.com>
Subject: [PATCH] selftests/memfd: delete unused declarations
From: Greg Thelen <gthelen@google.com>
To: Daniel Verkamp <dverkamp@chromium.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 32d118ad50a5 ("selftests/memfd: add tests for F_SEAL_EXEC"):
- added several unused 'nbytes' local variables

Commit 6469b66e3f5a ("selftests: improve vm.memfd_noexec sysctl tests"):
- orphaned 'newpid_thread_fn2()' forward declaration
- orphaned 'join_newpid_thread()' forward declaration
- added unused 'pid' local in sysctl_simple_child()
- orphaned 'fd' local in sysctl_simple_child()
- added unused 'fd' in sysctl_nested_child()

Delete the unused locals and forward declarations.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 3df008677239..18f585684e20 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -44,8 +44,6 @@
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
-static int newpid_thread_fn2(void *arg);
-static void join_newpid_thread(pid_t pid);
 
 static ssize_t fd2name(int fd, char *buf, size_t bufsize)
 {
@@ -194,7 +192,6 @@ static unsigned int mfd_assert_get_seals(int fd)
 static void mfd_assert_has_seals(int fd, unsigned int seals)
 {
 	char buf[PATH_MAX];
-	int nbytes;
 	unsigned int s;
 	fd2name(fd, buf, PATH_MAX);
 
@@ -696,7 +693,6 @@ static void mfd_assert_mode(int fd, int mode)
 {
 	struct stat st;
 	char buf[PATH_MAX];
-	int nbytes;
 
 	fd2name(fd, buf, PATH_MAX);
 
@@ -715,7 +711,6 @@ static void mfd_assert_mode(int fd, int mode)
 static void mfd_assert_chmod(int fd, int mode)
 {
 	char buf[PATH_MAX];
-	int nbytes;
 
 	fd2name(fd, buf, PATH_MAX);
 
@@ -731,7 +726,6 @@ static void mfd_fail_chmod(int fd, int mode)
 {
 	struct stat st;
 	char buf[PATH_MAX];
-	int nbytes;
 
 	fd2name(fd, buf, PATH_MAX);
 
@@ -1254,9 +1248,6 @@ static void test_sysctl_set_sysctl2(void)
 
 static int sysctl_simple_child(void *arg)
 {
-	int fd;
-	int pid;
-
 	printf("%s sysctl 0\n", memfd_str);
 	test_sysctl_set_sysctl0();
 
@@ -1321,7 +1312,6 @@ static void test_sysctl_sysctl2_failset(void)
 
 static int sysctl_nested_child(void *arg)
 {
-	int fd;
 	int pid;
 
 	printf("%s nested sysctl 0\n", memfd_str);
-- 
2.43.0.429.g432eaa2c6b-goog


