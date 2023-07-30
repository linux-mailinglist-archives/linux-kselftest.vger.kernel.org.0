Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA770768411
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjG3Gzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 02:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3Gzw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 02:55:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E61BFC;
        Sat, 29 Jul 2023 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690700149; bh=AsR7SScjhhhuUIwlLxCxzyirY1+1rrg50w0GYvxxVrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXOJs9hdlTZS/ostodKTbuDvGIJo6RGBMKe31DoWM+uezQM3R5hs9Ppdlz1bG/J4H
         +2xyXaUlD5gxa1nxD7rcFDOp8ksTUt4KuFYZZvsJMF+pMKCbjdi4m2xBPem35bV/dE
         zT6AyTYZE/kvrLmTxK1zoartVArnQo+ArOgnMVxo=
Date:   Sun, 30 Jul 2023 08:55:47 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Yuan Tan <tanyuan@tinylab.org>, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/nolibc: add testcase for pipe.
Message-ID: <ebf02a04-6e89-4bc9-beff-3902ad8a78b5@t-8ch.de>
References: <cover.1690307717.git.tanyuan@tinylab.org>
 <160ddef0313e11085ee906144d6d9678b8156171.1690307717.git.tanyuan@tinylab.org>
 <27bd9bc1-e7a5-4a81-91c9-2642feabb7ce@t-8ch.de>
 <20230730033343.GB7339@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230730033343.GB7339@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-30 05:33:43+0200, Willy Tarreau wrote:
> On Sun, Jul 30, 2023 at 12:17:24AM +0200, Thomas Weißschuh wrote:
> > > +	case 0:
> > > +		close(pipefd[0]);
> > > +		write(pipefd[1], msg, strlen(msg));
> > 
> > Isn't this missing to write trailing the 0 byte?
> 
> It depends if the other side expects to get the trailing 0.
> In general it's better to avoid sending it since it's only
> used for internal representation, and the other side must
> be prepared to receive anything anyway.
> 
> > Also check the return value.
> 
> Indeed!
> 
> > > +		close(pipefd[1]);
> > 
> > Do we need to close the pipefds? The process is exiting anyways.
> 
> It's better to, because we could imagine looping over the tests for
> example. Thus each test shoulld have as little impact as possible
> on other tests.

I meant the newly forked child exiting, not nolibc-test in general.
The exit is just below, so the fds in the child are close here anyways.
                |
		|
		v
> > > +		exit(EXIT_SUCCESS);
> > > +
> > > +	default:
> > > +		close(pipefd[1]);
> > > +		read(pipefd[0], buf, 32);
> > 
> > Use sizeof(buf). Check return value == strlen(msg).
> > 
> > > +		close(pipefd[0]);
> > > +		wait(NULL);
> > 
> > waitpid(pid, NULL, 0);
> > 
> > > +
> > > +		if (strcmp(buf, msg))
> > > +			return 1;
> > > +		return 0;
> > 
> > return !!strcmp(buf, msg);
> 
> In fact before that we need to terminate the output buffer. If for any
> reason the transfer fails (e.g. the syscall fails or transfers data at
> another location or of another length, we could end up comparing past
> the end of the buffer. Thus I suggest adding this immediately after the
> read():
> 
> 		buf[sizeof(buf) - 1] = 0;

This would still access uninitialized memory and lead to UB in strcmp as
not all bytes in buf were written to by read().

If we want to be really sure we should use memcmp() instead of strcmp().
For memcmp() I would prefer to transfer and check without the '\0', so
my review comments from before need to be adapted a bit.
