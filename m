Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610961F72D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 16:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiKGPJ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 10:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiKGPJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 10:09:56 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 07:09:53 PST
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7294B1DA74;
        Mon,  7 Nov 2022 07:09:53 -0800 (PST)
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 2A7EUxlV025525
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Nov 2022 15:30:59 +0100
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net] seg6: selftests/bpf: fix BPF object file name in test_lwt_seg6local.sh
Date:   Mon,  7 Nov 2022 15:30:44 +0100
Message-Id: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test_lwt_seg6local.c implements several eBPF programs which are
used to test the SRv6 End.BPF behavior.
Since commit afef88e65554 ("selftests/bpf: Store BPF object files with
.bpf.o extension"), part of the build system and test programs loading
BPF object files are supposed to work with the .bpf.o extension.

Consequently, the test_lwt_seg6local.c is compiled into
test_lwt_seg6local.bpf.o and the corresponding test_lwt_seg6local.sh
script is not updated to deal with the correct .bpf.o extension.

This patch fixes the test_lwt_seg6local.sh, using the correct .bpf.o
extension for the testing BPF object file, i.e. test_lwt_seg6local.bpf.o.

Fixes: afef88e65554 ("selftests/bpf: Store BPF object files with .bpf.o extension")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 tools/testing/selftests/bpf/test_lwt_seg6local.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
index 826f4423ce02..bfe76ab78481 100755
--- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
+++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
@@ -117,18 +117,18 @@ ip netns exec ${NS6} ip -6 addr add fb00::109/16 dev veth10 scope link
 ip netns exec ${NS1} ip -6 addr add fb00::1/16 dev lo
 ip netns exec ${NS1} ip -6 route add fb00::6 dev veth1 via fb00::21
 
-ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj test_lwt_seg6local.o sec encap_srh dev veth2
+ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj test_lwt_seg6local.bpf.o sec encap_srh dev veth2
 ip netns exec ${NS2} ip -6 route add fd00::1 dev veth3 via fb00::43 scope link
 
 ip netns exec ${NS3} ip -6 route add fc42::1 dev veth5 via fb00::65
-ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.o sec add_egr_x dev veth4
+ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.bpf.o sec add_egr_x dev veth4
 
-ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.o sec pop_egr dev veth6
+ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.bpf.o sec pop_egr dev veth6
 ip netns exec ${NS4} ip -6 addr add fc42::1 dev lo
 ip netns exec ${NS4} ip -6 route add fd00::3 dev veth7 via fb00::87
 
 ip netns exec ${NS5} ip -6 route add fd00::4 table 117 dev veth9 via fb00::109
-ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.o sec inspect_t dev veth8
+ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.bpf.o sec inspect_t dev veth8
 
 ip netns exec ${NS6} ip -6 addr add fb00::6/16 dev lo
 ip netns exec ${NS6} ip -6 addr add fd00::4/16 dev lo
-- 
2.20.1

