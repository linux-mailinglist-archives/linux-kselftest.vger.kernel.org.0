Return-Path: <linux-kselftest+bounces-9873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF218C16E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AE328D776
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6A143728;
	Thu,  9 May 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmwdionV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32A14290F
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284998; cv=none; b=qlCXQuwC0IFGSUxdNnv+PjdqgZL2emuXb3bNGo+wzoQ/yKGBuhoig1j9zTXKQmBwZOn4Z1kZuVRZ2Le+lyJQf8D7gAJUHWezhAa0l1xFDGiWtfuE42cFE6eJkQqtkWBtP9oV9ebTLv5PmNVRicp/ZlqrTA9vSG6uErejatWJV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284998; c=relaxed/simple;
	bh=5eCs2dGnvyXJyHpHcW99rKbYfAt3cSCAPK72Lv3waNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ErHUPR3Xi/WQ2eArp8BNz0UgZvlbxkCaRFBdsEIHQR1/f6NSwmBoDJ1YHzmrnnFdmG/jNYdNYDGKTgbbcXqNpkaAmpSi3qaIP5QADZmaWYnQCz1Pcu+EE5hYoaYxrmYeXIPOFITXZusO/7lzs6urOXVGbExoXQnwnDZhpHGXqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmwdionV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f454878591so836055b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284996; x=1715889796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy7DTv1aGKmws/cPGkTZCbrHaB1ocI0/bjdksGN1y4=;
        b=RmwdionVv+lFDdu+RyCiQO9pHTCDcpsKoCMy/Hm4k/KSBu265s17AubvIt1b4FHP+E
         hBrHCt4GUddE1rzxZMhYrBI63XQW7/NFsoSnuCxOncp44vi8Q56oIGH6IYkNYJjyr65P
         JIKXXiGR2ARHR3NmCoW3KWOzWwlMNMbNeezpnRUruSAm1s7GMCuLb7vclVgZYDwZO3hr
         EAQZDdTbwVSdgd6t1WBFU8yz5yJlvA8925kaGbnDyZ5X0CiEja230arE8/dFqBKZw4Nq
         vnPEzjPCnL4qsW2BfsGnAJXqp1gFYEGQJnA6cDgX1Qu8T4YvvSAdD3Cngedwll6ekYnK
         rWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284996; x=1715889796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy7DTv1aGKmws/cPGkTZCbrHaB1ocI0/bjdksGN1y4=;
        b=e3cqNfNlfImFmATHJiIK6Ux6+Nm5TcQTxD8Uw9Pnq4VgK7D39eyPZRY2cbeZrOLx7I
         ZQYm6rDu+e8QcA7RctCiv46ZKtNsgGpMRno5HX/5wUqv/x9OXlxVWqV2R8X47nb3L8Cn
         RH+kNIzr3hq97C4drnEoVBssO8jMRza977YoAIB5CH3StPHRr6FKwGcnRKM/iHjd+kEQ
         zVctKGZe+oeMBg7/hol7HeDmsoyVOEqfj6e+QxtWDHLFwBGa+I5CKuzMcDGSxiCWa+gJ
         LC8Ek0ze7ohExdcEvCqb5lLo0rhnBwN0LsJYK5b7N3c1qh+aYxxiuYBxqAI1h5hXdaCU
         FDbg==
X-Forwarded-Encrypted: i=1; AJvYcCXMknuXeNuNlI6jMfxm6cScb4XzFHP9wDyE1SPvlbT3no0cJ74V1q4em7H2GJ5hCz01O/eP91BadCVW5o7rdSYvgEcLCAHRH5f1aE2YlA7W
X-Gm-Message-State: AOJu0YwInYFRByJy4UXLNpzP17wWnqieaLycS1/1OR2ZGQlHWPJsQkN0
	pyWsVer271JiDUZZTkwKBZno1qj9C71mrojMsPw1+GG1S6R7hRzSVTcLSXStPRKIf3ACiFCa2zI
	mTg==
X-Google-Smtp-Source: AGHT+IEJ/rJS6p21P2/qhLYsQGGVjwiajthmzURaTvAjOCnE9jf3eBCmxwF6D/Wet0iEWq9F++qDVmCDiHs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3d54:b0:6ec:f406:ab4b with SMTP id
 d2e1a72fcca58-6f4e03a195cmr28293b3a.4.1715284996043; Thu, 09 May 2024
 13:03:16 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:42 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-51-edliaw@google.com>
Subject: [PATCH v3 50/68] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.0.118.g7fe29c98d7-goog


