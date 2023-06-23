Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98BA73BDC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjFWR2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 13:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFWR2S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 13:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC01997;
        Fri, 23 Jun 2023 10:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B923A61AD8;
        Fri, 23 Jun 2023 17:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF171C433C0;
        Fri, 23 Jun 2023 17:28:14 +0000 (UTC)
Date:   Fri, 23 Jun 2023 18:28:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/signal: Restore TPIDR2 register rather than
 memory state
Message-ID: <ZJXWLAsAVuHNOqpS@arm.com>
References: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
 <20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org>
 <ZJR6DvGofAvxSVYW@arm.com>
 <ZJSAuOrkgJyULV+v@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJSAuOrkgJyULV+v@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 22, 2023 at 06:11:20PM +0100, Mark Brown wrote:
> On Thu, Jun 22, 2023 at 05:42:54PM +0100, Catalin Marinas wrote:
> > On Thu, Jun 22, 2023 at 02:39:45PM +0100, Mark Brown wrote:
> 
> > > -		current->thread.tpidr2_el0 = tpidr2_el0;
> > > +		write_sysreg_s(tpidr2_el0, SYS_TPIDR2_EL0);
> 
> > I guess the other way around may also be true - the libc sets tpidr2_el0
> > to something else and doesn't want the kernel to restore its original
> > value from sigcontext.
> 
> > For tpidr_el0 we don't bother with sigcontext, not sure what the use for
> > tpidr2_el0 in signals is. If we assume the context saved is only
> > informative (like esr), we can simply ignore restoring it from the
> > signal stack.
> 
> TPIDR2 is intended to go along with the thread stack, it's intended to
> be used to allow lazy save of the (rather large) ZA register state when
> a called function needs it rather than forcing it to be caller saved.
> TPIDR2 is used to point to memory allocated for managing this process,
> something that provides a new value should be making a deliberate
> decision to do so and editing the stack frame.

OK, so if the signal handler invokes a function that touches the ZA
state, it may use TPIDR2 for lazy saving in any callee. In this case we
need to restore the original TPIDR2 of the interrupted context on
sigreturn.

So I convinced myself this is the only option that makes sense ;). I'll
queue the patches.

-- 
Catalin
