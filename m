Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE259F336
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHXFwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 01:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiHXFwB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 01:52:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD076B668;
        Tue, 23 Aug 2022 22:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D47B5B822F0;
        Wed, 24 Aug 2022 05:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A9C433D6;
        Wed, 24 Aug 2022 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661320317;
        bh=Uxw3C6Y366ppcVDZN6bcHHE2ruNtTnaTVER0kdIwvX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBtQDC7DpVTTiMIzApH1yLy2h0wSykqDlDdhNSrfSlkahCWM0DII5keYpZyOhIxu2
         90o7alSuMMbCLgIDyABtnLXvs5fUAcEBgYjRXWSIg6/4psWEbJu7+Ofh7zCnrNjgVB
         B5tn3QwnRdM8d5yqnWN8wyoEZ9/Hym4w9eXDWHqk=
Date:   Wed, 24 Aug 2022 07:51:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Delgadilo <adelg@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dylanbhatch@google.com,
        sashalevin@google.com, gthelen@google.com
Subject: Re: [PATCH] selftests: Add a taint selftest
Message-ID: <YwW8eo1rbo9tmpVK@kroah.com>
References: <20220823211958.2519055-1-adelg@google.com>
 <YwWx07EbaB90jDUN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwWx07EbaB90jDUN@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 24, 2022 at 07:06:27AM +0200, Greg KH wrote:
> On Tue, Aug 23, 2022 at 09:19:58PM +0000, Andrew Delgadilo wrote:
> > From: Andrew Delgadillo <adelg@google.com>
> > 
> > When testing a kernel, one of the earliest signals one can get is if a
> > kernel has become tainted. For example, an organization might be
> > interested in mass testing commits on their hardware. An obvious first
> > step would be to make sure every commit boots, and a next step would be
> > to make sure there are no warnings/crashes/lockups, hence the utility of
> > a taint test.
> 
> What's wrong with the tools/debugging/kernel-chktaint script?
> 
> Why do we need another "get what the taint status is" program?

Ah, looks like that script should probably be changed to return an error
code if a taint is found, but that should be a simpler patch rather than
create a whole new script.

thanks,

greg k-h
