Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F123F870D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbhHZMNG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 08:13:06 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:39142
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234332AbhHZMNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 08:13:05 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6D00C3F110;
        Thu, 26 Aug 2021 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629979937;
        bh=5RYkWf+WPX7pOB+VbHYlwiEqmOpWaHkK9aC98TVcYac=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=bNKk7NvF3VOKxty7n+U12e2CuM4IGbRYcOgY+wZSx0tdohDvyug9p7U7B6uNRKvEk
         qH5X6DdOv2N0E8TSAAIo5hjme/9C44rpqJQmHcFEwLndbjD8Y6GHzdwAUkbRZh090F
         TG9X+zH5afKQoTVr52isUF0Rm7Tjl3t+yxlNPCCJb7MWl49PVOmkOKT7UJmCaSankH
         W6bjytJY9Fc0njRthVK1rZjIJmh8tBrRJNctBSyJKoGK1stLJ4nKKT4dEH1IXhIlng
         oCZxQGvCANzuwNhAEjG9iAMVjJp5t6t5SiabZv6OzrcIS+EGy/U9ugSLIZobJQpsLM
         d0BvTa/81OiWg==
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix spelling mistake "cann't" -> "cannot"
Date:   Thu, 26 Aug 2021 13:12:17 +0100
Message-Id: <20210826121217.12885-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/vm/mlock-random-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/mlock-random-test.c b/tools/testing/selftests/vm/mlock-random-test.c
index ff4d72eb74b9..782ea94dee2f 100644
--- a/tools/testing/selftests/vm/mlock-random-test.c
+++ b/tools/testing/selftests/vm/mlock-random-test.c
@@ -70,7 +70,7 @@ int get_proc_locked_vm_size(void)
 		}
 	}
 
-	perror("cann't parse VmLck in /proc/self/status\n");
+	perror("cannot parse VmLck in /proc/self/status\n");
 	fclose(f);
 	return -1;
 }
-- 
2.32.0

