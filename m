Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799A7518D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjGMGec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 02:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjGMGec (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 02:34:32 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 716F110F2;
        Wed, 12 Jul 2023 23:34:30 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36D6YIxd022561;
        Thu, 13 Jul 2023 08:34:18 +0200
Date:   Thu, 13 Jul 2023 08:34:18 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Message-ID: <ZK+a6rEJIUjCnNsZ@1wt.eu>
References: <a00284a6-54b1-498c-92aa-44997fa78403@t-8ch.de>
 <20230713061227.43222-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713061227.43222-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

I haven't reviewed the rest yet but regarding this point:

On Thu, Jul 13, 2023 at 02:12:27PM +0800, Zhangjin Wu wrote:
> > > +	/* find auxv */
> > > +	i = 0;
> > > +	while (envp[i])
> > > +		i++;
> > > +	_auxv = (void *)(envp + i + 1);
> > 
> > Could be simplified a bit:
> > 
> > _auxv = (void *) envp;
> > while (_auxv)
> > 	_auxv++;
> >
> 
> Yeah, it is better, but needs a little change.
> 
>     _auxv = (void *) envp;
>     while (*_auxv)
> 	_auxv++;
>     _auxv++;

Or just:

    _auxv = (void*)environ;
    while (*_auxv++)
         ;

or:

    for (_auxv = (void*)environ; *_auxv++; )
         ;

Please also have a look at the output code, because at low optimization
levels, compilers sometimes produce a better code with a local variable
than with a global variable in a loop. Thus I wouldn't be that much
surprised if at -O0 or -O1 you'd see slightly more compact code using:

       /* find envp */
       environ = argv + argc + 1;
        
       /* find auxv */
       for (auxv = environ; *auxv++)
                ;
       _auxv = auxv;

than:
       /* find envp */
       envp = argv + argc + 1;
       environ = envp;
        
       /* find auxv */
       for (_auxv = environ; *_auxv++)
                ;

Since it's going to become generic code, it's worth running a few tests
to see how to best polish it.

Thanks,
Willy
