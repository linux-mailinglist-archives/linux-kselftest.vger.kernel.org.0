Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877A4B5A1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiBNSmx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 13:42:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiBNSms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 13:42:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E76A025;
        Mon, 14 Feb 2022 10:42:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 0F3981F410C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644864131;
        bh=7u0HNDo3EDsgorjd5iMF9ffXgHW0CA+ygVimr7HCfN0=;
        h=From:To:Cc:Subject:Date:From;
        b=PkjQ083apuELxkrX2tqCWqBbzGPsy3ku+Oyj2FCniH85Ru06e9qLtuMs5Wvf7f3G2
         I3Szy/v2wn2LE288W3CBqQZkn/gTSt95maP9Y/WdaOmrIR5lj+V51PqPR/tLggs5rJ
         N3ST6Qd2kHz05y9Vr+a8sHAamE+qx+mdCsubn/NO+ZytUk5Wg2K69t9Che8/+YznZl
         wvuvKl7C9YiQ2McRMk7WfM2kL+VrHSii+IpA2s2Lpbdmczx1jc6ixfg3eVqXT2blnG
         rzpUzxLs0VVpt25peClCbZWO4u3fcDuoQIcHY1ZMl967I0N0M6DWo3QyJGwzbc+glY
         967FnTylmzwcg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Borislav Petkov <bp@suse.de>,
        linux-sgx@vger.kernel.org (open list:INTEL SGX),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list), David.Laight@ACULAB.COM
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io
Subject: [PATCH V2 0/2] selftests: sgx: Fix build of test_sgx
Date:   Mon, 14 Feb 2022 23:41:07 +0500
Message-Id: <20220214184109.3739179-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CC can have multiple sub-strings like "ccache gcc". Build system of sgx
selftest is unable to support this use case and test_sgx isn't built.
Then rsync gives an erorr:

rsync: [sender] link_stat "//linux/build/kselftest/sgx/test_sgx" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]

This can be fixed if CC is considered to have one string while passing to
check_cc.sh script and inside this script, CC is expanded before execution.

Following build tests have been performed to confirm that these patches
don't break anything else. The verification has also been done through
KernelCI scripts locally as KernelCI has caught this bug:
1) cd tools/testing/selftests && make
2) make -C tools/testing/selftests
3) make -C tools/testing/selftests O=build
4) make -C tools/testing/selftests O=build CC="ccache gcc"
5) ./kci_build make_kselftest

Muhammad Usama Anjum (2):
  selftests: x86: add validity check and allow field splitting
  selftests: sgx: Treat CC as one argument

 tools/testing/selftests/sgx/Makefile    | 2 +-
 tools/testing/selftests/x86/check_cc.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.2

