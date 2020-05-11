Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80B61CE57C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgEKU2p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 16:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKU2p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 16:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFC220661;
        Mon, 11 May 2020 20:28:43 +0000 (UTC)
Date:   Mon, 11 May 2020 16:28:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Masami Hiramatsu' <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
Message-ID: <20200511162842.7c198741@gandalf.local.home>
In-Reply-To: <f61eda03333941958d62f9df93ba534b@AcuMS.aculab.com>
References: <87imh21x6f.fsf@igel.home>
        <158920418730.16156.8299185499520876735.stgit@devnote2>
        <20200511223804.9483cab03c9221818ff4fc5b@kernel.org>
        <f61eda03333941958d62f9df93ba534b@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 May 2020 14:59:20 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > >      echo "Test command: $command"
> > >      echo > error_log
> > > -    (! echo "$command" >> "$3" ) 2> /dev/null
> > > +    (! printf "%s" "$command" >> "$3" ) 2> /dev/null  
> 
> WTF is the (! for ??
> The (...) is a subshell.
> And ! inverts the exit status.
> Neither is needed at all.

This is done because the scripts are run with '-e' and will exit the script
on any error.

This particular test is examining errors in the error log. The command
being written into $3 is going to fail, and return an exit code. The
"(! ..)" is needed, otherwise that failure will exit out the script.

-- Steve
