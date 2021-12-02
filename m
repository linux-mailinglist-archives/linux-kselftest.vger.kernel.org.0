Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4B466D5B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 23:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhLBXAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 18:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbhLBXAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 18:00:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7AC06174A;
        Thu,  2 Dec 2021 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jimhSqp4ui/rEJFWw/TifB3e5eXU06bdFyt7nU5nKTE=; b=mwh3+s7+fsAReiSF8tnvnUGhKG
        ETaJwBnnXSeAic5naongGgL8r+yzXJhA8o3hyG1nXXLRieznY8KYWFc8w8yXbIuWUKW2RZWCF4jC2
        Eu23Pct0FY/6OBTWcZabScASYr+SJwpc2hb4LFFMpvBA+FKFpXh19tukcjJj57UnQMXXP3ggCEMCK
        NnXTLCwXsyaM77D1TF2UuYLnWFmdZYsQM0ZvJAJNToyl6YBoOhq8Ij/AW54DD+ZWSWinwmsdJj7L2
        4eKHZ7yCNP06enGlESvgOAnmuZ5AEmqbTR8FxKdRGR7+f4h8tQfvaI2FoB5eEOJyOPSKeDDHxX4gB
        1IPVNyQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msv0q-005ygo-Pv; Thu, 02 Dec 2021 22:57:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC23B9810D4; Thu,  2 Dec 2021 23:57:12 +0100 (CET)
Date:   Thu, 2 Dec 2021 23:57:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, open list <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: Re: ww_mutex.sh hangs since v5.16-rc1
Message-ID: <20211202225712.GG16608@worktop.programming.kicks-ass.net>
References: <895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 01, 2021 at 09:26:18AM +0800, Li Zhijian wrote:
> Hi Folks
> 
> 
> LKP/0Day found that ww_mutex.sh cannot complete since v5.16-rc1, but
> I'm pretty sorry that we failed to bisect the FBC, instead, the bisection pointed
> to a/below merge commit(91e1c99e17) finally.
> 
> Due to this hang, other tests in the same group are also blocked in 0Day, we
> hope we can fix this hang ASAP.
> 
> So if you have any idea about this, or need more debug information, feel free to let me know :)
> 
> BTW, ww_mutex.sh was failed in v5.15 without hang, and looks it cannot reproduce on a vm.

On real hardware:

root@ivb-ep:/usr/src/linux-2.6/tools/testing/selftests/locking# uname -a
Linux ivb-ep 5.16.0-rc3-00284-g68601c558556 #1 SMP PREEMPT Thu Dec 2 23:03:29 CET 2021 x86_64 GNU/Linux
root@ivb-ep:/usr/src/linux-2.6/tools/testing/selftests/locking# ./ww_mutex.sh
locking/ww_mutex: ok

[ 1907.907801] Beginning ww mutex selftests
[ 1915.700077] All ww mutex selftests passed


What else do I try?
