Return-Path: <linux-kselftest+bounces-21147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E313D9B6ADF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204AE1C2289E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11061BD9FD;
	Wed, 30 Oct 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGIX8l/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9221BD9E5
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308817; cv=none; b=YFVMc10khQlqBjVYgDtjWMI2jpV/3nRBODkr9Am19NSeJWaXA3J7bY47yJrwlJRoEZ87R2GySmmrWpBHy3ROHnjvirHtPxwajhYBOa0zHXX4Y3QKE2LxaD1JDyZeB/uUcWlJvUtOMctGSWAQ5gSzTcIwynfh6Kntpkdh4UygxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308817; c=relaxed/simple;
	bh=gxaWEGY6OQ4tuNoSTe7NIiwN+sNJjFe7RPhD8VYisHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OU754Nnp+ieaEqhFE/Hby+EBaDvIGeVpTVzLW8yWmBekhFetsenip4ihLF6BAzCyQCJXyr7DScy2byOHFwSxWwcNTaYRfPBzAk5xjWzsYhHBFnvPjFx/XNQw2NAX6rhMQzmSdUUt31c+kSuXJ83XplPyqQizZss+lyH2HTQGspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGIX8l/D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea527764c3so375667b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308815; x=1730913615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iaIhJ/i5AA0dydp29ds7cbKSvUDwa4uTzDrHzj4EZ5Q=;
        b=TGIX8l/DsFh6IQc4/QFGJc9TCcbIx+7+2kn44uuFrhYfDPGWxqX8Z5i2ByMCzaROtV
         vjOr5q1VhgBkE8yquSGuo8yIn4Hm/Vd/BiT54ZCtITeJliLtn/PJVywBCm77XFE/zhEf
         TRa4xzkW76M/NLrgHnUn+PjN3h4lzzk1dyxoaiK4PxRNvdiXKYYN4iAhfhi2W7aWngcS
         kVqXcH8zpOSOx2jmrnrCXbrwShmM5lx8LMj7nwjCr4gaHXXZAT+TfRs07lLi+e9dWzvf
         mEddM1YuFd68hgedw6tPPBjbCrvts/94udQz7umgiarUJgbdbkWdnHHftra4g2S82fws
         tRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308815; x=1730913615;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaIhJ/i5AA0dydp29ds7cbKSvUDwa4uTzDrHzj4EZ5Q=;
        b=CYxjF5396M7AxOj65zFh6ZN61m4dG6hPLlSXxXX+2HB/h9Wa40zIF8q4exfhdvhSNE
         Pr1UL8okkZnonZ9rqPUQkKjcLNl13IfLay/CvaAJVDZiXh2qL+G5sEWGcEUlozYKZHav
         D1GdCaBFyJ0LbSQNCX1BBld7G2Bb+QqivI/H1vwZsBoeytgnTgRmbL63sAt33lQZjMFp
         WpZ5zwntLNUu9hiRRFVbbkSea8ApIflxCSgsDSvMzvw3pp4gncBHc+j3CP60sSO9i/pL
         /+nv6QfZYvEkBuoyvD3crJZHjEzUhycegh0Vv9wki2A3LaqnbaWQNWAOUgFs0YTNYIbG
         rxmA==
X-Forwarded-Encrypted: i=1; AJvYcCU0cBSnNslGTf12IulpNj+WJuoUIeSkhpaQ3Dwk966cydwJVDKB/Ajqk9Viga8s+wxgApcnCjyPznwgJPqNCX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjt4VS3JfZQ+DfZMXE4EzQAIGWfijJKnX1yYWOQuo9Rq3vlGdG
	MUX+OusXm65xzT2PQBdEBXJ55+54b8deCmTFKElYtxLNidLMGqRn14AIDdhKFEti+7LLOktNZ3T
	m5lUZ4VnmkAJpHuiAhBjLXw==
X-Google-Smtp-Source: AGHT+IGBpQPuMEOVpamNolybCR+mjTbMPDt7+NshVJpSoNsW5gjRbhZ3g6gIduYS77bJPcwbAfWWiWqoJEWjy6Vnug==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:cd83:0:b0:6ea:4983:7cbd with SMTP
 id 00721157ae682-6ea49837d4cmr283447b3.7.1730308814679; Wed, 30 Oct 2024
 10:20:14 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-1-kaleshsingh@google.com>
Subject: [PATCH v2 0/3] Tracefs mount option fixes
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is v2 of the series fixing the tracefs mount options.

Changes in v2:
  - Update the commit descriptions, per Eric and Steve
  - Fix ordering of the patches, per Steve

v1 can be found at:
  - https://lore.kernel.org/r/20241028214550.2099923-1-kaleshsingh@google.com/

Thanks,
Kalesh

Kalesh Singh (3):
  tracing: Fix tracefs mount options
  tracing: Document tracefs gid mount option
  tracing/selftests: Add tracefs mount options test

 fs/tracefs/inode.c                            |  12 ++-
 kernel/trace/trace.c                          |   4 +
 .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
 .../testing/selftests/ftrace/test.d/functions |  25 +++++
 5 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
--
2.47.0.163.g1226f6d8fa-goog


