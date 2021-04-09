Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9A35963B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 09:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhDIHUE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhDIHUE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 03:20:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99441C061760
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Apr 2021 00:19:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s11so3668594pfm.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Apr 2021 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3jpQ3lZXMgzXRrsRMytSQQwKCg9AstxjxLrChn5w6cw=;
        b=q+jIWwzIzCXrBiItIjor8RfQsqmwt6DshA3PoZ7NMrJqyNtdyJ0LgUsNWVzl4aOKHg
         GayOOz+5vGt68tGX998K17zkv/pxUanMYMydbCfrUqNlv6zBUtlUOqABluYnslJkSYfj
         ouAymLwFd5ba8qNr2yRQ8Bs74Vjhiz3Dbee28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3jpQ3lZXMgzXRrsRMytSQQwKCg9AstxjxLrChn5w6cw=;
        b=e+22qp7PCqpzBXyV10tOOGJTkcHdtwAcPjscCzQH2ne5V9v202yedThlyjBP8RWFbt
         2y9eiPHchkHDkhRf0BetdIdRHZvdkg41Yau6reJ29+8kU5idRqkLTuSF3+7ZI6QRu/4Z
         +o4QbcuWK7Mkxsi+U7n2o+bR3yuQUPPOiqJjLZrPr5N5K3siPuS6DZqF76sAyZGHOWe/
         upsXW7XDvrWrrjk/ft9XfP7sNe8QrVIegq8kxT6cx2PNPuOF0gryTRFMW9Tb/A+NwYPW
         9NeEAzJfwwiJAMEoIds1WQuMkmjRaWWVuDKyc6JouWBgVK1exksq/pLdO5zCMqCDxqxZ
         ozMA==
X-Gm-Message-State: AOAM531nzeTbamA8M73TZrt9RjlJ6qFwvuD3E/Zw8lJWND6Hu40OnbUt
        JS5LUKV63U3OYHR1W7OGHJz8hg==
X-Google-Smtp-Source: ABdhPJwPfAya/vYfNmH8mZgcEYD6mXq9hmGnG4qDZ1azfbvW7kO+y+hKgSmjhSYDNtCBTNVyuPSGKw==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr5763854pgc.408.1617952791067;
        Fri, 09 Apr 2021 00:19:51 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-600a-73c5-13c4-f875.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:600a:73c5:13c4:f875])
        by smtp.gmail.com with ESMTPSA id b21sm1357924pji.39.2021.04.09.00.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 00:19:50 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] powerpc/selftests/perf-hwbreak: Coalesce event creation code
In-Reply-To: <20210407054938.312857-3-ravi.bangoria@linux.ibm.com>
References: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com> <20210407054938.312857-3-ravi.bangoria@linux.ibm.com>
Date:   Fri, 09 Apr 2021 17:19:47 +1000
Message-ID: <87k0pbgc18.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ravi,

> perf-hwbreak selftest opens hw-breakpoint event at multiple places for
> which it has same code repeated. Coalesce that code into a function.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  .../selftests/powerpc/ptrace/perf-hwbreak.c   | 78 +++++++++----------

This doesn't simplify things very much for the code as it stands now,
but I think your next patch adds a bunch of calls to these functions, so
I agree that it makes sense to consolidate them now.

>  1 file changed, 38 insertions(+), 40 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
> index c1f324afdbf3..bde475341c8a 100644
> --- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
> +++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
> @@ -34,28 +34,46 @@
>  
>  #define DAWR_LENGTH_MAX ((0x3f + 1) * 8)
>  
> -static inline int sys_perf_event_open(struct perf_event_attr *attr, pid_t pid,
> -				      int cpu, int group_fd,
> -				      unsigned long flags)
> +static void perf_event_attr_set(struct perf_event_attr *attr,
> +				__u32 type, __u64 addr, __u64 len,
> +				bool exclude_user)
>  {
> -	attr->size = sizeof(*attr);
> -	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
> +	memset(attr, 0, sizeof(struct perf_event_attr));
> +	attr->type           = PERF_TYPE_BREAKPOINT;
> +	attr->size           = sizeof(struct perf_event_attr);
> +	attr->bp_type        = type;
> +	attr->bp_addr        = addr;
> +	attr->bp_len         = len;
> +	attr->exclude_kernel = 1;
> +	attr->exclude_hv     = 1;
> +	attr->exclude_guest  = 1;

Only 1 of the calls to perf sets exclude_{kernel,hv,guest} - I assume
there's no issue with setting them always but I wanted to check.

> +	attr->exclude_user   = exclude_user;
> +	attr->disabled       = 1;
>  }
>  
> -	/* setup counters */
> -	memset(&attr, 0, sizeof(attr));
> -	attr.disabled = 1;
> -	attr.type = PERF_TYPE_BREAKPOINT;
> -	attr.bp_type = readwriteflag;
> -	attr.bp_addr = (__u64)ptr;
> -	attr.bp_len = sizeof(int);
> -	if (arraytest)
> -		attr.bp_len = DAWR_LENGTH_MAX;
> -	attr.exclude_user = exclude_user;
> -	break_fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> +	break_fd = perf_process_event_open_exclude_user(readwriteflag, (__u64)ptr,
> +				arraytest ? DAWR_LENGTH_MAX : sizeof(int),
> +				exclude_user);

checkpatch doesn't like this very much:

CHECK: Alignment should match open parenthesis
#103: FILE: tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c:115:
+	break_fd = perf_process_event_open_exclude_user(readwriteflag, (__u64)ptr,
+				arraytest ? DAWR_LENGTH_MAX : sizeof(int),

Apart from that, this seems good but I haven't checked in super fine
detail just yet :)

Kind regards,
Daniel
