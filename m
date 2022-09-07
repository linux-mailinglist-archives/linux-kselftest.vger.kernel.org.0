Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C95AFDAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIGHjc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIGHjb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 03:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595421A4;
        Wed,  7 Sep 2022 00:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC04BB81B86;
        Wed,  7 Sep 2022 07:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66683C433C1;
        Wed,  7 Sep 2022 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662536366;
        bh=xNfSQnW79KxqmfMU3riHt3rK2p4MSBkj0ld5YS0oz24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0uBDL/jbGzS7X7lNWheLRCf9TVNVsmOg1T8RgibbuLY+KrjZn+hI4PG47GbQmlNz
         SyPz/sWDenrfOklvPa8lUy2L72Lbmk1W4iEe789bR+4sh/ndN8uTY/nrUDUZsEqE7M
         Bjc6WujRLAiUEeJ7rv4X5yzh1lwcehWY8a1lMvbD8cf1EBj45vaBdT3AJjNSSgM3JJ
         Y79Y54ITDfnuljIAqs4zVv8QKmZRDGm7JOumH7Sn6dagnJTts8suuESWct/zgvHgMk
         wuXz4AlxEns2rwHq/q1LcwEuWogxuSKhyQ+JghWziowDBuHaKlIxIhi6jZVSb+xxtb
         e3NH4yYnX6pnA==
Date:   Wed, 7 Sep 2022 08:39:19 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, lkp@lists.01.org, lkp@intel.com,
        linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [fortify]  728833277d:
 WARNING:at_net/netlink/af_netlink.c:#netlink_ack
Message-ID: <YxhKp4n7K4h3aMQt@work>
References: <20220901065914.1417829-2-keescook@chromium.org>
 <202209071317.245c5751-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209071317.245c5751-oliver.sang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 07, 2022 at 01:42:16PM +0800, kernel test robot wrote:

Hi!

> 
> Hi Kees Cook,
> 
> the patch "[PATCH 1/2] fortify: Add run-time WARN for cross-field memcpy()"
> raises a persistent WARNING as below report in our tests.
> 
> according to commit message, we understand this is kind of expected. but
> we don't have enough knowledge if it reveals a real issue in kernel source
> code and what the next step could be.
> 
> so we still report FYI.
> 
> if you think it's unnecessary for us to make out this kind of report, please
> let us know. we will consider how to refine our report rules. Thanks a lot!
> 
> below is the full report.

It seems that the idea is to continue reporting these warnings, as they
help us identify the places that need to be audited and determine how to
refactor the code (in case it's a false positive), or how to properly fix
it (in case it's an actual bug).

In this case, it seems that the issue was already addressed by this patch:

https://lore.kernel.org/linux-hardening/20220903043749.3102675-1-keescook@chromium.org/

Thanks
--
Gustavo
