Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FED5AF2F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiIFRpI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFRpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 13:45:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453382DA8B
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 10:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BA5FB819CA
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 17:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47E2C433C1;
        Tue,  6 Sep 2022 17:44:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/10] kselftest/arm64: EXTRA_CONTEXT related fixes
Date:   Tue,  6 Sep 2022 18:44:57 +0100
Message-Id: <166248629287.3558870.8039810850318548542.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
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

On Mon, 29 Aug 2022 17:06:53 +0100, Mark Brown wrote:
> The arm64 architecture originally made the signal context a fixed size
> structure containing a linked list of records with the various kinds of
> register and other state which may be present. When SVE was implemented
> it was realised that it supported implementations with more state than
> could fit in that structure so a new record type EXTRA_CONTEXT was
> introduced allowing the signal context to be extended beyond the
> original size. Unfortunately the signal handling tests can not cope with
> these EXTRA_CONTEXT records at all - some support was implemented but it
> simply never worked.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[01/10] kselftest/arm64: Enumerate SME rather than SVE vector lengths for za_regs
        https://git.kernel.org/arm64/c/b3321fbd7fa2
[02/10] kselftest/arm64: Validate signal ucontext in place
        https://git.kernel.org/arm64/c/b97ff4f3ad95
[03/10] kselftest/arm64: Fix validatation termination record after EXTRA_CONTEXT
        https://git.kernel.org/arm64/c/909e2105c748
[04/10] kselftest/arm64: Fix validation of EXTRA_CONTEXT signal context location
        https://git.kernel.org/arm64/c/a934077a3f94
[05/10] kselftest/arm64: Remove unneeded protype for validate_extra_context()
        https://git.kernel.org/arm64/c/e374ab27e738
[06/10] kselftest/arm64: Only validate each signal context once
        https://git.kernel.org/arm64/c/b9731674ec9c
[07/10] kselftest/arm64: Validate contents of EXTRA_CONTEXT blocks
        https://git.kernel.org/arm64/c/3df95c1efeaf
[08/10] kselftest/arm64: Preserve any EXTRA_CONTEXT in handle_signal_copyctx()
        https://git.kernel.org/arm64/c/91f48fb9f82b
[09/10] kselftest/arm64: Allow larger buffers in get_signal_context()
        https://git.kernel.org/arm64/c/5f6539724421
[10/10] kselftest/arm64: Include larger SVE and SME VLs in signal tests
        https://git.kernel.org/arm64/c/7384bddbe246

-- 
Catalin

