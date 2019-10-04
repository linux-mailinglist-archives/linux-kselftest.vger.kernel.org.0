Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2535FCB41B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2019 07:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfJDFN0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 01:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbfJDFN0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 01:13:26 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DFE6207FF;
        Fri,  4 Oct 2019 05:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570166005;
        bh=ES869BO6h9noSDr8RsOScfEsr4Cnt/LG2wJ9+/QDzwM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZPqHINHRy5lTLkQZNkeucgHQfed1wSGf3sWHUaWtYp2k2+3LzQhzGom8BvDNXQiWi
         N+7CtJmO5eHYpb8NBxLwRnwm8/uD4Zb6oUI1Da/sZITUBGyuE0iPjBYnIjik9PHC5T
         SwU6x6hgQ/QCoZQyLz0VCuMSQb/69Mb30UJq7PkQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH] selftests: Use real temporary working directory for archiving
Date:   Fri,  4 Oct 2019 14:13:22 +0900
Message-Id: <157016600217.8022.346317009413291058.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use real temporary working directory for generating kselftest
archive.

tools/testing/selftests/kselftest directory has been used for
the temporary working directory for making a tar archive from
gen_kselftest_tar.sh, and it removes the directory for cleanup.

However, since the kselftest directory became a part of the
repository, it must not be used as a working dir.

Introduce mktemp to prepare a temporary working directory
for archiving kselftests.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/gen_kselftest_tar.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing/selftests/gen_kselftest_tar.sh
index a27e2eec3586..eba1e9987ffc 100755
--- a/tools/testing/selftests/gen_kselftest_tar.sh
+++ b/tools/testing/selftests/gen_kselftest_tar.sh
@@ -38,16 +38,16 @@ main()
 	esac
 	fi
 
-	install_dir=./kselftest
+	tmpdir=`mktemp -d ./install-XXXXXX` || exit 1
 
 # Run install using INSTALL_KSFT_PATH override to generate install
 # directory
-./kselftest_install.sh
-tar $copts kselftest${ext} $install_dir
+./kselftest_install.sh $tmpdir
+tar $copts kselftest${ext} -C $tmpdir kselftest
 echo "Kselftest archive kselftest${ext} created!"
 
 # clean up install directory
-rm -rf kselftest
+rm -rf $tmpdir
 }
 
 main "$@"

