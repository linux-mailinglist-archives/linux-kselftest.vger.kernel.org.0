Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC21E649D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391310AbgE1OwM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 10:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391291AbgE1OwL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 10:52:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983312075F;
        Thu, 28 May 2020 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590677530;
        bh=1cwsza4VkPxnPZPr6rqv9W6jMJ44T2SV2cjU4ztOO2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6wcvMPybdFAQWcmnzUNfQ6HQZDJbJyFsxlcjw9VUd4HQ1NKvhXllAHFgbQiVC/qW
         JWOHijBEUx7SX/8u+frag7vEBpyQDaoGOKgVT+2cbTRNPLBDOdB02A+WIBOO5na149
         7+wJ2AFmUymBaCTKP0nAbVTU0n2j5xzwolfdQjq0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: [PATCH 1/4] lib: Make prime number generator independently selectable
Date:   Thu, 28 May 2020 23:52:06 +0900
Message-Id: <159067752610.229397.10253900294111245982.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159067751438.229397.6746886115540895104.stgit@devnote2>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make prime number generator independently selectable from
kconfig. This allows us to enable CONFIG_PRIME_NUMBERS=m
and run the tools/testing/selftests/lib/prime_numbers.sh
without other DRM selftest modules.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/math/Kconfig |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index 15bd50d92308..f19bc9734fa7 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -6,7 +6,12 @@ config CORDIC
 	  calculations are in fixed point. Module will be called cordic.
 
 config PRIME_NUMBERS
-	tristate
+	tristate "Simple prime number generator for testing"
+	help
+	  This option provides a simple prime number generator for test
+	  modules.
+
+	  If unsure, say N.
 
 config RATIONAL
 	bool

