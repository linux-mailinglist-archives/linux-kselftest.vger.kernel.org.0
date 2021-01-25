Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116403047AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 20:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbhAZF6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jan 2021 00:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbhAYMqn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 07:46:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6868222A84;
        Mon, 25 Jan 2021 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611578761;
        bh=c1ESZ1aS34pGoP4FODnuFV3EEuoDWPCSVbwlqLba+wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJbNzV0PkXF7L4dtnJ3XXTVb5KqxyML1bOqWvfM18AFmy/942I+HDkwXp/+24n9Qp
         k76W9D77JlVdn2f/9xG+hcC44mhHBungtffaSl173frfAjcelo9R6SeDr5XY2Q2rc9
         KqLlfqUP/sb8ltt6+F4Kt/kjSFmo3nuO875DH8jwJqWI8gwEzO6/m9GACge0OI2izJ
         L+MlIeZbKa426KistfPzlhYCwgWVctTXtFi3RBXskLO1R6Y61GrP1fBJgOB4+m3EFy
         5xRW19AKq53J4TB7rzaSgKJE9yjU/O38UrK+CU1FY7jQ1kaZG0McdalkaTTUWQG1pd
         XjW8pOXXRXx6g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: [RFC 1/3] bitfield: build kunit tests without structleak plugin
Date:   Mon, 25 Jan 2021 13:45:26 +0100
Message-Id: <20210125124533.101339-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125124533.101339-1-arnd@kernel.org>
References: <20210125124533.101339-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The structleak plugin causes the stack frame size to grow immensely:

lib/bitfield_kunit.c: In function 'test_bitfields_constants':
lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index b5307d3eec1a..6a7300f0f02f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -348,6 +348,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
+CFLAGS_REMOVE_bitfield_kunit.o += -fplugin-arg-structleak_plugin-byref -fplugin-arg-structleak_plugin-byref-all
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
-- 
2.29.2

