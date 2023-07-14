Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB77542EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjGNSzq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 14:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjGNSzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 14:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EB3586;
        Fri, 14 Jul 2023 11:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6670561DD7;
        Fri, 14 Jul 2023 18:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB384C433C7;
        Fri, 14 Jul 2023 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689360943;
        bh=KgsFiG5i/f94+WDrQrUG1IaMGJEiJyBBRwspPPnTsJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTWKUsw4htC64FOKSPZK+JYYig6e8a53zQ/zQgd9R027K38gj1I2EwFtJQJhHegKz
         Y2DXrkon40FKOy8HJw9TYsjLnoDhE7bAZnmz3qeRL1eUWFk45ryJ5j634jcESIBg2Q
         YCK4C9RgGp4v4lvYYVmiycgxXL/lSRdD6SwaScvM=
Date:   Fri, 14 Jul 2023 11:55:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE() to args.h
Message-Id: <20230714115542.b5373a8dc80ba996338ee753@linux-foundation.org>
In-Reply-To: <20230714142237.21836-1-andriy.shevchenko@linux.intel.com>
References: <20230714142237.21836-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Jul 2023 17:22:37 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kernel.h is being used as a dump for all kinds of stuff for a long time.
> The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> without need of the full kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out these macros().
> 
> While at it, include new header where it's being used and drop custom
> implementation of these macros and document how it works.

This blows up my x86_64 allmodconfig build, starting with

In file included from drivers/block/drbd/drbd_nl.c:78:
./include/linux/genl_magic_func.h:26:26: error: 'CONCAT_' declared as function returning an array
   26 | static struct nla_policy CONCAT_(GENL_MAGIC_FAMILY, _tla_nl_policy)[] = {
      |                          ^~~~~~~
./include/linux/genl_magic_func.h:26:15: error: parameter names (without types) in function declaration [-Werror]
   26 | static struct nla_policy CONCAT_(GENL_MAGIC_FAMILY, _tla_nl_policy)[] = {
      |               ^~~~~~~~~~
./include/linux/genl_magic_func.h:26:15: error: function 'CONCAT_' is initialized like a variable
./include/linux/drbd_genl.h:88:13: error: array index in non-array initializer
   88 | GENL_struct(DRBD_NLA_CFG_REPLY, 1, drbd_cfg_reply,
      |             ^~~~~~~~~~~~~~~~~~
./include/linux/genl_magic_func.h:24:10: note: in definition of macro 'GENL_struct'
   24 |         [tag_name] = { .type = NLA_NESTED },
      |          ^~~~~~~~
...
