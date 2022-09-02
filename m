Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3177A5AB8ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIBTmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIBTmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 15:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C3FCA1A
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 12:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4BE60F63
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 19:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06979C433D6;
        Fri,  2 Sep 2022 19:41:59 +0000 (UTC)
Date:   Fri, 2 Sep 2022 20:41:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64/sve: Document our actual SVE syscall ABI
Message-ID: <YxJchN0nLFzsH9gO@arm.com>
References: <20220829162502.886816-1-broonie@kernel.org>
 <YxJJ3HVNbJO4Z+kT@arm.com>
 <YxJSC02ORt/4GFkH@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxJSC02ORt/4GFkH@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 02, 2022 at 07:57:15PM +0100, Mark Brown wrote:
> On Fri, Sep 02, 2022 at 07:22:20PM +0100, Catalin Marinas wrote:
> > On Mon, Aug 29, 2022 at 05:24:59PM +0100, Mark Brown wrote:
> > > v3:
> > >  - Rebase onto v6.0-rc3.
> > > v2:
> > >  - Rebase onto v6.0-rc1.
> 
> > Please don't rebase beyond -rc1 unless it no longer applies cleanly. I
> > came back from holiday and I have two or three versions of all of your
> > patches in my inbox. It just adds to the clutter.
> 
> OK, sure.  It might help to advertise what you're looking for here - the
> whole thing with wanting everything based off -rc3 has never been clear
> to me, IIRC I figured it out from some off hand comment rather than
> actually knowing what you and Will want.  It's neither base off latest
> nor base off -rc1 which seem to be the more common policies.

Usually basing off -rc1 is sufficient unless the patches conflict with
something newer and we occasionally push for-next/core to even higher
-rcX. Of course, fixes for something in a late -rc should be based off
that version.

Both Will and I start queuing patches around -rc3 with the two weeks
before pretty much reviewing or waiting to see if there are any more
comments. I don't mind you basing your patches off -rc3 though in
general it's better for series aimed at the upcoming merging window to
be posted shortly after -rc1 to give them some more time on the list.
However, once posted, if there are no changes please don't repost them
for subsequent -rcX, it won't make any difference as we can just apply
the original series to whatever we base for-next/core off.

Thanks.

-- 
Catalin
