Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F8AE9E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfIJMDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJMDr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE3D8C00861E;
        Tue, 10 Sep 2019 12:03:46 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31EDA5D9D6;
        Tue, 10 Sep 2019 12:03:42 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:03:16 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH 2/6] selftests/clone3: add a check for invalid exit_signal
Message-ID: <f5c715164c87a226afca711559e7ed72a70426a4.1568116761.git.esyr@redhat.com>
References: <cover.1568116761.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568116761.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 12:03:46 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check that the kernel fails calls with exit_signal with non-zero highest
32 bits.

* tools/testing/selftests/clone3/clone3.c (enum test_mode): Add
CLONE3_ARGS_BIG_EXIT_SIGNAL.
(call_clone3): Add args.exit_signal initialisation in case
test_mode == CLONE3_ARGS_BIG_EXIT_SIGNAL.
(main): Add test_clone3 clone check with
test_mode == CLONE3_ARGS_BIG_EXIT_SIGNAL.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/clone3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 7b65ee5..4f23a0c 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -28,6 +28,7 @@ enum test_mode {
 	CLONE3_ARGS_NO_TEST,
 	CLONE3_ARGS_ALL_0,
 	CLONE3_ARGS_ALL_1,
+	CLONE3_ARGS_BIG_EXIT_SIGNAL,
 };
 
 static pid_t raw_clone(struct clone_args *args, size_t size)
@@ -72,6 +73,10 @@ static int call_clone3(int flags, size_t size, enum test_mode test_mode)
 		args.tls = 1;
 		args.set_tid = 1;
 		break;
+
+	case CLONE3_ARGS_BIG_EXIT_SIGNAL:
+		args.exit_signal = 0xbadc0ded00000000;
+		break;
 	}
 
 	pid = raw_clone(&args, size);
@@ -146,6 +151,10 @@ int main(int argc, char *argv[])
 	/* Do a clone3() with all members set to 1 */
 	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL, CLONE3_ARGS_ALL_1))
 		goto on_error;
+	/* Do a clone3() with exit_signal having highest 32 bits non-zero */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+			CLONE3_ARGS_BIG_EXIT_SIGNAL))
+		goto on_error;
 	/*
 	 * Do a clone3() with sizeof(struct clone_args) + 8
 	 * and all members set to 0.
-- 
2.1.4

