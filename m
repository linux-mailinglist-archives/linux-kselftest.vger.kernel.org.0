Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B46D78AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjDEJn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjDEJn5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 05:43:57 -0400
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83F171B;
        Wed,  5 Apr 2023 02:43:52 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Ps07n5hbBzvjfm; Wed,  5 Apr 2023 11:43:49 +0200 (CEST)
Date:   Wed, 5 Apr 2023 11:43:49 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/clone3: fix number of tests in ksft_set_plan
Message-ID: <20230405094349.7fkipggxdmrnn2mo@distanz.ch>
References: <20230314115352.20623-1-tklauser@distanz.ch>
 <20230314123414.26907-1-tklauser@distanz.ch>
 <20230314130959.7gfuagxta6k423kf@wittgenstein>
 <20230403205735.ltb3pmh5yl2pjzhu@distanz.ch>
 <20230404-wasting-finicky-6f8876022a24@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-wasting-finicky-6f8876022a24@brauner>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=0.3 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-05 at 09:46:11 +0200, Christian Brauner <brauner@kernel.org> wrote:
> On Mon, Apr 03, 2023 at 10:57:37PM +0200, Tobias Klauser wrote:
> > On 2023-03-14 at 14:09:59 +0100, Christian Brauner <brauner@kernel.org> wrote:
> > > On Tue, Mar 14, 2023 at 01:34:14PM +0100, Tobias Klauser wrote:
> > > > Commit 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> > > > added an additional test, so the number passed to ksft_set_plan needs to
> > > > be bumped accordingly.
> > > > 
> > > > Also use ksft_finished() to print results and exit. This will catch future
> > > > mismatches between ksft_set_plan() and the number of tests being run.
> > > > 
> > > > Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > > > ---
> > > 
> > > Looks good. Thanks for fixing this,
> > > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > > 
> > > Feel free to take this through the selftests tree, Shuah.
> > 
> > It looks like this hasn't made it into Linus' tree yet and I also don't
> > see it in Shuah's tree. Would it be possible to still submit this for
> > 6.3-rc6 given the commit it fixes has made it to Linus' tree already?
> 
> Is it in linux-next?

No, doesn't look like it (I checked on tags/next-20230405).
