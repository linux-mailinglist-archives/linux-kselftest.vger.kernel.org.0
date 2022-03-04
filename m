Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733934CDBF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbiCDSQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 13:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiCDSQl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 13:16:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35B1D21E2;
        Fri,  4 Mar 2022 10:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9C06101F;
        Fri,  4 Mar 2022 18:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7260FC340E9;
        Fri,  4 Mar 2022 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646417752;
        bh=QtRmzYeZWWRMKtMgE76VEBJ3pSCoqPxHQCc/ttQXt6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8Bflq7cMJLn6wmf19dyscS4sqFHhiYufUyprdS+TsUzI3ngHhc3Rh7Thmxnb7eoZ
         lC8OD2wLPU/7D0ZXaEdIqUlvV30ZRSd7BKc+mrBy9uE0piFjrTVy2jLDHfB6I6obkx
         6DhNuSNepAdIlfDxcrPyKlS///1uiSel/lgywiUWZOFBDHYlO4fCW3rok5Shg1Wczi
         ozb7JmHSG7xoac1m7x9m2ZsbDVYNi8Wk8fwmX1K4ECv2XTpL/X0J0CtZ6HvnSXbtCH
         EenfHfmM18uHNQlPF3BSJjJvAHcGXEAc+PyHrT7JVQXEDyaTOErKLPPmFXeJVMzqek
         UmmvWBNbAJWEg==
Date:   Fri, 4 Mar 2022 11:15:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
Message-ID: <YiJXUL3zIik+4QDv@thelio-3990X>
References: <20220304170813.1689186-1-nathan@kernel.org>
 <202203041005.A3B985C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203041005.A3B985C@keescook>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 04, 2022 at 10:09:03AM -0800, Kees Cook wrote:
> On Fri, Mar 04, 2022 at 10:08:14AM -0700, Nathan Chancellor wrote:
> > [...]
> > 
> > Update and reorder the documentation to reflect these new additions.
> > At the same time, notate that LLVM=0 is not the same as just omitting it
> > altogether, which has confused people in the past.
> 
> Is it worth making LLVM=0 actually act the way it's expected to?

I don't really see the point, omitting $(LLVM) altogether is simpler.
Why specify LLVM=0 if you want GNU tools, since it is the default?
However, I can look into changing that in a new revision or a follow up
if others disagree?

> > Link: https://lore.kernel.org/r/20200317215515.226917-1-ndesaulniers@google.com/
> > Link: https://lore.kernel.org/r/20220224151322.072632223@infradead.org/
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Looks good; minor .rst nit below...
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > [...]
> > -LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
> > -to enable them. ::
> > -
> > -	make LLVM=1
> > -
> > -They can be enabled individually. The full list of the parameters: ::
> > +LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
> > +The full list of supported make variables: ::
> 
> ": ::" and "::" yield the same result. I think the latter is more
> readable in non-rendered form. *shrug*

Ack, I'll wait for other feedback before sending v3, unless there is
none and Masahiro does not mind fixing it up during application.

Thanks for the review!
Nathan
