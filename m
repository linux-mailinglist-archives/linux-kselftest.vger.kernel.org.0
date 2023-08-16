Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64B77E89F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbjHPSZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbjHPSZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9C42702;
        Wed, 16 Aug 2023 11:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAFAD63F66;
        Wed, 16 Aug 2023 18:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE06C433CC;
        Wed, 16 Aug 2023 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210337;
        bh=Ys/SLUYq/H+BiAWtcmpLi2aTECuJmmf1YViHNLiOGv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sK8La1GXuqPkxEAU+SJMidW38QovsSK6P/gSObqpJZ2z5OmAFUIx2Mx7u851s1UZC
         EynWQO8UJXu/bPZSHAaLCJwwut3Xoncp/KyTVWDA8MBY0iVObyAUfM2ZOWOdRNoDXZ
         IBfBBtEc77dX+OqScF5oDqvKq1ndi94tEsZuwuFJUK+0cJtaAqe/QnPZb7gFBMPbhh
         F/1uD+CYyTkfjs4t8IVTt/TNRr05Y2HCbQT67hFp+ztfybGD/PL9n/N6XhuIhHSV+V
         CaBov5hH3gBZbdcZUNSCIgyJMOF0Us78aVdha5Oy4EzClgf7DpPYnyPC9FxIb54pxo
         /rt07yzlpbHTw==
From:   Will Deacon <will@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, shuah@kernel.org,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: fix a memleak in zt_regs_run()
Date:   Wed, 16 Aug 2023 19:25:24 +0100
Message-Id: <169219182714.1944257.1703987051897216466.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230815074915.245528-1-dingxiang@cmss.chinamobile.com>
References: <20230815074915.245528-1-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Aug 2023 15:49:15 +0800, Ding Xiang wrote:
> If memcmp() does not return 0, "zeros" need to be freed to prevent memleak
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: fix a memleak in zt_regs_run()
      https://git.kernel.org/arm64/c/46862da15e37

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
