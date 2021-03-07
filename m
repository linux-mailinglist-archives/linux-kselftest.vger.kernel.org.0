Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6127333020E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCGO0Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:26:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:46477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhCGO0A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615127129;
        bh=fQX81Of9P558A+iW5ccipb7QmmQldM7xCcBpY9SL5ME=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JcV9o1aAX1TZ0UNvRSkCxkJT9+7HBfF8fGe3HXMAoOYz/kVBKmJE7x2Dku7rqIuiP
         aHF0Wzb8PSPOLCLgvKCNgydozo8kfMi5RTMubetRFHsg/Qp/ghR3FXcJBU7JL5D9QR
         UJSoaT80+nagP5Z/XjVJ8gvxZOhlRSx6SwN3lrYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MzQgC-1leiYC2bQ0-00vNTO; Sun, 07 Mar 2021 15:25:28 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 8/8] MAINTAINERS: Add a new entry for the Brute LSM
Date:   Sun,  7 Mar 2021 12:30:31 +0100
Message-Id: <20210307113031.11671-9-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210307113031.11671-1-john.wood@gmx.com>
References: <20210307113031.11671-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:92T2xSso/iqnFhtuivLc6H+ad35shneVfp1UrybbP/Im+3YKN1F
 Nk/9E7+dJeILbl55LIx2eyEl01qi1fhQmD2HJq7R5CvHTdFbaYKt6no4Q68dQ47GgY4MsdZ
 1vXzT7Q98HnOEBuTcvKDHqx8r6NjRjQiK/1PNH51ZVcX4l4MgTF77dJjUs8ffI8uK07kERm
 R0ld+fw4y0HIy3Kci58Xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UqIghxRRgYU=:wfvvziITSMY1VJyeBqqnaG
 G48S/wskeSQe9mTR0rxB/3lmVUp4vSGlgy3jZP0haDRKwz9pcHlYOMmOwI6kXugpcH2U87fGV
 17AD3cgcVhug/X23JOw0CU/9BuB7VEgV7uHQ2yr/ZEWhmpt7sPmrqBddN7Veojmc2JnxxMw4X
 eow7YOm7h/BQSOay4lJesnGNtmsN4rau1MwNK2Y+dX52jElFiR2yVK/qZx43xxx0GlI7Q1AhU
 Y2ZS5PRXRCnvmYul2dFm8tNwFBk6EwMVvDa5z3xTF5QGsJt9n2TA9eT3hD/EMY1op4pWZ4/IP
 4+akzd3sCCOv2ZKyiuC5qv0E9IiWFCGHLVH5c1p/zvLSHsFvVYJ3UQoCpreuTJ4d+Swv2nMeW
 Pbv/nI6CyyCn/ioZaFXhQogNnJ8x8frpjGee/OJz9CLtsPc6XmdMiY6VEqIAu5IFILs11qR/0
 N0S1pnLwHN+7sdrvnX1wk0pkl96BU7CsZCZAMBJeFnT/oNqtKbQ+yArIm04iekky7YRE8ulzO
 cfVGf74agXwMFmNs0671O2FIAx82CaP8Z99i/CRprRJX/v3xkXOiTWNAALARJxCDxrBdKHFzW
 7oG2HYLsL+q5whZjfadMsEfKyTNznb1F5GQoJfHSnwHArMon2q/b8Mf40mRzAcj2PC4SP+2Tg
 Cu43uOdiiJbD7AA6Mz7bMz17375khYdXty5F2xNryTFZBcgnMow5BSuSJCaAH8SfnymOCqwUm
 g0rShLIdRG8ZsCEqAIsdzodZE4tOjzOQjMmtXXmCgAxl5D7EXoYrkaDFa5w7/p5NLvewjgp91
 owuoARapvVS4G1gPeZi6Ih7i6YnDAzz7LunJSt/8HmjBo7XJe1pj7PmNqsw5GqaJUxvBB/fo3
 Pr9b2F2RIr8isgnwPvBw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to maintain the code for the Brute LSM add a new entry to the
maintainers list.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..0b88b7a99991 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3764,6 +3764,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/brocade/bna/

+BRUTE SECURITY MODULE
+M:	John Wood <john.wood@gmx.com>
+S:	Maintained
+F:	Documentation/admin-guide/LSM/Brute.rst
+F:	security/brute/
+F:	tools/testing/selftests/brute/
+
 BSG (block layer generic sg v4 driver)
 M:	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
 L:	linux-scsi@vger.kernel.org
=2D-
2.25.1

