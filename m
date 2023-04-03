Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688126D52F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjDCU5n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 16:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjDCU5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 16:57:43 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505626B9;
        Mon,  3 Apr 2023 13:57:40 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Pr3BB13BBzvjfm; Mon,  3 Apr 2023 22:57:38 +0200 (CEST)
Date:   Mon, 3 Apr 2023 22:57:37 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/clone3: fix number of tests in ksft_set_plan
Message-ID: <20230403205735.ltb3pmh5yl2pjzhu@distanz.ch>
References: <20230314115352.20623-1-tklauser@distanz.ch>
 <20230314123414.26907-1-tklauser@distanz.ch>
 <20230314130959.7gfuagxta6k423kf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314130959.7gfuagxta6k423kf@wittgenstein>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=0.3 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-03-14 at 14:09:59 +0100, Christian Brauner <brauner@kernel.org> wrote:
> On Tue, Mar 14, 2023 at 01:34:14PM +0100, Tobias Klauser wrote:
> > Commit 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> > added an additional test, so the number passed to ksft_set_plan needs to
> > be bumped accordingly.
> > 
> > Also use ksft_finished() to print results and exit. This will catch future
> > mismatches between ksft_set_plan() and the number of tests being run.
> > 
> > Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> > Cc: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> Looks good. Thanks for fixing this,
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> Feel free to take this through the selftests tree, Shuah.

It looks like this hasn't made it into Linus' tree yet and I also don't
see it in Shuah's tree. Would it be possible to still submit this for
6.3-rc6 given the commit it fixes has made it to Linus' tree already?

Thanks
