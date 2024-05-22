Return-Path: <linux-kselftest+bounces-10505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CC98CB751
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6B0B2425A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480D146597;
	Wed, 22 May 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLTtOhdx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE14146017
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339625; cv=none; b=e7kqEcIc8Mct2FQV68GawfZ9buvLSgsucAit/9tOQqCSCjHLbyKytFU+LvOwt/HQIxCwQYInFS4dmq4V9MzFy6CK5c90sreevaufz7ua/YXJp3zBH/W+yWKxravZF4XcOOjEZPPpoTYn8V5+6NhX8nYL8N2HOrQrqvPD1cVuf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339625; c=relaxed/simple;
	bh=h2u1MofALu0r1tYsSYukYszzEq5gHMXIX9iUm9aPpv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EO9zVv5YFsMU4wJAE29uh1fAwlXkNxiWa1+Zn3H050jKc1ojYSkrqvVaP/mZc9fvAJNgS9vcVCO1R8ZtQ35hIzMflcwOPnG6zBHXncPf1lYStbVdwYP5BGHsjr+mZlEga/I1ieaD+Mjl/27Mu1KxGHdc5jv4za22RCc7WcrAM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLTtOhdx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-604bad9b2e8so12370827a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339624; x=1716944424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NK4aimLzcbzcHbun/AiqJMn6SwzGMo+GBjyX7d91cEw=;
        b=yLTtOhdxpJw7AIeqoZGxYnthyR5KhjOoSFpQitVZcURhgTCyvxMX6vR6juapy7h+9N
         f03TpNYeGMeBA2y6LMHt9QFomIFDpn+CVL194UM/v4taGt9aBvWdi3Fv2OhKx9l7uaI+
         OtycS5kol5aPsydq+GkLGiyi/ue/5wk60oWOoHBIapZR9nISOLaGLcJMwqcAPg6ToIir
         HSrVYpWNCIZlrZxgOK5i4ZfJMO2nO3W536FYc0ZRTTuBEu5wtuPSvWWCWgxn+uLmzO+n
         MpaNZX3StcGh5spUrdn+qtPWbrhTBHNNFHlsh+NNK7ZH8+slrAU9YQtfamDQgsXARoT6
         6rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339624; x=1716944424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK4aimLzcbzcHbun/AiqJMn6SwzGMo+GBjyX7d91cEw=;
        b=WBNYzyPU7IzlcGAOY7sY5ko+dPWvloXo548tUfFdMd/xJr3vxazZ/NXEbfeB45LuYf
         2lstSZFg8B2tTe+d/3D3O/b0cnxC0ZikkBpwsilCuJwF0XdfA/BVXrb70wZM44OeutaZ
         68BkgctlJdpXX/Zn8FOGsnjJ2Y3YYYAyFMCL142Kg/7/sCIPhUDpkju23v+0TPyrxxyZ
         hX7r32BKtOSwGTrqnKUzFsBgW/yaTY1gAXfv87ZdtW4cN58nktShxej5H5EoTYrKoXBj
         n6w8/7+ng+Ejh0QGF/myEjjspaTe0mnJbpjv8/mYwhyI2i5crhV3r3S2D+MrEHYVTGXN
         rSKA==
X-Forwarded-Encrypted: i=1; AJvYcCUdUATtVxx9xD179lqIx8O8zStY7OVq1gWtBxrS0J/lN/0PAi68h01bqIAQQRDKzSNux9awC53No/XQU7uGCrRcHA9wbWokKDJ1oVFXJt2+
X-Gm-Message-State: AOJu0YxOrU4tW7sHv06DPl59gtP2kVH3oE8pc0kEB/0uzqlGG+SYfn1O
	dbGZIyLVSFJmEmo4BsJomyM0ZQcJ+YQAC0a9YP/HjLnuELZrH/BM0eWZ0MMI9YDKCGeFlTkoOFQ
	yAQ==
X-Google-Smtp-Source: AGHT+IEfubfbv0g1n6E/xjRKgWJVsI5mDRaAB3rAehbhcdlOwRi+21CKT/tu9kKkmJpP9Jll2mvLmtGZyiQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e74f:b0:1f3:135c:f70f with SMTP id
 d9443c01a7336-1f31c97ec7fmr402795ad.6.1716339623577; Tue, 21 May 2024
 18:00:23 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:04 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-19-edliaw@google.com>
Subject: [PATCH v5 18/68] selftests/firmware: Drop define _GNU_SOURCE
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
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.1.288.g0e0cd299f1-goog


