Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A12A6129
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 11:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgKDKGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 05:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDKGC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 05:06:02 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB140C0613D3;
        Wed,  4 Nov 2020 02:06:01 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR2NR6l76z9sVM; Wed,  4 Nov 2020 21:05:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604484359;
        bh=bNNE6svKGzREq+ItnszP9noPZsw1yD9fOjueGdg56Nw=;
        h=From:To:Cc:Subject:Date:From;
        b=ryIipBcdwV/mNmI0qWzV73fyDySN2CIWwMRIscb7E1XgwbPcgqQtmiLJ1D9nLAxxJ
         9cDcTK/WqMVaCK6xB9EfS9doqfRaRLRAO8V5QyTI2eOl/I4CWC+0OaOCbU6jsbFbFg
         kuLbvE2WsOSJxhOzIWHfbMYmFP29EyNksdc1FPxud+Lc+T2awdKHWMmbYKFSod7Uas
         DFcwzbGqnhtW0jTcY78yeQ5A5u5F+Hs/IFABlS66J+/ASb64u2w+Mc+97pctxFuptF
         3usarWZcRTOxIDc9LFtsPQJousadmzMd6aDi+6WOpGyn0AcmG9bm9sy4VDhxDS82Ql
         w3OSVShM8UvPA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        christian@brauner.io
Subject: [PATCH] selftests/cgroup: Fix build on older distros
Date:   Wed,  4 Nov 2020 21:05:45 +1100
Message-Id: <20201104100545.657898-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On older distros struct clone_args does not have a cgroup member,
leading to build errors:

  cgroup_util.c: In function 'clone_into_cgroup':
  cgroup_util.c:343:4: error: 'struct clone_args' has no member named 'cgroup'

But the selftests already have a locally defined version of the
structure which is up to date, called __clone_args.

So use __clone_args which fixes the error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 05853b0b8831..58e30f65df5e 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -337,7 +337,7 @@ pid_t clone_into_cgroup(int cgroup_fd)
 #ifdef CLONE_ARGS_SIZE_VER2
 	pid_t pid;
 
-	struct clone_args args = {
+	struct __clone_args args = {
 		.flags = CLONE_INTO_CGROUP,
 		.exit_signal = SIGCHLD,
 		.cgroup = cgroup_fd,

base-commit: cf7cd542d1b538f6e9e83490bc090dd773f4266d
-- 
2.25.1

