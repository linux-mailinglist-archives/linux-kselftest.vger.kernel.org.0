Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371EB57CED9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiGUPZ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 11:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGUPZ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 11:25:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8047B95
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 08:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00C61B82588
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 15:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D510BC3411E;
        Thu, 21 Jul 2022 15:25:21 +0000 (UTC)
Date:   Thu, 21 Jul 2022 16:25:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/3] arm64/sve: Document our actual SVE syscall ABI
Message-ID: <Ytlv3e4WPrNvBYWN@arm.com>
References: <20220720205013.890942-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720205013.890942-1-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 20, 2022 at 09:50:10PM +0100, Mark Brown wrote:
> Currently our SVE syscall ABI documentation does not reflect the actual
> implemented ABI, it says that register state not shared with FPSIMD
> becomes undefined on syscall when in reality we always clear it. Since
> changing this would cause a change in the observed kernel behaviour
> there is a substantial desire to avoid taking advantage of the
> documented ABI so instead let's document what we actually do so it's
> clear that it is in reality an ABI.
> 
> There has been some pushback on tightening the documentation in the past
> but it is hard to see who that helps, it makes the implementation
> decisions less clear and makes it harder for people to discover and make
> use of the actual ABI. The main practical concern is that qemu's user
> mode does not currently flush the registers.
> 
> Mark Brown (3):
>   kselftest/arm64: Correct buffer allocation for SVE Z registers
>   arm64/sve: Document our actual ABI for clearing registers on syscall
>   kselftest/arm64: Enforce actual ABI for SVE syscalls

For the series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
