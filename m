Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA37628E79B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJNUAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 16:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNUAD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 16:00:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84265C061755;
        Wed, 14 Oct 2020 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dBOYMLQQlx6kYOwTChDpfwiT4F6gbGW7SjYy3hlDmqI=; b=GgyKcWz5leHygg4kK7woUaWtj1
        fOgwoaMk9of07DvgpbLTw5a9s7c6HlXJXaKsm+VoT+L9yG1ZDum6iwHXCX4dRtM36x1EteAVeJGYS
        wbTMPw4GfHYc+T8kxVvk5KXO+AN6qLM9Q5gcSkT9k3FiWgMUz7O4usJqTkaTtQ+82R6KKoV/C+NQP
        Q0IznlIbhkht1EtekWFMVzJbx+q+NtuWoMpwpAXihsvpSRF6BHn3bAQZKZLvH2lfYc/jgY49EChTc
        N76u96GbNxWc+J6DKthDv3KaUGz4sH3Q7PjhKns2jC3URthZKv2RSm3/5weo+0VWhGElRb1zR1ipf
        88j7zmjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSmw9-0002gi-CM; Wed, 14 Oct 2020 19:59:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0682E980F54; Wed, 14 Oct 2020 21:59:49 +0200 (CEST)
Date:   Wed, 14 Oct 2020 21:59:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
Message-ID: <20201014195948.GE2974@worktop.programming.kicks-ass.net>
References: <20200729201146.537433-1-vitor@massaru.org>
 <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
 <20200804132517.GK2657@hirez.programming.kicks-ass.net>
 <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
 <20200804142344.GM2674@hirez.programming.kicks-ass.net>
 <CADQ6JjWbCsyWxZKQ5=kkxx8hkaW=mbCjDodPXDAv5vH-=tVvEQ@mail.gmail.com>
 <CAFd5g46DzWRzp9yXkpHbtyJuv236E=z7OaWeqXnfuiy6CTBL4A@mail.gmail.com>
 <CAP-5=fXhFG9sTMcfd1qJmMDNJWqOGky=jFtWNWg8U8-dkRp=dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXhFG9sTMcfd1qJmMDNJWqOGky=jFtWNWg8U8-dkRp=dQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 14, 2020 at 11:16:10AM -0700, Ian Rogers wrote:

> There were some issues in the original patch, they should be easy to
> fix. I'm more concerned that Peter's issues are addressed about the
> general direction of the patch, verbosity and testing frameworks. I
> see Vitor followed up with Peter but I'm not sure that means the
> approach has been accepted.

I kinda lost track, as long as it doesn't get more verbose I suppose I'm
fine.
