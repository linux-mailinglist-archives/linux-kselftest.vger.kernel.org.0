Return-Path: <linux-kselftest+bounces-30321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F1A7F091
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 01:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBD11694DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925222538F;
	Mon,  7 Apr 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsEbvlNy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547922488E
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066798; cv=none; b=AxVVzOyAjU0y8TSjDiS/D4JEt25HF2dwqVaoPPnHGFMylXkKhltRv3GQWimFBJ1ovHTOVDcvjxeuuCD+D5niKPzxYjMcM4wdVMVli5Fz/LX6rR5xgbegavwa5znsbdMi0qOuRGmQ+fj/InJn2H3kJdVylf26e2XZY0gKUAGjgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066798; c=relaxed/simple;
	bh=5LbPyCNLLcTj5RpphsHDzbLID3Tqav0FNxp4F98aH8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DtZBFchYHIV8ty87cMIPZO3nnvw4ZOHL3+IbRUYEXclILny5M8vIwxbAGyBwWjwkKMnP7CtosAOs7WJCBPu/EvdbAkigsv/Y+3x4g9Mz6qrsyzqqPpc5n6Z1pGDi9halYwMKIi7DpQ6uJsBEkdJhMlJQAA3HarCMTsd7gV8Wvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsEbvlNy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so70164895ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744066796; x=1744671596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmFTd+75mDki530ZTm5rh5SILZIWEG1jv3Vb3IWwElo=;
        b=tsEbvlNyehmbqFR4/suebCqNArg3BU9GTqqBnvYKnkF3RtVx0gkeCGzc5QtIKQdbCT
         IxyiyWrcZ7jlNnWqysXej/+JE1DHCDLwk4nrtQ3GL7Ca4OIi8bPhzkD4CB0txJec78Y1
         +6AFNEn9zBn4Y5ZfWsgmcutMUosASvXBzf46J8JknADoDshrgwqrxLObzHQ3ud2Pn+zx
         CKwIPe+/dUHhhQKdQZiDRm9PyJfhJuedllMctpUL28VjDBUy/Pb3gip9CLgFHmbnt623
         ndaP0FGTsXCaVKveD7oTXOKSmEixvjDt/AUQh3EFbEPuYxow3nonJV855qp7TQcp2u5q
         UXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744066796; x=1744671596;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmFTd+75mDki530ZTm5rh5SILZIWEG1jv3Vb3IWwElo=;
        b=s47M3bLzpDZ/GqoVHrpvPq5ttVlvuWMculHRU/enHhRtYYPs32e1MdpJm5dsb8Jjf/
         d0FrOX4rTg7YNMQI/SnpE3061U+2dBS+ODLPcoBBfzuG/W7DgQTZHCZlMGhMVTs24zrA
         1CaSO4QIG5wQJKM2TPKxVIffkjzav6uQnRfLIl5C0L0qwOaY9DE34Y9xs9MVw+zSElWe
         sIN/b2gVrmDqwPrhTJuXic+wqr+lucrOtL6NxP5V6N24QrZceO/b3ncRDG+xwQP24Vjr
         cUCvTRpmRxU7lNWGZD/zsuvyaa3Vq0KD9+Q4zpyqv5l7QqSUz73XdjPewBceg0aBLUb3
         3+2g==
X-Forwarded-Encrypted: i=1; AJvYcCU/fxRjasXLub5qxd3QQ8P6tkphmQz7Ula4mY9cqNdxYeEbtQ7lx35XSvkG5QoKfUGsBwO6qxPj5kGO8vvqgD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpgQWtX/xgI3mTGaTbpiTJdmtAT1Y+rk0M76iKq8CzPzIKaC5
	OLbmCdL0n6sWxo+lhqNgfUMTUqoN1U3+IddeEDiXq2mnXlIW0VqCSGp8QVnkpFb0XM4hXEQ6vKF
	YZdmLQJ8QKj+rvw==
X-Google-Smtp-Source: AGHT+IFskHOxsSaypr7Z498msZSpofqWjjn89muNo0ISrDKVaEqeO6DZKPcTGrC/EZ6umNznNFtR46hyuWZumVA=
X-Received: from pfgs3.prod.google.com ([2002:a05:6a00:1783:b0:736:6fb6:7fc])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c1:b0:227:e74a:a063 with SMTP id d9443c01a7336-22a8a0a3a2dmr182684035ad.37.1744066796203;
 Mon, 07 Apr 2025 15:59:56 -0700 (PDT)
Date: Mon,  7 Apr 2025 22:59:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407225953.1540476-1-tjmercier@google.com>
Subject: [PATCH] tests/pid_namespace: Add missing sys/mount.h
From: "T.J. Mercier" <tjmercier@google.com>
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pid_max.c: In function =E2=80=98pid_max_cb=E2=80=99:
pid_max.c:42:15: error: implicit declaration of function =E2=80=98mount=E2=
=80=99
                                       [-Wimplicit-function-declaration]
   42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |               ^~~~~
pid_max.c:42:36: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclared (first use =
in this
                                  function); did you mean =E2=80=98MAP_PRIV=
ATE=E2=80=99?
   42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |                                    ^~~~~~~~~~
      |                                    MAP_PRIVATE
pid_max.c:42:49: error: =E2=80=98MS_REC=E2=80=99 undeclared (first use in t=
his function)
   42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |                                                 ^~~~~~
pid_max.c:48:9: error: implicit declaration of function =E2=80=98umount2=E2=
=80=99; did
               you mean =E2=80=98SYS_umount2=E2=80=99? [-Wimplicit-function=
-declaration]
   48 |         umount2("/proc", MNT_DETACH);
      |         ^~~~~~~
      |         SYS_umount2
pid_max.c:48:26: error: =E2=80=98MNT_DETACH=E2=80=99 undeclared (first use =
in this
                                                               function)
   48 |         umount2("/proc", MNT_DETACH);

Fixes: 615ab43b838b ("tests/pid_namespace: add pid_max tests")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testin=
g/selftests/pid_namespace/pid_max.c
index 51c414faabb0..96f274f0582b 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/mount.h>
 #include <sys/wait.h>
=20
 #include "../kselftest_harness.h"
--=20
2.49.0.504.g3bcea36a83-goog


