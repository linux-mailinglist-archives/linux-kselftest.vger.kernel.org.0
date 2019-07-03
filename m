Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C315DFA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGCIUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 04:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfGCIUj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 04:20:39 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2B3218A3;
        Wed,  3 Jul 2019 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562142038;
        bh=M9Kh2ZvkJ9vu25atSN+BcI5yboMlIhTY1BxAY7FIEX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0z0Ly2Qb3lz9P+2mAWO/PWXzTbfxmz+1Eymx7NcmumF2QWEU6q+5PdT1tzXNZgsHk
         VxD72i1wyQhC4MTCuQ9vyH5wE4ZWYOe9LleONbDsp+3IXxdkQCpZL10HuxWFm1x6PH
         UCqxW9w2L9MJWLr0H3OyExDjavxVrpWq5PAgChGE=
Date:   Wed, 3 Jul 2019 17:20:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     shuah <shuah@kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not
 enabled
Message-Id: <20190703172033.7b575566e6e2f269bcc93cc5@kernel.org>
In-Reply-To: <20190702231808.36845f83@gandalf.local.home>
References: <20190702062358.7330-1-po-hsu.lin@canonical.com>
        <4a44dd22-be88-ce5b-5c9b-6a3759b6c2eb@kernel.org>
        <20190703091147.064029248fed5066ea5e5d2b@kernel.org>
        <20190702210730.2c041882@gandalf.local.home>
        <20190703120953.ba36c8f30a4fb6f62c18808f@kernel.org>
        <20190702231808.36845f83@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2 Jul 2019 23:18:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Jul 2019 12:09:53 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > Would something like that work?  
> > 
> > For older kernel, I think we'd better try to mount debugfs first.
> 
> Sure, that's pretty trivial to do. Or what I was thinking, try it if it
> fails:
> 
>  	if [ -z "$TRACING_DIR" ]; then
>  	  save_err=$err_ret
>  	  err_ret=$err_skip
> 	  if mount -t tracefs nodev /sys/kernel/tracing; then
>  	    TRACING_DIR="/sys/kernel/tracing"
> 	  elif mount -t debugfs nodev /sys/kernel/debug; then
>  	    TRACING_DIR="/sys/kernel/debug/tracing"
> 	  else
> 	    errexit "debugfs is not configured in this kernel"
> 	  fi
> 	  if [ ! -d "$TRACING_DIR" ]; then
> 	    errexit "ftrace is not configured in this kernel"
> 	  fi
>  	  err_ret=$save_err
>  	fi

This looks good to me :)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
