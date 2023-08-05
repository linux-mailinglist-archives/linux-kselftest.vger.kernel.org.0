Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5587711CD
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 21:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHETic (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHETib (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 15:38:31 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ABC1732
        for <linux-kselftest@vger.kernel.org>; Sat,  5 Aug 2023 12:38:27 -0700 (PDT)
X-QQ-mid: bizesmtp68t1691264173thz60w1z
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 03:36:12 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: Xz3VOcA7Mr1ZcCeErdAI9dd9j6rIAoGrSUiAzxKeDLeDGqPahyEFAb8R1Ipyw
        TV/Ul+LwxE1LVpxJdpE/iOaPuIEVn67WwY5z3VxuA22rN3fW6ovrLN8XhZ7AJmRMMBjSRWP
        u+JQq/qmdnCPpfKPjISQ0o8xa90EgsPDi7s+DSIe8WUMYrIVkDgL8gSHWJIFlyd2UfZS4FM
        45YPbZVhz57WKCE5thuZSI0XK2pMOZKNMxk8c0pkoxapygSKMPGedD2TcgDhym+GOsu1v2w
        l8YUVt1DENLoAahW52Xt1IADFg1wqSWhT6QPBED16DB2/jHGJxdtcaK1JIN/HkaCOQDXHL7
        9EgpD/GbBvxtX3v07yzZcPz9iMZ7SlabmBNPzVGHlviLy8JCSuqg3FRfXEII2b14e5RLTJ5
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8914460153520872544
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v1 0/4] selftests/nolibc: customize CROSS_COMPILE for all supported architectures
Date:   Sun,  6 Aug 2023 03:36:11 +0800
Message-Id: <cover.1691263493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Based on the CROSS_COMPILE customize support [1] from the last ppc
patchset, to further make run-user/run targets happy for all of the
nolibc supported architectures, let's customize CROSS_COMPILE for all of
them.

Beside loongarch, all of the other architectures have local toolchains.
let's use the one from [2] for loongarch, it has a different prefix.

And also, as suggested by you in our previous discuss, let's add some
notes for the toolchains and firmwares instead of automatically download
them.

Now, the test iteration becomes very simple and pretty:

    $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390"
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status; done
         i386: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
       x86_64: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
        arm64: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
          arm: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
         mips: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
          ppc: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
        ppc64: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
      ppc64le: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
        riscv: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
         s390: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

(I have no qemu-user currently for loongarch, so, no test result above)

Best regards,
Zhangjin
---
[1] https://lore.kernel.org/lkml/cover.1691259983.git.falcon@tinylab.org/
[2] https://mirrors.edge.kernel.org/pub/tools/crosstool/

Zhangjin Wu (4):
  selftests/nolibc: allow use x86_64 toolchain for i386
  selftests/nolibc: customize CROSS_COMPILE for many architectures
  selftests/nolibc: customize CROSS_COMPILE for loongarch
  selftests/nolibc: add some notes about qemu tools

 tools/testing/selftests/nolibc/Makefile | 32 ++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

-- 
2.25.1

