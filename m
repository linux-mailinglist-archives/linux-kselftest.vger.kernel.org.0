Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0E2679CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgILLKw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgILLJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3590C061757
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so9062045pfc.12
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZnp4yDc6/H8oZY5gPE0ntNCiw9S8Y24vH6szdlcBNQ=;
        b=Zk/gIvdNfjQE/2unl26djetvFbMWk4A8shRgP7V779rbL1iDmAqb/WJsaeUEyvkWho
         8jG+lsS6GNlo3kWdNKOEks2fdvmH3bO73kMlDWOuyuO55TqqWNyvjERND1Wyg09jCOar
         c+he/PZbFxcnDUtW7NY4RKVcPovh+GacMTNqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZnp4yDc6/H8oZY5gPE0ntNCiw9S8Y24vH6szdlcBNQ=;
        b=VmDJleoH1eIsqCFn12RkJh+7CDl8LVTQGVJ4YDrm3AWfR/dv8XSX24e++ghG77xiCO
         Dst6ngFsnanp+b7j+4S9IVATQIbWdrUIKsXt3r5Dd2BCV7LW3neKjw41wugfxMqeDh79
         HQqIRWQkS6DThNxqW0/HufB+oVjE4DEp3ecvVqWXPUrEC9roOrTxLvTU6sOwAC6+XPy3
         TdE34B/m8YFLVET6nonKpVQ+8TzIafyB+3zmF/gdB8+ZdF/l0y17y/5xWez4OL9Q40pt
         hovoXVwk3Q4rl8XnLQFvLUXpEQlt0S38ZjcJ6PCorQVXQK6WhxfRxbmMXDMMquSDxOYO
         yd4g==
X-Gm-Message-State: AOAM531VM1HrZgexdfi6LFniKOBgH8tGuITew4BQe8+kELlea/L4O5GK
        gjUMng81cISVPRBgfKlWQ/QX5/KQ/cODhDpT
X-Google-Smtp-Source: ABdhPJxq4vqIb6iJR4MN1IGlGkXsD9IVC0sP3rRF3lcvwIHfpvEszE0WWk+A5K78Aa5hwg8SNrEAAg==
X-Received: by 2002:aa7:9ac9:0:b029:13e:d13d:a133 with SMTP id x9-20020aa79ac90000b029013ed13da133mr6030859pfp.27.1599908916069;
        Sat, 12 Sep 2020 04:08:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm4796064pfi.55.2020.09.12.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/15] selftests/seccomp: Use __NR_mknodat instead of __NR_mknod
Date:   Sat, 12 Sep 2020 04:08:20 -0700
Message-Id: <20200912110820.597135-16-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The __NR_mknod syscall doesn't exist on arm64 (only __NR_mknodat).
Switch to the modern syscall.

Fixes: ad5682184a81 ("selftests/seccomp: Check for EPOLLHUP for user_notif")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 26c712c6a575..b34ede28f314 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3773,7 +3773,7 @@ TEST(user_notification_filter_empty)
 	if (pid == 0) {
 		int listener;
 
-		listener = user_notif_syscall(__NR_mknod, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		listener = user_notif_syscall(__NR_mknodat, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 		if (listener < 0)
 			_exit(EXIT_FAILURE);
 
-- 
2.25.1

