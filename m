Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBC767E01
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjG2KEM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 06:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjG2KEL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 06:04:11 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B85210D0;
        Sat, 29 Jul 2023 03:04:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36TA41ej004582;
        Sat, 29 Jul 2023 12:04:01 +0200
Date:   Sat, 29 Jul 2023 12:04:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org
Subject: Re: [PATCH 1/2] tools/nolibc: add pipe() support
Message-ID: <20230729100401.GA4577@1wt.eu>
References: <20230728191717.GA32165@1wt.eu>
 <20230729083700.7554-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729083700.7554-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 04:37:00PM +0800, Zhangjin Wu wrote:
> > This one does not have the correct prototype for the function exposed
> > to the user, pipe really is "int pipe(int pipefd[2])". Maybe you were
> > thinking about sys_pipe() instead ? But since MIPS also has pipe2() now,
> > there's no reason to make an exception.
> >
> 
> Yes, pipe2() should be a better choice, but I have seen this sentence in
> syscall manpage [1]:
> 
>        /* On Alpha, IA-64, MIPS, SuperH, and SPARC/SPARC64, pipe() has the
>           following prototype; see NOTES */
> 
>        #include <unistd.h>
> 
>        struct fd_pair {
>            long fd[2];
>        };
>        struct fd_pair pipe(void);
> 
> If it is about syscall, then we are ok to align all of the architectures
> together to use "int pipe(int pipefd[2])"

Yes it's OK, that's how applications expect it to be used:

  https://pubs.opengroup.org/onlinepubs/9699919799/functions/pipe.html

For the archs you mention above, it's the libc that wraps the call,
exactly what we ought to do as well (using pipe2() since it will be
easier).

Willy
