Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7D72D54F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjFMABf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMABe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 20:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21E12A;
        Mon, 12 Jun 2023 17:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0982461EC2;
        Tue, 13 Jun 2023 00:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0000C433EF;
        Tue, 13 Jun 2023 00:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686614492;
        bh=Bn+QvIz6hyHE0Xqm10vIQJCsdphMcxbTH1ZlKTNe/KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7D6YNnSz8P7X1fK5goO196pQOl6A1Byezt94IhucKDdLQXK6Xz6QxjJYP6wfmdtf
         U3K+cNLYv3CqedjABjrveUvKypwON0BLCbCWmvD85cfnd70GB2PUDdtpjS3Gm/6zky
         KswGRin5FCl2t4tNh9HJA2c3lIFVHkqVN+4rdlLiocOugondmLGgNPWIJ87+K37ZKB
         5aatGKq1y2b+3nlOUgt4/Exifn6TLpKvKDDpmTxscSSb2bpqCMaT1BokwMSXaKy96/
         SoEgwe1y/l6j5QeanYNjE3CgOYVbhwmODPF/JH09mn/nUiMaFANvdnc153DLch19yz
         NtazYKCJy53EQ==
From:   SeongJae Park <sj@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     SeongJae Park <sj@kernel.org>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add source tree entry for kunit
Date:   Tue, 13 Jun 2023 00:01:30 +0000
Message-Id: <20230613000130.85038-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABVgOS=HpS9g+YwLth2xpY9i2u3DxLzbbPoqnJshhAhU2fB_pA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 13 Jun 2023 07:54:01 +0800 David Gow <davidgow@google.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 1120 bytes --]
> 
> On Sun, 11 Jun 2023 at 02:05, SeongJae Park <sj@kernel.org> wrote:
> >
> > Patches for kunit are managed in linux-kselftest tree before merged into
> > the mainline, but the MAINTAINERS section for kunit doesn't have the
> > entry for the tree.  Add it.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> 
> Thanks very much.

My pleasure! :)

> 
> Given KUnit work happens in the kunit and kunit-fixes branches here,
> should we note those as well?

That makes sense, I will add those in the commit message with the next version
of this.

> 
> -- David
> 
> 
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ce5f343c1443..8a217438956b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11327,6 +11327,7 @@ L:      linux-kselftest@vger.kernel.org
> >  L:     kunit-dev@googlegroups.com
> >  S:     Maintained
> >  W:     https://google.github.io/kunit-docs/third_party/kernel/docs/
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> 
> Should we also mention the branch here:
> git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> kunit

I think so.  Would you prefer having only one 'T' line with 'kunit' branch?
Or, both branches like below?  I have no strong opinion.

T:     git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
T:     git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit-fixes


Thanks,
SJ

> 
> >  F:     Documentation/dev-tools/kunit/
> >  F:     include/kunit/
> >  F:     lib/kunit/
> > --
> > 2.25.1
> >
> 
