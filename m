Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51937753E51
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjGNPDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjGNPDQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 11:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C01B5;
        Fri, 14 Jul 2023 08:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D098A61D48;
        Fri, 14 Jul 2023 15:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6263C433C8;
        Fri, 14 Jul 2023 15:03:11 +0000 (UTC)
Date:   Fri, 14 Jul 2023 11:03:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE() to args.h
Message-ID: <20230714110309.72e3e371@gandalf.local.home>
In-Reply-To: <20230714142237.21836-1-andriy.shevchenko@linux.intel.com>
References: <20230714142237.21836-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Jul 2023 17:22:37 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kernel.h is being used as a dump for all kinds of stuff for a long time.
> The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> without need of the full kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out these macros().
> 
> While at it, include new header where it's being used and drop custom
> implementation of these macros and document how it works.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
