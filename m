Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E9768420
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 09:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjG3HMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG3HMe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 03:12:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79B0710FE;
        Sun, 30 Jul 2023 00:12:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36U7CRen008095;
        Sun, 30 Jul 2023 09:12:27 +0200
Date:   Sun, 30 Jul 2023 09:12:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Yuan Tan <tanyuan@tinylab.org>, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/nolibc: add testcase for pipe.
Message-ID: <20230730071227.GB8033@1wt.eu>
References: <cover.1690307717.git.tanyuan@tinylab.org>
 <160ddef0313e11085ee906144d6d9678b8156171.1690307717.git.tanyuan@tinylab.org>
 <27bd9bc1-e7a5-4a81-91c9-2642feabb7ce@t-8ch.de>
 <20230730033343.GB7339@1wt.eu>
 <ebf02a04-6e89-4bc9-beff-3902ad8a78b5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebf02a04-6e89-4bc9-beff-3902ad8a78b5@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 30, 2023 at 08:55:47AM +0200, Thomas Weißschuh wrote:
> On 2023-07-30 05:33:43+0200, Willy Tarreau wrote:
> > On Sun, Jul 30, 2023 at 12:17:24AM +0200, Thomas Weißschuh wrote:
> > > > +	case 0:
> > > > +		close(pipefd[0]);
> > > > +		write(pipefd[1], msg, strlen(msg));
> > > 
> > > Isn't this missing to write trailing the 0 byte?
> > 
> > It depends if the other side expects to get the trailing 0.
> > In general it's better to avoid sending it since it's only
> > used for internal representation, and the other side must
> > be prepared to receive anything anyway.
> > 
> > > Also check the return value.
> > 
> > Indeed!
> > 
> > > > +		close(pipefd[1]);
> > > 
> > > Do we need to close the pipefds? The process is exiting anyways.
> > 
> > It's better to, because we could imagine looping over the tests for
> > example. Thus each test shoulld have as little impact as possible
> > on other tests.
> 
> I meant the newly forked child exiting, not nolibc-test in general.
> The exit is just below, so the fds in the child are close here anyways.

Ah OK, but still it remains cleaner with it IMHO (i.e. better rely on
explicit things in tests, that's less doubts when they fail).

> > > > +	default:
> > > > +		close(pipefd[1]);
> > > > +		read(pipefd[0], buf, 32);
> > > 
> > > Use sizeof(buf). Check return value == strlen(msg).
> > > 
> > > > +		close(pipefd[0]);
> > > > +		wait(NULL);
> > > 
> > > waitpid(pid, NULL, 0);
> > > 
> > > > +
> > > > +		if (strcmp(buf, msg))
> > > > +			return 1;
> > > > +		return 0;
> > > 
> > > return !!strcmp(buf, msg);
> > 
> > In fact before that we need to terminate the output buffer. If for any
> > reason the transfer fails (e.g. the syscall fails or transfers data at
> > another location or of another length, we could end up comparing past
> > the end of the buffer. Thus I suggest adding this immediately after the
> > read():
> > 
> > 		buf[sizeof(buf) - 1] = 0;
> 
> This would still access uninitialized memory and lead to UB in strcmp as
> not all bytes in buf were written to by read().
> 
> If we want to be really sure we should use memcmp() instead of strcmp().
> For memcmp() I would prefer to transfer and check without the '\0', so
> my review comments from before need to be adapted a bit.

In fact you make a good point regarding the fact that the test doesn't
use read()'s return value. This problem totally goes away if the return
value is used, e.g.:

      len = read(pipefd[0], buf, sizeof(buf));
      close(pipefd[0]);
      waitpid(pid, NULL, 0);
      return len < 0 || len > sizeof(buf) || len > strlen(msg) || memcmp(buf, msg, len) != 0;

Willy
