Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F135C425625
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbhJGPLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242271AbhJGPLF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F8A861139;
        Thu,  7 Oct 2021 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633619351;
        bh=u8X3FagrdJhU7I1VIDV1L7v9LQDZx07lRfeM+3Fv7Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zfIUU3NHUqm/lFCfrqnSsG7ZoqbIELwCdSBULRqAYNU6uoZaaMYxeqXuhdGD4egg7
         vtcM9dhf6XkTW4eFHiNn7+1MJuksq4+W4OtQOwlENmJJYge9ETpxq+C/MzxQFpfNGJ
         nWN1vfVA49D9+7HSX3Jp1FuI32wzJAcerPerCbsI=
Date:   Thu, 7 Oct 2021 17:09:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v3 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
Message-ID: <YV8NlXMJpVRcH42I@kroah.com>
References: <20211007150339.28910-1-andriy.shevchenko@linux.intel.com>
 <20211007150339.28910-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007150339.28910-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 06:03:34PM +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt cleaning it up by splitting out container_of() and
> typeof_member() macros.
> 
> For time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 
> Note, there are _a lot_ of headers and modules that include kernel.h solely
> for one of these macros and this allows to unburden compiler for the twisted
> inclusion paths and to make new code cleaner in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/container_of.h | 37 ++++++++++++++++++++++++++++++++++++
>  include/linux/kernel.h       | 31 +-----------------------------
>  include/linux/kobject.h      |  1 +

Why did you touch kobject.h here?

It shouldn't have been needed to change for this commit.

Anyway, I really don't think this is all worth any more work at all, as
I'm not going to be the one taking it...

thanks,

greg k-h
