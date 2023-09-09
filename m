Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA15799593
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 03:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjIIB1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 21:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjIIB1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 21:27:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD419B4;
        Fri,  8 Sep 2023 18:26:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E6BC433C9;
        Sat,  9 Sep 2023 01:26:54 +0000 (UTC)
Date:   Fri, 8 Sep 2023 21:27:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>, shuah@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
Message-ID: <20230908212712.211a4964@gandalf.local.home>
In-Reply-To: <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
        <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 9 Sep 2023 00:33:05 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Sep 08, 2023 at 08:19:16PM +0000, Beau Belgrave wrote:
> 
> > Add common methods to detect if tracefs and user_events is enabled. If
> > either is not enabled skip the test. If tracefs is enabled, but is not
> > mounted, mount tracefs and fail if there were any errors. Fail if not
> > run as root.  
> 
> This will leave tracefs mounted if it was not already mounted which is a
> change to the system configuration.  While that may happen if things go
> wrong during a test we should probably avoid actively doing this and
> either only skip or try to umount at the end of the test if we mounted
> ourselves.

LOL! Beau just asked me yesterday if anyone would care if the test mounted
tracefs and left it mounted. I told him "no" as ftracetest in the selftests
already do that.

I guess I was wrong and some people do care ;-)

-- Steve
