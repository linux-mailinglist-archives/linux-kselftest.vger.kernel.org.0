Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568B675C8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 19:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjATSSI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjATSSH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 13:18:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF031041A;
        Fri, 20 Jan 2023 10:18:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0155B829E2;
        Fri, 20 Jan 2023 18:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD74C433EF;
        Fri, 20 Jan 2023 18:18:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zenghui Yu <yuzenghui@huawei.com>
Cc:     Will Deacon <will@kernel.org>, shuah@kernel.org,
        broonie@kernel.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH 1/2] kselftest/arm64: Remove the local NUM_VL definition
Date:   Fri, 20 Jan 2023 18:17:59 +0000
Message-Id: <167423867636.2495718.6585471068346623071.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221218092942.1940-1-yuzenghui@huawei.com>
References: <20221218092942.1940-1-yuzenghui@huawei.com>
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

On Sun, 18 Dec 2022 17:29:41 +0800, Zenghui Yu wrote:
> It was introduced in commit b77e995e3b96 ("kselftest/arm64: Add a test
> program to exercise the syscall ABI") but never actually used. Remove it.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: Remove the local NUM_VL definition
      https://git.kernel.org/arm64/c/00598857e38f
[2/2] kselftest/arm64: Correct buffer size for SME ZA storage
      https://git.kernel.org/arm64/c/daac835347a5

-- 
Catalin

