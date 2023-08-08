Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4B773CFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjHHQMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjHHQLD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:11:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF47D8A
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 08:46:44 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKjbC1vFFzNmrS;
        Tue,  8 Aug 2023 14:15:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:18:30 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kristina.martsenko@arm.com>, <shuah@kernel.org>,
        <catalin.marinas@arm.com>, <broonie@kernel.org>, <will@kernel.org>
CC:     <zengheng4@huawei.com>, <linux-kselftest@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/5] kselftest/arm64: add features check to hwcap test
Date:   Tue, 8 Aug 2023 14:13:56 +0800
Message-ID: <20230808061356.2215158-6-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808061356.2215158-1-zengheng4@huawei.com>
References: <20230808061356.2215158-1-zengheng4@huawei.com>
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

Add new feature checks and provide testing item to support capturing
SIGBUS exception signal.

The following is a log snippet from my local testing environment:
~~~
 TAP version 13
 1..90
 # CRC32 present
 ok 1 cpuinfo_match_CRC32
 ok 2 sigill_CRC32
 ok 3 # SKIP sigbus_CRC32
 ok 4 cpuinfo_match_CSSC
 # sigill_reported for CSSC
 ok 5 # SKIP sigill_CSSC
 ok 6 # SKIP sigbus_CSSC
 # FP present
 ok 7 cpuinfo_match_FP
 ok 8 sigill_FP
 ok 9 # SKIP sigbus_FP
 # LRCPC present
 ok 10 cpuinfo_match_LRCPC
 ok 11 sigill_LRCPC
 ok 12 # SKIP sigbus_LRCPC
 # LRCPC2 present
 ok 13 cpuinfo_match_LRCPC2
 ok 14 sigill_LRCPC2
 ok 15 # SKIP sigbus_LRCPC2
 # LSE present
 ok 16 cpuinfo_match_LSE
 ok 17 sigill_LSE
 ok 18 # SKIP sigbus_LSE
 # LSE2 present
 ok 19 cpuinfo_match_LSE2
 ok 20 sigill_LSE2
 ok 21 sigbus_LSE2
 ok 22 cpuinfo_match_MOPS
 ok 23 sigill_MOPS
 ok 24 # SKIP sigbus_MOPS
 # RNG present
 ok 25 cpuinfo_match_RNG
 ok 26 sigill_RNG
 ok 27 # SKIP sigbus_RNG
 ok 28 cpuinfo_match_RPRFM
 ok 29 # SKIP sigill_RPRFM
 ok 30 # SKIP sigbus_RPRFM
 ok 31 cpuinfo_match_SME
 ok 32 sigill_SME
 ok 33 # SKIP sigbus_SME
 ok 34 cpuinfo_match_SME2
 ok 35 sigill_SME2
 ok 36 # SKIP sigbus_SME2
 ok 37 cpuinfo_match_SME 2.1
 # sigill_reported for SME 2.1
 ok 38 # SKIP sigill_SME 2.1
 ok 39 # SKIP sigbus_SME 2.1
 ok 40 cpuinfo_match_SME I16I32
 # sigill_reported for SME I16I32
 ok 41 # SKIP sigill_SME I16I32
 ok 42 # SKIP sigbus_SME I16I32
 ok 43 cpuinfo_match_SME BI32I32
 # sigill_reported for SME BI32I32
 ok 44 # SKIP sigill_SME BI32I32
 ok 45 # SKIP sigbus_SME BI32I32
 ok 46 cpuinfo_match_SME B16B16
 # sigill_reported for SME B16B16
 ok 47 # SKIP sigill_SME B16B16
 ok 48 # SKIP sigbus_SME B16B16
 ok 49 cpuinfo_match_SME F16F16
 # sigill_reported for SME F16F16
 ok 50 # SKIP sigill_SME F16F16
 ok 51 # SKIP sigbus_SME F16F16
 # SVE present
 ok 52 cpuinfo_match_SVE
 ok 53 sigill_SVE
 ok 54 # SKIP sigbus_SVE
 ok 55 cpuinfo_match_SVE 2
 # sigill_reported for SVE 2
 ok 56 # SKIP sigill_SVE 2
 ok 57 # SKIP sigbus_SVE 2
 ok 58 cpuinfo_match_SVE 2.1
 # sigill_reported for SVE 2.1
 ok 59 # SKIP sigill_SVE 2.1
 ok 60 # SKIP sigbus_SVE 2.1
 ok 61 cpuinfo_match_SVE AES
 # sigill_reported for SVE AES
 ok 62 # SKIP sigill_SVE AES
 ok 63 # SKIP sigbus_SVE AES
 ok 64 cpuinfo_match_SVE2 PMULL
 # sigill_reported for SVE2 PMULL
 ok 65 # SKIP sigill_SVE2 PMULL
 ok 66 # SKIP sigbus_SVE2 PMULL
 ok 67 cpuinfo_match_SVE2 BITPERM
 # sigill_reported for SVE2 BITPERM
 ok 68 # SKIP sigill_SVE2 BITPERM
 ok 69 # SKIP sigbus_SVE2 BITPERM
 ok 70 cpuinfo_match_SVE2 SHA3
 # sigill_reported for SVE2 SHA3
 ok 71 # SKIP sigill_SVE2 SHA3
 ok 72 # SKIP sigbus_SVE2 SHA3
 ok 73 cpuinfo_match_SVE2 SM4
 # sigill_reported for SVE2 SM4
 ok 74 # SKIP sigill_SVE2 SM4
 ok 75 # SKIP sigbus_SVE2 SM4
 # SVE2 I8MM present
 ok 76 cpuinfo_match_SVE2 I8MM
 ok 77 sigill_SVE2 I8MM
 ok 78 # SKIP sigbus_SVE2 I8MM
 # SVE2 F32MM present
 ok 79 cpuinfo_match_SVE2 F32MM
 ok 80 sigill_SVE2 F32MM
 ok 81 # SKIP sigbus_SVE2 F32MM
 # SVE2 F64MM present
 ok 82 cpuinfo_match_SVE2 F64MM
 ok 83 sigill_SVE2 F64MM
 ok 84 # SKIP sigbus_SVE2 F64MM
 # SVE2 BF16 present
 ok 85 cpuinfo_match_SVE2 BF16
 ok 86 sigill_SVE2 BF16
 ok 87 # SKIP sigbus_SVE2 BF16
 ok 88 cpuinfo_match_SVE2 EBF16
 ok 89 # SKIP sigill_SVE2 EBF16
 ok 90 # SKIP sigbus_SVE2 EBF16
 # Totals: pass:46 fail:0 xfail:0 xpass:0 skip:44 error:0
~~~

Zeng Heng (5):
  kselftest/arm64: add float-point feature to hwcap test
  kselftest/arm64: add crc32 feature to hwcap test
  kselftest/arm64: add DEF_SIGHANDLER_FUNC() and DEF_INST_RAISE_SIG()
    helpers
  kselftest/arm64: add test item that support to capturing the SIGBUS
    signal
  kselftest/arm64: add lse and lse2 features to hwcap test

 tools/testing/selftests/arm64/abi/hwcap.c | 201 ++++++++++++++++------
 1 file changed, 151 insertions(+), 50 deletions(-)

--
2.25.1

