Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02BC515AB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 07:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiD3FyN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Apr 2022 01:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359521AbiD3Fxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Apr 2022 01:53:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE4D15802;
        Fri, 29 Apr 2022 22:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A932EB81A3E;
        Sat, 30 Apr 2022 05:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C851C385AA;
        Sat, 30 Apr 2022 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651297822;
        bh=+V2WHEt+BbvR6Kus8+NIeeG1n5JYSfd+/mtuVc2EfEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acenyzvdTD/N4PkrwL3b3HfSqotPlBP0FqkzY3snX2drUSO3vtWxzTWr4yWwCL8SA
         Ls9ax3d876TSxMrK4gE+uMJ8w47uhq0nMP0/zgSoL58NJKuAnBeoRhhaug+BA90YjZ
         8b0OvcH9NbJ4iIjulOhdrR09L+l98sRgo4+TMxlU=
Date:   Sat, 30 Apr 2022 07:50:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
Message-ID: <YmzOFtrStXIgL2B1@kroah.com>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220430030019.803481-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430030019.803481-1-davidgow@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 30, 2022 at 11:00:19AM +0800, David Gow wrote:
> KUnit tests are not supposed to run on production systems: they may do
> deliberately illegal things to trigger errors, and have security
> implications (assertions will often deliberately leak kernel addresses).
> 
> Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
> run. This will be printed as 'N' (for kuNit, as K, U and T were already
> taken).
> 
> This should discourage people from running KUnit tests on production
> systems, and to make it easier to tell if tests have been run
> accidentally (by loading the wrong configuration, etc.)
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
