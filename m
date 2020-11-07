Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563032AA437
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 10:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgKGJTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Nov 2020 04:19:46 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:57833 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgKGJTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Nov 2020 04:19:46 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id D9A5666663C;
        Sat,  7 Nov 2020 17:19:42 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Wang Qing <wangqing@vivo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tool: selftests: fix spelling typo of 'writting'
Date:   Sat,  7 Nov 2020 17:19:35 +0800
Message-Id: <1604740776-27082-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkwYGklLGh1IH0geVkpNS09MT0tMQ0hJQkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6GSo*Vj8dHRwzTEMdKx8W
        HEgaCTlVSlVKTUtPTE9LTENITUxDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQkJNNwY+
X-HM-Tid: 0a75a2011c3e9373kuwsd9a5666663c
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

writting -> writing

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 9b0912a..9132fae7
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -894,7 +894,7 @@ static int faulting_process(int signal_test)
 				count_verify[nr]);
 	        }
 		/*
-		 * Trigger write protection if there is by writting
+		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
 		*area_count(area_dst, nr) = count;
@@ -922,7 +922,7 @@ static int faulting_process(int signal_test)
 				count_verify[nr]); exit(1);
 		}
 		/*
-		 * Trigger write protection if there is by writting
+		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
 		*area_count(area_dst, nr) = count;
-- 
2.7.4

