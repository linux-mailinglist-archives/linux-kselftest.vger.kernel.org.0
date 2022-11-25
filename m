Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7AC63866C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiKYJm4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 04:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKYJmo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 04:42:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2E23BFE;
        Fri, 25 Nov 2022 01:42:39 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669369357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkHfIWZ+AXddA17Vln4Zv2kJvTG9y3spaF3cG2QDrJU=;
        b=U9GnlAVlA00LESkky61O56pvX9stU5T9eAGYoI06mvV7ObkG7eQmZw6BDKMJpjzb2Kbcgk
        P1ikq9bsh06PjSX/DyKKNpGxfl2CQ8m/Mk+dh0w7bYfH/1x2spaJjayHM+MaDoca7aa9JI
        nIvyEv2d4dlgkxMZulNU0mjKoHHCbOEMizE2XD1EKKWQPPsJ8nIU14EdvsBJHugSEDslJL
        YlcepZNvqBFqYfWMdS5dzjpPFtSExSayFWDbMDYYKWPtVEnkjoiKfO6nVsg6Y9v93CtD/0
        Jd2JSPaq08cS/ZivTWkdb6I18BxKL7z1HPbWK4ZtOVdoDrGqUDEqj9x4uh8tXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669369357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkHfIWZ+AXddA17Vln4Zv2kJvTG9y3spaF3cG2QDrJU=;
        b=/nPSkX2ux5m+/P5mpV/FRizufVbb7UsOHs/O4CpzXs35wg3eH1hgnEmBsJAVPHcsxjOrHX
        AxcsAWw9yHd7pzDg==
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Roland Mainz <roland.mainz@nrubsig.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests: Make a warning if getcpu is missing on 32bit.
Date:   Fri, 25 Nov 2022 10:42:16 +0100
Message-Id: <20221125094216.3663444-4-bigeasy@linutronix.de>
In-Reply-To: <20221125094216.3663444-1-bigeasy@linutronix.de>
References: <20221125094216.3663444-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The vsyscall for getcpu has been wired up on 32bit so it can be warned
now if missing.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/x86/test_vsyscall.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/se=
lftests/x86/test_vsyscall.c
index 5b45e6986aeab..47cab972807c4 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -92,11 +92,8 @@ static void init_vdso(void)
 		printf("[WARN]\tfailed to find time in vDSO\n");
=20
 	vdso_getcpu =3D (getcpu_t)dlsym(vdso, "__vdso_getcpu");
-	if (!vdso_getcpu) {
-		/* getcpu() was never wired up in the 32-bit vDSO. */
-		printf("[%s]\tfailed to find getcpu in vDSO\n",
-		       sizeof(long) =3D=3D 8 ? "WARN" : "NOTE");
-	}
+	if (!vdso_getcpu)
+		printf("[WARN]\tfailed to find getcpu in vDSO\n");
 }
=20
 static int init_vsys(void)
--=20
2.38.1

