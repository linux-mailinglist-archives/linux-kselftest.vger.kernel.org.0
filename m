Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B07707A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHDSLb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjHDSLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 14:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD04ED3
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 11:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C529C620EE
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 18:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C9C433CA;
        Fri,  4 Aug 2023 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691172632;
        bh=e3y4P9acdotrQAk32zsEP1Fc+mK3cnWnND8FkQK2kAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdVrZzVILKNTalHMxvwcyxiPJ1y8pjeE7hoaCN3ihsPj6/lCtYx3Up7UaaQnEp0Ty
         m8bDYimsOTwgrCSGQVdurD4N2e7IwmXPhIsYEZB2dKum5+KrisD0kQDm8Csj37GWYC
         PsY6l8L6MJmVagKKovCeLv04go9iRtRUtMWmYl9AERdm3YDj3mzYJPPrqG1GpJhB5l
         2UxA1dBdIHs5bs4Yq/myhSNObwOD3alv/eljaLBj2HbjgyTAut4NLfb5vrNSCPnR3D
         q+ZeVuufG+WP/+z/Ma84ttf3724H/VA4q/tdEBJ6FLL8sKXAEafG++GdoCZ2gWoY5Q
         +DXCKAHoGG0ow==
From:   Will Deacon <will@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>, kristina.martsenko@arm.com,
        shuah@kernel.org, broonie@kernel.org, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com
Subject: Re: [PATCH v2] kselftest/arm64: add RCpc load-acquire to hwcap test
Date:   Fri,  4 Aug 2023 19:10:16 +0100
Message-Id: <169116681834.147300.15609916365529780173.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230803133905.971697-1-zengheng4@huawei.com>
References: <20230803133905.971697-1-zengheng4@huawei.com>
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

On Thu, 3 Aug 2023 21:39:05 +0800, Zeng Heng wrote:
> Add the RCpc and various features check in the set of hwcap tests.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: add RCpc load-acquire to hwcap test
      https://git.kernel.org/arm64/c/d1890517ac75

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
