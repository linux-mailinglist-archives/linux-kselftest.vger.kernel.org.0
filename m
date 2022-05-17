Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4F52A795
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiEQQE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiEQQEV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 12:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C550046;
        Tue, 17 May 2022 09:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78FB161243;
        Tue, 17 May 2022 16:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39E4C385B8;
        Tue, 17 May 2022 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803459;
        bh=fMF2BNIvkvrF0iD186WbKtU3kdy8mDQgsofbJCS1OPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=FUW9q9owWQTX9xiyiV23z1NZBo2aGhO4u75vC9rqi9hDzbQ/13UvfRIPhoHHMIhiF
         lpS5/2Hy0RKLVpGp2lrWG13uJ6qzJpZqpd5Xk3EUi5Sodu7iWfNtuCK9F2AA/Iw/rM
         8DHReuWxlzXmh/VInI11ifLQBU0U5HTdKOz+tsoQznXZN8T1vC7Uu+IE54Pdah8u35
         iLjFnkg2/5Fb56+N0ppwTtEyznOladA6h4tPcHcHPEaW8BBm3JVvJnSX89zL75nugE
         OIU3QYtdnIx3+zeB4TnYn5etQF7WWgx3YZz3Rd0XXvhXacFI/0hbD7jz3iUYEHW83C
         2hYgy70+PzyAQ==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Markus Boehme <markubo@amazon.de>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
Date:   Tue, 17 May 2022 09:04:17 -0700
Message-Id: <20220517160417.1096-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <CAJj2-QGk9DmGhjPsjHwL5uj+cQs6=12iKEffpq+Vxv3=CrMPBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yuanchu,

On Mon, 16 May 2022 21:07:25 -0400 Yuanchu Xie <yuanchu@google.com> wrote:

> SeongJae,
> 
> Do you have a preference on how this should be handled?

Sorry for late response.  I was thinking you were asking Shuah's opinion.  I
have no strong opinion but the approach you made in v2 looks slightly better
for me.


Thanks,
SJ

> 
> Thanks,
> Yuanchu
> 
> On Wed, May 4, 2022 at 6:12 PM Yuanchu Xie <yuanchu@google.com> wrote:
> >
> > Hi SeongJae,
> >
> > On Wed, May 4, 2022 at 11:45 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hi Yuanchu,
> > >
> > > On Wed, 4 May 2022 18:29:08 +0000 Yuanchu Xie <yuanchu@google.com> wrote:
> > >
> > > > The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
> > > > use '__GFP_NOWARN' for user-specified size buffer allocation")
> > > > intentionally writes and reads with a large count to cause
> > > > allocation failure and check for kernel warnings. We suppress
> > > > the compiler warnings for these calls as they work as intended.
> > > >
> > > > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> > > > ---
> > >
> > > It would be a good practice to mention the changes from the previous version of
> > > this patch here[1].
> > >
> > > [1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
> > >
> > Thank you, I missed this when trying to figure out how to add
> > additional comments for a revision.
> >
> > > >  tools/testing/selftests/damon/huge_count_read_write.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
> > > > index ad7a6b4cf338..91bd80c75cd9 100644
> > > > --- a/tools/testing/selftests/damon/huge_count_read_write.c
> > > > +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> > > > @@ -2,6 +2,8 @@
> > > >  /*
> > > >   * Author: SeongJae Park <sj@kernel.org>
> > > >   */
> > > > +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> > > > +#pragma GCC diagnostic ignored "-Wstringop-overread"
> > >
> > > I agree that this must be the cleaner way than v2.  But, I get below warning
> > > after applying this:
> > >
> > >     $ sudo make -C tools/testing/selftests/damon run_tests
> > >     make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
> > >     gcc     huge_count_read_write.c  -o /home/sjpark/linux/tools/testing/selftests/damon/huge_count_read_write
> > >     huge_count_read_write.c:6:32: warning: unknown option after ‘#pragma GCC diagnostic’ kind [-Wpragmas]
> > >         6 | #pragma GCC diagnostic ignored "-Wstringop-overread"
> > >           |                                ^~~~~~~~~~~~~~~~~~~~~
> > >
> > > My gcc version is:
> > >
> > >     $ gcc --version
> > >     gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> > I see, I'm running
> >
> >     $ gcc --version
> >     gcc (Debian 11.2.0-16+build1) 11.2.0
> >
> > I believe this is a new warning for gcc-11 [1], and somewhat
> > unfortunate that it results in a warning for gcc-9.4. I'm not sure
> > what the preference is here.
> > [1] https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gcc/Warning-Options.html
> >
> > Thanks,
> > Yuanchu
> 
