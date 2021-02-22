Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3E320F6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Feb 2021 03:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBVCa7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 21:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhBVCa7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 21:30:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81EC061574;
        Sun, 21 Feb 2021 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FxtaJxHYxh45JP8CGcyZZ3iN6KsOnhwHVasM+q0hz4E=; b=0yFtlVmfnjyQi9y36fryboiiNq
        r0ZlCmpgoi6iKlEKoseouKm0RcbeN9vjcUULuGsz9Yr/bHfvMKEE7L4ySRAQpxQKe5DG9WmyZRLGh
        toFArWcpzK9Pgi+/HMIhZcAL0ZFpu1trhsq+aCwjKTuANK/ArzL8xnfPpVQT7wsW5/02CyqGtGRWS
        RvsS2Px570Tn/AP4ktfxfZk+EVwhqgFZytnNKCAyGWJZ0nPEYaYAKXTBZzLtYgKfAFur2CNKIF/+A
        KNUsXJGJ+s90bFSwJrcwz3IYPv11d6XoK1ApDTtr8QGheQzxlEmD3k0Da18KkkepzNa46DPay8K/2
        ma5b4DgQ==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE0zH-0000q3-U0; Mon, 22 Feb 2021 02:30:16 +0000
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
Message-ID: <4fde79a5-34fe-fd27-b390-e9fd341996fb@infradead.org>
Date:   Sun, 21 Feb 2021 18:30:10 -0800
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

Hi,

one spello in 2 locations:

On 2/21/21 7:49 AM, John Wood wrote:
> To detect a brute force attack it is necessary that the statistics
> shared by all the fork hierarchy processes be updated in every fatal
> crash and the most important data to update is the application crash
> period. To do so, use the new "task_fatal_signal" LSM hook added in a
> previous step.
> 
> The application crash period must be a value that is not prone to change
> due to spurious data and follows the real crash period. So, to compute
> it, the exponential moving average (EMA) is used.
> 
> There are two types of brute force attacks that need to be detected. The
> first one is an attack that happens through the fork system call and the
> second one is an attack that happens through the execve system call. The
> first type uses the statistics shared by all the fork hierarchy
> processes, but the second type cannot use this statistical data due to
> these statistics dissapear when the involved tasks finished. In this

                   disappear

> last scenario the attack info should be tracked by the statistics of a
> higher fork hierarchy (the hierarchy that contains the process that
> forks before the execve system call).
> 
> Moreover, these two attack types have two variants. A slow brute force
> attack that is detected if the maximum number of faults per fork
> hierarchy is reached and a fast brute force attack that is detected if
> the application crash period falls below a certain threshold.
> 
> Also, this patch adds locking to protect the statistics pointer hold by
> every process.
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
> + * brute_get_exec_stats() - Get the exec statistics.
> + * @stats: When this function is called, this parameter must point to the
> + *         current process' statistical data. When this function returns, this
> + *         parameter points to the parent process' statistics of the fork
> + *         hierarchy that hold the current process' statistics.
> + *
> + * To manage a brute force attack that happens through the execve system call it
> + * is not possible to use the statistical data hold by this process due to these
> + * statistics dissapear when this task is finished. In this scenario this data

                 disappear

> + * should be tracked by the statistics of a higher fork hierarchy (the hierarchy
> + * that contains the process that forks before the execve system call).
> + *
> + * To find these statistics the current fork hierarchy must be traversed up
> + * until new statistics are found.
> + *
> + * Context: Must be called with tasklist_lock and brute_stats_ptr_lock held.
> + */
> +static void brute_get_exec_stats(struct brute_stats **stats)
> +{


-- 
~Randy

