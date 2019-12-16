Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B341216A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfLPSMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 13:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730924AbfLPSMS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 13:12:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103EF206B7;
        Mon, 16 Dec 2019 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519937;
        bh=EwT10ETY9MI/NdSUuESri3Es+yuKxE44eF/VBhE5Dkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwnKulP14TAHsnlo1flBzSWOfuzC1UIbuW3qncqpJOM7EX61XfH2J/EIPWW8ymOZD
         8xGXzXkN9TiyszGzRsEBCTFxsFEE1DO8fZYjLwpIpxA1eTFfghmPPuurW8XQhBWHL6
         /T1E4SFCnenhJ2O3cj4zgMKsRQWthOzHwCF/deTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Tycho Andersen <tycho@tycho.ws>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.3 131/180] seccomp: avoid overflow in implicit constant conversion
Date:   Mon, 16 Dec 2019 18:49:31 +0100
Message-Id: <20191216174841.842411126@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

commit 223e660bc7638d126a0e4fbace4f33f2895788c4 upstream.

USER_NOTIF_MAGIC is assigned to int variables in this test so set it to INT_MAX
to avoid warnings:

seccomp_bpf.c: In function ‘user_notification_continue’:
seccomp_bpf.c:3088:26: warning: overflow in implicit constant conversion [-Woverflow]
 #define USER_NOTIF_MAGIC 116983961184613L
                          ^
seccomp_bpf.c:3572:15: note: in expansion of macro ‘USER_NOTIF_MAGIC’
  resp.error = USER_NOTIF_MAGIC;
               ^~~~~~~~~~~~~~~~

Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: stable@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Link: https://lore.kernel.org/r/20190920083007.11475-3-christian.brauner@ubuntu.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -35,6 +35,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <time.h>
+#include <limits.h>
 #include <linux/elf.h>
 #include <sys/uio.h>
 #include <sys/utsname.h>
@@ -3077,7 +3078,7 @@ static int user_trap_syscall(int nr, uns
 	return seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
 }
 
-#define USER_NOTIF_MAGIC 116983961184613L
+#define USER_NOTIF_MAGIC INT_MAX
 TEST(user_notification_basic)
 {
 	pid_t pid;


