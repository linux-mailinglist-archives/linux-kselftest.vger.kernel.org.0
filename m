Return-Path: <linux-kselftest+bounces-20857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D939F9B3D78
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A328B28B65B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB52F1E230E;
	Mon, 28 Oct 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1iUXEXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CB18FC67
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153109; cv=none; b=GnDyvLi57/aoSLVMQBf7WINB02gFEkw3lwz1NS3rUZqOxOlm1OsdyDzxf+L12/MGT783tRVeZ/N2UIdCPJq6Ejq4Ok34cH/kD74oP5yfdZdFfzwgnOns2Qp+ZgHxI0r5MsC72Dwi26zIvEKYon8wn5NYp1oxzHzCkB23Y2vUM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153109; c=relaxed/simple;
	bh=0hoHck181vRn1NSr2f2PwuVWiPIZTgKgLGSUOf4IQxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pxCu55TTd86gvZkhDNid4+34vw85TgpdBBkriO0DbMYV/Cv5Z67vVWNMiYLw9KqjxOEBFodzp4StyU6MJg5MqOvLe6YZjNPpChIVDJbrHdCkHFx49rHBYyb6Yjj1nhFJos8o9OoHKBTUrMCCRCCV/KE5i9Hc6hza3U/cSgmiews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1iUXEXX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370139342so87993817b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153106; x=1730757906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWhquCb49LKi5H2UYgYKpnhN10davrTJtCE6vqtRvG0=;
        b=L1iUXEXX23c7s4SOJfwXncF8st+C577cU7wbrxCeM0rC6RBqgRRNhucnuFc6Fuls2B
         nhYB5LkBne2C/+b9lkOfOC2gMVwbN+ER4p9Fu2gvNOAtjD/lpSIAz1Uy9nYcHaSWrwW0
         md+SXybpg2NVcb+/fVbjipXe2zNG+di/HB+7NpmvEgVMaTwi3m1OLuR5zNq5SjqhPIQ/
         ERpIrF0pjUCVrD7WsQFMPRIQWpzckSWjV+rko9e+2wFnQr4NdM6PxlaykQKOx9bRzX50
         SwcP7KBOhXLVLacbTK/75uG+I29BMVSpNOTYGcXxJhTJ7KqBi0+VubR9VDHDtxlQcM2R
         a4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153106; x=1730757906;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWhquCb49LKi5H2UYgYKpnhN10davrTJtCE6vqtRvG0=;
        b=JX2HTt2vMJGwoW7Gnp85DJhweaNa4VrU4gA/oA/hGtU3NoTeWvApI420eMmwhiJ1Tg
         oeY0ZJbTvKzOmqJjU+xcZLUbpn/ASVEILwn/gceC2WxxiqOdWPrjnk5KdQaxHTAWwmf6
         r/BgUpc8b28Df9emHJ/lgf10cEy7sWnqnkNoUvrTXxzIvsI0RU2GfrVHZFKn64NUNAAY
         rQgrbL7YVmtvZ1GtoycAz3t2iEy2uCoqVmgVCa6r8oCmCuOEeO4Ni142hghdnhYytohc
         uAczIUF6QhxLFm7Xf0hpivbL+f5hZ8QDt3B+jRkKXEIx1YxHAb2njK0NrVdJBPp2WDIQ
         QsWA==
X-Forwarded-Encrypted: i=1; AJvYcCUrmEeOm514oFlaPxKpeXlRTTvdJJcCFhSd7U4kJn72ksUfqfWy+kQ/hhko4uvIRIIxew7kOq7JIYKlH06gOQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YJ8EbOUxg/fb9F3uCVBYz1lhAwallpk/eLGmAzRMTCYy5iRI
	rHVx8NgEicieCKChD8QhK6BsAnm+KE8ev9v9IIbOi+xZpmf5HUIoomhYKa31EgMGYki9Pp1OCd+
	XvqweyRG2VUx/UCWjYd7OyA==
X-Google-Smtp-Source: AGHT+IEAnCfdVLBm6ktQBhqpFyGMf87tkH/Lnfvvyg2A06ArHO+JMopPeHeJSfmCQLpmkvHXVSBQbL+oME5hPCmQMQ==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:521:b0:e29:7dd4:a945 with
 SMTP id 3f1490d57ef6-e308784b3c3mr25736276.2.1730153106526; Mon, 28 Oct 2024
 15:05:06 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-1-kaleshsingh@google.com>
Subject: [PATCH 0/3] Tracefs gid mount option fixes
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series is based on v6.12-rc4. It fixes an issue with the  tracefs
gid mount option. Adds test case to prevent future breakages and updates
the tracefs readme to document the expected behavior of this option.

Thanks,
Kalesh

Kalesh Singh (3):
  tracing: Document tracefs gid mount option
  tracing/selftests: Add tracefs mount options test
  tracing: Fix tracefs gid mount option

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


