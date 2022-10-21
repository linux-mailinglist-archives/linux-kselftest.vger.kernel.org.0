Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1BF607959
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiJUOQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJUOQw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 10:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE45227C961;
        Fri, 21 Oct 2022 07:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C3CFB82BD0;
        Fri, 21 Oct 2022 14:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE10C433C1;
        Fri, 21 Oct 2022 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666361808;
        bh=PRytFCKdCT1L3cd5CHsBUG4+VKn3sU9mmpc6aa+Ovks=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=n0BYFG9VEEZacp9J0pCV285LJboNVWnBkr3nTja0Zxmux96k+PMK2V9Jyu4VWRJ07
         RyVNDURFNHsAY1ITKGq5jg0ZfNG7C14tCUqYPMWCa1MqvGcvUlnuVWAmBEOce5NQrA
         a74Pf6uj8syYtdLBlIXcgzclA+Kg1byvukOV/7QqulTGS/nio/Gv9TGpJgJx3By5XQ
         e2j79wGS3gxdtwpvF62bIfBKgHcuGXUu9UVWNOyAhnNR/effUe1GgdmGY572tsk+uh
         kRraSBrFiZNsu1PXsyPfAHNnGeUcOvXl3Ky9o9UEMmoGJBPAL33JbiAVYfMEnnxiDI
         BOVyniBt9sjDQ==
Date:   Fri, 21 Oct 2022 07:16:46 -0700
From:   Kees Cook <kees@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_kunit=3A_Use_the_stat?= =?US-ASCII?Q?ic_key_in_kunit=5Ffail=5Fcurrent=5Ftest=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221021072854.333010-2-davidgow@google.com>
References: <20221021072854.333010-1-davidgow@google.com> <20221021072854.333010-2-davidgow@google.com>
Message-ID: <C8A2E3D7-E62D-43B3-AECC-3B6117E1DD0E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On October 21, 2022 12:28:55 AM PDT, David Gow <davidgow@google=2Ecom> wrot=
e:
>Speed up the case where kunit_fail_current_test() is called when no test
>is running=2E This should make it convenient for code to call this
>unconditionally in some error paths, without fear of causing a
>performance problem=2E

A third patch showing these cases may help in understanding the utility=2E=
 I get it, but I lack imagination on where/why they would be added=2E :)

>
>If CONFIG_KUNIT=3Dn, this compiles away to nothing=2E If CONFIG_KUNIT=3Dy=
, it
>will compile down to a NOP (on most architectures) if no KUnit test is
>currently running=2E kunit_fail_current_test() does not work if KUnit
>itself is built as a module, though this is a pre-existing limitation=2E
>
>Note that the definition of kunit_fail_current_test() still wraps an
>empty, inline function if KUnit is not built-in=2E This is to ensure that
>the printf format string __attribute__ will still work=2E
>
>Signed-off-by: David Gow <davidgow@google=2Ecom>
>---
> include/kunit/test-bug=2Eh | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
>
>diff --git a/include/kunit/test-bug=2Eh b/include/kunit/test-bug=2Eh
>index 5fc58081d511=2E=2Eba9558a9f9c0 100644
>--- a/include/kunit/test-bug=2Eh
>+++ b/include/kunit/test-bug=2Eh
>@@ -9,16 +9,29 @@
> #ifndef _KUNIT_TEST_BUG_H
> #define _KUNIT_TEST_BUG_H
>=20
>-#define kunit_fail_current_test(fmt, =2E=2E=2E) \
>-	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
>-
> #if IS_BUILTIN(CONFIG_KUNIT)
>=20
>+#include <linux/jump_label=2Eh> /* For static branch */
>+
>+/* Static key if KUnit is running any tests=2E */
>+extern struct static_key_false kunit_running;
>+
>+#define kunit_fail_current_test(fmt, =2E=2E=2E) do {					\
>+	if (static_branch_unlikely(&kunit_running)) {				\

This trailing { should be dropped=2E

>+		__kunit_fail_current_test(__FILE__, __LINE__,			\
>+					  fmt, ##__VA_ARGS__);			\

Or a closing one added here=2E (The {}s are unbalanced, as 0day complained=
 about=2E)

>+	} while (0)
>+
>+
> extern __printf(3, 4) void __kunit_fail_current_test(const char *file, i=
nt line,
> 						    const char *fmt, =2E=2E=2E);
>=20
> #else
>=20
>+/* We define this with an empty helper function so format string warning=
s work */
>+#define kunit_fail_current_test(fmt, =2E=2E=2E) \
>+		__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
>+
> static inline __printf(3, 4) void __kunit_fail_current_test(const char *=
file, int line,
> 							    const char *fmt, =2E=2E=2E)
> {


--=20
Kees Cook
