Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1D2EAFF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jan 2021 17:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAEQWp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 11:22:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:44032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAEQWo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 11:22:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609863718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAZnmja/35ubIGv8myiWVL1zjOD22NksoZUG90z16ZY=;
        b=N5lSNrvfp+JEwbplJF7qFGUjWCDyY4Qh9sL32Lw+RMPhqI0WISPiGFXtHtOv5vmR04eecj
        rk+Q+Wx+JGKu1AUhv3t39I4jV0Z1JJEvFBbYleYUXQjHQf/oKvxG3SuNY/muvcvATPzMjg
        95AAwUghundkS4Y0hczvUEy1aKHNz0o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1DD4AF7B;
        Tue,  5 Jan 2021 16:21:57 +0000 (UTC)
Date:   Tue, 5 Jan 2021 17:21:57 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
Message-ID: <X/SSJQ+I5zEMaYYJ@alley>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
> > On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
> > > kunit_tool relies on the UML console outputting printk() output to the
> > > tty in order to get results. Since the default console driver could
> > > change, pass 'console=tty' to the kernel.
> > > 
> > > This is triggered by a change[1] to use ttynull as a fallback console
> > > driver which -- by chance or by design -- seems to have changed the
> > > default console output on UML, breaking kunit_tool. While this may be
> > > fixed, we should be less fragile to such changes in the default.
> > > 
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
> > 
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> 
> Thank you all. Now in linux-kselftest kunit-fixes branch.
> 
> Will send this up for rc3.
> 
> Sorry for the delay - have been away from the keyboard for a
> bit.

JFYI, I am not sure that this is the right solution. I am
looking into it, see
https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
for more details.

Best Regards,
Petr
