Return-Path: <linux-kselftest+bounces-10520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3F8CB7A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27171F25836
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA8714EC53;
	Wed, 22 May 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2bO7ccy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527814E2EF
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339666; cv=none; b=kvraB1hSslZT7xtvzCni7vk9iwl13wZVtaKN4LGDiADHjwmZzZqNd382VyVWMs78scodIlmxK5TSZK8W5D7C9q1/xnVppclvhGEbKrBnX2W1IrQoyR24gKMVrHXvikqvJ7uD/DCmJsy2vGO7g73JuTr8u5So39Zq7EqipiEB06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339666; c=relaxed/simple;
	bh=D6pMabfdWOjYC/LSqUawpi3nlFHWIIN86xOHz+bpvM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyXI+8kwrG3rQ2QwW++Dxno89NRJXaSo64t//e3QYD0MLhoM73JXYHY+J2L4EyxCBJdeVCCwzxLEExXh+7VwGF9T6HAonkNK5iildW6Vi64aOaJCptZIWk43TbMFHxtWvaOhyHVGugz4Oz4UnIOK39wAwUHeTq48Gpc+7zj9ssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2bO7ccy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-667fd2bf4feso2914988a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339664; x=1716944464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=li4cMkwFpL+HSmSEXdVX350c2G+5+gkC9h0B1FeGGvM=;
        b=R2bO7ccyqs3tXPEKzxf4XjEhbrnu5r+YFZqHPax25EnIdejevjilIkRoyRZh5kATHu
         mj4e7Z5cyf7DC0Ggo0XqtiGBl/rzk54xQbgEsBE1fXps/ghIdm9t8Z6Wv73c31vzJMhj
         U4+wFZTG1by73Qof6XSsP6OcWwSnYmtfbddc6WIxgX6X8n5gnIJqCqAAvQzFRjM4HTwe
         MYu2cm7AIg8LLV4og13cd7Jo0YBdZH36XnI45XngbkueucjswSwycjSEyDdnVOz+mDPF
         FmhEzaw7GBKPHo/oJefHNVrIHRXLtMXzSbVIBmxxmSfe9eZUxedJ6hCUAjaMngmsaFKm
         D90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339664; x=1716944464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li4cMkwFpL+HSmSEXdVX350c2G+5+gkC9h0B1FeGGvM=;
        b=NieVxMnFze17AWrDurjXyQ4fxrEr/27gcwjEKl9p4HpKloUNYVoiUq2nYmIxOPdA2l
         ob0dwX9y/C7lUCiH+MKWe076ys7ST7OnVLrx8PwE18AGpahpobIC36FgTSHBUwfDMlmk
         KirstffnrhRDZNgmJcof4z0OhmDQKQI9t8Gh/HM3B3123xLfzxsXURbuE5lrB41eZhdm
         LXWfeNw64ZlN157gjSdYslU95w1XgR69wLildkTFFMUCh+H1rxI2dpXv1q2PU4LOFcT6
         jakaBgvHoVgUBsxpMnoEVYt9fWlUsQeYrU2S0B7YW+nHo3XrE8HrVL0Z91dtauWVK8VH
         AZeg==
X-Forwarded-Encrypted: i=1; AJvYcCVWxY+YoYF6PsEdo1EPwyoq8B14cFqemDw6IOf6vXxNbYhFSzr0eZ6hX+xNadbJ5Sy01/PaDsXBPuw+4hMwhYyQM5+b4sg6p9h/4AvxYmKu
X-Gm-Message-State: AOJu0YxXdiK8OMkNu1NOmMgm6G96gH9crQ+WVq8GNRouFG7j28Tfl3Je
	z0tkguZGkgZpKUc6pQ6NdVIDf2nlGDa8sC+pEIzTH3WYOO91QzUFZuH2teKnwvWsEH0q7sFsaj1
	3RA==
X-Google-Smtp-Source: AGHT+IEaH9w2a57rqCwXzXPT6DdBOoiiolYlPL4GLEwkxrskFIkwJojwmD2tTcosE6e+p+FZJxRnCD+/8cU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:2644:0:b0:633:af0f:16aa with SMTP id
 41be03b00d2f7-676492d62abmr1177a12.5.1716339664339; Tue, 21 May 2024 18:01:04
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:19 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-34-edliaw@google.com>
Subject: [PATCH v5 33/68] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


