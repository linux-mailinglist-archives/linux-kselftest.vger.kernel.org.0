Return-Path: <linux-kselftest+bounces-10209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF08C5EA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07063282869
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B60803;
	Wed, 15 May 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3I7We6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B55CB0;
	Wed, 15 May 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735302; cv=none; b=D45ki/HVFU2u1zvpUAS+8DDBk3u9hk0zZfLIC7Fy7VhQY7QKPAt8wwiFclSozbd7/8Ei3OtK00yqOhtVGVXdAhv6yXmFlUdkmrd9Zslgvk1XvCMnSFK2cy6jt0MTzGELGXXW3lQ1UKTe84DXO5k+a7dDMpHlgwIaOVRP1jlkhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735302; c=relaxed/simple;
	bh=D69ZLC8/gjwZxvU+Y4nvOh9+wCwb1dUPhipLaDHJTd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3J8TFH9WkiNIlzNtMgpcii4KyNa320nf2J0eLQDKDHmqeGQY/r45pxNsrSvLepmZuDyH43ZEzzFlJormBM5YT+UMnZgmaPp6MF3qXK8nm/mdKUYg3VCJokR2yZNMdTx+5SRbxeJtgwz7qcf65LtFcE/KJWbjVFhsL00RE4xAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3I7We6z; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f4dcc3eeb3so3589945b3a.0;
        Tue, 14 May 2024 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715735300; x=1716340100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEOuUmrraVajZP9NumOJGczPjev4TG6biSN92z3lk0k=;
        b=i3I7We6ztg0PplCVUQqhfrhvi/KFp8gskcg35QEDt01Et1y1yLXIrBFw1dq6ru2wQP
         P5OSHo/515ulToKUhuohdS53EUY2NFXmom16WzVYsB7HFWrZITzKPdPNyTwb/hNocHTd
         Yf/Wj0t7rcbL9d9xXHLX+RPZ+cgqfPRchfbYY07dieSxOo23FT4ql9JRoY77U5xDSsrE
         NCmrpXAfbwDVQ09MVXHDH+qipHYXTeb/96lRXRsNsMrdtrI4qfkSUxzx9SDxYn7L3D66
         ov7bfeGNRnTT9XOjPSv9BEDdHlKvB2xyn8gk5WeEPRrh9BXFFiAprPSiY9x59SQ2oL/O
         BpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715735300; x=1716340100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEOuUmrraVajZP9NumOJGczPjev4TG6biSN92z3lk0k=;
        b=UK/nF4SEgW/e1P8KB5a/7nUK7p2ti600ELm1gRw31aPDUfWcm9RyTrs4skG+0x0ajw
         zTIxFF/f3WX5D9FH0kJ0oegQbJ/s/w7pWOtfJEyqie+0BP1eCdOG1Y/TaJiQiOEkZx5P
         +b3/6R5Hil0EaHQprN3sZBBwGoZ/A5uPDwrk0K2IwJklZ7lwuT5HIWvABqoSRWb54FGz
         2N3N6BzKkbQwb0Il5IRRiFLaEkvb28NtUUWhbFfj9FK5KK42GKzXCmb0qxr8mCpGSiQd
         187gldcmxoYE+xYvlQvgK+8gk43cxwatPke14JFO9pf4MVGddCZijNo58wsYvvUGT2Hf
         w+5g==
X-Forwarded-Encrypted: i=1; AJvYcCWGqwW/nmLt/PdrIytacOYYp9uw/z6AlZRvu8f6K0LLRmrAUirrAXUnyxEIz6UKeyRR5mClkaCzAA2K6i/oBLABIJyxfjcDhS/v6lFe
X-Gm-Message-State: AOJu0YxPBlCsWR3gRPI16LCQD68y44iHik2Wn6nlM1gwtx43HKh+hUOx
	RQKEecTFfEmjw8elTm8HlanrU8lXLOAYIE9+zZpcCNJzG2Cl3Ts8sCwAWHj5y+Q=
X-Google-Smtp-Source: AGHT+IEf/8xYnuiJOOGb2Sge2zyvi8v+F5kXfA+0Ec6yoRGy+k/BnTYqMYRzAU13OsIYlFSS1N9lgA==
X-Received: by 2002:a05:6a20:43a7:b0:1af:fa18:76f7 with SMTP id adf61e73a8af0-1affa18795amr7375050637.39.1715735299986;
        Tue, 14 May 2024 18:08:19 -0700 (PDT)
Received: from server.ucalgary.ca (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16cfsm104973325ad.18.2024.05.14.18.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:08:19 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [RFC PATCH 0/4] selftests/binderfs: Fixes to binderfs_test
Date: Wed, 15 May 2024 01:08:01 +0000
Message-Id: <20240515010805.605511-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

My name is Abhinav Saxena. I am a graduate student at the University
of Calgary. This is my first patch series for the Linux kernel. I am
applying for the "Linux kernel Bug Fixing Summer Unpaid
2024". Apologies in advance if I made any trivial mistakes :)

This patch mainly includes issues reported by checkpatch.pl.  The
changes include:
- Running clang-format on `binderfs_test.c` to fix formatting issues.
- Updates the macro close_prot_errno_disarm macro.

Testing: I tested patches on my local machine (ARM64 ubuntu) with
checkpatch.pl and running the selftests.

Best,
Abhinav

Abhinav Saxena (4):
  run clang-format on bindergfs test
  update close_prot_errno_disarm macro to do{...}while(false) structure
    for safety
  Macro argument 'fd' may be better as '(fd)' to avoid precedence issues
  add missing a blank line after declarations; fix alignment formatting

 .../filesystems/binderfs/binderfs_test.c      | 204 +++++++++++-------
 1 file changed, 126 insertions(+), 78 deletions(-)

--
2.34.1


