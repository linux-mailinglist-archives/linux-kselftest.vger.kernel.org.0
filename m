Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F9743E43
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjF3PGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjF3PG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 11:06:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (unknown [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C04E3C14;
        Fri, 30 Jun 2023 08:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688136804; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ktQWRloAJVcbtfzrwy7QVJMfZYy4BWWVjmUnPf5NL47XUIoo2h2XF5m496FyVmK59f
    Jure2X4x2FXITqAPDvytbcGH/plEu0Ir1NS59iS6xm4CYzAFLvY0YXxXdAXgEMD5juCK
    PLrfx5/wpjEajxzFuEbmd4FnaVdyI4OXDrDqgSQtV1VHeJrqpvhPEvjHvwegTlcG+674
    cZCcEQJwWuqowQPaiatkm1mIpkqkt67MQGuKt8XDSNOebpyK2CokqgzJ+47LAGskQlZl
    Ap3eT1iZ/63HV+Kd/I0ZgMMiDRSuU5eLUlLzn5XlUp44nvseCfYudELwf60T6YMFJFR3
    hlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688136804;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3v9FwKwabXm3VhIGPqHolyELPsxinvnAmxZlzv2LbiI=;
    b=sMGy9vkeo4NgzYHgfB0DQFmQqVMbUEs7H2EoBi9KokQIPmhvbogESQxzHlzvV7Yyat
    z4LNi/ZuvybenLmXsXId/aow0xq4QPXIm8ctX9/ClEOjy0568svuJVZ6uAtHMpZuft+J
    oHWTfEMG5TyvNd5Qg5X8UG8agVi7PJpphXhdR0N/2g2jeQHn3HhItS6UruFB3zGQeV5a
    FqNgBj9bVl5GMxWovb3iBcteo9LHcJv890aeg/ZCie0IjJxgO6W9oUH2iW2yDNIW0dbM
    lh7s6ECZCvhJVSf2p4qRJXk2vKH0+jII4LXuKDffzq1fGmf3Dy70waa93ljo9z3VfNzJ
    K0/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688136804;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3v9FwKwabXm3VhIGPqHolyELPsxinvnAmxZlzv2LbiI=;
    b=XSuY7hhtLS79JwyA0oJpta5/cIWvSuU1nviL381DYHGxEyGJ4WIsKEm6wF14LU0aIW
    o33SoVm5T19ssaE+7fXvXsY2ZgSW+HyNN/yEl01exvzsD4myOYzaY7mwJQzMctROmuUz
    VJrD7vZCJdgR8gN+9Jutem9t1zM/LqqNX6sFQykL+qmVDbxW898b8dx1j82xBxScZr+7
    IqV0sbEJt2q3ponqcHiknFIk8Fk99xvfkDldewrTB1ahTWDhJNy0yLK0qNEWiymny60M
    BzeR0FJNCWhtmqcWeaXb8WgLZ63zxXWZztfG9vqCKTxKKRzpUAbmucPeOQdgPdxjzd98
    EJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688136804;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=3v9FwKwabXm3VhIGPqHolyELPsxinvnAmxZlzv2LbiI=;
    b=F7Gp3a1EBO67LR5zgQEvd/wQ/xgdvjrUUG7VhAM/OOv6ZMCH6AdEZs9KlNJ3YQvGVi
    6eCAwGpbjiBJbIExRaCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x+1/7Qcst+v+6egNSCv2nSejLpXdlt4RWwKmQOQ=="
Received: from sender
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id y5401az5UErNzMj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 30 Jun 2023 16:53:23 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Prarit Bhargava <prarit@redhat.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1] Fix documentation of panic_on_warn
Date:   Fri, 30 Jun 2023 16:53:02 +0200
Message-Id: <20230630145307.25865-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel cmdline option panic_on_warn expects an integer, it is not a
plain option as documented. A number of uses in the tree figured this
already, and use panic_on_warn=1 for their purpose.

Adjust a comment which otherwise may mislead people in the future.

Fixes: 9e3961a097 ("kernel: add panic_on_warn")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..15196f84df49 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4049,7 +4049,7 @@
 			extra details on the taint flags that users can pick
 			to compose the bitmask to assign to panic_on_taint.
 
-	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
+	panic_on_warn=1	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
 	parkbd.port=	[HW] Parallel port number the keyboard adapter is
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 62f3b0f56e4d..d3cdc2d33d4b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -655,4 +655,4 @@ fi
 # Control buffer size: --bootargs trace_buf_size=3k
 # Get trace-buffer dumps on all oopses: --bootargs ftrace_dump_on_oops
 # Ditto, but dump only the oopsing CPU: --bootargs ftrace_dump_on_oops=orig_cpu
-# Heavy-handed way to also dump on warnings: --bootargs panic_on_warn
+# Heavy-handed way to also dump on warnings: --bootargs panic_on_warn=1
