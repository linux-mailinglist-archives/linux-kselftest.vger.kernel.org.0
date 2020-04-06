Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB61519F6D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Apr 2020 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDFNXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 09:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgDFNXL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 09:23:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC9323109;
        Mon,  6 Apr 2020 13:23:09 +0000 (UTC)
Date:   Mon, 6 Apr 2020 09:23:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <shuah@kernel.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, <mingo@redhat.com>,
        <ice_yangxiao@163.com>, <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Add CONFIG_SAMPLE_FTRACE_DIRECT=m
 kconfig
Message-ID: <20200406092306.7ea72524@gandalf.local.home>
In-Reply-To: <20200405014457.8854-1-yangx.jy@cn.fujitsu.com>
References: <20200405014457.8854-1-yangx.jy@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 5 Apr 2020 09:44:57 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> ftrace-direct.tc and kprobe-direct.tc require CONFIG_SAMPLE_FTRACE_DIRECT=m
> so add it to config file which is used by merge_config.sh.


Shuah,

Care to take this in your tree?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tools/testing/selftests/ftrace/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
> index c2c8de4fafff..e59d985eeff0 100644
> --- a/tools/testing/selftests/ftrace/config
> +++ b/tools/testing/selftests/ftrace/config
> @@ -11,5 +11,6 @@ CONFIG_PREEMPTIRQ_DELAY_TEST=m
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_SAMPLES=y
> +CONFIG_SAMPLE_FTRACE_DIRECT=m
>  CONFIG_SAMPLE_TRACE_PRINTK=m
>  CONFIG_KALLSYMS_ALL=y

