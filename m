Return-Path: <linux-kselftest+bounces-9850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1A8C1666
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C242868C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA613A89A;
	Thu,  9 May 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/JDoVCa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C213A87A
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284924; cv=none; b=cvbdEfUc0CmCtX6r8YJhjZkLy+dOM831j75rJQpqNP71u36iN/ub2pVmZFf6HLJrDV9AmOdKZI2+pnBlOgCrah1z1xaoHGCoNQo4CVAZuhATL9rGtfVW/YSyD8mZbDFWSS4h3t7c0I/EXQqKnjD4YMQJvlUU4wn+u21ty7y1XRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284924; c=relaxed/simple;
	bh=MSaNSVn2H2fXKJMZvElS2FKazJ5y9Ory35O+Q9b33LE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nYtJnUJ8ONGo5TTBXD/HQ9g4dzlkxX+R+HvWNsb23MQ9rPzc68KOT1b/XyNDMaTqc1w3GmGNZeeURgTQ/eQyHB9QbxhzBtKc4LwuWzNB11vfX3WX9uSBWNi8LvjQAONXFWqDiG8vbfm+RVEohpVG8hkF0qwCpegrIpVBCd2UdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/JDoVCa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ee128aa957so1306103b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284923; x=1715889723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F47u4j3b3GFOE9nBbPizFblW4KN5wlKfs78lSrCeF6g=;
        b=q/JDoVCaEHYxDmkbNkVV0LUBx+gBUxuHuFwTIIwVrqf84C1I85Re7wu/t8O5NcvRzY
         1VkRWpYKFBqGS4k1BfBGu7KNPigGBA/g/a4NoFLno8WPhqlgpXIYgoxNkp1VTMuT/4bI
         7EhWwtXK0BaoJ30rhjYZw2qHRpZspjF/CUKB+rY4ENb/3v2iO4WXIiGvdh+/zs8TdLAG
         eu0diIjuNofk1A31CzfCxs6KhcXpSytH+G85X5piCDqXL8rbtSjSfRi0kf+pT9h7mbnG
         hqD17vigiH7hjQLs/t9Ic9k+KgK3FbB8qkPTK9FnUFbhzHZHgJDhBN4XVFQODBue8dwO
         KikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284923; x=1715889723;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F47u4j3b3GFOE9nBbPizFblW4KN5wlKfs78lSrCeF6g=;
        b=F3KaPaPg6tCBvaEiOcgXy8lp/NkBmQYPNEhReze9ZUN9wnRtkC2qLTn+W9pNyXp9kN
         cHounsxB1xpzGwJZVq9pZ4lLs/KhyEn0IBwvxRAubqQFLZ+/x537Z5HqnN3oErq6CkG2
         aYLtICJL93OTaC/buqMvUvV8O1aYZpSNxIYbJPLmJiAPee6om5uPrSs+p4HD9usfUqe4
         fmJtvmbYh+Pa+Ol+JiI9eVT9OHu4VyAjqbLCAB5Yt/ABn8KajxnpGOz6koGLROM06CRX
         6Y2vSlpSc8MkpPXUD9YPu5SYLF7g2p/SY8SZBlJcWPFIqFV1k6oxyztwlGWIQhMl08wK
         emnA==
X-Forwarded-Encrypted: i=1; AJvYcCWifnjudkXMVOMYx0jey9megGRTYXHE0KIILVRUl4mYB3KP+px/psanXaaNJsozWJzn5Tzyrjkri8u/WfBy7RXj+cdz1ljSw+rj779piXhB
X-Gm-Message-State: AOJu0YyhiSEhw/JiQJGGyoXDULBdEryUdvSOcUc/JMvWkIhtAvz1HQiR
	7s1p2WQ1mE009QjL2bSqoK4mNXHbt2Yo7CxhBPIg489h3Jag+pA8zIbN6Ja5KiaKoSj5HhgY4Nk
	hAg==
X-Google-Smtp-Source: AGHT+IEwxeU3tl/HtqsMnTJkYdZr1n57m7vtfQ4Aif9keJqoN/Cra4P1os0zNIz+mmvEABVwiFWGOQCjS4g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4b03:b0:6f3:84f4:78e4 with SMTP id
 d2e1a72fcca58-6f4e03a9522mr1248b3a.4.1715284922572; Thu, 09 May 2024 13:02:02
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:19 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-28-edliaw@google.com>
Subject: [PATCH v3 27/68] selftests/landlock: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/landlock/base_test.c   | 2 --
 tools/testing/selftests/landlock/fs_test.c     | 2 --
 tools/testing/selftests/landlock/net_test.c    | 2 --
 tools/testing/selftests/landlock/ptrace_test.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 3c1e9f35b531..c86e6f87b398 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -5,8 +5,6 @@
  * Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
  * Copyright =C2=A9 2019-2020 ANSSI
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 6b5a9ff88c3d..eec0d9a44d50 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6,8 +6,6 @@
  * Copyright =C2=A9 2020 ANSSI
  * Copyright =C2=A9 2020-2022 Microsoft Corporation
  */
-
-#define _GNU_SOURCE
 #include <asm/termbits.h>
 #include <fcntl.h>
 #include <libgen.h>
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/se=
lftests/landlock/net_test.c
index f21cfbbc3638..eed040adcbac 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -5,8 +5,6 @@
  * Copyright =C2=A9 2022-2023 Huawei Tech. Co., Ltd.
  * Copyright =C2=A9 2023 Microsoft Corporation
  */
-
-#define _GNU_SOURCE
 #include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing=
/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..c831e6d03b02 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -5,8 +5,6 @@
  * Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
  * Copyright =C2=A9 2019-2020 ANSSI
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
--=20
2.45.0.118.g7fe29c98d7-goog


