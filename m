Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A340943B549
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhJZPSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 11:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhJZPSx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 11:18:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2CE6023D;
        Tue, 26 Oct 2021 15:16:28 +0000 (UTC)
Date:   Tue, 26 Oct 2021 11:16:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-ID: <20211026111626.73e9eb9c@gandalf.local.home>
In-Reply-To: <20211026231314.1b5c1f378f9c5410b01a2d85@kernel.org>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
        <20211018221636.47157e52@gandalf.local.home>
        <20211020112027.b01762f2adcfac99e71dcf99@kernel.org>
        <20211019223454.5da09d74@gandalf.local.home>
        <20211020115522.75f3e25247c1d30726e9b130@kernel.org>
        <20211020101659.42360147@gandalf.local.home>
        <20211021093131.affc348280aba040f76f769e@kernel.org>
        <20211025221717.56daf4e8@rorschach.local.home>
        <20211026211331.8496340b0011127e6505b5ff@kernel.org>
        <20211026091534.4ef376e0@gandalf.local.home>
        <20211026231314.1b5c1f378f9c5410b01a2d85@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Oct 2021 23:13:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> >From e6ab7217c8f50dabee0f565764489fdd32e1ff07 Mon Sep 17 00:00:00 2001  
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Wed, 20 Oct 2021 11:55:22 +0900
> Subject: [PATCH v2] selftests/ftrace: Stop tracing while reading the trace file
>  by default
> 
> Stop tracing while reading the trace file by default, to prevent
> the test results while checking it and to avoid taking a long time
> to check the result.
> If there is any testcase which wants to test the tracing while reading
> the trace file, please override this setting inside the test case.
> 
> This also recovers the pause-on-trace when clean it up.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Looks good. Can you resend this as a standalone patch, so that it triggers
my patchwork?

-- Steve
