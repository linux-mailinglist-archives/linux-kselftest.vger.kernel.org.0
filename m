Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A614B7533
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 10:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfISIf5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 04:35:57 -0400
Received: from u164.east.ru ([195.170.63.164]:58268 "EHLO mx.lavteam.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbfISIf5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 04:35:57 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 04:35:56 EDT
Received: from yogzotot (yogzotot [192.168.111.254])
        by mx.lavteam.org (Postfix) with ESMTPS id 509EA2E69;
        Thu, 19 Sep 2019 11:29:03 +0300 (MSK)
Date:   Thu, 19 Sep 2019 11:29:02 +0300
From:   Anatoly Pugachev <matorola@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH] selftests: update .gitignore files for selftests/bpf and
 selftests/zram
Message-ID: <20190919082902.GA15755@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests: update .gitignore files for selftests/bpf and selftests/zram

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---
 tools/testing/selftests/bpf/.gitignore  | 4 ++++
 tools/testing/selftests/zram/.gitignore | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 tools/testing/selftests/zram/.gitignore

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 7470327edcfe..218ac37f460a 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -15,6 +15,9 @@ test_libbpf_open
 test_sock
 test_sock_addr
 test_sock_fields
+test_sockopt
+test_sockopt_multi
+test_sockopt_sk
 urandom_read
 test_btf
 test_sockmap
@@ -32,6 +35,7 @@ test_section_names
 test_tcpnotify_user
 test_libbpf
 test_tcp_check_syncookie_user
+test_tcp_rtt
 test_sysctl
 alu32
 libbpf.pc
diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
new file mode 100644
index 000000000000..b4a2cb6fafa6
--- /dev/null
+++ b/tools/testing/selftests/zram/.gitignore
@@ -0,0 +1 @@
+err.log
-- 
2.23.0

