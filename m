Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5955166FF
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 May 2022 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbiEAS0Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 May 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356465AbiEAS0V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 May 2022 14:26:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195956F90;
        Sun,  1 May 2022 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsxRG+o5tCFQ9J2x/QjS5qnwU7KinLZIjT5m8zCRNvI=; b=iglSFNTl8xU8y6sJPUcWiF+8zA
        nFZr9469FlwEN2Q04GrInbny8Sk1c7BqVTRdk7FJEwOx4Yi4RLsmUeN3T2xRXTw5AUzSDcQIQdLvf
        CkxZwTnLDq7e2AlYl1dzNkIkNSIXVukLMcaeMR7/+m6matsNwqp8fXt/tLUoTm4OIC4gi/EkTvoo/
        dHJarYVn7yhFAbklYOsOpArsiFe2R5flgRyHTaNX7J4EZPEg3AaTfPu3k6dzjecDWzrpcJmtErwua
        vDAuzP+yTIOW/SEf9/63Fmd9fEVhXeUyJLUZM5GOrsmVwlFMEW1vBYAzIWuqmlE/kBO/i4P8lNzxN
        Vz+uQJmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlEDO-00Gh3W-4i; Sun, 01 May 2022 18:22:38 +0000
Date:   Sun, 1 May 2022 11:22:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
Message-ID: <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220430030019.803481-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430030019.803481-1-davidgow@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

There is no reason to distinguish kunit from selftests if the result is
the same: really make the kernel try really insane stupid things which
may crash it or put it into a bad state.

So no, this should be renamed to "TEST_BREAK" as I think outside of
selftest and kunit we may grow the kernel to do stupid things outside
of that domain and this gives us the flexilibilty to use that in other
places as well.

It begs the question if we *should* allow userspace to volunterally say
"hey, we are doing really insane things, brace yourself." Why ? Well
because selftest has tons of modules. We either then define a macro
that adds the taint for them and wrap the module declaration for it,
or we expose a syctl to let userspace volunteer to opt-in to seggest
we are about to try something stupid with the kernel including loading
some dangeerous modules which may not have macros which taint the kernel.
That would let selftest taint on *any* selftest. Because we can run all
selftests or run one selftest.

Then, if such sysctl is exposed, maybe we should then also use this for
example for blktests, fstests, fio tests, etc.

  Luis
