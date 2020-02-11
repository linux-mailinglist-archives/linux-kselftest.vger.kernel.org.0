Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBDD158D94
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 12:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBKLc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 06:32:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42463 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBKLc7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 06:32:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so5356516pfz.9;
        Tue, 11 Feb 2020 03:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7XIwjb1NmupQsOWTxb+gUt0SoUoKsZRKZltoxsJ+0E=;
        b=TUNLEbkwqFFXyUaExg1rcZ4cxXvBJgO0OMJCHgAQpqIUxfxxEbLICqd89J31UzbIUH
         xw6R0MwtCWUWI5W7dMWfOSPAIdT9quhDDIwcABa8TBlQLunh2KAQVVtqfWJZCmj+w9zr
         1bmhv/h7+Olj9CpXn9L0JB4g5Rw+gq2nvkKm8TD4/n65L0ZayZjyVlvrwc8QRx4ge551
         md+gZAUhmh3aedgcjTUumQgVymRhjaHjJ/PmoDwT57mR/qnCb7o0y9nBdsmU+PrwHeji
         2oTrxXmYIyMxbI9bzWwcbuWWkDjMpmiJi3Qin2lggaKoMM2vwEcHoDco4TfdnOC0Wfij
         0xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7XIwjb1NmupQsOWTxb+gUt0SoUoKsZRKZltoxsJ+0E=;
        b=SuiInuss+V+V6gcpBXigo4wTvbrMzKj9D5TL759QGAlbU1Mk+tO3jYNHZC/DRpHRZD
         drjDZi87L2n+qVnziJU+N9GYQDIeHnIM9RfO2tLj5U5XQXrnqght7pfifBtb+Qp7QUk9
         JKjcOzvYG0P/3tjC7FWqaI41A8NNtaHk9/adZEZvd+CnukJIjBtYqBctkjYKArcHwi7b
         JE6OajOtcmXjxwhBAlXKhD6gY95viX8z0aIfSelzRMq+DccX0EjADMRyU33Pp53fulVe
         B9Sp1Pe2PuxxOWxaMBGnw+2VP4c/r93eC9YCMQoVx9uqDmufaAmHwh6ObE2xgXJFfTqZ
         rZRQ==
X-Gm-Message-State: APjAAAX+QNrEhhEveWw7oHus7p+FwrlFPypl7Fe0inCsZkutlF4fVdJ9
        APH6eObqcYhQ5fOlSW9oC7Q8omgW3SM=
X-Google-Smtp-Source: APXvYqxPJQt/2QMW+tXXPqW8yLwcsk4nRTYq/zpCBsPECWConwDbHwxcBeM7DjrVf3AZfC0tUNpbrA==
X-Received: by 2002:a63:7c17:: with SMTP id x23mr6367756pgc.436.1581420778563;
        Tue, 11 Feb 2020 03:32:58 -0800 (PST)
Received: from mentat.byu.edu ([128.187.112.29])
        by smtp.gmail.com with ESMTPSA id x25sm4159009pfp.30.2020.02.11.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:32:57 -0800 (PST)
From:   Isaac Young <isaac.young5@gmail.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Removing a duplicate condition.
Date:   Tue, 11 Feb 2020 04:32:57 -0700
Message-Id: <20200211113257.451781-1-isaac.young5@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Isaac Young <isaac.young5@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 098bcae5f827..0954c7a8aa08 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -823,7 +823,7 @@ void test_select_reuseport(void)
 
 	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
 	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
-	if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)
+	if (saved_tcp_syncookie < 0)
 		goto out;
 
 	if (enable_fastopen())
-- 
2.24.1

