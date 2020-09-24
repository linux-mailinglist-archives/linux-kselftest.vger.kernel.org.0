Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293F7277379
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIXOAb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgIXOAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 10:00:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3852C0613CE;
        Thu, 24 Sep 2020 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qIgj7Hl/mK3z08IlAa0KO02ef5f7Ktvw+3PqNseFblg=; b=FWvDvV70XJ5TuIqo2IUFpsddid
        4bpADJ7rTnH62tcaWl9Sq1nKrU4IyHE+KamW32gcBG4U1bzjOm5PtJySQLChaW8M6gY0LPSZ0coze
        LM8z4wCOv8Zpa8kvOxn1wyatKvQIhtPRU/Hs/NVZEUFjJJAFBuHUhGS5qawq1Mczd1ftu3YW+tFeL
        864SUTdfJvJxMMEpGydt5PyuVqcKJrHbgH14qXZByDkv8OO5fNrYni6b3K9R/ee4jMHnkkzXQQV9/
        BRWBg4IMjdDnVRLswoFywsUZ67wWYEw3e8p0FgYYSgFQZ7Vdbv5Uwu9sd+jK1xsAmMGJgWdEn9nM/
        1agEj31w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLRnN-0002LE-D2; Thu, 24 Sep 2020 14:00:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C89D13003E5;
        Thu, 24 Sep 2020 16:00:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B53EE2023C925; Thu, 24 Sep 2020 16:00:23 +0200 (CEST)
Date:   Thu, 24 Sep 2020 16:00:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Message-ID: <20200924140023.GO2628@hirez.programming.kicks-ass.net>
References: <20200923233618.2572849-1-posk@google.com>
 <1693241031.67909.1600955503870.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693241031.67909.1600955503870.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 24, 2020 at 09:51:43AM -0400, Mathieu Desnoyers wrote:
> 
> 
> ----- On Sep 23, 2020, at 7:36 PM, Peter Oskolkov posk@google.com wrote:
> 
> > This patchset is based on Google-internal RSEQ
> > work done by Paul Turner and Andrew Hunter.
> > 
> > When working with per-CPU RSEQ-based memory allocations,
> > it is sometimes important to make sure that a global
> > memory location is no longer accessed from RSEQ critical
> > sections. For example, there can be two per-CPU lists,
> > one is "active" and accessed per-CPU, while another one
> > is inactive and worked on asynchronously "off CPU" (e.g.
> > garbage collection is performed). Then at some point
> > the two lists are swapped, and a fast RCU-like mechanism
> > is required to make sure that the previously active
> > list is no longer accessed.
> > 
> > This patch introduces such a mechanism: in short,
> > membarrier() syscall issues an IPI to a CPU, restarting
> > a potentially active RSEQ critical section on the CPU.
> > 
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!, I've queued them in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core

please double check the Subject/Changelog edits I made. Once all the
robots are green, I'll push out the lot to -tip.
