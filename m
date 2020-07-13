Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C821E0DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGMThR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 15:37:17 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:35388 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGMThR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 15:37:17 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E81D1BC06E;
        Mon, 13 Jul 2020 19:37:12 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] rcutorture: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 21:37:06 +0200
Message-Id: <20200713193706.37523-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
index 449cf579d6f9..cc280ba157a3 100644
--- a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
+++ b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
@@ -36,7 +36,7 @@ References:
 	https://help.ubuntu.com/community/JeOSVMBuilder
 	http://wiki.libvirt.org/page/UbuntuKVMWalkthrough
 	http://www.moe.co.uk/2011/01/07/pci_add_option_rom-failed-to-find-romfile-pxe-rtl8139-bin/ -- "apt-get install kvm-pxe"
-	http://www.landley.net/writing/rootfs-howto.html
-	http://en.wikipedia.org/wiki/Initrd
-	http://en.wikipedia.org/wiki/Cpio
+	https://www.landley.net/writing/rootfs-howto.html
+	https://en.wikipedia.org/wiki/Initrd
+	https://en.wikipedia.org/wiki/Cpio
 	http://wiki.libvirt.org/page/UbuntuKVMWalkthrough
-- 
2.27.0

