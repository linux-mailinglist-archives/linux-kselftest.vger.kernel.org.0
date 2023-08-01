Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C176BF03
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHAVLz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjHAVLw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 17:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89087E67;
        Tue,  1 Aug 2023 14:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076EC61719;
        Tue,  1 Aug 2023 21:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08120C433C7;
        Tue,  1 Aug 2023 21:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690924301;
        bh=zx03PjfgY07UCKTT9D+a57aqd3/g+SVsstHgr2BvJBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sblLoR3kQGCtNkxVEW+NLWBgyfNJOVLJD1dqEJzGWiDAlpPajGeOX+9YR66py8GlS
         h3+TDJG7WbJ9qG/Vw3xavRlmqLqqhDxttl+YTfpqpGBQPE5Uk8MWl1s9nQVlmX/ecK
         snTPWPFHsvdLkqenjmJ/F5htbfdTu42CyWxG5Ls3RNfeXWnndeA36mJZ1DE81y9b11
         ts1SLqVvDfbVQjjJ5ZWAoYjhJ/y4RcD+MavMdz7psXxnvkAfpfH5DIdcLqD37FmAfh
         mH31ki9VoGdMte6bBBOingw7G3PxdVuSlVSc7g0D+rwjb/AjP5mcPDVl4xRSK9WvwH
         x35MKBUb9+5Nw==
Date:   Tue, 1 Aug 2023 16:11:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/4] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE() to args.h
Message-ID: <20230801211139.GA51676@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718211147.18647-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 12:11:44AM +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> without need of the full kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out these macros().
> 
> While at it, include new header where it's being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ff7500772e6..eeb2e6f6130f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -23,7 +23,7 @@
>  #ifndef LINUX_PCI_H
>  #define LINUX_PCI_H
>  
> -
> +#include <linux/args.h>
>  #include <linux/mod_devicetable.h>
>  
>  #include <linux/types.h>

If there's not a reason otherwise, I'd put this in the main list
instead of the weirdly separated mod_devicetable.h.
