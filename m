Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BF5BDEBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 09:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiITHrf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiITHqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 03:46:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DB219D;
        Tue, 20 Sep 2022 00:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98CA8B80ADE;
        Tue, 20 Sep 2022 07:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B383AC433D7;
        Tue, 20 Sep 2022 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663659978;
        bh=dqlwdS1nNJrKARBzFnDndlwz48uka9lPxXPSXPHp7ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vb9LISwZTG/66zkPRswH395sv7igFLvvetziFGJM/xi19OWa3rxLOWOH5kbbJftPN
         CjMLcV8zCljeqT5wED/cWL30YlcAxtnct+GCUNPFF+Vw2rd+SVvSq21wICXeAmcKyY
         bxk/XM+HuaoIxKJCGHwcSulvVdsb3lIHBre4lbfc=
Date:   Tue, 20 Sep 2022 09:46:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     shuah@kernel.org, jstultz@google.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] selftests: timers: Remove the unneeded result
 variable
Message-ID: <Yylv5hbSBejJ58nt@kroah.com>
References: <20220920063202.215088-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920063202.215088-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 20, 2022 at 06:32:02AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value adjtimex() directly instead of storing it in another
> redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Once again, as this seems to keep being forgotten, you are sending
multiple patches all from the same gmail.com account, yet are claiming
they are from different people from a company that no one from that
company has agreed is actually at that company.

Then there's the whole "ignoring
Documentation/process/researcher-guidelines.rst" issues, which would
disqualify the changes anyway.

So we can not take these patches at all.

Please fix up your corporate email structures so that you can properly
submit changes to the kernel that can be verified to actually come from
your company.  Otherwise they can not be accepted at all for obvious
reasons (ZTE would not want to have people claiming to work for them
that are not actually working for them, right?)

thanks,

greg k-h
