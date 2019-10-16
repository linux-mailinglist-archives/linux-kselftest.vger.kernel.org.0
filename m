Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41736D948C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfJPO6T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 10:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404400AbfJPO6R (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 10:58:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62DE121A49;
        Wed, 16 Oct 2019 14:58:16 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:58:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191016105814.2061a106@gandalf.local.home>
In-Reply-To: <20191016113316.13415-1-mbenes@suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Oct 2019 13:33:12 +0200
Miroslav Benes <mbenes@suse.cz> wrote:

> Livepatch uses ftrace for redirection to new patched functions. It means
> that if ftrace is disabled, all live patched functions are disabled as
> well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
> It is not a problem per se, because only administrator can set sysctl
> values, but it still may be surprising.
> 
> Introduce PERMANENT ftrace_ops flag to amend this. If the
> FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
> disabled by disabling ftrace_enabled. Equally, a callback with the flag
> set cannot be registered if ftrace_enabled is disabled.
> 
> v2->v3:
> - ftrace_enabled explicitly set to true
> - selftest from Joe Lawrence (I just split it to two patches)
> - typo fix
> 
> v1->v2:
> - different logic, proposed by Joe Lawrence
> 
> Joe Lawrence (2):
>   selftests/livepatch: Make dynamic debug setup and restore generic
>   selftests/livepatch: Test interaction with ftrace_enabled
> 
> Miroslav Benes (1):
>   ftrace: Introduce PERMANENT ftrace_ops flag
> 

Would you like me to take all three patches through my tree?

-- Steve
