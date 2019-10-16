Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18965D94A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbfJPPBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 11:01:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388424AbfJPPBO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 11:01:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E36DB308;
        Wed, 16 Oct 2019 15:01:12 +0000 (UTC)
Date:   Wed, 16 Oct 2019 17:01:11 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
In-Reply-To: <20191016105814.2061a106@gandalf.local.home>
Message-ID: <alpine.LSU.2.21.1910161700450.7750@pobox.suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz> <20191016105814.2061a106@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Oct 2019, Steven Rostedt wrote:

> On Wed, 16 Oct 2019 13:33:12 +0200
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
> > Livepatch uses ftrace for redirection to new patched functions. It means
> > that if ftrace is disabled, all live patched functions are disabled as
> > well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
> > It is not a problem per se, because only administrator can set sysctl
> > values, but it still may be surprising.
> > 
> > Introduce PERMANENT ftrace_ops flag to amend this. If the
> > FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
> > disabled by disabling ftrace_enabled. Equally, a callback with the flag
> > set cannot be registered if ftrace_enabled is disabled.
> > 
> > v2->v3:
> > - ftrace_enabled explicitly set to true
> > - selftest from Joe Lawrence (I just split it to two patches)
> > - typo fix
> > 
> > v1->v2:
> > - different logic, proposed by Joe Lawrence
> > 
> > Joe Lawrence (2):
> >   selftests/livepatch: Make dynamic debug setup and restore generic
> >   selftests/livepatch: Test interaction with ftrace_enabled
> > 
> > Miroslav Benes (1):
> >   ftrace: Introduce PERMANENT ftrace_ops flag
> > 
> 
> Would you like me to take all three patches through my tree?

I think that would be the easiest, yes.

Thanks
Miroslav
