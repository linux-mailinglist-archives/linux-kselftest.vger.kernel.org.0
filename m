Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D6512199
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiD0SwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiD0SwN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC0C3C37A5
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 11:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BD461EC6
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9DAC385A9;
        Wed, 27 Apr 2022 18:38:09 +0000 (UTC)
Date:   Wed, 27 Apr 2022 19:38:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] selftests/arm64: Fix O= builds for the FP
 selftests
Message-ID: <YmmNjs7gtUBWUxPN@arm.com>
References: <20220419200442.1374548-1-broonie@kernel.org>
 <Yml+s1MzY7HC81U4@arm.com>
 <YmmCZrCWqBz+jhn4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmmCZrCWqBz+jhn4@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 27, 2022 at 06:50:30PM +0100, Mark Brown wrote:
> On Wed, Apr 27, 2022 at 06:34:43PM +0100, Catalin Marinas wrote:
> > Would you mind rebasing them on top of the arm64 for-next/kselftest
> > branch? I get some conflicts with the SME patches that went in there (or
> > I can sort the conflicts out sometime tomorrow/Friday).
> 
> Sure.  BTW note that the kselftest branch doesn't build since it doesn't
> include the SME branch so the test programs for the SME ABI haven't got
> a bunch of defintions that they're relying on.

Ah, I haven't tried it independently. I'll probably merge the sme branch
into it.

-- 
Catalin
