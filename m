Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1B432BB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJSCSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 22:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJSCSv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 22:18:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8549E6103B;
        Tue, 19 Oct 2021 02:16:38 +0000 (UTC)
Date:   Mon, 18 Oct 2021 22:16:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     <mingo@redhat.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kselftests: ftrace: limit the executing time by reading
 from cached trace
Message-ID: <20211018221636.47157e52@gandalf.local.home>
In-Reply-To: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
References: <20211018132616.2234853-1-lizhijian@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 18 Oct 2021 21:26:16 +0800
Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> LKP/0day observed that kselftests/ftrace cannot finish within 1 hour on
> a 96 cpus platform where it hangs in the line like:
> 'cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l'
> subsystem-enable.tc
> 
> It seems that trace will keep growing during it's read by 'cat' command.
> Consequently, trace becomes too large to finish reading.
> 
> replace 'cat trace' by:
> $ sed -i 's/cat trace |/read_cached_trace |/g' $(find test.d -name "*.tc")
> 

Instead, what happens if you add this command to each test?

if [ -t options/pause-on-trace ]; then
   echo 1 > options/pause-on-trace
fi

We also need to add to the "initialize_ftrace" function in test.d/functions.

if [ -t options/pause-on-trace ]; then
   echo 0 > options/pause-on-trace
fi

-- Steve

> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
