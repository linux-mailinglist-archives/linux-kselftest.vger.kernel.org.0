Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3726B63C86E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 20:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiK2Tbw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 14:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiK2Tbb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 14:31:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3502AFD
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 11:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 10C44CE12E9
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 19:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6134C433C1;
        Tue, 29 Nov 2022 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669750274;
        bh=D5QTknxafjNXHi0UY7hBX49+WnfHieaoJs/a4jeU0IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUKl1t3Blf66Hx6A18sB2C0E78GkQsApVFMGaJaKBNo1mybwUtbsR+4NNMNoifxhS
         50Dq46A+BLj21OqT5MyG7rWepAFS6INClTFZRxQugxZt9o+Jux8YsePQc41Gu8gq2q
         ZgtYHzu9UTElAzX6Rmw6WznDJDDFz8ZET7eetWmOU2QWli8+8Ln6+k2COKs04v6mXE
         OA7g9hqRs3dohc+rP+RUG0REZa6cpBFoqe5VbL75qHH+zvIGs/6s1afMdw+bhcu4jZ
         T+GdVrwtncKnOUzrU28RgmdiwkO++cOtCeAP91fK8Fm2eQe/bS5H9IHGxfg0CWaIAG
         KRsUz2zFJRkVQ==
Date:   Tue, 29 Nov 2022 19:31:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/3] kselftest/arm64: fp-stress performance
 improvements
Message-ID: <20221129193108.GA26941@willie-the-truck>
References: <20221129000355.812425-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129000355.812425-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 29, 2022 at 12:03:52AM +0000, Mark Brown wrote:
> This series contains a few improvements to fp-stress performance, only
> noticable on emulated platforms which both run more slowly and are
> stressed far more by fp-stress due to supporting more VLs for SVE and
> SME.  The bulk of the improvement comes from the first patch which
> reduces the amount of time the main fp-stress executable is swamped by
> load from the child processes during startup, the other two patches are
> much more marginal.
> 
> Mark Brown (3):
>   kselftest/arm64: Hold fp-stress children until they're all spawned
>   kselftest/arm64: Don't drain output while spawning children
>   kselftest/arm64: Allow epoll_wait() to return more than one result
> 
>  tools/testing/selftests/arm64/fp/fp-stress.c | 74 +++++++++++++++-----
>  1 file changed, 57 insertions(+), 17 deletions(-)

These don't apply on top of for-next/selftests

Will
