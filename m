Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B65E6471
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIVN6Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiIVN6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 09:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A9EF08A
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 06:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84FD7B83708
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 13:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F57C433D6;
        Thu, 22 Sep 2022 13:58:00 +0000 (UTC)
Date:   Thu, 22 Sep 2022 14:57:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Message-ID: <Yyxp5BnxTp/N6hAa@arm.com>
References: <20220829154921.837871-1-broonie@kernel.org>
 <20220829154921.837871-4-broonie@kernel.org>
 <YyRlm/koy30sze9Z@arm.com>
 <Yyhj2kEtJcSSngd2@sirena.org.uk>
 <f87f6a6f-d137-9a81-fa44-5a6bda2991fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87f6a6f-d137-9a81-fa44-5a6bda2991fd@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 12:15:13PM +0100, Luis Machado wrote:
> On 9/19/22 13:43, Mark Brown wrote:
> > On Fri, Sep 16, 2022 at 01:01:31PM +0100, Catalin Marinas wrote:
> > > On Mon, Aug 29, 2022 at 04:49:20PM +0100, Mark Brown wrote:
> > > > @@ -1392,7 +1407,7 @@ static const struct user_regset aarch64_regsets[] = {
> > > >   	},
> > > >   	[REGSET_TLS] = {
> > > >   		.core_note_type = NT_ARM_TLS,
> > > > -		.n = 1,
> > > > +		.n = 2,
> > > >   		.size = sizeof(void *),
> > > >   		.align = sizeof(void *),
> > > >   		.regset_get = tls_get,
> > 
> > > Does this change confuse user-space? I presume an updated gdb would
> > > check the iov.len to figure out whether a new register is available but
> > > would existing debuggers complain of the new size of this regset?
> > 
> > gdb seems happy as far as I can see, it is possible something would be
> > reusing the read_iov for repeated TLS read calls in a context where it
> > was only pointing at a single u64 but I'm not sure how realistic that
> > is given the idiom.  I did do a search on sources.debian.net and didn't
> > turn up anything that'd have problems.
> > 
> > If using this as an extensiblility mechanism is a concern we need to
> > bear that in mind elsewhere, and for this it's either a case of
> > providing another single register regset or trying to do a generic
> > sysreg read/get (though that'd be another regset that's not idiomatic
> > for the regset API).
> 
> Older GDB's assume a single register for NT_ARM_TLS, so they will always
> fetch TPIDR. Newer GDB's will check the size and act accordingly.

That's fine. Looking at the ptrace_regset() implementation in Linux, it
updates the user iov_len to what was actually copied. In this case it
would be 1 (the minimum of the user iov_len and the regset n * size). So
from the old gdb ABI perspective, it shouldn't notice a difference. An
old gdb setting the TLS reg will also leave tpidr2_el0 unchanged.

An updated gdb running on an older kernel should be aware that even if
it asked for two u64, it may only get one back and the user iov_len
updated accordingly.

-- 
Catalin
