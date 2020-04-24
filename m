Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0D1B77BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgDXOBs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 10:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgDXOBs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 10:01:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE74B2075A;
        Fri, 24 Apr 2020 14:01:47 +0000 (UTC)
Date:   Fri, 24 Apr 2020 10:01:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     <joel@joelfernandes.org>, <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>,
        Xiao Yang <ice_yangxiao@163.com>
Subject: Re: preemptirq_delay_test module can trigger crash on arm64 vm
Message-ID: <20200424100146.786bcd7f@gandalf.local.home>
In-Reply-To: <5EA2B0C8.2080706@cn.fujitsu.com>
References: <5EA2B0C8.2080706@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 24 Apr 2020 17:26:32 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Hi Steve, Joel
> 
> Sorry to bother you.
> 
> On my slow arm64 vm, inserting and removing preemptirq_delay_test module
> in loops triggers kernel panic sometimes.
> 
> Reproduce steps:
> Do the following steps in loops(more than 10 times):
> [root@CentOS81-aarch64 ]# modprobe preemptirq_delay_test
> test_mode=preempt delay=500000; rmmod preemptirq_delay_test
> 
>

Joel,

I never did really look at that module, but doing a quick scan, I see you
never clean up the task you start.

Which means, you can remove the module and the task still exists, and when
it runs, it will execute code that has been freed.

The module exit should still do a kthread_stop() on it. If anything, it
will prevent the task existing after the module is removed.

-- Steve
