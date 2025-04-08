Return-Path: <linux-kselftest+bounces-30385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44949A81917
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 01:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC6F3B8668
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C5245021;
	Tue,  8 Apr 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaygwAfW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A11A7262
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153353; cv=none; b=VTuIlDJQ83ISIRtbokKz+V8D/EbdJnzqx9wVesyA3qZ7lejhyNMZ86GF/mVtEu5Upbi75joAc/sSSyVq4XZnJUmIDgahNXIhC7h2NKfCdjG/9Zql4Q3/IAsbk9S4OiSMG2ZawgU+vlg64zDTHmUgeXPOoy/31pwpnLfgWe7LLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153353; c=relaxed/simple;
	bh=5LbPyCNLLcTj5RpphsHDzbLID3Tqav0FNxp4F98aH8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k3uLiIYhzu923rYi7NLjuo14aHXbhe8ZPoJ2Gb3St7H5xoxm53e4Oh1jbw2UlqX94TwlD2c9Lw3yu+yUZxrbcxNSoRH8/ztjRjxaHfNUOhf4nUGveu0r0CvLM4UIOWdPz+lGraCzn9YmcN1RWQoZu9snpKmP5gfylk/kvqZYrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaygwAfW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff68033070so5616895a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744153351; x=1744758151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmFTd+75mDki530ZTm5rh5SILZIWEG1jv3Vb3IWwElo=;
        b=EaygwAfWOeYpWYKxXBPPt7hPqtpYsLfpbhKMcYkOFQJrtXfOqCdBYLwKMrbyVTwpth
         Ij+dmSc1d6Yl2BxKnaBXpq4RMOHQH3kSQmjX7W581Kv+BWoVuL7Q/L/vLA9tuLdnTzCM
         HUPVTVVkmEyXn8OjkZgOiylYtyXJzkLg1Rz5CMcMmstvEnkSgrInQOujAJmyWSpUrgRb
         hzDgPvI9Jzx0JSCxGiErSDMOQaMHSCo+giPl7w9Sax9eUWWietk4bOz6Yw304PrJ1f9v
         ibc/2qhL7tTKDPsbg5omNy+JbRZHZKDV1MP17jiCc5faoU9wNoLlwqMccq9rzKXQEefL
         pAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744153351; x=1744758151;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmFTd+75mDki530ZTm5rh5SILZIWEG1jv3Vb3IWwElo=;
        b=udJZMOhg37MFhfF8mTLnGMVPbRtkmUctjIXAqh/irWYY+a8rBYbMOnu3CnKbBz2sZ8
         c/l7ffR3pAGSPunU9lAftOgJ49YeChM/7JvrJi+W/5f1rZGBVDA8PlTFOSJSglkwnPn+
         cFz9pfuEAg6Zww2N55Qz4Jx3kgPxhmDk0LUznrAFijvKGijdxGKCOOQOah6KqcYjRnSH
         b6U9zylncDn0d0qVHOq7ztc4m6s2BeaV3fdN0pxHAPS+4d028BNe8Rin/AlluFstbzDV
         N07ZnyzNKhda7Skh6vYb3NZK7mgPpYzCGhdp3ikQ7eNg4rkeOYOMIUUT5zantCnfI+aP
         WIZg==
X-Forwarded-Encrypted: i=1; AJvYcCVFmRbJvaxNRMMHeQcds3Z1hc8fG7WsKmZiRFCEzu1EWmTxHlCVdycx/a5OqGxyEZQGeEDbvOwjYuflEZ8cmrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kAf3x/o87R20gl8PI+VasvpG+CzmkIvG+tRVQzCr/3aZkXdd
	EBXW/3OkR0MqPQAckpfMZNX2gC2ul/sSXEL4TvYkiW5cC3YOAZ8FtKFWhzDy0acyjox4BsnP3tU
	qa970cyAnKsnYMg==
X-Google-Smtp-Source: AGHT+IEz/iinmz2aUN8NGTDBu7wDgRygobnaakmTyndIcbAs2iIys4f9fIOWuulr0+mK4GNl5Vsi7MJhQlasP0g=
X-Received: from pjbqj15.prod.google.com ([2002:a17:90b:28cf:b0:2ea:29de:af10])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d64e:b0:2fe:8a84:e033 with SMTP id 98e67ed59e1d1-306dbb93007mr1166983a91.2.1744153350776;
 Tue, 08 Apr 2025 16:02:30 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:02:02 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408230204.2775226-1-tjmercier@google.com>
Subject: [PATCH v2] selftests: pid_namespace: Add missing sys/mount.h
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


