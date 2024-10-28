Return-Path: <linux-kselftest+bounces-20858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B39B3D7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D0D28BAA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D81EF0B7;
	Mon, 28 Oct 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1QH1M2Xv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9081EE010
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153133; cv=none; b=qer9+RL5CZhCmqf44wsNY3+5rp1UWg/woSW0uhhEfjJ0EbWMZB5pcAgPLTuBB237/cjZjQqDRIjmSUzL1IcRtmPvDPq6341NiuiSLYbF/xtVsk6s4CrKRDKXRvTEJQBNTFNLaNoHurw1Fi74YjTbe/n8IDwWGA0Ur5d8+LJgXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153133; c=relaxed/simple;
	bh=b7NDcp0ZbtvVvN+n9OTWm8KVIbatbAAOOj0YER5oc7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncIYf0w/8OrPlVRS9Q+HU7/K8NHECkeo+5XgjTQ9zIwtZ+F19H3eqKYmLmKOD9CsGoK34ancayawuiBYaAz75avZ0AaNrFu8tWBy3s+3vdVDcKPSdSTi3dVVskUoZ2Za8LVvBv07LadvzUsw8xdJjc47Xxo4OAE1eGTlgt/strU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1QH1M2Xv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290947f6f8so8639568276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153130; x=1730757930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3ou0NFxNBMI+LK68R3aSahBHwkUL88oLn/g1FPlgGI=;
        b=1QH1M2XvwYrj5izJC2xtekYMt62DZ7zG56TLeFpFr+e2UGI8abFbMX2L9Jnx1vVFvR
         k6M7y9RPM3pGXIM5utjHALB9qanTcptdnOZ2md3wpZXuY+kxTc8ymFNzU3yJKMcvUb2W
         C1ExmcbWlPK5oY9E24/d/qxV6l5obOKux90exJcfkgopWqYxyos1tgYIHUK21mN0EjRp
         qzD8aUd9Gmu7bB7c9TBa1dnMC7nx/iuLeRgs+FL0H1mScvIBKJ0DvSRtHsemjhBU7C3J
         1cBUhKju+oYaT6Ao97CpfvINrGbpqBzA+MQa5I1gnfiupx4TEA96FVMgPFVLEUC2cOJr
         rBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153130; x=1730757930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3ou0NFxNBMI+LK68R3aSahBHwkUL88oLn/g1FPlgGI=;
        b=gKcAfoCvNCyyY9ZNgP6lDnnM+jYUFeCmS/MctGcHw3gXM89zS/DfR+fVPDsatdNFpo
         pMLg+VxWmjEjLmYY5vRytJglBhBRefJCxOLsG7NrHpfrBxo0D1jLXa1W+Os4CsAcz0bZ
         NlFxFtHldBIbbO9oN4rmu4KA6m1FUPUrPHXZxqrDgLTSIwlvuLPfdXOU4uCcDwIfEfoh
         dzQD2UZO+ZhqgTmHtiEK0kUeeVchtVv5LTeTkcZkXAY1jSigJfLQc5bPpqpIcZBuM8j4
         bj601oEGJX31sXYTfrz6zv65n6a1kHhYyjDXc3dmu4BVEPhuyHo1xDc/OnOdfKYrkhSF
         hbnw==
X-Forwarded-Encrypted: i=1; AJvYcCXjD0g+Gxqqam5yB7aGnddlSR2jYY2f3x33/UiAR4Zmc3//ZpG9kY444Z1w5a2bh/ZLYMdsEIpnBga+cJOHJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjJISdFpZqbMA18Fd2cisKIDyi/B1UiqD07XXj3Lsla33xU43
	XYNSZZITSqlQQU5k0G7UtK9eQz5F2uxpfFKcZyDvEvYFI8yBpHRfxgYThQOIbnzShN0yMITm2Ag
	6+0Cf9igQ0bEG3O9iX3tXhA==
X-Google-Smtp-Source: AGHT+IEoJvt/jAg/wrQgLrbnpd1PYPhm7g2qxg9aTFmYZoLnT+5hMX+dRMvN53ZNPQP7hmPh/zEREK2sEQRWA+pWew==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:3297:b0:e2e:2e79:207c with
 SMTP id 3f1490d57ef6-e3087728d56mr8839276.0.1730153130042; Mon, 28 Oct 2024
 15:05:30 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:57 -0700
In-Reply-To: <20241028214550.2099923-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-2-kaleshsingh@google.com>
Subject: [PATCH 1/3] tracing: Document tracefs gid mount option
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Eric Sandeen <sandeen@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[1] and [2] introduced a new gid mount options that could apply to a
group to all entries in tracefs.

Document this in the tracing readme.

[1] https://lore.kernel.org/r/20211208075720.4855d180@gandalf.local.home/T/#u
[2] https://lore.kernel.org/r/20211207171729.2a54e1b3@gandalf.local.home/T/#u

Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..2b64b3ec67d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5501,6 +5501,10 @@ static const struct file_operations tracing_iter_fops = {
 
 static const char readme_msg[] =
 	"tracing mini-HOWTO:\n\n"
+	"By default tracefs removes all OTH file permission bits.\n"
+	"When mounting tracefs an optional group id can be specified\n"
+	"which adds the group to every directory and file in tracefs:\n\n"
+	"\t e.g. mount -t tracefs [-o [gid=<gid>]] nodev /sys/kernel/tracing\n\n"
 	"# echo 0 > tracing_on : quick way to disable tracing\n"
 	"# echo 1 > tracing_on : quick way to re-enable tracing\n\n"
 	" Important files:\n"
-- 
2.47.0.163.g1226f6d8fa-goog


