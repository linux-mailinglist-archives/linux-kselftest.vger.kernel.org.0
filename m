Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B794C49A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiBYPxZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242388AbiBYPxY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57551680B0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 07:52:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79B9EB83273
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 15:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8B7C340F0;
        Fri, 25 Feb 2022 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804369;
        bh=M5bu53xphKA8fCFggR4QUQSIC9kxcdVVWdDnb2wz5CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nwsgvfze3p8nNHBixhpEl67KGpEl+AZmhjNVjBWYy8Bqw7M2piDgoB8gxXhTLaAi0
         8I8YGVjs7x08fvdfn3CY1poVXuNrQNY0NDhOa5S/NrTgfN+fS+977RdQuZu16us4TI
         F7arSIigh6QshH96SSkF5SwPa8i+cGQroDebOB2aC6YTbpR8jeNt42QNYz0mGSG63u
         a8HAKOgRgM9WP5fQt/WIjgIqmleUIYxSH7Xvh+qGYurpdSKMvvaFAdVXK5AYwROmp/
         R31nea1c+oWI7zOBTOdHAzGBB5lZF7071jsuqvjhMuzP3kzazBNaM/UNDq7Sb0lxQj
         2c9ne5YNG+YqA==
Date:   Fri, 25 Feb 2022 15:52:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <james.morse@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v11 00/40] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <20220225155241.GA20310@willie-the-truck>
References: <20220207152109.197566-1-broonie@kernel.org>
 <164579991080.3691228.14311210559888008730.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164579991080.3691228.14311210559888008730.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 03:50:12PM +0000, Will Deacon wrote:
> On Mon, 7 Feb 2022 15:20:29 +0000, Mark Brown wrote:
> > This series provides initial support for the ARMv9 Scalable Matrix
> > Extension (SME).  SME takes the approach used for vectors in SVE and
> > extends this to provide architectural support for matrix operations.  A
> > more detailed overview can be found in [1].
> > 
> > For the kernel SME can be thought of as a series of features which are
> > intended to be used together by applications but operate mostly
> > orthogonally:
> > 
> > [...]
> 
> Applied patch 5 to arm64 (for-next/kselftest), thanks!
> 
> [05/40] kselftest/arm64: signal: Allow tests to be incompatible with features
>         https://git.kernel.org/arm64/c/32de73e89099

I also applied 1-3 to for-next/fpsimd, but the 'thanks' file got overwritten
before I sent it!

Will
