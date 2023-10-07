Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749407BC61C
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjJGImT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjJGImT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 04:42:19 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D059C;
        Sat,  7 Oct 2023 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696668136;
        bh=2Vvew6fqSBv6tVBypSBxMHQdLCQoQrI+qlg1pZeHdOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txnU3414A6HGKSNh/zpDKbKS8idjPSh1hNbv9HB3d03bf9lsoj8LiwLyBBmv9n23G
         G2vZXuVc8VNC33EMy/vne4qXUr2Qzl6B9OlnuTjO7YVd+OVatFUkeXOhdPPEsh1vng
         2sFMtsvprLjDeAx+QRSonvODYVBpDzxvznkkV+l8=
Date:   Sat, 7 Oct 2023 10:42:16 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] tools/nolibc: add support for constructors and
 destructors
Message-ID: <e9b5d12a-3f16-4a20-b2e2-3b63d16a6d20@t-8ch.de>
References: <20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net>
 <20231007065025.GZ20998@1wt.eu>
 <485b8b48-673a-4b1d-8651-2c0038d478cf@t-8ch.de>
 <20231007083035.GA21880@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007083035.GA21880@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-07 10:30:35+0200, Willy Tarreau wrote:
> On Sat, Oct 07, 2023 at 09:28:45AM +0200, Thomas Weißschuh wrote:
> > > In the past I learned the hard way that you can never trust the execution
> > > order of constructors, so if you're unlucky above you could very well end
> > > up with 1 and that would be correct. I suggest that instead you do something
> > > such as:
> > > 
> > >       constructor_test_value += 1;
> > > ...
> > >       constructor_test_value += 2;
> > > 
> > > and check for value 3 in the test to make sure they were both executed
> > > exactly once each.
> > 
> > Was this indeterminism for constructors from the same translation unit?
> > Or across different translation units/shared objects?
> 
> I'm certain that there's no guarantee from multiple units, but I seem
> to remember something about possible reordering within a same unit.
> 
> > I'm not entirely sure, but the GCC [0] docs could be read that within a
> > given TU the execution order for constructors is the same as the
> > definition order, even for C.
> > 
> >     The priorities for constructor and destructor functions are the same
> >     as those specified for namespace-scope C++ objects
> > 
> > And linked from there:
> > 
> >     In Standard C++, objects defined at namespace scope are guaranteed
> >     to be initialized in an order in strict accordance with that of
> >     their definitions *in a given translation unit*. No guarantee is made
> >     for initializations across translation units.
> 
> Then that's probably OK. I'd say it all depends what you want to test.
> If you also want the test to cover for this, then your test is stricter,
> but then maybe you should put a comment there saying that it's on purpose
> to also verify they execute in the expected order ;-)

Given that the worst failure mode that could happen here is that the
tests fail and directly point at the issue, it should not be too risky to
try to rely on this behaviour.

Verifying the order was indeed the goal. I'll add the comment.

Thanks,
Thomas
