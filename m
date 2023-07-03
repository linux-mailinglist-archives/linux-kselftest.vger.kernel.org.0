Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C450474637B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGCTo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCTo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 15:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3103E69;
        Mon,  3 Jul 2023 12:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88BD660F15;
        Mon,  3 Jul 2023 19:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817B0C433C8;
        Mon,  3 Jul 2023 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688413496;
        bh=AO+kyGEBydPcDlN9QE362yJ1rPtNie+nlzDaI8BIFd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3kMFMEpG5eyIzXKsj1HDCMSI1JnNF04PMLlb3qahM0cvzedtvD8oqNEwLLA/mgJV
         AyFhibcXksoHa85abTXw8trxRGYTvvt1XuGMpZL2pJ8nUdawvFnCPVfW3qSiaYI6HT
         rYUVFDZDSifQIIdA0E14Sbf9C7FEoOAPgG55Ul14=
Date:   Mon, 3 Jul 2023 21:44:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
Message-ID: <2023070322-retype-lanky-6f2d@gregkh>
References: <20230610175618.82271-1-sj@kernel.org>
 <20230703192704.16500-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703192704.16500-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 03, 2023 at 07:27:04PM +0000, SeongJae Park wrote:
> Hi Greg and Sasha,
> 
> On Sat, 10 Jun 2023 17:56:18 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Sat, 10 Jun 2023 12:15:55 +0800 David Gow <davidgow@google.com> wrote:
> > 
> > > [-- Attachment #1: Type: text/plain, Size: 2275 bytes --]
> > > 
> > > On Sat, 10 Jun 2023 at 03:09, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Hi David and Brendan,
> > > >
> > > > On Tue, 2 May 2023 08:04:20 +0800 David Gow <davidgow@google.com> wrote:
> > > >
> > > > > [-- Attachment #1: Type: text/plain, Size: 1473 bytes --]
> > > > >
> > > > > On Tue, 2 May 2023 at 02:16, 'Daniel Latypov' via KUnit Development
> > > > > <kunit-dev@googlegroups.com> wrote:
> > > > > >
> > > > > > Writing `subprocess.Popen[str]` requires python 3.9+.
> > > > > > kunit.py has an assertion that the python version is 3.7+, so we should
> > > > > > try to stay backwards compatible.
> > > > > >
> > > > > > This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
> > > > > > pre-existing `mypy --strict` errors and update run_checks.py"), since
> > > > > > mypy complains like so
> > > > > > > kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]
> > > > > >
> > > > > > Note: `mypy --strict --python-version 3.7` does not work.
> > > > > >
> > > > > > We could annotate each file with comments like
> > > > > >   `# mypy: disable-error-code="type-arg"
> > > > > > but then we might still get nudged to break back-compat in other files.
> > > > > >
> > > > > > This patch adds a `mypy.ini` file since it seems like the only way to
> > > > > > disable specific error codes for all our files.
> > > > > >
> > > > > > Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
> > > > > > but I think being explicit is better, particularly since most kernel
> > > > > > devs won't be familiar with how mypy works.
> > > > > >
> > > > > > Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
> > > > > > Reported-by: SeongJae Park <sj@kernel.org>
> > > > > > Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
> > > > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > > > ---
> > > > >
> > > > > Thanks for jumping on this.
> > > > >
> > > > > Looks good to me!
> > > > >
> > > > > Reviewed-by: David Gow <davidgow@google.com>
> > > >
> > > > Looks like this patch is still not merged in the mainline.  May I ask the ETA,
> > > > or any concern if you have?
> > > >
> > > >
> > > 
> > > We've got this queued for 6.5 in the kselftest/kunit tree[1], so it
> > > should land during the merge window. But I'll look into getting it
> > > applied as a fix for 6.4, beforehand.
> > 
> > Thank you for the kind answer, Gow!  I was thinking this would be treated as a
> > fix, and hence merged into the mainline before next merge window.  I'm actually
> > getting my personal test suite failures due to absence of this fix.  It's not a
> > critical problem, but it would definitely better for me if this could be merged
> > into the mainline as early as possible.
> 
> This patch is now in the mainline (e30f65c4b3d671115bf2a9d9ef142285387f2aff).
> However, this fix is not in 6.4.y yet, so the original issue is reproducible on
> 6.4.y.  Could you please add this to 6.4.y?  I confirmed the mainline commit
> can cleanly applied on latest 6.1.y tree, and it fixes the issue.

As this was not specifically tagged with a "cc: stable..." marking, that
is why it was not picked up automatically.  Also, we do not normally add
patches to any stable releases until it is in a released kernel from
Linus (i.e. a -rc release), unless you have a specific reason for it to
be merged earlier.

Should this be merged "now" into the stable trees and not wait for
6.5-rc1?

thanks,

greg k-h
