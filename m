Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F63F2DC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhHTOOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 10:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235032AbhHTOOD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 10:14:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35874601FD;
        Fri, 20 Aug 2021 14:13:25 +0000 (UTC)
Date:   Fri, 20 Aug 2021 10:13:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 5/5] selftests/ftrace: Add selftest for testing
 duplicate eprobes and kprobes
Message-ID: <20210820101318.542d5cc2@oasis.local.home>
In-Reply-To: <20210820095359.f99a6cecb9886d8809685465@kernel.org>
References: <20210819152604.704335282@goodmis.org>
        <20210819152825.715290342@goodmis.org>
        <20210820095359.f99a6cecb9886d8809685465@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 20 Aug 2021 09:53:59 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, can you also remove kprobe event dependency from this test case?
> The event probe depends on CONFIG_PROBE_EVENTS meta config, but that
> is enabled both of CONFIG_KPROBE_EVENTS and CONFIG_UPROBE_EVENTS.
> This means if the kernel configs CONFIG_KPROBE_EVENTS=n and
> CONFIG_UPROBE_EVENTS=y, this will be executed but should fail.

I'll add a check if kprobes are available before testing the kprobes.

-- Steve
