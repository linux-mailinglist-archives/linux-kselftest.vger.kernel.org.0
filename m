Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A841B4860A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFQOwI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 10:52:08 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:41776 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFQOwI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 10:52:08 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id Rqs52000E3XaVaC01qs5gl; Mon, 17 Jun 2019 16:52:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcszN-0002MC-Px; Mon, 17 Jun 2019 16:52:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcszN-0001mb-Ol; Mon, 17 Jun 2019 16:52:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] selftests/powerpc: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:52:04 +0200
Message-Id: <20190617145204.6810-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/testing/selftests/powerpc/mm/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index ba919308fe3052f3..16861ab840f57e90 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -3,4 +3,4 @@ subpage_prot
 tempfile
 prot_sao
 segv_errors
-wild_bctr
\ No newline at end of file
+wild_bctr
-- 
2.17.1

