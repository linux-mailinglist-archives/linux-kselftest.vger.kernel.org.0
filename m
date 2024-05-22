Return-Path: <linux-kselftest+bounces-10513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B78CB77B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407051F21492
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57214A60D;
	Wed, 22 May 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJYVpxHb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0314A4F4
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339644; cv=none; b=Q8sARylGp2Z1SkQsLlH87CmVVmXMq4mLSC4dLj0MGhrVzxMK0r1A0o38SlCl+FGxV3mwvNlKAGrrRjkhXw62zQ3YARhTvzRfLhx2j9tsiHoBwFM+JsYa1idZ4CHrvBZAVinABBah72SXHoyCDsDfAFM9q01HVWxNFDXtfJR2YQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339644; c=relaxed/simple;
	bh=vAK1SjmRfYckscjlF9bXWhC3HCJDYSUy2bAKb7cYeUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/4xCceuF3soCKld3vGRmae1NKzYcg6LMr2GQUKnXEzSF4UVBmh1at0N53JhJvs55hApq1SqHMO0s8A6oZFAKugAB5QTt8Ii/yHgEWA7X5qeKWKPmRMBCTtPeKhwTc35fSwMdAU5hTMZ52hORJql8RZPmYza5xfdlG6Orhm0mT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJYVpxHb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee902341c0so14977866276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339642; x=1716944442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/APWv0oI9augsnZmJefO/JsxQIQ0ybcPp2DpgllRB2k=;
        b=vJYVpxHbNpMCtVLkULj7a0AiLkDP3WEjoB1PYaXRdsr7Y78aa0OfFnbNQ62980dRyl
         7gaEmHRWZhpSGbrF2Op3Mt/ir2jQx/PWSLFquxH/BP/CIwQFmtxh9vtrr8sKU7rnx7z+
         YjCPWhBTgx5XcOQqsNtbSZwh6HVnXUVcMjg4vHVZN2gcBbM6N9HBivTbWgLY/RtZ+huX
         OiqTCH/CAlDqeGSvY3UpLzUbBZDX7UD4ls7lkFPVbX1S/fj+nP6Q53hRpaYV5cFrfuSJ
         13plBQqRG95v/6J24DA/xQobdh8kWYbP1gOPPir/YzhYi0eAUenTq2mvTJY//12GtFZU
         +geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339642; x=1716944442;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/APWv0oI9augsnZmJefO/JsxQIQ0ybcPp2DpgllRB2k=;
        b=t8w9vGoibSpDikWv6Az5SJTIo37bR6UX2wU34QTrt8EqJM4afVZmeNlQQDyUZxHBwJ
         fnOkTYYqa9UszZwyul/hV4/GMaE8Zbgu21Yx8Jh9r1GBLrNSkthE1SsCsrSLf6mIrjRD
         a4fjCrgYd+deryUuB5JX7UhwFirp3/n6C+hCMjs3lsHb2L82STbUbVYRV3lFYdau774c
         WT3q+mfHXzD187vb593XWXNVuOXU9xTlyQowH3VyGGVgtAi2ABNWzHLpbjgAjKi/s6Jh
         m+OlUqA0H7gpfiA4Qiyyz9+dgN+QylHKkp7iVtirqOvL6q/SGqFIbaQp9gE7IEecxaI9
         O/0g==
X-Forwarded-Encrypted: i=1; AJvYcCWdgWs+sBCVUwEYWFTLb56tQ1YxZLdTmlqGMGEADPFdHcguU0Y6/9qN0AlYDoSbeY7DgV7dl4EXOp76i98lJc0ThNiXq8HclOO1nYSmezUx
X-Gm-Message-State: AOJu0YyPHBzsYNZr/tQigR1HTNHt4e7PC217wloXKg53hmq27AQ9V+8h
	5x4+00PElJr+0iGfsTrBvVrUaIJWBuetu2aeF1qcfIK3fOp1m47Ip4oQo1lumo46My2t6NXl6nG
	/ww==
X-Google-Smtp-Source: AGHT+IGAclX451NumcxAy9NMEz+qq9f2aWZhVVXFDpvWXMuYKe4iFyqjOFjW34/TGUUo4ozk/aBl3VFiCKo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1205:b0:dee:6f9d:b753 with SMTP id
 3f1490d57ef6-df4e0ac5d4fmr74410276.6.1716339642289; Tue, 21 May 2024 18:00:42
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:12 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-27-edliaw@google.com>
Subject: [PATCH v5 26/68] selftests/landlock: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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
index 7d063c652be1..a30174e2e053 100644
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
2.45.1.288.g0e0cd299f1-goog


