Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682E7A3609
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjIQPHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjIQPH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 11:07:27 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA75B6;
        Sun, 17 Sep 2023 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694963241;
        bh=7/Orlex/DcvUIrTiTjE7jsedSBarqpG1A2LXaMcy8Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYuutu8oStQ8LzGOg0Z6E4Zq1iuoPXBte3vGMm7tU5ca2WwdeLLkEDX5YWTddKPD9
         HQ+fIvAsLr4WZ1Ov23zLu3BJs0gjM8xDZk+lHOvJYXl90vkx4fjwDs2wBt/2i8nfTa
         dDFx8MmxNfGpHZGHwZPrLptXsFTRR2ulS56I+E2A=
Date:   Sun, 17 Sep 2023 17:07:18 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
Message-ID: <1ef57a1e-89d3-4eb6-be12-3045a31f99e4@t-8ch.de>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
 <20230914-nolibc-syscall-nr-v1-2-e50df410da11@weissschuh.net>
 <20230917025851.GE9646@1wt.eu>
 <2bd688b7-5f1b-44ca-a41b-6e90dc3e8557@t-8ch.de>
 <20230917094827.GA11081@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917094827.GA11081@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-17 11:48:27+0200, Willy Tarreau wrote:
> [..]
> > Maybe the macro-equivalent of this?
> > 
> > static inline int __nolibc_enosys(...)
> > {
> > 	return -ENOSYS;
> > }
> > 
> > The only-vararg function unfortunately needs C23 so we can't use it.
> >
> > It's clear to the users that this is about ENOSYS and we don't need a
> > bunch of new macros similar.
> 
> I like it, I didn't think about varargs, it's an excellent idea! Let's
> just do simpler, start with a first arg "syscall_num" that we may later
> reuse for debugging, and just mark this one unused:
> 
>   static inline int __nolibc_enosys(int syscall_num, ...)
>   {
> 	(void)syscall_num;
>   	return -ENOSYS;
>   }

But which syscall_num to use, as the point of __nolibc_enosys() would be
that no syscall number is available and the defines are missing.

For debugging we could add a string argument, though.
