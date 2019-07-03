Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8785DCCC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCDSM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 23:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfGCDSM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 23:18:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972CA206A2;
        Wed,  3 Jul 2019 03:18:10 +0000 (UTC)
Date:   Tue, 2 Jul 2019 23:18:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     shuah <shuah@kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not
 enabled
Message-ID: <20190702231808.36845f83@gandalf.local.home>
In-Reply-To: <20190703120953.ba36c8f30a4fb6f62c18808f@kernel.org>
References: <20190702062358.7330-1-po-hsu.lin@canonical.com>
        <4a44dd22-be88-ce5b-5c9b-6a3759b6c2eb@kernel.org>
        <20190703091147.064029248fed5066ea5e5d2b@kernel.org>
        <20190702210730.2c041882@gandalf.local.home>
        <20190703120953.ba36c8f30a4fb6f62c18808f@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 3 Jul 2019 12:09:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Would something like that work?  
> 
> For older kernel, I think we'd better try to mount debugfs first.

Sure, that's pretty trivial to do. Or what I was thinking, try it if it
fails:

 	if [ -z "$TRACING_DIR" ]; then
 	  save_err=$err_ret
 	  err_ret=$err_skip
	  if mount -t tracefs nodev /sys/kernel/tracing; then
 	    TRACING_DIR="/sys/kernel/tracing"
	  elif mount -t debugfs nodev /sys/kernel/debug; then
 	    TRACING_DIR="/sys/kernel/debug/tracing"
	  else
	    errexit "debugfs is not configured in this kernel"
	  fi
	  if [ ! -d "$TRACING_DIR" ]; then
	    errexit "ftrace is not configured in this kernel"
	  fi
 	  err_ret=$save_err
 	fi

-- Steve
