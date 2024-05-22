Return-Path: <linux-kselftest+bounces-10542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E08CB814
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC311F2A34A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5421586C7;
	Wed, 22 May 2024 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huLa982i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B648158204
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339734; cv=none; b=aTHIzrtnLrd+wFfsL1nps+pqv/1Z0sykMI44YgJFmBr0vy37NKyJ4CQT2LbxGrFLFkRf72CcZziMtbTcRWYLQ4MhVIM1b6Wok0RvG2l6qIiJ+TXk48mAZF4TOWTcdFfSzOqIzK3G/TcSU8WoxRaMBZMs8ISHU6GGCVd2yx4tzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339734; c=relaxed/simple;
	bh=cNihbrzeHXKylEz/SCN9dJ+kYGl2jhozgZowklGSBnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IS1IjUqzN8jtT5kv9u3nsJVutK/1/yBRsqnWudexHVj8Tds2vCsU3xOihhXuuwT2e2SxXWDGjlPHL5kmpMns1qnrxCh8sKTn/rlZiHPHyGazD9YK/oOXd4bmWIwAHGTN771aUpPYDcJm4aw7Jezo7u5awEEmUenjfy9eSed834g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huLa982i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so15191895b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339733; x=1716944533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAsd/Ppca2ejRhM9/9MWOjE3ktFAjB1L9G3cs3vun20=;
        b=huLa982ip39nhYcAJ+yjNXdol3toF+VODR4r88JoAy3HWw8LngTRTJYRVjiMvFraBx
         684LfoMT38IpJgArwassPpy3tQYzS0k7xDRR2HVtM9tvs5ywB1Mm7TG+DXKbVec9pf7J
         vjGjRtxs7UpdCh/r+rAqIHjNtp/v96nphwVRYiz6wuwDOv+jd5D0rdr2dsS+aTvNm+EG
         VFGqHFYitUmPQjMqhIW0zNCvpPhBdUEAPY4Vj06xA1CObBPWwDc3a1K2RUI9VtL6Gic5
         kfnJsw/BDFvmJuAq2bAhomirpC8Ao/hbEff86KrUbO7pWaMREBoAshq1A99ZHiAPwknT
         5OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339733; x=1716944533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAsd/Ppca2ejRhM9/9MWOjE3ktFAjB1L9G3cs3vun20=;
        b=T4psbQQKA5O/ny/117hg5ccvCUgSRsTux4BI3dFTmeCf4zfKC75+ZiY8iszDE79djv
         Yu6RhuNSCwOT5NsgOQh8hM58zCdQlp5Psja33IXNJlwPN8pI7UAt4vvDKABhTH5Cqt7Q
         o0sBS7dL5DbIKWlzFX6/qGmaoky/a9Ihz7To5Nwgz6K+tE0g6b9vWjWSM+PKBwJ9mcrB
         cqDKI9Nnyiy+hwoj/MZRY49rZ9PkTti3yRST2CNHFFCq5MhEyZvftuVt0TMNG9InDxQ9
         a4d35KYRSWV0RUEMGre8PsbrTjzBd6GVpfcAcq+/aIBC4+bS9222lkEKBKBew94SfosV
         Ytgg==
X-Forwarded-Encrypted: i=1; AJvYcCXI5dspGTFH6rpwIi2AeY0wLzDD5HTK4G/LvTs54vA9LBol+goOvpzvzVna94iRUOrNgpDiWwKpCPsmuXCp7obMXNr7pyhN0WeZu+3rWUhF
X-Gm-Message-State: AOJu0YwKCepFY6WiAm8I9xdt2mR/Fk45dLTOanOSmL6z9EgnFjSJDduQ
	7Amw21qeQZ4ocZ/AvlK1LfWHuUx8p6cFzYV+E6CaGu+BtGPE415vDZgJtodMajYblcoF41IipLO
	kqQ==
X-Google-Smtp-Source: AGHT+IHH7wkPUdUjgwa1/oOxKhUosXdZXQHCdxIhj9UD0tOKCukjPqh+CALUTfw2/d4x2W06CEkVNYszUyc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:aa7:8888:0:b0:6f4:9fc7:d21e with SMTP id
 d2e1a72fcca58-6f6d643e499mr24375b3a.5.1716339732719; Tue, 21 May 2024
 18:02:12 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:41 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-56-edliaw@google.com>
Subject: [PATCH v5 55/68] selftests/seccomp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..3632a4890da9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -2,7 +2,6 @@
  * Strictly speaking, this is not a test. But it can report during test
  * runs so relative performace can be measured.
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <err.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..972ccc12553e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4,8 +4,6 @@
  *
  * Test code for seccomp bpf.
  */
-
-#define _GNU_SOURCE
 #include <sys/types.h>
 
 /*
-- 
2.45.1.288.g0e0cd299f1-goog


