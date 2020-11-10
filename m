Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7896A2AE30E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgKJWPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 17:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbgKJWPS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 17:15:18 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C31C0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 14:15:17 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n129so91664iod.5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 14:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9r8Sb8WnPfDcu9PaF/bRLIXbVzvj7W4rI2y9M7AptxM=;
        b=RrCBk9gsYkgr4JGLD6//ysw/HkF6S5XevjEJzSiAPBM4bV7HRdxDtnXyE1YXmdlCgW
         NVSFhVGp5HoErmIbuSCxrvnF1kDYBtvvdLApWub/k8nttHHdwsVuC82+TeCKnmWtVjaS
         R3bnVp5GkzTTU8WSXf1sUIip2Urh2wNNVQYAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9r8Sb8WnPfDcu9PaF/bRLIXbVzvj7W4rI2y9M7AptxM=;
        b=LU+Zuj+flQRhFRkE4VffZ5P9eMXcy5u8R3jN5H8ZdlvrCTERIn5TN3u8scluDPWawK
         lDsFWhz4RLdxRY07kZZ5h19T+Y5A4e3yI2f9pEoYUJ5TSvvFVe+HnJyrNfN5YSPhrMEM
         vFff5IiOGXjMYcEeswth1pXzOrhRutNBU9xzISay35RlLH4HEtFTJM2nJ9e/gwtyjSQw
         aFdu4ovRadzmarH/sdC7Z3X4aRpu3f/m3G1k3wvy2bnhU1E7OKTIad6jwMi+TlTyvA+3
         meH610e9aULXiqqbG6eJKs+Pt68jRfZ15Cqas4415pNiZEa6F+rZwyAFPmIbWZa7v3/l
         Y8jg==
X-Gm-Message-State: AOAM5321MaLmfyKBDlMA9910NvXTi42WFwtsEh9ttmDyiqKkKfgBZha+
        3ATkh4iknM0HoKDSbwP6Z6ig6A==
X-Google-Smtp-Source: ABdhPJyEeSW5eq/cht4GvdXndbRqSbau8R3yhklWo1EXdqkKeWKwhm6496TtKrnClymgAXAJGzaQyA==
X-Received: by 2002:a5d:9042:: with SMTP id v2mr14195459ioq.98.1605046517070;
        Tue, 10 Nov 2020 14:15:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y19sm8754ilk.79.2020.11.10.14.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 14:15:16 -0800 (PST)
Subject: Re: [PATCH V2] selftests/cgroup: Fix build on older distros
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michael Ellerman <michael@ellerman.id.au>,
        linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, linux-kernel@vger.kernel.org,
        keescook@chromium.org, Shuah Khan <skhan@linuxfoundation.org>
References: <160464840151.97255.15344214064240834294.sendpatchset@MacBook-Pro.local>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <50cb30c4-8e8d-7ba0-d429-3f1da4ad1f0b@linuxfoundation.org>
Date:   Tue, 10 Nov 2020 15:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <160464840151.97255.15344214064240834294.sendpatchset@MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/6/20 12:40 AM, Sachin Sant wrote:
> On older distros struct clone_args does not have a cgroup member,
> leading to build errors:
> 
>   cgroup_util.c: In function 'clone_into_cgroup':
>   cgroup_util.c:343:4: error: 'struct clone_args' has no member named 'cgroup'
>   cgroup_util.c:346:33: error: invalid application of 'sizeof' to incomplete
>    type 'struct clone_args'
> 
> But the selftests already have a locally defined version of the
> structure which is up to date, called __clone_args.
> 
> So use __clone_args which fixes the error.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sachin Sant <sachinp@linux.vnet.ibm.com>>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> 
> V2: Replace all instances of clone_args by __clone_args
> ---
> 
> diff --git a/a/tools/testing/selftests/cgroup/cgroup_util.c b/b/tools/testing/selftests/cgroup/cgroup_util.c
> index 05853b0..0270146 100644
> --- a/a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -337,13 +337,13 @@ pid_t clone_into_cgroup(int cgroup_fd)
>   #ifdef CLONE_ARGS_SIZE_VER2
>   	pid_t pid;
>   
> -	struct clone_args args = {
> +	struct __clone_args args = {
>   		.flags = CLONE_INTO_CGROUP,
>   		.exit_signal = SIGCHLD,
>   		.cgroup = cgroup_fd,
>   	};
>   
> -	pid = sys_clone3(&args, sizeof(struct clone_args));
> +	pid = sys_clone3(&args, sizeof(struct __clone_args));
>   	/*
>   	 * Verify that this is a genuine test failure:
>   	 * ENOSYS -> clone3() not available
> 

Not sure how you generated the patch. I had to use git am -p2

Applied to linux-kselftest next - please make sure to generate from
top level.

thanks,
-- Shuah

