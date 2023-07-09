Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6162B74C1C2
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 11:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjGIJ5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIJ5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 05:57:19 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1567129;
        Sun,  9 Jul 2023 02:57:16 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3699uvD9021671;
        Sun, 9 Jul 2023 11:56:57 +0200
Date:   Sun, 9 Jul 2023 11:56:57 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 01/12] tools/nolibc: rename arch-<ARCH>.h to
 <ARCH>/arch.h
Message-ID: <20230709095657.GJ9321@1wt.eu>
References: <cover.1688828139.git.falcon@tinylab.org>
 <ef34ee3cc8cb0e4f8ce7c7c9975a0e8d14473a84.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef34ee3cc8cb0e4f8ce7c7c9975a0e8d14473a84.1688828139.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 08, 2023 at 11:26:42PM +0800, Zhangjin Wu wrote:
> Currently, the architecture specific arch.h has two parts, one is the
> syscall declarations for sys.h, another is the _start code definition
> for startup support.
> 
> The coming crt.h will provide the startup support with a new common
> _start_c(), it will replace most of the assembly _start code and shrink
> the original _start code to be minimal, as a result, _start_c() and the
> left minimal _start code will work together to provide the startup
> support, therefore, the left _start code will be only required by crt.h.
> 
> So, the syscall declarations part of arch.h can be split to sys_arch.h
> and the _start code part of arch.h can be split to crt_arch.h and then,
> they should only be included in sys.h and crt.h respectively.
> 
> At the same time, the architecture specific arch-<ARCH>.h should be
> split to <ARCH>/crt.h and <ARCH>/sys.h.
> 
> As a preparation, this creates the architecture specific directory and
> moves tools/include/nolibc/arch-<ARCH>.h to
> tools/include/nolibc/<ARCH>/arch.h.

I'm sorry but I still don't understand what it *provides*. I'm reading
it as "we *can* do this so let's do it". But what is the specific
purpose of adding this extra directory structure ? It's really unclear
to me and worries me that it'll only result in complicating maintenance
by adding even more files, thus even more "include" lines and cross
dependencies.

Zhangjin, very often in your series, the justification for a change is
missing, instead it's only explaining what is being changed, and I must
confess that it makes it particularly difficult to figure the benefits.
I'm only seeing this as an opportunity for a change ("can be split").
I could have missed something of course, but I can't figure what problem
it is trying to solve.

As a general advice, I tend to remind people that when sending a patch
series, they should consider they're trying to sell it, so they must
emphasize the benefits of accepting the series for the maintainer(s).

You very likely have a good reason for doing this but I can't see it
here so I'm just seeing a change that will possibly add some extra
cost (if at least because file locations change again) and nothing
more. When you try to reorganize things, it's often much more
efficient to try to discuss it before proposing patches, because
reorg patches are generally unreadable and take time for you to
create and for others to review. Instead, just explaining what you
think you can improve is faster for everyone, and others can chime in
and propose alternate approaches (something which is very hard to do
with a patch series).

Thanks!
Willy
