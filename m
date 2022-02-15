Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C3E4B7259
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiBOPzy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 10:55:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240945AbiBOPzn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 10:55:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C403F9F3B2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 07:55:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81AEEB81AE6
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 15:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4217C340EB;
        Tue, 15 Feb 2022 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644940531;
        bh=rEdVOFjT0HGlA49OJzxvyOmRa3ihSj4oeYEMdHqLxc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg6cloOC/+1rNioOAJcELqOC8XKIn5npABZa1zYSYyoOgg2wTaokmGEXkddRSpH0D
         YwEBvJzVUB/eq1+t9aq+JLmmbHcH/RXV/vk3L7elbn499vmsz6JBPYjXLZlr7SibBs
         5NJ4K/xy0ZJrQoVIK5oHBJBFtYKfnP9J2TC3RmwpuOpbyLQLg6Sk5D0Ay1MaG05YgW
         yXc6MllPoPnualGKXMhWJh3EfsMt3ogp98180yGRYCQ1RnpidxWVXv+LMecJzq0Wt8
         gTeaTzqc1A10VInzBjW2nFX8tZRnMcxN5K5HKr500ybqTAjCPy7I3eKqc0JMP47XFp
         7f7VX9hVzTOWw==
Date:   Tue, 15 Feb 2022 15:55:26 +0000
From:   Will Deacon <will@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] arm64: insn: Add tests for
 aarch64_insn_gen_logical_immediate()
Message-ID: <20220215155525.GA8117@willie-the-truck>
References: <20220127162127.2391947-1-james.morse@arm.com>
 <20220127162127.2391947-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127162127.2391947-3-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 04:21:26PM +0000, James Morse wrote:
> Aarch64 has instructions to generate reasonably complicated 32 or 64
> bit masks from only 13 bits of information.
> aarch64_insn_gen_logical_immediate() has to created the immediate
> encoding by spotting the patterns in the 32 or 64 bit immediate.
> 
> Despite attempts to validate or model this code, or use it as-is outside
> the kernel tree, bugs still exist.
> 
> Add a self test module that tests this code in place against a golden
> set of values.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/Kconfig.debug                   |  3 +
>  arch/arm64/Makefile                        |  2 +
>  arch/arm64/lib/Makefile                    |  2 +
>  arch/arm64/lib/insn.c                      |  3 +
>  arch/arm64/lib/test_insn.c                 | 90 ++++++++++++++++++++++

Can we put the new tests under tools/testing/selftests/arm64 as well,
please? It looks like there's precedence for having modules in there (e.g.
bpf_testmod.c).

In the meantime, I'll pick up patch 3.

Cheers,

Will
