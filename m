Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACB10A36B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 18:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfKZRhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 12:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfKZRhf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 12:37:35 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF322073F;
        Tue, 26 Nov 2019 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574789854;
        bh=sDTX7GDoGbVX388dHhgwDXN7/ruhMXRdtOA8iSNG1wQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O600EPpGdAddvGuKbUD5JjHdBCgGXOpC+eH1DULKr20sgwas7DWMhIjrYaejmydIW
         mpZdLae8B/Xe1VuV7ctAliprtjd96zpajK8BbAjDTIBGLagPj2viynWo7FWTOypN6t
         HtjpIf5dQF1ajKBXcC+7cXUYl3heWmLk8GWnMbQU=
Subject: Re: [BUGFIX PATCH v4 0/4] selftests/ftrace: Fix ftracetest testcases
 for non-function tracer case
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
From:   shuah <shuah@kernel.org>
Message-ID: <6e05af26-584e-3f03-c63f-b2603a5a9620@kernel.org>
Date:   Tue, 26 Nov 2019 10:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157475724667.3389.15752644047898709246.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/19 1:34 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Here is the 4th version of patches to fix some issues which happens on
> the kernel with CONFIG_FUNCTION_TRACER=n or CONFIG_DYNAMIC_FTRACE=n.
> 
> In this version I fixed [1/4] to cleanup set_ftrace_notrace (Thanks Steve!)
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>        selftests/ftrace: Fix to check the existence of set_ftrace_filter
>        selftests/ftrace: Fix ftrace test cases to check unsupported
>        selftests/ftrace: Do not to use absolute debugfs path
>        selftests/ftrace: Fix multiple kprobe testcase
> 
> 
>   .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
>   .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
>   tools/testing/selftests/ftrace/test.d/functions    |    5 ++++-
>   .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    6 +++---
>   .../inter-event/trigger-action-hist-xfail.tc       |    4 ++--
>   .../inter-event/trigger-onchange-action-hist.tc    |    2 +-
>   .../inter-event/trigger-snapshot-action-hist.tc    |    4 ++--
>   7 files changed, 19 insertions(+), 9 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

Hi Masami and Steve,

Thanks. I will pull these in for 5.5-rc1

-- Shuah
