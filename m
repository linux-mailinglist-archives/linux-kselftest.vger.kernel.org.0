Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2876D9A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjHBVge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHBVgd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:36:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959DD10C7;
        Wed,  2 Aug 2023 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691012190; bh=Kl3ThNCjJRX0Aikin/vSGRtztwQOGkS9N+bnYGYxVg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrYxwDXieT4uTgqq54AsOXtG/eHRw7RnSR/I4oaqE4Y+hDIGzKc4uG1VZa3YLvy7u
         Ttr8zeFRgTRHXUSow0L5pOlR4JLwcQ50AmINMQJyPAGldLkTJcBNUCL45SLtP9tlhg
         RgQWcK5WOhLw6VZt1dgKJQCgaxp89hrscQB4O8RY=
Date:   Wed, 2 Aug 2023 23:36:30 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Message-ID: <98629d86-eca8-4cad-aedc-2e2328a4f6ab@t-8ch.de>
References: <20230802103217.231036-1-falcon@tinylab.org>
 <20230802160358.407890-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802160358.407890-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-03 00:03:58+0800, Zhangjin Wu wrote:
> Hi, Willy, Hi Thomas
> 
> I'm so happy to share with you, we have solved all of the left found
> issues, include the ones about ppc and the missing poweroff options for
> the tinyconfig series, will renew both series ;-)

Can we stick to one series at a time?

> > Further compared the preprocessed files, found the root cause is the new
> > compiler using 'no_stack_protector' instead of
> > '__optimize__("-fno-stack-protector")'. And the attribute 'no_stack_protector'
> > breaks our "omit-frame-pointer" like the failure with '-O0' we fixed before.
> > 
> > I checked some of the other architectures, they didn't have the same issue, but
> > test shows the 'no_stack_protector' attribute does have such compability issue
> > here.
> > 
> > I learned the commit message of tools/include/nolibc/compiler.h, seems
> > __optimize__("-fno-stack-protector") is enough for all of the nolibc supported
> > architectures? is it ok for us to simply give up 'no_stack_protector'
> > eventully? otherwise, we should manually disable 'no_stack_protector' for
> > ppc32:
> > 
> >     #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
> >
> 
> Hello, any suggestion here? ;-)

Patience :-)

no_stack_protector is the offically documented mechanism to disable
stack protector for a function. As it works for all other architectures
this seems like a compiler bug.

If we want to work around it I would prefer to have both attributes.

> [..]

Thomas
