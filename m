Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ECF77C6A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 06:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjHOEHE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjHOEEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 00:04:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B81FD0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 21:02:19 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPyDf0fYtztRxg;
        Tue, 15 Aug 2023 11:58:42 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 12:02:16 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>, <shuah@kernel.org>,
        <broonie@kernel.org>
CC:     <zengheng4@huawei.com>, <xiexiuqi@huawei.com>,
        <linux-kselftest@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next 0/4] kselftest/arm64: Add crypto-related feature checks to hwcap test
Date:   Tue, 15 Aug 2023 11:58:46 +0800
Message-ID: <20230815035850.3947870-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new feature checks related to crypto to the hwcap test.

The following is a log snippet from my local testing environment
based on for-next/selftests:
~~~
 TAP version 13
 1..111
 # AES present
 ok 1 cpuinfo_match_AES
 ok 2 sigill_AES
 ok 3 # SKIP sigbus_AES
 # CRC32 present
 ok 4 cpuinfo_match_CRC32
 ok 5 sigill_CRC32
 ok 6 # SKIP sigbus_CRC32
 ok 7 cpuinfo_match_CSSC
 # sigill_reported for CSSC
 ok 8 # SKIP sigill_CSSC
 ok 9 # SKIP sigbus_CSSC
 # FP present
 ok 10 cpuinfo_match_FP
 ok 11 sigill_FP
 ok 12 # SKIP sigbus_FP
 # JSCVT present
 ok 13 cpuinfo_match_JSCVT
 ok 14 sigill_JSCVT
 ok 15 # SKIP sigbus_JSCVT
 # LRCPC present
 ok 16 cpuinfo_match_LRCPC
 ok 17 sigill_LRCPC
 ok 18 # SKIP sigbus_LRCPC
 # LRCPC2 present
 ok 19 cpuinfo_match_LRCPC2
 ok 20 sigill_LRCPC2
 ok 21 # SKIP sigbus_LRCPC2
 # LSE present
 ok 22 cpuinfo_match_LSE
 ok 23 sigill_LSE
 ok 24 # SKIP sigbus_LSE
 # LSE2 present
 ok 25 cpuinfo_match_LSE2
 ok 26 sigill_LSE2
 ok 27 sigbus_LSE2
 ok 28 cpuinfo_match_MOPS
 ok 29 sigill_MOPS
 ok 30 # SKIP sigbus_MOPS
 # RNG present
 ok 31 cpuinfo_match_RNG
 ok 32 sigill_RNG
 ok 33 # SKIP sigbus_RNG
 # PMULL present
 ok 34 cpuinfo_match_PMULL
 ok 35 sigill_PMULL
 ok 36 # SKIP sigbus_PMULL
 ok 37 cpuinfo_match_RPRFM
 ok 38 # SKIP sigill_RPRFM
 ok 39 # SKIP sigbus_RPRFM
 # SHA1 present
 ok 40 cpuinfo_match_SHA1
 ok 41 sigill_SHA1
 ok 42 # SKIP sigbus_SHA1
 # SHA2 present
 ok 43 cpuinfo_match_SHA2
 ok 44 sigill_SHA2
 ok 45 # SKIP sigbus_SHA2
 # SHA512 present
 ok 46 cpuinfo_match_SHA512
 ok 47 sigill_SHA512
 ok 48 # SKIP sigbus_SHA512
 ok 49 cpuinfo_match_SME
 ok 50 sigill_SME
 ok 51 # SKIP sigbus_SME
 ok 52 cpuinfo_match_SME2
 ok 53 sigill_SME2
 ok 54 # SKIP sigbus_SME2
 ok 55 cpuinfo_match_SME 2.1
 # sigill_reported for SME 2.1
 ok 56 # SKIP sigill_SME 2.1
 ok 57 # SKIP sigbus_SME 2.1
 ok 58 cpuinfo_match_SME I16I32
 # sigill_reported for SME I16I32
 ok 59 # SKIP sigill_SME I16I32
 ok 60 # SKIP sigbus_SME I16I32
 ok 61 cpuinfo_match_SME BI32I32
 # sigill_reported for SME BI32I32
 ok 62 # SKIP sigill_SME BI32I32
 ok 63 # SKIP sigbus_SME BI32I32
 ok 64 cpuinfo_match_SME B16B16
 # sigill_reported for SME B16B16
 ok 65 # SKIP sigill_SME B16B16
 ok 66 # SKIP sigbus_SME B16B16
 ok 67 cpuinfo_match_SME F16F16
 # sigill_reported for SME F16F16
 ok 68 # SKIP sigill_SME F16F16
 ok 69 # SKIP sigbus_SME F16F16
 # SVE present
 ok 70 cpuinfo_match_SVE
 ok 71 sigill_SVE
 ok 72 # SKIP sigbus_SVE
 ok 73 cpuinfo_match_SVE 2
 # sigill_reported for SVE 2
 ok 74 # SKIP sigill_SVE 2
 ok 75 # SKIP sigbus_SVE 2
 ok 76 cpuinfo_match_SVE 2.1
 # sigill_reported for SVE 2.1
 ok 77 # SKIP sigill_SVE 2.1
 ok 78 # SKIP sigbus_SVE 2.1
 ok 79 cpuinfo_match_SVE AES
 # sigill_reported for SVE AES
 ok 80 # SKIP sigill_SVE AES
 ok 81 # SKIP sigbus_SVE AES
 ok 82 cpuinfo_match_SVE2 PMULL
 # sigill_reported for SVE2 PMULL
 ok 83 # SKIP sigill_SVE2 PMULL
 ok 84 # SKIP sigbus_SVE2 PMULL
 ok 85 cpuinfo_match_SVE2 BITPERM
 # sigill_reported for SVE2 BITPERM
 ok 86 # SKIP sigill_SVE2 BITPERM
 ok 87 # SKIP sigbus_SVE2 BITPERM
 ok 88 cpuinfo_match_SVE2 SHA3
 # sigill_reported for SVE2 SHA3
 ok 89 # SKIP sigill_SVE2 SHA3
 ok 90 # SKIP sigbus_SVE2 SHA3
 ok 91 cpuinfo_match_SVE2 SM4
 # sigill_reported for SVE2 SM4
 ok 92 # SKIP sigill_SVE2 SM4
 ok 93 # SKIP sigbus_SVE2 SM4
 # SVE2 I8MM present
 ok 94 cpuinfo_match_SVE2 I8MM
 ok 95 sigill_SVE2 I8MM
 ok 96 # SKIP sigbus_SVE2 I8MM
 # SVE2 F32MM present
 ok 97 cpuinfo_match_SVE2 F32MM
 ok 98 sigill_SVE2 F32MM
 ok 99 # SKIP sigbus_SVE2 F32MM
 # SVE2 F64MM present
 ok 100 cpuinfo_match_SVE2 F64MM
 ok 101 sigill_SVE2 F64MM
 ok 102 # SKIP sigbus_SVE2 F64MM
 # SVE2 BF16 present
 ok 103 cpuinfo_match_SVE2 BF16
 ok 104 sigill_SVE2 BF16
 ok 105 # SKIP sigbus_SVE2 BF16
 ok 106 cpuinfo_match_SVE2 EBF16
 ok 107 # SKIP sigill_SVE2 EBF16
 ok 108 # SKIP sigbus_SVE2 EBF16
 ok 109 cpuinfo_match_HBC
 ok 110 sigill_HBC
 ok 111 # SKIP sigbus_HBC
 # Totals: pass:60 fail:0 xfail:0 xpass:0 skip:51 error:0
~~~

Zeng Heng (4):
  kselftest/arm64: add SHA1 and related features to hwcap test
  kselftest/arm64: add AES feature check to hwcap test
  kselftest/arm64: add pmull feature to hwcap test
  kselftest/arm64: add jscvt feature to hwcap test

 tools/testing/selftests/arm64/abi/hwcap.c | 77 +++++++++++++++++++++++
 1 file changed, 77 insertions(+)

--
2.25.1

