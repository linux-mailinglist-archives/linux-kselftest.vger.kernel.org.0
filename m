Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9419320F91
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Feb 2021 03:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBVCsL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 21:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhBVCsG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 21:48:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD12C061574;
        Sun, 21 Feb 2021 18:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5fFHNeJ8nqeNMa0DGHcRPcH+3cOuL7XbveGYEMFXDD0=; b=zv4edCC+GUZ4S1hKw2n1qVccHA
        SyAdKzZ7/YhO7qCGFXhKPPMOylEbFxDAr3gyFcD+aWyX7xIx/6p393eHfreBW3ie4QmMpK/fm81Bn
        VZg+wbJHlpaMhy/OexPEqs2ay95PZ97d006cElTeOeBdu50B12NLBz3h+Gl0Q54P4S2AQ4Cuq9yE8
        BnfK+54Y9cUu52AYwqTyGiyPerKvaKwtu4W9BqkMib187LitIbX5AWpKuN8nhXdNCISllSyZV3nw0
        RcPrJWAo0C5WilVYiksG1s7MyFmNEyhvjkZFw5dYkxLNaT+C6UTobqz3cDtYT2UmpB5ffJ3KahLbz
        EwpxiH5Q==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE1Fq-0001g8-QV; Mon, 22 Feb 2021 02:47:23 +0000
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
Message-ID: <f4fd9e44-539e-279e-a3a6-8af39f863f73@infradead.org>
Date:   Sun, 21 Feb 2021 18:47:16 -0800
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

scripts/kernel-doc does not like these items to be marked
as being in kernel-doc notation. scripts/kernel-doc does not
recognize them as one of: struct, union, enum, typedef, so it
defaults to trying to interpret these as functions, and then
says:

(I copied these blocks to my test megatest.c source file.)


../src/megatest.c:1214: warning: cannot understand function prototype: 'const u64 BRUTE_EMA_WEIGHT_NUMERATOR = 7; '
../src/megatest.c:1219: warning: cannot understand function prototype: 'const u64 BRUTE_EMA_WEIGHT_DENOMINATOR = 10; '
../src/megatest.c:1228: warning: cannot understand function prototype: 'const unsigned char BRUTE_MAX_FAULTS = 200; '
../src/megatest.c:1239: warning: cannot understand function prototype: 'const unsigned char BRUTE_MIN_FAULTS = 5; '
../src/megatest.c:1249: warning: cannot understand function prototype: 'const u64 BRUTE_CRASH_PERIOD_THRESHOLD = 30000; '


On 2/21/21 7:49 AM, John Wood wrote:
> 
> +/**
> + * brute_stats_ptr_lock - Lock to protect the brute_stats structure pointer.
> + */
> +static DEFINE_RWLOCK(brute_stats_ptr_lock);

> +/**
> + * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
> + */
> +static const u64 BRUTE_EMA_WEIGHT_NUMERATOR = 7;

> +/**
> + * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
> + */
> +static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR = 10;

> +/**
> + * BRUTE_MAX_FAULTS - Maximum number of faults.
> + *
> + * If a brute force attack is running slowly for a long time, the application
> + * crash period's EMA is not suitable for the detection. This type of attack
> + * must be detected using a maximum number of faults.
> + */
> +static const unsigned char BRUTE_MAX_FAULTS = 200;

> +/**
> + * BRUTE_MIN_FAULTS - Minimum number of faults.
> + *
> + * The application crash period's EMA cannot be used until a minimum number of
> + * data has been applied to it. This constraint allows getting a trend when this
> + * moving average is used. Moreover, it avoids the scenario where an application
> + * fails quickly from execve system call due to reasons unrelated to a real
> + * attack.
> + */
> +static const unsigned char BRUTE_MIN_FAULTS = 5;

> +/**
> + * BRUTE_CRASH_PERIOD_THRESHOLD - Application crash period threshold.
> + *
> + * The units are expressed in milliseconds.
> + *
> + * A fast brute force attack is detected when the application crash period falls
> + * below this threshold.
> + */
> +static const u64 BRUTE_CRASH_PERIOD_THRESHOLD = 30000;

Basically we don't support scalars in kernel-doc notation...

-- 
~Randy

