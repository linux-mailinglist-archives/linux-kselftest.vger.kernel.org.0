Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22071FEDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjFBKUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjFBKUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:20:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B66194;
        Fri,  2 Jun 2023 03:20:38 -0700 (PDT)
Date:   Fri, 2 Jun 2023 12:20:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685701235; bh=p8zy09hQZDIIVHzkSV9VXJxDfAUWj/mvEvyOT3k7A/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXAY/JzAJzZGzRxkerz7y+d+s64mDEh57DaAujLAWHIUZJkFJSVPGYOa+IvRPH32t
         MTKDzLcBUTuikb6NM8VUOjmr9e63fAiEmOGZKG7pTGvVmorEemK6nGONfxAY38evcp
         WWvGkvyaAQTYpX3dXfxbB5L60xEVkWEpTRDqH9l8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: test_fork: fix up duplicated print
Message-ID: <a72cac9d-609f-4c4f-a7f8-7c6b89837e0a@t-8ch.de>
References: <61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org>
 <20230602024157.11151-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602024157.11151-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-02 10:41:57+0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> What about this one for 2023xxxx-nolibc-rv32+stkp6?
> 
> @Thomas, welcome your Reviewed-by If it is ok for you ;-)

Indeed, good catch!

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> Best regards,
> Zhangjin
> 
> > running nolibc-test with glibc on x86_64 got such print issue:
> > 
> >     29 execve_root = -1 EACCES                                       [OK]
> >     30 fork30 fork = 0                                                      [OK]
> >     31 getdents64_root = 712                                         [OK]
> > 
> > The fork test case has three printf calls:
> > 
> >     (1) llen += printf("%d %s", test, #name);
> >     (2) llen += printf(" = %d %s ", expr, errorname(errno));
> >     (3) llen += pad_spc(llen, 64, "[FAIL]\n"); --> vfprintf()
> > 
> > In the following scene, the above issue happens:
> > 
> >     (a) The parent calls (1)
> >     (b) The parent calls fork()
> >     (c) The child runs and shares the print buffer of (1)
> >     (d) The child exits, flushs the print buffer and closes its own stdout/stderr
> >         * "30 fork" is printed at the first time.
> >     (e) The parent calls (2) and (3), with "\n" in (3), it flushs the whole buffer
> >         * "30 fork = 0 ..." is printed
> > 
> > Therefore, there are two "30 fork" in the stdout.
> > 
> > Between (a) and (b), if flush the stdout (and the sterr), the child in
> > stage (c) will not be able to 'see' the print buffer.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 7de46305f419..88323a60aa4a 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -486,7 +486,13 @@ static int test_getpagesize(void)
> >  static int test_fork(void)
> >  {
> >  	int status;
> > -	pid_t pid = fork();
> > +	pid_t pid;
> > +
> > +	/* flush the printf buffer to avoid child flush it */
> > +	fflush(stdout);
> > +	fflush(stderr);
> > +
> > +	pid = fork();
> >  
> >  	switch (pid) {
> >  	case -1:
> > -- 
> > 2.25.1
> > 
> > 
