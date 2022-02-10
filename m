Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC434B15DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbiBJTIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 14:08:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiBJTIL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 14:08:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC310C2;
        Thu, 10 Feb 2022 11:08:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B11E41F4676F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644520090;
        bh=w9UAj95XKnPRibc1brD+qtkacXLhUZfQCGbpzMCMPok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYZY6rCWfCZBE+0886mH7m5RHGsBgmuNXnM5VnWqvgNdLQDcK5h3uxUfaAcVH6QjD
         C+mNZVYBuHH/xWOccwOZl6OoQc6yUo/rkR7UbBEEKrZ6rr5QU8QKfTsXmzXvJqhf9l
         28yi9/hrMIhV7BPMCUOiNGHA0yK0Bpl1OClyRGAK1D9l84LEXzuIoPOcsZvutxRvcU
         Fss8S0OzQYcMYB5S8+PL7l3BTJ7NMzdoMRyjygJc20jiycTb0Mui8qcVkTU/SlvxWv
         7UbJA1Zo9oyDQLyyZNuIXX6L1wTGc2E6s0RwKWzQnsvMso98hAl84AaFqXZbUV+3+i
         7a2kOqE6x86jw==
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
Subject: [PATCH 2/2] selftests: sgx: Treat CC as one argument
Date:   Fri, 11 Feb 2022 00:06:41 +0500
Message-Id: <20220210190642.1477814-3-usama.anjum@collabora.com>
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

CC can have multiple sub-strings like "ccache gcc". For check_cc.sh,
CC needs to be treated like one argument. Put double quotes around it to
make CC one string and hence one argument.

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 2956584e1e37f..75af864e07b65 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -4,7 +4,7 @@ include ../lib.mk
 
 .PHONY: all clean
 
-CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
+CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh "$(CC)" \
 			    ../x86/trivial_64bit_program.c)
 
 ifndef OBJCOPY
-- 
2.30.2

