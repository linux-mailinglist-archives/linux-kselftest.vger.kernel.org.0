Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB927F154
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Sep 2020 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgI3ScT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3ScQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 14:32:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6AC061755
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 11:32:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n13so2606230ybk.9
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/2LbwaWNooOMKpnLJAJw9jcrrnwee0nQQaqBBLf78/Y=;
        b=b2Siq8d72wpXcNEVybG6qBGKlSWmEL42dSqiz9ouNhXXklc8D2RdftQoRCRXyX/MeE
         bZQgBzkyZ79eF8q3Tizg87UYoitBaPNfBYmsN2WIpcPDsBUhhg2v5aj3FBmJuVKuOsOG
         DnSvO28Pa4phSvpkJOCOgNDDeBwDztVoGrSxMfB9YY7ws/YZQc2BWP2/TTCQMIiSufLh
         I0++KeGrpb9RPNt5hs8cE9EbBnxep2qX3rZDxnTxJ3gAQx2WPrbwteopc8Drwt22pZa9
         dVFTKyMxhZ96Kfk6DbFmpDECSqWWS0EcetqedQDdH5UOCHHvvHlKlw4IVav8hvEzujo9
         5ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=/2LbwaWNooOMKpnLJAJw9jcrrnwee0nQQaqBBLf78/Y=;
        b=Vp5yHuX5SOTsvxSD7YKQYFTHKexg82zsBMR6FAKtCGj7PObBH/h/RljAxGzkaNOzx1
         15fe3K66Biuj5uEbIOAdXuCDiWaLadcV15Y7n+lvkfAOmlg/L0kybOIFxD5rZ3Funk3x
         mR2HMn7iPcD9HNYOtRdO2Q6/iLpl+lxBKVv4wQmXJ5b2QO5nevbpHVVkbl/PVYrRCSJ3
         hpWMPljM1JbeVE14ddK+n+2bN6t5gwkRhmfAoYtSnCH2FRGn+xRdUj4nojFxwL7AdaD3
         jUNnAv9DxWm/nVLALoZPuEMyAv5gn4gehilUkYTtRsnuikvp/yHwibMbxhyftkT7Zf30
         Q6IQ==
X-Gm-Message-State: AOAM532PNMaMYvz7Nqp5PD/EJ6GnlENhuf6bv3d9N7xLbP6RcAkKULHp
        pt/xklU+0IayBM9Glh7g9Knhe0ItuRJg4g==
X-Google-Smtp-Source: ABdhPJxCZVQmy6aKg+oaaWzvBreZE/7lds9Y9QPeBscFiVG3hKr6AbO/lAHJKvJ8GuzJolIk6nMXTYJVn2IFFg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:6805:: with SMTP id
 d5mr4814916ybc.4.1601490733625; Wed, 30 Sep 2020 11:32:13 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:31:51 -0700
Message-Id: <20200930183151.1046716-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH] kunit: tool: fix display of make errors
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CalledProcessError stores the output of the failed process as `bytes`,
not a `str`.

So when we log it on build error, the make output is all crammed into
one line with "\n" instead of actually printing new lines.

After this change, we get readable output with new lines, e.g.
>   CC      lib/kunit/kunit-example-test.o
> In file included from ../lib/kunit/test.c:9:
> ../include/kunit/test.h:22:1: error: unknown type name =E2=80=98invalid_t=
ype_that_causes_compile=E2=80=99
>    22 | invalid_type_that_causes_compile errors;
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [../scripts/Makefile.build:283: lib/kunit/test.o] Error 1

Secondly, trying to concat exceptions to strings will fail with
> TypeError: can only concatenate str (not "OSError") to str
so fix this with an explicit cast to str.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kuni=
t_kernel.py
index e20e2056cb38..0e19089f62f0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -36,9 +36,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(['make', 'mrproper'], stderr=3Dsubprocess.STDOU=
T)
 		except OSError as e:
-			raise ConfigError('Could not call make command: ' + e)
+			raise ConfigError('Could not call make command: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise ConfigError(e.output)
+			raise ConfigError(e.output.decode())
=20
 	def make_olddefconfig(self, build_dir, make_options):
 		command =3D ['make', 'ARCH=3Dum', 'olddefconfig']
@@ -49,9 +49,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(command, stderr=3Dsubprocess.STDOUT)
 		except OSError as e:
-			raise ConfigError('Could not call make command: ' + e)
+			raise ConfigError('Could not call make command: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise ConfigError(e.output)
+			raise ConfigError(e.output.decode())
=20
 	def make_allyesconfig(self):
 		kunit_parser.print_with_timestamp(
@@ -79,9 +79,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(command, stderr=3Dsubprocess.STDOUT)
 		except OSError as e:
-			raise BuildError('Could not call execute make: ' + e)
+			raise BuildError('Could not call execute make: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise BuildError(e.output)
+			raise BuildError(e.output.decode())
=20
 	def linux_bin(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""

base-commit: ccc1d052eff9f3cfe59d201263903fe1d46c79a5
--=20
2.28.0.709.gb0816b6eb0-goog

