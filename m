Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BB1FD81F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFQWDc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 18:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQWDc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 18:03:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C348C06174E
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 15:03:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b7so2696010pju.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7bw5q/TJxpqMicrHyIFon0t9gt+svhVPDuc7AUFnrI=;
        b=AssCNT+fl7FZXIZEydCky+FoEabK9WHSRC/Cz7t+GsLm7aO2UJ/YytOxHd1B0j1e+l
         XnLm1Rt+qfp2EUmGG/yFhjq91D26f7ku2eo0bUwGuEdGWnmwt6HPJOj85Snm44Eef3sC
         VVnAeX1Tp5FyYfkxWhsd8A7EzPvh9OS4GeLdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7bw5q/TJxpqMicrHyIFon0t9gt+svhVPDuc7AUFnrI=;
        b=kQv52QJsY60pBwXFUEWmrhW8vLy0fG/ni+L7L8V7ggYfGUirkhqok/V9sleWHKLpmk
         fekFeeK1JAwOVQPBLNfQc0Vs/YOHXuY4VgHuy571Fe7xgKa5a73WuzlF3jI902U2+gIM
         gilYcOU5UvuqZlep+FWKd08HxaZJXB9lkDkHdHClyN8uobXXrQ5mJ9TIiBK1duKjW/TU
         qoSKEf7GVhQi82rl9eqIgCHQpfAj4ybV/ye5WebjFujc2XXOJjXvbNisCjln/I0ANxqB
         U+enDQGvRcbFYIh51oeJrMszTVON7rJISxjTffgLEMiMWbXByfkpUVnvGs0PRFD7/Rk3
         e/Rw==
X-Gm-Message-State: AOAM5337luZgbgeWIkyaKN0fVrPBYJ6GoB5KTmxnrZAyi+o2CH5Gexp2
        QIuw3y/g16+ixZQkx0RQJCX0Hw==
X-Google-Smtp-Source: ABdhPJy8S/6IprS//E4loSZ1ZgKk4AjU+iw9QdwwDUrpFc38iJU+1J4kMZ7xNS+1rFNTzrhm1LjJ3w==
X-Received: by 2002:a17:90a:f3c4:: with SMTP id ha4mr1155509pjb.18.1592431411577;
        Wed, 17 Jun 2020 15:03:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n24sm461968pjt.47.2020.06.17.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:03:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 4/7] pidfd: Replace open-coded partial fd_install_received()
Date:   Wed, 17 Jun 2020 15:03:24 -0700
Message-Id: <20200617220327.3731559-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220327.3731559-1-keescook@chromium.org>
References: <20200617220327.3731559-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sock counting (sock_update_netprioidx() and sock_update_classid()) was
missing from pidfd's implementation of received fd installation. Replace
the open-coded version with a call to the new fd_install_received()
helper.

Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/pid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index f1496b757162..24924ec5df0e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -635,18 +635,9 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = security_file_receive(file);
-	if (ret) {
-		fput(file);
-		return ret;
-	}
-
-	ret = get_unused_fd_flags(O_CLOEXEC);
+	ret = fd_install_received(file, O_CLOEXEC);
 	if (ret < 0)
 		fput(file);
-	else
-		fd_install(ret, file);
-
 	return ret;
 }
 
-- 
2.25.1

