Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660971CDC7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgEKOFK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 10:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbgEKOFK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 10:05:10 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 262C2206D3;
        Mon, 11 May 2020 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589205909;
        bh=7SgyhWGUh0wPIruatp/c7gv8B3mqcIESafxuZRcMzAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mZfdeT4pv3a87d9jWl5oRq9uHnvxVqpOd/zSzNZzrTDzLKVQDCWzPsLqLPxn+kmcC
         N87UWjiBYCpLpExWAR7KCahCh3bzGcfBn/w7McUr/M6lL8sgGA+FWVXtC6EaaN/DSe
         sWWPz+15o2Hcmm8wGCNOQ+phQiwOuGlT+7rMMcuo=
Date:   Mon, 11 May 2020 23:05:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
Message-Id: <20200511230505.dc343ffa6ede2b45322e3965@kernel.org>
In-Reply-To: <bfac765efd7a4f87815460b7fa40152d@AcuMS.aculab.com>
References: <87imh21x6f.fsf@igel.home>
        <158920418730.16156.8299185499520876735.stgit@devnote2>
        <20200511223804.9483cab03c9221818ff4fc5b@kernel.org>
        <bfac765efd7a4f87815460b7fa40152d@AcuMS.aculab.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 May 2020 13:46:35 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Masami Hiramatsu
> > Sent: 11 May 2020 14:38
> > 
> > Hi Andreas and David,
> > 
> > OK, what about this fix?
> 
> No idea what it is trying to do or why.
> Just a way of avoiding the differences between SYSV and BSD /bin/echo.
> 
> IIRC Posix allows both behaviours (and probably others).

Ah, I got it. That's why POSIX said "the results are implementation-defined."

https://pubs.opengroup.org/onlinepubs/009695399/utilities/echo.html

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
