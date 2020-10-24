Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B63297B4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Oct 2020 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759939AbgJXHx7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Oct 2020 03:53:59 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41508 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbgJXHx7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Oct 2020 03:53:59 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C2DCB1B3B63;
        Sat, 24 Oct 2020 16:53:58 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09O7rvgf003004
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 24 Oct 2020 16:53:58 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09O7rvAW028044
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 24 Oct 2020 16:53:57 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 09O7rtrT028043;
        Sat, 24 Oct 2020 16:53:55 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] fat: Add KUnit tests for checksums and timestamps
References: <20201024055955.2553966-1-davidgow@google.com>
        <20201024060558.2556249-1-davidgow@google.com>
Date:   Sat, 24 Oct 2020 16:53:55 +0900
In-Reply-To: <20201024060558.2556249-1-davidgow@google.com> (David Gow's
        message of "Fri, 23 Oct 2020 23:05:58 -0700")
Message-ID: <87ft64ys8c.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Gow <davidgow@google.com> writes:

> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 66532a71e8fd..4e66f7e8defc 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -115,3 +115,15 @@ config FAT_DEFAULT_UTF8
>  	  Say Y if you use UTF-8 encoding for file names, N otherwise.
>  
>  	  See <file:Documentation/filesystems/vfat.rst> for more information.
> +
> +config FAT_KUNIT_TEST
> +	tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && (MSDOS_FS || VFAT_FS)
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the FAT KUnit tests
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit
> +
> +	  If unsure, say N

Maybe, the following would be better? With this, it looks like kunit
works whether depends on or select.

Thanks.

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index ca31993..c1229d4 100644
--- a/fs/fat/Kconfig	2020-09-02 20:48:54.967175266 +0900
+++ b/fs/fat/Kconfig	2020-10-24 16:44:07.734324397 +0900
@@ -77,7 +77,7 @@ config VFAT_FS
 
 config FAT_DEFAULT_CODEPAGE
 	int "Default codepage for FAT"
-	depends on MSDOS_FS || VFAT_FS
+	depends on FAT_FS
 	default 437
 	help
 	  This option should be set to the codepage of your FAT filesystems.
@@ -115,3 +115,15 @@ config FAT_DEFAULT_UTF8
 	  Say Y if you use UTF-8 encoding for file names, N otherwise.
 
 	  See <file:Documentation/filesystems/vfat.rst> for more information.
+
+config FAT_KUNIT_TEST
+	tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
+	depends on KUNIT && FAT_FS
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the FAT KUnit tests
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit
+
+	  If unsure, say N
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
