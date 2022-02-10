Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7C4B15DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 20:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbiBJTII (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 14:08:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiBJTIH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 14:08:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5910C2;
        Thu, 10 Feb 2022 11:08:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id C36A81F4676E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644520078;
        bh=0jYGpXD6Jqyxvu0gUaOrjVAD3YdDmEptoto1aYaXkx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BN2I87IFqIlmzuZQ9OgfAua3tk7cvmzg6kPr/iGhmd2PCTT5IlEK6dztVZIhezLD4
         3WyDMRomVZar+N2tWODVT57JL6onXu7UD70VCXwygCA3nUIOH4bDRlvpRP5nT5mYoW
         trR/KdhjCdonotJWSA59R2C8ZQ2RD1ohbU2sWVNHuk3rVAUxXKL91pP8wWh6D3X69a
         N/jk5E1OGqcogkV72MXj79i79HKdT2GHUSZirSjE/PJ4fY2I9RUb5SKh8AWNAzJuPj
         eeGI29ugeLl8mgLRAaBITV8CbnMDxrPQQItFWjcCgI7bgHic1xmejv3QeO6j3dxatm
         JugxnpvjGWi1w==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        linux-sgx@vger.kernel.org (open list:INTEL SGX),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH 1/2] selftests: x86: allow expansion of $(CC)
Date:   Fri, 11 Feb 2022 00:06:40 +0500
Message-Id: <20220210190642.1477814-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210190642.1477814-1-usama.anjum@collabora.com>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
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

CC can have multiple sub-strings like "ccache gcc". Erorr pops up if
it is treated as single string and double quote are used around it.
This can be fixed by removing the quotes and not treating CC a single
string.

Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/check_cc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
index 3e2089c8cf549..aff2c15018b53 100755
--- a/tools/testing/selftests/x86/check_cc.sh
+++ b/tools/testing/selftests/x86/check_cc.sh
@@ -7,7 +7,7 @@ CC="$1"
 TESTPROG="$2"
 shift 2
 
-if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
+if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
     echo 1
 else
     echo 0
-- 
2.30.2

