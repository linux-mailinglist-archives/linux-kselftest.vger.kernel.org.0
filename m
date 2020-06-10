Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB88C1F4D5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 07:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFJFzl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 01:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgFJFzl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 01:55:41 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A04F20801;
        Wed, 10 Jun 2020 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591768540;
        bh=KFffeQlQ3ejoQDHl0mCIa2lYqP0RiWorWvUaxswIW9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rUGUJLhyoLvwurOS7cz8gdKKAp8OaIfDHLD3MKIDds/02BpPCD4j+EIy28CwetAyO
         AlZQVFhbWpIGJuEhX966JZM1t6jbGEjG3sHIE5zl6v48c3zQA8wvNZ/dcONAnmeumI
         FGetIYKDbX9/uyic8tbYAVM1tdjKVWVsYELd4MjY=
Date:   Wed, 10 Jun 2020 14:55:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
Message-Id: <20200610145535.747d2765d60e6e3923441768@kernel.org>
In-Reply-To: <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
        <159115203782.70027.2241223276591824366.stgit@devnote2>
        <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Tue, 9 Jun 2020 14:41:27 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 6/2/20 8:40 PM, Masami Hiramatsu wrote:
> > Convert the required tracefs interface checking code with
> > requires: list.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >    Changes in v2: Fix trigger-onchange-action-hist.tc requires list.
> 
> Masami,
> 
> This patch doesn't apply to linux-kselftest next
> 
> Patches 1-3 applied fine and this one failed. For now I will
> hold off on applying this series.

Yes, there is another patch posted by Tom with his ftrace enhancement
in tracing-next. Thus I commented on 0/7 as below.

----
Since this series depends on following 2 commits,

commit 619ee76f5c9f ("selftests/ftrace: Return unsupported if no
 error_log file") on Shuah's Kselftest tree
commit bea24f766efc ("selftests/ftrace: Distinguish between hist
 and synthetic event checks") on Steven's Tracing tree

This can be applied on the tree which merged both of them.
----

I'm not sure how do I handle it. It is OK just modifying this
for linux-kselftest, but in that case we will need another
patch after merged both.

IMHO, since the kselftest must run correctly on older kernel,
(and ftracetest does) Tom's kselftest patch should be merged
into linux-kselftest instead of tracing tree.

Steve, what would you think?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
