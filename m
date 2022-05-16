Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE60528D58
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbiEPSpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiEPSpR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253783EA98;
        Mon, 16 May 2022 11:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B456261482;
        Mon, 16 May 2022 18:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AC9C385AA;
        Mon, 16 May 2022 18:45:14 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: bti: force static linking
Date:   Mon, 16 May 2022 19:45:11 +0100
Message-Id: <165272667337.3711461.11956194541511506230.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511172129.2078337-1-andre.przywara@arm.com>
References: <20220511172129.2078337-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 11 May 2022 18:21:29 +0100, Andre Przywara wrote:
> The "bti" selftests are built with -nostdlib, which apparently
> automatically creates a statically linked binary, which is what we want
> and need for BTI (to avoid interactions with the dynamic linker).
> 
> However this is not true when building a PIE binary, which some
> toolchains (Ubuntu) configure as the default.
> When compiling btitest with such a toolchain, it will create a
> dynamically linked binary, which will probably fail some tests, as the
> dynamic linker might not support BTI:
> ===================
> TAP version 13
> 1..18
> not ok 1 nohint_func/call_using_br_x0
> not ok 2 nohint_func/call_using_br_x16
> not ok 3 nohint_func/call_using_blr
> ....
> ===================
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: bti: force static linking
      https://git.kernel.org/arm64/c/d7a49291d786

-- 
Catalin

