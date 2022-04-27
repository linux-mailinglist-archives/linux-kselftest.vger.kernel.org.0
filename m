Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743B5121A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiD0SzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiD0Sxr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:53:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA03D7075;
        Wed, 27 Apr 2022 11:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28985B828C7;
        Wed, 27 Apr 2022 18:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52662C385A7;
        Wed, 27 Apr 2022 18:40:06 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     zhengkui_guo@outlook.com
Subject: Re: [PATCH] kselftest/arm64: fix array_size.cocci warning
Date:   Wed, 27 Apr 2022 19:40:03 +0100
Message-Id: <165108479997.3292602.14830911961076617578.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419032501.22790-1-guozhengkui@vivo.com>
References: <20220419032501.22790-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Apr 2022 11:24:51 +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> tools/testing/selftests/arm64/mte/check_child_memory.c:110:25-26:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:88:24-25:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:90:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:147:24-25:
> WARNING: Use ARRAY_SIZE
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: fix array_size.cocci warning
      https://git.kernel.org/arm64/c/55a5c18e5dab

-- 
Catalin

