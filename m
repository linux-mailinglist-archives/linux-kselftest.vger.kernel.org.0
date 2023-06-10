Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B672ADF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFJR4Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFJR4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 13:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE235A9;
        Sat, 10 Jun 2023 10:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4339160C99;
        Sat, 10 Jun 2023 17:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53FCC433EF;
        Sat, 10 Jun 2023 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686419781;
        bh=NvPgEXsmIasY6Cjtsye1b9f6W2Pqjj+ESFnG02dWLhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cttIOawKuYHVFDYDSNRgZobLOwHWT1cVx+rToonQQgjwie132EucELH7pNdhH+SSi
         w7jfT8y9juYfm1SBt26b25YW2n6tkpOdohIFxQFaSZwZATVgXekCGGLkCmyiOuMDOX
         jirw5s8dFFL5VYOSL30t3dL7izy3mdc4n18VC9vsiHHsAgLwftx++GZzNo1N33qBRA
         sZzj2CioIsmLcwsanr2FuKaY75SjBdduae3VYu6cfpRULb/QkhTXzs+wgjRFIiWG8B
         Yv8tRpqOm6ZUBZOVpeyFwf6H1+VtbgSiOauOEW2Wh+z1BreXOTdyicCaMVTcRkdrOh
         ybYCT72dxJBVQ==
From:   SeongJae Park <sj@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
Date:   Sat, 10 Jun 2023 17:56:18 +0000
Message-Id: <20230610175618.82271-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABVgOS=wR0J9X1VaU4eOOb_VZRLV0nmj860B1pyq97EvCnbe2Q@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 10 Jun 2023 12:15:55 +0800 David Gow <davidgow@google.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 2275 bytes --]
> 
> On Sat, 10 Jun 2023 at 03:09, SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi David and Brendan,
> >
> > On Tue, 2 May 2023 08:04:20 +0800 David Gow <davidgow@google.com> wrote:
> >
> > > [-- Attachment #1: Type: text/plain, Size: 1473 bytes --]
> > >
> > > On Tue, 2 May 2023 at 02:16, 'Daniel Latypov' via KUnit Development
> > > <kunit-dev@googlegroups.com> wrote:
> > > >
> > > > Writing `subprocess.Popen[str]` requires python 3.9+.
> > > > kunit.py has an assertion that the python version is 3.7+, so we should
> > > > try to stay backwards compatible.
> > > >
> > > > This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
> > > > pre-existing `mypy --strict` errors and update run_checks.py"), since
> > > > mypy complains like so
> > > > > kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]
> > > >
> > > > Note: `mypy --strict --python-version 3.7` does not work.
> > > >
> > > > We could annotate each file with comments like
> > > >   `# mypy: disable-error-code="type-arg"
> > > > but then we might still get nudged to break back-compat in other files.
> > > >
> > > > This patch adds a `mypy.ini` file since it seems like the only way to
> > > > disable specific error codes for all our files.
> > > >
> > > > Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
> > > > but I think being explicit is better, particularly since most kernel
> > > > devs won't be familiar with how mypy works.
> > > >
> > > > Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
> > > > Reported-by: SeongJae Park <sj@kernel.org>
> > > > Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > ---
> > >
> > > Thanks for jumping on this.
> > >
> > > Looks good to me!
> > >
> > > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Looks like this patch is still not merged in the mainline.  May I ask the ETA,
> > or any concern if you have?
> >
> >
> 
> We've got this queued for 6.5 in the kselftest/kunit tree[1], so it
> should land during the merge window. But I'll look into getting it
> applied as a fix for 6.4, beforehand.

Thank you for the kind answer, Gow!  I was thinking this would be treated as a
fix, and hence merged into the mainline before next merge window.  I'm actually
getting my personal test suite failures due to absence of this fix.  It's not a
critical problem, but it would definitely better for me if this could be merged
into the mainline as early as possible.


Thanks,
SJ

> 
> -- David
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=e30f65c4b3d671115bf2a9d9ef142285387f2aff
