Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8513651204F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiD0Rkc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244214AbiD0Rka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 13:40:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E404207
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 10:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E812AB828AD
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 17:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F1C385B0;
        Wed, 27 Apr 2022 17:37:15 +0000 (UTC)
Date:   Wed, 27 Apr 2022 18:37:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] selftests/arm64: Fix O= builds for the FP
 selftests
Message-ID: <Yml/R4y6QsfWNUIh@arm.com>
References: <20220419200442.1374548-1-broonie@kernel.org>
 <Yml+s1MzY7HC81U4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yml+s1MzY7HC81U4@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 27, 2022 at 06:34:48PM +0100, Catalin Marinas wrote:
> Hi Mark,
> 
> On Tue, Apr 19, 2022 at 09:04:38PM +0100, Mark Brown wrote:
> > Currently the arm64 selftests don't support building with O=, this
> > series fixes that, bringing them more into line with how the kselftest
> > Makefiles want to work.
> > 
> > v2:
> >  - Rebase onto v5.18-rc3.
> 
> Would you mind rebasing them on top of the arm64 for-next/kselftest
> branch? I get some conflicts with the SME patches that went in there (or
> I can sort the conflicts out sometime tomorrow/Friday).

Unless you aimed these at 5.18 but I don't think they are urgent.

-- 
Catalin
