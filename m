Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455501C753D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEFPny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 11:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbgEFPny (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 11:43:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441E6206D5;
        Wed,  6 May 2020 15:43:53 +0000 (UTC)
Date:   Wed, 6 May 2020 11:43:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>, joel@joelfernandes.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
Message-ID: <20200506114351.1b45e82f@gandalf.local.home>
In-Reply-To: <CAMy_GT8r8H21Ly3N5VFkiPi0qUCkPCvy8SU3Ns2vesaS8xvffQ@mail.gmail.com>
References: <20200505101445.27063-1-po-hsu.lin@canonical.com>
        <20200505090912.7114f420@gandalf.local.home>
        <CAMy_GT8r8H21Ly3N5VFkiPi0qUCkPCvy8SU3Ns2vesaS8xvffQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 6 May 2020 09:46:21 +0800
Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> On Tue, May 5, 2020 at 9:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > You keep forgetting to Cc Shuah's other email.  
> Thanks!
> I got the recipients list from the get_mainter.pl.

Hmm.

Seems like that is what get_maintainer.pl does:

Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
Ingo Molnar <mingo@redhat.com> (maintainer:TRACING)
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
linux-kernel@vger.kernel.org (open list)

And looking at the code, it appears it will only take the first email
address found in the file.

Shuah, if you prefer the linuxfoundation.org email, you need to update
MAINTAINERS file to have that one first.

-- Steve
