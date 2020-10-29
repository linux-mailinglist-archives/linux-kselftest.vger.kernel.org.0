Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC6229F772
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2WKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 18:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2WKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 18:10:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA6C0613D2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 15:10:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i11so2016667pgi.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=8FO8hKhWo8C4LkpWBb3TOyUhwVl2tgrqtKgNpxdQBao=;
        b=dyMOA9oqMOS6va+C/MbpRoprIAGsBsKj1w9S6Sa1dTZMXbYw0nv5t8CI+BZaLnrCbl
         pumiqx7Th1d8ahZvnpzU3Ma2a2JVTcmXpmpP2XA74m3XnHXf3bX/bcF8tn1MohB/KbBd
         UdoVF9ynHw3k8hds5HbRpLU78GHgvzaxotAUW2krmNhuXHtO++tHwvhoibMFd3bFd4Ks
         opCJkclDRD42843Kld6nJMH50Xqhheh6gf6KNkj/zPCrVyxX0q/9/Hhxsx+zsEqcjvik
         H3uiLcftU/ltNESOsMInt4gMcieOIFchEXaOrJsDx8xS0LJpFfruQmcUBzje25Y+fE+5
         4uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=8FO8hKhWo8C4LkpWBb3TOyUhwVl2tgrqtKgNpxdQBao=;
        b=lM/sxMJFX5WelbfcfhoZEOfw2w6u44yiZYw7SWAbYB5SXG8WijvYuci11ZW+hVTMiV
         cKU/oH+d/hrY+pOzvsN5tNzLBVy+THkEdqbxdXeY9Uw4oqA38Ddgt+pbbN6Cvljg2yqh
         /WmnPCZGEq0fLmc+hST4WOTLC2Evzvmleh3ncafcgoS9ZJYfXweMX1zCnhAJw7RtgUEI
         SoiBZu9cgfA5eNiz55TPeMrVRFy6+xbUa0B0Hs0JX/I7UG30d6LUpMxQEYekv1oHFQSe
         bl4K6Fv5MCrFV2vEzmboAdoecrYbHzv0VWzAZRwwIuvwhC6pkctM1dwfUlPmIwoREd2L
         oXTw==
X-Gm-Message-State: AOAM530rPXy2L2Jx62iX2o3jFGfJSpNbAJDAs9u67IpT6dK9Q68RMTlp
        Yc07ZeSfowesYyIfJSxL5h6dOLI2+yH9sA==
X-Google-Smtp-Source: ABdhPJxg7AkIoi6WznVzqpiz7XfH4HE0lhenNJ8tvH0f4uyzgciqlKQIsmU062LGVpfDclTmOoKlRwpzDOMD3Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:f85:: with SMTP id
 ft5mr100494pjb.1.1604009419252; Thu, 29 Oct 2020 15:10:19 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:09:29 -0700
Message-Id: <20201029220929.4068251-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] kunit: tool: print out stderr from make (like build warnings)
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the tool redirects make stdout + stderr, and only shows them
if the make command fails.
This means build warnings aren't shown to the user.

This change prints the contents of stderr even if make succeeds, under
the assumption these are only build warnings or other messages the user
likely wants to see.

We drop stdout from the raised exception since we can no longer easily
collate stdout and stderr and just showing the stderr seems fine.

Example with a warning:

[14:56:35] Building KUnit Kernel ...
../lib/kunit/kunit-test.c: In function =E2=80=98kunit_test_successful_try=
=E2=80=99:
../lib/kunit/kunit-test.c:19:6: warning: unused variable =E2=80=98unused=E2=
=80=99 [-Wunused-variable]
   19 |  int unused;
      |      ^~~~~~

[14:56:40] Starting KUnit Kernel ...

Note the stderr has a trailing \n, and since we use print, we add
another, but it helps separate make and kunit.py output.

Example with a build error:

[15:02:45] Building KUnit Kernel ...
ERROR:root:../lib/kunit/kunit-test.c: In function =E2=80=98kunit_test_succe=
ssful_try=E2=80=99:
../lib/kunit/kunit-test.c:19:2: error: unknown type name =E2=80=98invalid_t=
ype=E2=80=99
   19 |  invalid_type *test =3D data;
      |  ^~~~~~~~~~~~
...

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kuni=
t_kernel.py
index b557b1e93f98..326e82746d41 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -82,11 +82,16 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command +=3D ['O=3D' + build_dir]
 		try:
-			subprocess.check_output(command, stderr=3Dsubprocess.STDOUT)
+			proc =3D subprocess.Popen(command,
+						stderr=3Dsubprocess.PIPE,
+						stdout=3Dsubprocess.DEVNULL)
 		except OSError as e:
-			raise BuildError('Could not call execute make: ' + str(e))
-		except subprocess.CalledProcessError as e:
-			raise BuildError(e.output.decode())
+			raise BuildError('Could not call make command: ' + str(e))
+		_, stderr =3D proc.communicate()
+		if proc.returncode !=3D 0:
+			raise BuildError(stderr.decode())
+		if stderr:  # likely only due to build warnings
+			print(stderr.decode())
=20
 	def linux_bin(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""

base-commit: 07e0887302450a62f51dba72df6afb5fabb23d1c
--=20
2.29.1.341.ge80a0c044ae-goog

