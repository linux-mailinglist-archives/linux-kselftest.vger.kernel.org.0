Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560D779D7DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjILRqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbjILRqc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 13:46:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC2E59;
        Tue, 12 Sep 2023 10:46:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB3C433C8;
        Tue, 12 Sep 2023 17:46:26 +0000 (UTC)
Date:   Tue, 12 Sep 2023 13:46:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>, shuah@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
Message-ID: <20230912134644.3b7959b9@gandalf.local.home>
In-Reply-To: <20230912171234.GA3704-beaub@linux.microsoft.com>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
        <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
        <20230908212712.211a4964@gandalf.local.home>
        <20230912171234.GA3704-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Sep 2023 10:12:34 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:


> > I guess I was wrong and some people do care ;-)
> > 
> > -- Steve  
> 
> It looks like this change got applied [1] to the fixes branch of
> linux-kselftest. I can either send a V3 with this addressed or build a
> patch based upon the fixes branch on top of this one to address it.
> 
> Which way do you all prefer?
> 
> Thanks,
> -Beau
> 
> 1. https://git.kernel.org/shuah/linux-kselftest/c/a06023a8f78d

I'm guessing that this would go through Shuah's tree right? So it would be
up to her to decide that.

-- Steve

