Return-Path: <linux-kselftest+bounces-10550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3E8CB842
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2170B1F2515B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6CC15B971;
	Wed, 22 May 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usQfgb71"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13615B152
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339756; cv=none; b=KhMKAh4Pe793XlOW6QYDWusbLRYdd+GAvlBBhhfQzsEKN5qIOfh2MgCUOr9OE7I8gZPE0PBFqVk0++1ReD7lMVNK6O0/+lECrcWhpw23Ak01ax4iuwSsmy2nOIyL/X93cLrtULXiSeHaz5sHpvaX96u+5rXPJ90FURFia6Bkmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339756; c=relaxed/simple;
	bh=RS7rPE8AKloHG6WzPsTg3jpXH0LcLyLyrga22Zx6Vcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oACNdWpNKJs6O9WHxT+HAcZPvWCr6iQJXt8gpJfILw3sTfzXm0CzlAAOPds0HXovqYp5nmkZ5iOHgAElV96sfbqoyojdGOmLu1Sv+iaZ6J26ITJd1UQ2ZVD8gZFFOUNkwq+7JRZZ/S/X/tEOKHZaTEq7ypVcr4kUSYBumDX50E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usQfgb71; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6204c4f4240so216645777b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339753; x=1716944553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB5Ap62KVVuT4Uqpd1hkwJ0UXOFlpsGfFy42T0fhJ4=;
        b=usQfgb71T3STK152exlBiQIZrjlwDm4bMxjED0C53hFoJg2T3WHzWrGacmP+448v+Y
         guCCYaUTPt1n67Sag+1njjqoWDWdMoMMz7F75/EF5FFOxlX5NNiYJB6W14dnuEhSXRy5
         QTPUNvsQs0rhCPD+ZMijtPakju8kGwCmhiUKrj/uFbgwHlAGYrxTz5ID5vu8eJMPB+54
         Viw3uMnm3kshVvzrMEBCwYErhsjPC00VqKQI4ESh96WxRqcu0tsT/jdQqf84ejpZNygp
         IYRX8anZENkFv+87a5UeJ+JORFYylR5vaKyHMnJCXEtTQmUZT45lwXA3/YHV1ImSstXt
         NDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339753; x=1716944553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB5Ap62KVVuT4Uqpd1hkwJ0UXOFlpsGfFy42T0fhJ4=;
        b=k2wpAPViG2sRd/Urhdy5JdLLPtbeAl7GWlbcZMjpf3lKNqadR+4wElxeNfAivWzMnP
         ZyGAE2dOkIi0zQJkmYLN4DcCIndnBXqtx9xQlp6HI3ACGdwNyCSXThPlER0M6jksubo7
         GERhzfeBvY/J6G+4PqKPaEMfnE63OoS9zuYEL1h/EQ6bXZV6+5RUaodwKNYra2ACfBc3
         I7//4eBzJ+e1CRYY6UsiUhtk98ElsuCcPxFQjzCMide0F4JR+LmzDdWZDdpNxEOPLeUh
         iN+qAShp/I3iYTqerwK8pUy7nNzVSyVBNG9LxSVjjPkf1WOyK/IzgYVlp+f+2wOav3I0
         ewtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Hnkmq8BDWWufVkl/+iEcYbBNZu35bokojnEMk5DNzjgqSvVMNOH0qaqbkFWji0zP7Rui7bRe2tUzOgdpAO5ONWsSRIgdswl00AaknKqD
X-Gm-Message-State: AOJu0YywJe5ZvmvMuks9HqoBSrVgDdjF+iVdDrkMEIXXyiPU9y5WANoP
	LUemAt4DXKqvL0MwlxCRkhk+9fblXCDtQFp4YZne1uiHj+avRnxVNVtAE72C0ToXkk215TPAO/G
	UzA==
X-Google-Smtp-Source: AGHT+IE6DaOUUCz74vGUOqCerBQLQc2Nz00SvVsD82xkEGEYIxXJhZ7/jUS8DPdXT3VoOulznt1IlpyCyc4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d895:0:b0:627:a961:1b32 with SMTP id
 00721157ae682-627e4886e1cmr1667607b3.6.1716339753056; Tue, 21 May 2024
 18:02:33 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:49 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-64-edliaw@google.com>
Subject: [PATCH v5 63/68] selftests/uevent: Drop define _GNU_SOURCE
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
 tools/testing/selftests/uevent/uevent_filtering.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index dbe55f3a66f4..e308eaf3fc37 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/netlink.h>
-- 
2.45.1.288.g0e0cd299f1-goog


