Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230317684ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjG3LIq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjG3LIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 07:08:45 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66DC91BD1;
        Sun, 30 Jul 2023 04:08:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36UB8XUv012520;
        Sun, 30 Jul 2023 13:08:33 +0200
Date:   Sun, 30 Jul 2023 13:08:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Yuan Tan <tanyuan@tinylab.org>, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/nolibc: add testcase for pipe.
Message-ID: <20230730110833.GA12462@1wt.eu>
References: <cover.1690307717.git.tanyuan@tinylab.org>
 <160ddef0313e11085ee906144d6d9678b8156171.1690307717.git.tanyuan@tinylab.org>
 <27bd9bc1-e7a5-4a81-91c9-2642feabb7ce@t-8ch.de>
 <20230730033343.GB7339@1wt.eu>
 <ebf02a04-6e89-4bc9-beff-3902ad8a78b5@t-8ch.de>
 <20230730071227.GB8033@1wt.eu>
 <c5de2d13-3752-4e1b-90d9-f58cca99c702@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5de2d13-3752-4e1b-90d9-f58cca99c702@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 30, 2023 at 10:07:24AM +0200, Thomas Weißschuh wrote:
> > In fact you make a good point regarding the fact that the test doesn't
> > use read()'s return value. This problem totally goes away if the return
> > value is used, e.g.:
> > 
> >       len = read(pipefd[0], buf, sizeof(buf));
> >       close(pipefd[0]);
> >       waitpid(pid, NULL, 0);
> >       return len < 0 || len > sizeof(buf) || len > strlen(msg) || memcmp(buf, msg, len) != 0;
> 
> Wouldn't this happily accept len == 0?
> 
> Why not just:
> 
> if (len != strlen(msg))
>   return 1;
> return !!memcmp(buf, msg, len);

Indeed, works for me.

> Also so far we have assumed that one call one call to read() is enough.
> But looking at pipe(7) this is not guaranteed by the spec.
> If we want to be really sure, a loop around read() seems to be necessary.

In practice it will be OK as the message is small and sent in one syscall,
so let's not care too much about this for now.

Willy
