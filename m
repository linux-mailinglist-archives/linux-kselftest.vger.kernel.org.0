Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A5794181
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbjIFQ3X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjIFQ3V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 12:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA31BD5;
        Wed,  6 Sep 2023 09:28:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33280C433C7;
        Wed,  6 Sep 2023 16:28:10 +0000 (UTC)
Date:   Wed, 6 Sep 2023 12:28:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: user_events: Test terminated by assertion
Message-ID: <20230906122822.0ecef430@gandalf.local.home>
In-Reply-To: <e24daa53-d8c7-4c40-b04d-20b64ae220fa@sirena.org.uk>
References: <CA+G9fYuugZ0OMeS6HvpSS4nuf_A3s455ecipGBvER0LJHojKZg@mail.gmail.com>
        <ZPidKsNWH34Xt+r6@DESKTOP-4OLSCEK.>
        <e24daa53-d8c7-4c40-b04d-20b64ae220fa@sirena.org.uk>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 6 Sep 2023 17:02:19 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Sep 06, 2023 at 08:39:22AM -0700, Beau Belgrave wrote:
> 
> > What is the expected behavior of self tests if run without their
> > feature enabled? Is it expected these should skip vs fail in that case?  
> 
> Yes, tests should skip if preconditions for running them aren't met.

Yep, see how the ftrace selftests run. If it is determined that the feature
is not present, it simple returns UNSUPPORTED and not FAILED.

-- Steve
