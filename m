Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD872A2DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFITJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFITJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 15:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B6210A;
        Fri,  9 Jun 2023 12:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139BB65B31;
        Fri,  9 Jun 2023 19:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B053AC433D2;
        Fri,  9 Jun 2023 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686337778;
        bh=6dzCM0l3yez6xLMwZhhp3ZeNdCkNfftfdY4FRAKrm/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=proX85yrQ4KXKICb6x2F9PlW27QVZSo9A7mG6/JFIM9ErnSvBws3NjbLxasa7fsEa
         1u10sj69wI/XP2nOsZWYjjaf+fe/G9twt+fnnzA9qmaJhZRlAISTFeG0PMlMedhlPI
         q2QljvcQgABuYZhv1n1qfYfWeZpWcedL7wwrMjAJ2zgLSSMjN//2P5iWSKZpRe0IY3
         h4NwiUrTCQknKqp9S9bbC9lu/mb54+GoF/RD/i7od6hMpFZ/teNbX9fT19dHNqlMCj
         pMGoM23FnT6lz/e0X5IUeETjz6icBp1b3pQPL2mYRw/jAjKq47aQ/XSOluGnJ3IhRU
         R4eg7no5Itn3Q==
From:   SeongJae Park <sj@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, johannes@sipsolutions.net,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
Date:   Fri,  9 Jun 2023 19:09:36 +0000
Message-Id: <20230609190936.30045-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABVgOSmUxDoWHWOaJYmayCE8FnfS5bUoAJoosO44x=gwKdtLng@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David and Brendan,

On Tue, 2 May 2023 08:04:20 +0800 David Gow <davidgow@google.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 1473 bytes --]
> 
> On Tue, 2 May 2023 at 02:16, 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Writing `subprocess.Popen[str]` requires python 3.9+.
> > kunit.py has an assertion that the python version is 3.7+, so we should
> > try to stay backwards compatible.
> >
> > This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
> > pre-existing `mypy --strict` errors and update run_checks.py"), since
> > mypy complains like so
> > > kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]
> >
> > Note: `mypy --strict --python-version 3.7` does not work.
> >
> > We could annotate each file with comments like
> >   `# mypy: disable-error-code="type-arg"
> > but then we might still get nudged to break back-compat in other files.
> >
> > This patch adds a `mypy.ini` file since it seems like the only way to
> > disable specific error codes for all our files.
> >
> > Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
> > but I think being explicit is better, particularly since most kernel
> > devs won't be familiar with how mypy works.
> >
> > Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
> > Reported-by: SeongJae Park <sj@kernel.org>
> > Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> 
> Thanks for jumping on this.
> 
> Looks good to me!
> 
> Reviewed-by: David Gow <davidgow@google.com>

Looks like this patch is still not merged in the mainline.  May I ask the ETA,
or any concern if you have?


Thanks,
SJ

> 
> Cheers,
> -- David
