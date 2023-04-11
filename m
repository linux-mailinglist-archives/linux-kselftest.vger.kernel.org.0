Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32336DDEC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjDKPDd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDKPD2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 11:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945ADE6E;
        Tue, 11 Apr 2023 08:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A7261F65;
        Tue, 11 Apr 2023 15:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0040C433EF;
        Tue, 11 Apr 2023 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681225406;
        bh=9O8piP4byfbI2oKaqDdxrpLi1xAscXVAg7UF/bvC1oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djLKARAKOGjPCQQoGhKXq1rXpba5LAAtAXRM903h4oSJrNFMKicjNikZXcPfgpE1u
         o+f9hhDfJNCwudxBugw1iXyD7i75XKK9+bUKGAffCVjorJ7uYlR7w8ExFNPF1Hg+yb
         zjmENUZ+/+DQZLTnGmWCEPVMh4vOcSA4OeHbBm3sM2svyaDdrKzQgtANBVC44kiIlT
         vPFKIf91gK0psHrFvwQVZyDMtLSIa09iyFyK/zpO0vkTsTVBGlXBfvqC2MlwlFYfLs
         +aNqIlL3bwpxxKj8+BFiDeoTdqdGLIRCoXl83p5p2jXYGW6ciL99nAVajn6tPe/TKi
         3FD6B6YgNRc+Q==
Date:   Tue, 11 Apr 2023 16:03:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <20230411150320.GA23045@willie-the-truck>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
 <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
 <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 03:31:10PM +0100, Mark Brown wrote:
> On Mon, Apr 10, 2023 at 12:30:04PM -0600, Shuah Khan wrote:
> > On 4/6/23 12:43, Paul E. McKenney wrote:
> 
> > > Alternatively, if it would be more convenient for Mark to send this
> > > up via kselftest:
> 
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> > > It currently merges cleanly with the -rcu tree's dev branch, so this
> > > should not be a problem.
> 
> > > Either way, please let me know, Mark!
> 
> > I can take these through kselftest or can go through arm64
> 
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> It seems like more of a kselftest change than anything else so probably
> makes sense for it to go that way?  The example user isn't really even
> needed.

Fine by me, as long as it doesn't conflict with any other arm64 selftest
changes you hope to land for 6.4.

Will
