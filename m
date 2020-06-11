Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F1B1F7077
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFKWke (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 18:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgFKWkd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF185C03E96F
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m1so3176468pgk.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLfetYDG8Hj+ZD7+f5tmR+S0GsdbzHMWoDQj21buSPw=;
        b=kqd6PapK/+TOoz8EkUrOmtB4aQD7tjF70sfmyPZHb4No96IUQQV3TWEzBhf3z8017N
         ecgy8jS3+kIkONCJxeoUTRC2Fd+wn5/Hbt6sikumR5ZdfFx2UcE+HWglkf9soSsQt824
         1QcD7yW7zfet3D62ADeIqR/SxqgaAeBF2xnDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLfetYDG8Hj+ZD7+f5tmR+S0GsdbzHMWoDQj21buSPw=;
        b=kroFqDe5Jz7NplWbe2tvunvDZEYjp35kDe+dXw3px1QOUj7Mj9ypC2HP6Z0dUvVXcU
         Hkh47SriRq3De6snqeG/3bbmDD8i9LOyxBaMYdrx/Ji32kVjDdoKG2p/jr8aAwj2+Imp
         yDHfniAz456XWMCD22cFsloSiEGH3jRD8t+K/cGzLWxOsOJQGqX2Bp4y5OxVh/toB+S4
         O1NslLOjbuiVnXvemxv8RjH0Xb0PJjr4u2NhG0vfpTe4iZ9S4UdJBmJjg0NPPIv7NgvT
         KZdo0sP5i/B0t+Ubsd4TOKdJ4EpLLRCvuIiCyaDZISdylmTPDyie98R6MMztLFfk1esc
         PEeQ==
X-Gm-Message-State: AOAM532xqM9x9OUerz+pojMhMwWb3ECx1GjNgc0Rq263Uy0Y+MtCVufa
        98eVIJMRx7QndGWwuV2jRlotjQ==
X-Google-Smtp-Source: ABdhPJw4SbI17i9uWSNasj87VfFWE+1K/bw74n/2CXdL6sLZZMpd71TQiHPwGFLBAqUEsOLmmrDPTA==
X-Received: by 2002:a63:f502:: with SMTP id w2mr8376139pgh.321.1591915232249;
        Thu, 11 Jun 2020 15:40:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm4162506pfr.182.2020.06.11.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] selftests/clone3: Reorder reporting output
Date:   Thu, 11 Jun 2020 15:40:22 -0700
Message-Id: <20200611224028.3275174-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611224028.3275174-1-keescook@chromium.org>
References: <20200611224028.3275174-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftest output reporting was happening before the TAP headers and plan
had been emitted. Move the first test reports later.

Cc: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/clone3/clone3.c               | 2 +-
 tools/testing/selftests/clone3/clone3_clear_sighand.c | 3 +--
 tools/testing/selftests/clone3/clone3_set_tid.c       | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index f14c269a5a18..b7e6dec36173 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -131,9 +131,9 @@ int main(int argc, char *argv[])
 
 	uid_t uid = getuid();
 
-	test_clone3_supported();
 	ksft_print_header();
 	ksft_set_plan(17);
+	test_clone3_supported();
 
 	/* Just a simple clone3() should return 0.*/
 	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 9e1af8aa7698..db5fc9c5edcf 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -119,9 +119,8 @@ static void test_clone3_clear_sighand(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	test_clone3_supported();
-
 	ksft_set_plan(1);
+	test_clone3_supported();
 
 	test_clone3_clear_sighand();
 
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 25beb22f35b5..5831c1082d6d 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -157,8 +157,8 @@ int main(int argc, char *argv[])
 	pid_t set_tid[MAX_PID_NS_LEVEL * 2];
 
 	ksft_print_header();
-	test_clone3_supported();
 	ksft_set_plan(29);
+	test_clone3_supported();
 
 	if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
 		ksft_exit_fail_msg("pipe() failed\n");
-- 
2.25.1

