Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0A1C16B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbgEANwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 09:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgEANhq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 09:37:46 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9A324953;
        Fri,  1 May 2020 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340266;
        bh=wlb9Yzf1cohxo7Y+UM3qahpyFZZr2kDu1/XLeApB72w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkRNKTPpF3G39VW4lemYhQwxst5+2W+HkhacksfaLY75eEnaX4V38N2D2WcHbnbsG
         BXtM4qTyWIDc16a4lCyCMoMHkEpIeK9ZKX1Gl7HVwuCykTRhMfNpYlG15PpWEBFskH
         tAKg4qrXOw9YmBbSD6qR8ChmuPmGn4pUQNQZzcsU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: [PATCH 1/3] selftests/ftrace: Make XFAIL green color
Date:   Fri,  1 May 2020 22:37:41 +0900
Message-Id: <158834026136.28357.14691721094452323293.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158834025077.28357.15141584656220094821.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since XFAIL (Expected Failure) is expected to fail the test, which
means that test case works as we expected. IOW, XFAIL is same as
PASS. So make it green.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 063ecb290a5a..72e837d0dfc1 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -273,7 +273,7 @@ eval_result() { # sigval
       return $UNSUPPORTED_RESULT # depends on use case
     ;;
     $XFAIL)
-      prlog "	[${color_red}XFAIL${color_reset}]"
+      prlog "	[${color_green}XFAIL${color_reset}]"
       XFAILED_CASES="$XFAILED_CASES $CASENO"
       return 0
     ;;

