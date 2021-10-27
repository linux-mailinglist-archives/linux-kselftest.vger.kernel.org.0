Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FDC43D660
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 00:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhJ0WPt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 18:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJ0WPt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 18:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45FD860EFE;
        Wed, 27 Oct 2021 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635372803;
        bh=Qusou+GTSRWee2wKlxAwgNDheywqVp69l4gLDXw9uj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIhLgQ17rx0gtZdAOFcI636rtClyZ9Hpe4HlkQJ9q4YUkgBx89pNPBjB72Thz/KqH
         f9gtqZcBFR0Rvsz/n7+WudLHNo5RoBVXRdBqrvsfgO2fG9+D/fXQaKi93DQp+HKjjs
         ek0rxdT3K4MG3eGBS4g1DQTI2fBlsbeYD8+/FtNllj554LwxNtb5irENhGYh6lvIGo
         iYy0VGj7o5d5r84vGP2SV5rV1pZAVs8hPSkKf1FkjqMjXJAt5XlguMkNr2hg2j+Zgu
         xg1825g+bz4w17Drr3ZtlTCYfXS1AgA3cYT+jCuapVXxW0ZLMLksl+YIR6XdBXY4fX
         U0hJdp7kpfS9Q==
Date:   Thu, 28 Oct 2021 07:13:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing/histogram: Document hist trigger variables
Message-Id: <20211028071319.44e3e885352866713dd08046@kernel.org>
In-Reply-To: <20211027205919.1648553-2-kaleshsingh@google.com>
References: <20211027205919.1648553-1-kaleshsingh@google.com>
        <20211027205919.1648553-2-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 Oct 2021 13:59:08 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Update the tracefs README to describe how hist trigger variables
> can be created.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/trace.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bc677cd64224..c41b3786401d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5628,6 +5628,7 @@ static const char readme_msg[] =
>  #ifdef CONFIG_HIST_TRIGGERS
>  	"      hist trigger\t- If set, event hits are aggregated into a hash table\n"
>  	"\t    Format: hist:keys=<field1[,field2,...]>\n"
> +	"\t            [:<var1>=<field|var_ref|numeric_literal>[,<var2>=...]]\n"
>  	"\t            [:values=<field1[,field2,...]>]\n"
>  	"\t            [:sort=<field1[,field2,...]>]\n"
>  	"\t            [:size=#entries]\n"
> @@ -5639,6 +5640,16 @@ static const char readme_msg[] =
>  	"\t            common_timestamp - to record current timestamp\n"
>  	"\t            common_cpu - to record the CPU the event happened on\n"
>  	"\n"
> +	"\t    A hist trigger variable can be:\n"
> +	"\t        - a reference to a field e.g. x=current_timestamp,\n"
> +	"\t        - a reference to another variable e.g. y=$x,\n"
> +	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
> +	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
> +	"\n"
> +	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
> +	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
> +	"\t    variable reference, field or numeric literal.\n"
> +	"\n"
>  	"\t    When a matching event is hit, an entry is added to a hash\n"
>  	"\t    table using the key(s) and value(s) named, and the value of a\n"
>  	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
