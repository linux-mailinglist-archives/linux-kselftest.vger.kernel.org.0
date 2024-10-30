Return-Path: <linux-kselftest+bounces-21149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8349B6AE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43A8281843
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C321766D;
	Wed, 30 Oct 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zagntXFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C81BD9D1
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308860; cv=none; b=EZK6MCcExkJYU3Grz+pJA7JKOyzk8sFQhv6JFXBHveTb8AA/9femPX3aSPR7AQO7M275B91LsIVkEauwuAeD90jkQLDUzN26HMDzC/eqsGK4X+5O6DLhMMHPXyT2OMHooT/Z/aj8LMRntSQuJaop0KlitTUp/fUF1SFIAGmVizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308860; c=relaxed/simple;
	bh=rDPKRF5nbM8EQhE80nGXFbHhdN7TfLAQ/0VKEszrmh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYzDRnNNFT12E2ZgPdk3Ipfb5h+8YM1+JGnPfqgPJLF35p5W1lOpyUrGLNVGa2xN29S1BMwfWIH2DGH5SBjXeXLHJoxVV2BBQ4x8taw7WXfuymyXcjnuo3MNMdtiuBMzCR5QxBmEpp3p68T7RtjugTzms1edmYrv2ooJfjEKn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zagntXFx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2946a143efso116039276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308857; x=1730913657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9Xa4889yKfv5Xap+j/sksIJtCR3GgXWQrx5hFIpw=;
        b=zagntXFxRZqTxnxKXcgJeayJuezPjyn5mtzfxnUrqPMZbooV0xXDnE26UqCXLwJGCa
         J1+dD9iSDg+t2YYTqvEXIGHoJmZcENbSmnZ52VAluSThydDCp0XzJ+aVZj2X4hvX7+5O
         gJry2sSOl5xCuOtxjuoTlv0Uv6zlN8dKZLt+TaU4QK7/264CXhhK+8243BNXGPmegEXU
         nZjmr/aFmmkFAuSxSp9i3Gb045S3Rfp/MS4SysyvsBHV3RZX0bFOgJY0+MQw0m9xjg+E
         +qao1Tu590uX+3Juwn5d3BF8jAXZ/Eodtu75fYMvtbYlmLp1VirvrA34fEZKq79PsTf5
         xLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308857; x=1730913657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9Xa4889yKfv5Xap+j/sksIJtCR3GgXWQrx5hFIpw=;
        b=etIMmxxrTa2474xA46tsWLohr2x01Os4da+EeWBItY8MAoeTHrRdlKVon1kiKlcF+G
         MQmYAA5XhC+k0zxc+gssRrKEaxm/KkKfGIyB+TY1x3N6MlVDM/wjRO3GpJPcUAGFX66k
         9GnLraVVHNhas0jkQRoRUPKK38CoEO/jS+ALPI731oi1kBUI6DtYakXhRIswtg7y7e/7
         kZLsxAkR+Gw/BA+dAt4pQvwOPYPyu4M9xV5FOIi9CdZ5mZHJY6Uk/t9+NC5fdwxgImRi
         adJtE0c0Uf4Uk5PV8MS5dLz7ijXWhtvpuv6O0ip78cM84gMTcRHe0iuzvqP7IBN/h6ha
         TMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu8EGvKS50dUeEWAMTgEgNFZpEVn4D/b24M3X4mXAcZH1yRThZ7xRgRaz5q3W9jOl6ivjOytt6PZfA3avrIh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJq0m6x/G9F7SvpP/gcxbESbyFlsHtsiyKAqvHVOenX2BmATUj
	uBx5L9kBDqcCIR2k4rLnfDdAGP/UIR0Lon5Au2mPSr04H12SsEuuOqz9bcC50KB5UhEvBhv6RF7
	spiQ8PKcVPtfxvD1eEZvqgw==
X-Google-Smtp-Source: AGHT+IFmFQ2+ilc/frkLStjSQyf19IpIYrW2nD/6coGLs4CVgqbF3qEYdPRbZm6F8+l8PBqgjQXpJziq3HiTUEpEQg==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:d4c:0:b0:e30:bdc8:567f with SMTP
 id 3f1490d57ef6-e30c190221cmr60305276.4.1730308857554; Wed, 30 Oct 2024
 10:20:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:49 -0700
In-Reply-To: <20241030171928.4168869-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030171928.4168869-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-3-kaleshsingh@google.com>
Subject: [PATCH v2 2/3] tracing: Document tracefs gid mount option
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit ee7f3666995d ("tracefs: Have new files inherit the ownership
of their parent") and commit 48b27b6b5191 ("tracefs: Set all files to
the same group ownership as the mount option") introduced a new gid
mount option that allows specifying a group to apply to all entries
in tracefs.

Document this in the tracing readme.

Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Reference commits instead of lore links, per Steve

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


