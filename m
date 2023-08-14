Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8277B233
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjHNHTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 03:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjHNHS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 03:18:57 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE82EE71;
        Mon, 14 Aug 2023 00:18:56 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37E7IooG016713;
        Mon, 14 Aug 2023 09:18:50 +0200
Date:   Mon, 14 Aug 2023 09:18:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 0/7] selftests/nolibc: customize CROSS_COMPILE for all
 supported architectures
Message-ID: <20230814071850.GC14322@1wt.eu>
References: <20230813093734.GJ8237@1wt.eu>
 <20230813100503.8613-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813100503.8613-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 06:05:03PM +0800, Zhangjin Wu wrote:
> > I think that later I'll further extend XARCH with new variants to
> > support ARMv5 and Thumb2, because we have different code for this
> > and I continue to manually change the CFLAGS to test both.
> >
> 
> Ok, what about further add x86_64 as the default variant for x86 (like ppc for
> powerpc)? and then it is able to only resereve the variables for x86_64. I have
> prepared a patch for this goal in our new tinyconfig patchset, it will further
> avoid adding the same nolibc-test-x86.config and nolibc-test-x86_64.config.

I'm confused, x86 already defaults to x86_64, it's just that it depends
on the .config itself to figure whether to produce a 32- or 64-bit kernel.
But for example it starts qemu in 64-bit mode. Am I missing anything ?

Willy
