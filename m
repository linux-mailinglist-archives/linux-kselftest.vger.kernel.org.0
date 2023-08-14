Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987C77B263
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjHNH0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 03:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjHNH0F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 03:26:05 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5B51E71;
        Mon, 14 Aug 2023 00:26:03 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37E7PqqQ016748;
        Mon, 14 Aug 2023 09:25:52 +0200
Date:   Mon, 14 Aug 2023 09:25:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 2/2] tools/nolibc: fix up size inflate regression
Message-ID: <20230814072552.GD14322@1wt.eu>
References: <20230813090037.GE8237@1wt.eu>
 <20230813133944.19604-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813133944.19604-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 09:39:44PM +0800, Zhangjin Wu wrote:
> > Let's just roll brk(), mmap() and sbrk() to their original, working,
> > definition:
> > 
> >  static __attribute__((unused))
> >  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
> >  {
> >         void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
> >  
> >         if ((unsigned long)ret >= -MAX_ERRNO) {
> >                 SET_ERRNO(-(long)ret);
> >                 ret = MAP_FAILED;
> >         }
> >         return ret;
> >  }
> >
> 
> Agree, only left a suggestion here [2] about whether we can apply the 2nd patch
> instead of rolling them back, let's discuss it in [2] thread.
(...)
> [2]: https://lore.kernel.org/lkml/20230813132620.19411-1-falcon@tinylab.org/

I'm sorry but I can't find this "suggestion" in this yet-another-super-
long-description-of-another-idea-of-redesign. In addition it's extremely
painful to constantly have to go through web links to follow a single
conversation. Mail works in threads for a reason. When the same discussion
is handled in many parallel threads it becomes impossible to keep it
focused on a specific topic. This is also why you should stop systematically
responding to a message with yet another redesign suggestion, this is super
hard to follow and it literally takes me several hours a week! And at the
end we've not addressed the initial problem but discussed plenty of other
things.

Thanks,
Willy
