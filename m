Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A294320F60
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Feb 2021 03:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBVC0p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 21:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBVC0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 21:26:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713C3C061574;
        Sun, 21 Feb 2021 18:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SgDyTF6te7DXNOCVKjo1ENIP+yb2tE5tKrG6fzvV48A=; b=d3gAn8tmpmoO8+BYMVc8MSNBlO
        ptbHm8IWEbjsn3ShJKhmDjLA9bXZ05G2jAq0fh2z0YEskL/Nv7PmKahwIf8QctnTzKCOcINUN781f
        YsMy3YsCBlksoJsfNFd6q7HaT7O9rU2nHws4oEfKzPkzZ9I6NCc21KlZ2cZvy7qgmsRvTP1S8inb0
        g2mAKWcegynrKxMPN7OFRWe/WJmZV1V0Jq1/rvKLWwHTS3X8Y5PcdUyxnTF1o8aYvshT+LX1CG3/w
        +aNbFoLERm3Gv7OEMzcgI9SWYCTdgVcyXh+PccTtacBFPowiQPH3T4sBREoqXtF3z8yyMGbfwLSmM
        NdOLpk9w==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE0v6-0000iD-Vd; Mon, 22 Feb 2021 02:25:57 +0000
Subject: Re: [PATCH v3 3/8] securtiy/brute: Detect a brute force attack
To:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20210221154919.68050-1-john.wood@gmx.com>
 <20210221154919.68050-4-john.wood@gmx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <085f8f05-243e-fbf0-3f9c-ea011511a296@infradead.org>
Date:   Sun, 21 Feb 2021 18:25:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210221154919.68050-4-john.wood@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi--

On 2/21/21 7:49 AM, John Wood wrote:
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/brute/brute.c | 488 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 474 insertions(+), 14 deletions(-)
> 
> diff --git a/security/brute/brute.c b/security/brute/brute.c
> index 70f812bb7763..645bd6e02638 100644
> --- a/security/brute/brute.c
> +++ b/security/brute/brute.c


> +/**
> + * print_fork_attack_running() - Warn about a fork brute force attack.
> + */
> +static inline void print_fork_attack_running(void)
> +{
> +	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
> +}

Do these pr_warn() calls need to be rate-limited so that they don't
flood the kernel log?


> +/**
> + * print_exec_attack_running() - Warn about an exec brute force attack.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * Before showing the process name it is mandatory to find a process that holds
> + * a pointer to the exec statistics.
> + *
> + * Context: Must be called with tasklist_lock and brute_stats_ptr_lock held.
> + */
> +static void print_exec_attack_running(const struct brute_stats *stats)
> +{
> +	struct task_struct *p;
> +	struct brute_stats **p_stats;
> +	bool found = false;
> +
> +	for_each_process(p) {
> +		p_stats = brute_stats_ptr(p);
> +		if (*p_stats == stats) {
> +			found = true;
> +			break;
> +		}
>  	}
> +
> +	if (WARN(!found, "No exec process\n"))
> +		return;
> +
> +	pr_warn("Exec brute force attack detected [%s]\n", p->comm);
> +}


thanks.
-- 
~Randy

