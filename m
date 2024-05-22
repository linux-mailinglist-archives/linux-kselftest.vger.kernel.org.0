Return-Path: <linux-kselftest+bounces-10503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAA8CB746
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D251F21DB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB3145B0E;
	Wed, 22 May 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwcUJ9FW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314584D07
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339619; cv=none; b=M+RgbRBEGbL6a3Fo1OW9DNjKF4jFV597v8cL+efsVEvLUDDe/8qSN5mxv1fU+4QJxnlt11zkjV4m8wYgrsMKRXqpY97lT5Hx+nEKdYl4Lx/m4QKzAmQgiSR6IyXZ6kakZFQ4ZcY+rHHQI6cLx+PA/v0Oovbnd8n6iDTX5sB75kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339619; c=relaxed/simple;
	bh=3Gx9Y7koEuLmKWFa4HZRsro/S/wbBSvGswNHCVIdU68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fD+Vb2SMt/fWWM8ug5Npk+we/NL1SAqMxKuf+kRL51BnloY3T62V+RtpYg3o+zdIkSF+/qx0K/cAXQZ6d6Z9nCZ5D1XowLKyoSnKP1KQZRqw5MV2hr2VT6iQnbwoy8sT5BkcojJJzbHuRG3z30/Os44l3xoCMjdMSt5ITGOUKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwcUJ9FW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b96fd83042so7532126a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339617; x=1716944417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=euH6SpNkjpR6Tnz6zGeol1ij+1qgoiYexMkc8Ht33no=;
        b=vwcUJ9FWdBhqZVaWn7cQicw9YbDmqkFJmyg+GqRsGG7NCYi10ndiXm6uJPnF9JEkRW
         cXb/Wr7xDf8EVjxlUXa9BN8aJoeKZDRtKY9jzOP9mkWYW639TKCDrZwyKVAHo6i7GOL3
         PZh82rWnwmeWBLeqJPHkn3+6aMxweCdDf05X0mMLdBfuAH9Rnbb26YakxKR2fLCuK3Kh
         D/tKON1tAu5V8ou1NN+iLILgr/QKVxx1pRybm134Q9zOFe6rGPJwW487JV4SyhT6U0yt
         6hB9Sl47+oY6iA+Bazb+jHMq9Z8BZxRTIuiXiu3rJMVDTSloKa95P0qJzz1Uj9mTW6gU
         48Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339617; x=1716944417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euH6SpNkjpR6Tnz6zGeol1ij+1qgoiYexMkc8Ht33no=;
        b=LAGV0fMwxYZrft9O5UtcIM/HYMxEV3cc5oVodcFRHOOJZNuL817chN7NMhWVrrbCvF
         qTtFba7ldNAkY0Ev5m9074UcwAjjoyd+i6quxCutGcIZInA/dm9WqS8IpceEgi96JGV9
         XZpwjfGAFP5Ut4+bXYyc7V7FL3NyPrTquSPfxYq2BjBi5DQOZgzNBbsrn0Xr5bfCaUWd
         lEYM97rPMo3FK2YDerBQjognrxUbRb7FcgJh49So/w7MwR+DC4bkonXknOdt8HajsZPI
         ZIYCeq4kCOQYwTQSjtxfnST3+vKNQ0G735rtnKimoZbbRmPWVhkO6UiiGqtSiNvqOnle
         yDNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXT4PCnMNzGzPSCNOfdGcLl6Xy1hz5E3V8UiAogLut3FVOVibhKgbWG0ntZXU3QCXVkuYde5SqJhRB9yR0mzEugR5XMV6+MnTJ8G4zu4Ow
X-Gm-Message-State: AOJu0YwKYqI5P2HRS6UrZOj4ykI68WM9pld8DgJ8QH6vrAkjwJDhwirA
	sLbWvN4e9bvPkzngyskVtCxxfZFf9d8U0Nibux9TBgf0GD6Gd8tzVZ0n5aF1PWdPtIt44K519+d
	f9g==
X-Google-Smtp-Source: AGHT+IEB0tGz6rHOMHOchoEOE8oKcrvsoJF0sE+ZwOacZzPYGlJR211+G8KBWntRy0FMBqnrHhJ3voNI1kw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:695:b0:2b6:208c:8520 with SMTP id
 98e67ed59e1d1-2bd9f5cf34bmr2018a91.6.1716339617419; Tue, 21 May 2024 18:00:17
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:02 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-17-edliaw@google.com>
Subject: [PATCH v5 16/68] selftests/filelock: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog


