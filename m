Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57281B034F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfIKSCl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Sep 2019 14:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfIKSCl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Sep 2019 14:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D404BC057E9F;
        Wed, 11 Sep 2019 18:02:40 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E2419C77;
        Wed, 11 Sep 2019 18:02:36 +0000 (UTC)
Date:   Wed, 11 Sep 2019 19:02:11 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH v3 2/6] selftests/clone3: add a check for invalid exit_signal
Message-ID: <2cb6dfff8c4ae164ad019812c4095f2c4d6e0941.1568224280.git.esyr@redhat.com>
References: <cover.1568224280.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568224280.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 11 Sep 2019 18:02:40 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check that the kernel fails calls with exit_signal with non-zero highest
32 bits, negative 32-bit exit_signal, and invalid exit_signal withing
CSIGNAL mask, like legacy clone syscalls do.

* tools/testing/selftests/clone3/clone3.c (enum test_mode): Add
CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG, CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG, CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG.
(call_clone3): Add args.exit_signal initialisation in case test_mode
is equal to one of the added enum test_mode values.
(main): Add test_clone3 clone check with test_mode equal to the added
enum test_mode values.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/clone3.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 7b65ee5..4837865 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -28,6 +28,10 @@ enum test_mode {
 	CLONE3_ARGS_NO_TEST,
 	CLONE3_ARGS_ALL_0,
 	CLONE3_ARGS_ALL_1,
+	CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG,
+	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
+	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
+	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
 };
 
 static pid_t raw_clone(struct clone_args *args, size_t size)
@@ -72,6 +76,22 @@ static int call_clone3(int flags, size_t size, enum test_mode test_mode)
 		args.tls = 1;
 		args.set_tid = 1;
 		break;
+
+	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG:
+		args.exit_signal = 0xbadc0ded00000000ULL;
+		break;
+
+	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG:
+		args.exit_signal = 0x0000000080000000ULL;
+		break;
+
+	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG:
+		args.exit_signal = 0x0000000000000100ULL;
+		break;
+
+	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
+		args.exit_signal = 0x00000000000000f0ULL;
+		break;
 	}
 
 	pid = raw_clone(&args, size);
@@ -146,6 +166,22 @@ int main(int argc, char *argv[])
 	/* Do a clone3() with all members set to 1 */
 	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL, CLONE3_ARGS_ALL_1))
 		goto on_error;
+	/* Do a clone3() with exit_signal having highest 32 bits non-zero */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+			CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG))
+		goto on_error;
+	/* Do a clone3() with negative 32-bit exit_signal */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+			CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG))
+		goto on_error;
+	/* Do a clone3() with exit_signal not fitting into CSIGNAL mask */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+			CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG))
+		goto on_error;
+	/* Do a clone3() with NSIG < exit_signal < CSIG */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
+			CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG))
+		goto on_error;
 	/*
 	 * Do a clone3() with sizeof(struct clone_args) + 8
 	 * and all members set to 0.
-- 
2.1.4

