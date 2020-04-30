Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567CC1BEE01
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Apr 2020 04:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD3CEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Apr 2020 22:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgD3CEl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Apr 2020 22:04:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 097D920757;
        Thu, 30 Apr 2020 02:04:39 +0000 (UTC)
Date:   Wed, 29 Apr 2020 22:04:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, mingo@redhat.com,
        shuah <shuah@kernel.org>, Colin King <colin.king@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: treat module requirement unmet
 situation as unsupported
Message-ID: <20200429220438.3a7bbc17@gandalf.local.home>
In-Reply-To: <CAMy_GT88BD6Ty9=gtqhsm2UPf8aX-=SHZrWj_-UZJONnk73+nQ@mail.gmail.com>
References: <20200429095044.24625-1-po-hsu.lin@canonical.com>
        <20200429122855.02594f33@gandalf.local.home>
        <CAMy_GT88BD6Ty9=gtqhsm2UPf8aX-=SHZrWj_-UZJONnk73+nQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Apr 2020 09:46:36 +0800
Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> > I'm fine with these changes if Masami is. But it is Masami's call as his
> > infrastructure is more sensitive to the return calls than mine. I just run
> > the test and see what passes. I don't actually look at the return codes.  
> Another thing to note is that this will also change the "# of
> unresolved" and "# of unsupported" in the summary at the end of the
> test report.

Understood. In my testing, I have all the modules enabled so I don't worry
about it ;-)

-- Steve
