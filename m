Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8964059D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiLBLRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 06:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiLBLRx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 06:17:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9564D5DD
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 03:17:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C598462263
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 11:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E09C433D6;
        Fri,  2 Dec 2022 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669979871;
        bh=EAxenrt1jPGUffOVpU4TWE0I1SviMXPvhCzcjWgbYdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6dJuqGBRc/fUpyr0ESXlGxXbbQ3ofguA+ICIYi9qwp/s6Vch/qcopz2f3j6klNgH
         qktIUsT5e7pLjX0QqFG+pZz0lmNHfjTawAiet/cCxpu0OKpe+LAeN1BfdFy8Iy7r7V
         PAjx4PNiVYPFytYDCOuhUXyyq39g37NLMjDNWh0t5w6cCll3Xr5YwwO5k8odjIHHL9
         seZ3AEaP+4POWr7HBQsisul0nNcXvST3irfUe0pBx7cJF/vw76M2wsusNv5qfhyhB/
         ixubfewmV2jC7weFKbXFdWCIj9ELYyz2t1/vLPN6hIeT8j8PbB7Sz+imFiZ8dEAS7c
         2Xk989wiuq/8A==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] kselftest/arm64: fp-stress performance improvements
Date:   Fri,  2 Dec 2022 11:17:41 +0000
Message-Id: <166991680583.2620264.6355829920350480651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221129215926.442895-1-broonie@kernel.org>
References: <20221129215926.442895-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Nov 2022 21:59:22 +0000, Mark Brown wrote:
> This series contains a few improvements to fp-stress performance, only
> noticable on emulated platforms which both run more slowly and are
> stressed far more by fp-stress due to supporting more VLs for SVE and
> SME.  The bulk of the improvement comes from the first patch which
> reduces the amount of time the main fp-stress executable is swamped by
> load from the child processes during startup, the other two patches are
> much more marginal.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/3] kselftest/arm64: Hold fp-stress children until they're all spawned
      https://git.kernel.org/arm64/c/98102a2cb786
[2/3] kselftest/arm64: Don't drain output while spawning children
      https://git.kernel.org/arm64/c/92145d88ce0b
[3/3] kselftest/arm64: Allow epoll_wait() to return more than one result
      https://git.kernel.org/arm64/c/c4e8720f2eb0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
