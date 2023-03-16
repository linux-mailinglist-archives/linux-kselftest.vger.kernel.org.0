Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13956BC5EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 07:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCPGC4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 02:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCPGCz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 02:02:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9E4A1F6
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 23:02:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ix20so640128plb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678946574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4N/acoeONMeU2uIZEvkbnhE87qN//0NSzB356Hql8M=;
        b=k0fvzVV61mIjU3/tXTWjnwBpKsG8c5sE6bCeStyJkGXk3TR9adIm4C2uHbGoiKlFnV
         /6k444DudbAgRp7Ii59wdt5Ir2pcwATIlu8uxOrTPyzfyeh75RyerT8RI0au99NCULwY
         DCkxUMpMr4atvHjKg8BEqZRBtP9d1iqFs1C21XKX7QeokEdw0LM8Wr9Dx4/j94jmkrc7
         mlLiK5A817P9HT0EAqrIQwMM2oDeXDMh9fL8trupUEM2OwO+ELtkn6ff47bQ9oVgg4M9
         K1TVWCI1IbDg1dGAIfFq4H4NzPjvTJfYPHOfWn9wn9zjG4YJa5thpnz5+rt33sqBPrll
         8cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678946574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4N/acoeONMeU2uIZEvkbnhE87qN//0NSzB356Hql8M=;
        b=CX7B+EVainjk4H/m2EL6UT1OWnBrXMyCm5hsD+Gbaxx/RW0hH8hzHQ/1J+0eSC6VMG
         4WIL5Cw6yVVDAF2QxVPb6qmXg7olvJaRKTX/laVAD2hk3DeRYeV7qGpHoeuRYeXTFknP
         g/+HJD9JRos4a0nBFG54j+QYhuEyipK1NyGW5qevb87sV3HXi4FdCJ5wp08yy9nsBeh1
         lQt11vlqJ02nf5Es5zyQzQEGI6GXvNLHy4MrRaZa7oV0zIpzOk8uD28n8gucHVmKi4q2
         rQAqN2+zWlJEtdjiqmNZ4vHc/A9DlmwtD4xirTa1tiQ82Wd2IH6APDDgrdgb974W+L33
         0+Pg==
X-Gm-Message-State: AO0yUKUL2Z3JcdgsLS8kI5Yhb6Kq38K1/VpAUWO7Znc/1StDfOuINTEa
        5HXA+DB9Ulxj7MdPFDLXKElWW2LVST49FEeavmpnYA==
X-Google-Smtp-Source: AK7set/vNo2lUgV6dmOXYw2tW4JBAGz0RLufXR8NjXlMkSPl0J1RRn84ek4/Qk1YT71fX4BFOXd2lMKZDkRlNDspBQ0=
X-Received: by 2002:a17:902:f544:b0:199:7d2:d9da with SMTP id
 h4-20020a170902f54400b0019907d2d9damr906568plf.11.1678946573698; Wed, 15 Mar
 2023 23:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
In-Reply-To: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 15 Mar 2023 23:02:42 -0700
Message-ID: <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 15, 2023 at 10:57=E2=80=AFPM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> This should be IO[str], since we use it for printing strings.

This is a good catch, thanks.
But we also have a few more bare generic types that warrant attention.

I think the diff below [1] should fix the others as well.
I can send it out as a formal patch and add your name for the Reported-by?


[1]
diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index 53e90c335834..e6fc8fcb071a 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -92,7 +92,7 @@ class LinuxSourceTreeOperations:
                if stderr:  # likely only due to build warnings
                        print(stderr.decode())

-       def start(self, params: List[str], build_dir: str) -> subprocess.Po=
pen:
+       def start(self, params: List[str], build_dir: str) ->
subprocess.Popen[str]:
                raise RuntimeError('not implemented!')


@@ -112,7 +112,7 @@ class
LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
                kconfig.merge_in_entries(base_kunitconfig)
                return kconfig

-       def start(self, params: List[str], build_dir: str) -> subprocess.Po=
pen:
+       def start(self, params: List[str], build_dir: str) ->
subprocess.Popen[str]:
                kernel_path =3D os.path.join(build_dir, self._kernel_path)
                qemu_command =3D ['qemu-system-' + self._qemu_arch,
                                '-nodefaults',
@@ -141,7 +141,7 @@ class
LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
                kconfig.merge_in_entries(base_kunitconfig)
                return kconfig

-       def start(self, params: List[str], build_dir: str) -> subprocess.Po=
pen:
+       def start(self, params: List[str], build_dir: str) ->
subprocess.Popen[str]:
                """Runs the Linux UML binary. Must be named 'linux'."""
                linux_bin =3D os.path.join(build_dir, 'linux')
                params.extend(['mem=3D1G', 'console=3Dtty', 'kunit_shutdown=
=3Dhalt'])
diff --git a/tools/testing/kunit/kunit_printer.py
b/tools/testing/kunit/kunit_printer.py
index 5f1cc55ecdf5..015adf87dc2c 100644
--- a/tools/testing/kunit/kunit_printer.py
+++ b/tools/testing/kunit/kunit_printer.py
@@ -15,7 +15,7 @@ _RESET =3D '\033[0;0m'
 class Printer:
        """Wraps a file object, providing utilities for coloring output, et=
c."""

-       def __init__(self, output: typing.IO):
+       def __init__(self, output: typing.IO[str]):
                self._output =3D output
                self._use_color =3D output.isatty()

diff --git a/tools/testing/kunit/run_checks.py
b/tools/testing/kunit/run_checks.py
index 066e6f938f6d..61cece1684df 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -37,7 +37,7 @@ def main(argv: Sequence[str]) -> None:
        if argv:
                raise RuntimeError('This script takes no arguments')

-       future_to_name: Dict[futures.Future, str] =3D {}
+       future_to_name: Dict[futures.Future[None], str] =3D {}
        executor =3D futures.ThreadPoolExecutor(max_workers=3Dlen(commands)=
)
        for name, argv in commands.items():
                if name in necessary_deps and
shutil.which(necessary_deps[name]) is None:
