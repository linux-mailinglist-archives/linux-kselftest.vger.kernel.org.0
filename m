Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECA11EA3F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgFAMcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 08:32:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45863 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFAMcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 08:32:15 -0400
Received: from 201-95-154-249.dsl.telesp.net.br ([201.95.154.249] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jfjbx-0003Mb-3J; Mon, 01 Jun 2020 12:32:13 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH] selftests/seccomp: use 90s as timeout
Date:   Mon,  1 Jun 2020 09:32:02 -0300
Message-Id: <20200601123202.1183526-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As seccomp_benchmark tries to calibrate how many samples will take more
than 5 seconds to execute, it may end up picking up a number of samples
that take 10 (but up to 12) seconds. As the calibration will take double
that time, it takes around 20 seconds. Then, it executes the whole thing
again, and then once more, with some added overhead. So, the thing might
take more than 40 seconds, which is too close to the 45s timeout.

That is very dependent on the system where it's executed, so may not be
observed always, but it has been observed on x86 VMs. Using a 90s timeout
seems safe enough.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/seccomp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/settings b/tools/testing/selftests/seccomp/settings
index d61f00d8cad3..ba4d85f74cd6 100644
--- a/tools/testing/selftests/seccomp/settings
+++ b/tools/testing/selftests/seccomp/settings
@@ -1 +1 @@
-90
+timeout=90
-- 
2.25.1

