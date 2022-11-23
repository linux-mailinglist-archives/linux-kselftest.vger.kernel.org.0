Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509C9634BEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiKWBDq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKWBDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 20:03:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7E04DA4F2;
        Tue, 22 Nov 2022 17:03:41 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxpfBscX1jgyMAAA--.464S3;
        Wed, 23 Nov 2022 09:03:40 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJldqcX1js24YAA--.45400S2;
        Wed, 23 Nov 2022 09:03:39 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] selftests: Use "grep -E" instead of "egrep"
Date:   Wed, 23 Nov 2022 09:03:27 +0800
Message-Id: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxJldqcX1js24YAA--.45400S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtrW5Gr4DZw1kGw18uF1fXrb_yoWkWrbE9r
        W8tF95Jr4UZF9rAr47Ww4YyrZrC3y2kr1qqrWrW3WYkrW5XF4DGF4kAw1j9a4rWw45G34a
        vFsYkFySkw1aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        U7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E
        0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
        IYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2: split into separate 6 patches suggested by Shuah

Tiezhu Yang (6):
  selftests: rcutorture: Use "grep -E" instead of "egrep"
  selftests: ftrace: Use "grep -E" instead of "egrep"
  selftests: powerpc: Use "grep -E" instead of "egrep"
  selftests: gpio: Use "grep -E" instead of "egrep"
  selftests: net: Use "grep -E" instead of "egrep"
  selftests: kselftest_deps: Use "grep -E" instead of "egrep"

 .../selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc       |  8 ++++----
 tools/testing/selftests/gpio/gpio-sim.sh                       |  2 +-
 tools/testing/selftests/kselftest_deps.sh                      |  2 +-
 tools/testing/selftests/net/toeplitz.sh                        |  2 +-
 tools/testing/selftests/powerpc/scripts/hmi.sh                 |  2 +-
 tools/testing/selftests/rcutorture/bin/console-badness.sh      |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm-build.sh            |  4 ++--
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh      |  4 ++--
 tools/testing/selftests/rcutorture/bin/kvm.sh                  |  4 ++--
 tools/testing/selftests/rcutorture/bin/parse-console.sh        | 10 +++++-----
 10 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.1.0

