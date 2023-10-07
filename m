Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903A17BC60F
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjJGIay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjJGIax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 04:30:53 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9530A6;
        Sat,  7 Oct 2023 01:30:50 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3978UZTu021895;
        Sat, 7 Oct 2023 10:30:35 +0200
Date:   Sat, 7 Oct 2023 10:30:35 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] tools/nolibc: add support for constructors and
 destructors
Message-ID: <20231007083035.GA21880@1wt.eu>
References: <20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net>
 <20231007065025.GZ20998@1wt.eu>
 <485b8b48-673a-4b1d-8651-2c0038d478cf@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <485b8b48-673a-4b1d-8651-2c0038d478cf@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 07, 2023 at 09:28:45AM +0200, Thomas Weißschuh wrote:
> > In the past I learned the hard way that you can never trust the execution
> > order of constructors, so if you're unlucky above you could very well end
> > up with 1 and that would be correct. I suggest that instead you do something
> > such as:
> > 
> >       constructor_test_value += 1;
> > ...
> >       constructor_test_value += 2;
> > 
> > and check for value 3 in the test to make sure they were both executed
> > exactly once each.
> 
> Was this indeterminism for constructors from the same translation unit?
> Or across different translation units/shared objects?

I'm certain that there's no guarantee from multiple units, but I seem
to remember something about possible reordering within a same unit.

> I'm not entirely sure, but the GCC [0] docs could be read that within a
> given TU the execution order for constructors is the same as the
> definition order, even for C.
> 
>     The priorities for constructor and destructor functions are the same
>     as those specified for namespace-scope C++ objects
> 
> And linked from there:
> 
>     In Standard C++, objects defined at namespace scope are guaranteed
>     to be initialized in an order in strict accordance with that of
>     their definitions *in a given translation unit*. No guarantee is made
>     for initializations across translation units.

Then that's probably OK. I'd say it all depends what you want to test.
If you also want the test to cover for this, then your test is stricter,
but then maybe you should put a comment there saying that it's on purpose
to also verify they execute in the expected order ;-)

Willy
