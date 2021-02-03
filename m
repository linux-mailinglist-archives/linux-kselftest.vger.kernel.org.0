Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0134830E289
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 19:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBCSa6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhBCSa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 13:30:56 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2EFC061573
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 10:30:16 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id v1so787914ott.10
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hEe3LKST1YHcfKQNO2v4b7c0gwVjN8GSIL8jKaA5Cfo=;
        b=ie1t7tv30f1+Kl61SxX+cXlirmj3FIWBalujA9MEeMhB41z62szQ2QLCu5q+lxLWv+
         oVj4s9MFBx5q6M1frsxeVMzHnzWoMik3k5FEuuru82EObZlkAVI1zWWLXRIFUnj4MhK/
         4J9S9fNg6y35WabREdeEpPQLO2SmuJdJPcq4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEe3LKST1YHcfKQNO2v4b7c0gwVjN8GSIL8jKaA5Cfo=;
        b=jFDK1DWDZ8fGMGm7tT/N4Wa7c9e58pRFiaV190x+daEZYnVs2DT6+aGe2OlrYAEiAw
         IdF447OPKr4W10+VFX+6UhlOjSTSxDEVghllnAgWeY8eYnxh7vbiswbqlKZoeu4hF8R0
         pkDErRWZRXqiVICD4UfPWXHQDOH4I1p5s81V2QwyD7n7C0OSvvQlCpmxIjTHM6ufjZuz
         +3WVC6hbWqWGWaxve2exbGIQOx62EWi1qpVJVREZxTkNd7KteNOrCN4W8auDTtSc3d5Y
         3AIbF2nhDMFvpdNNzyhdYcQXroNkwNzRecpQlcIyAjzRkao3a6Xcmwej74+Stxa9pNHo
         G3rw==
X-Gm-Message-State: AOAM530whUSSZpDnxQ6V0/PkEeJLoa1qd+a7CY7CxjBU7pRWHn1Ni5bB
        wiKwTz2Km77CJdOR+5Ew5J4JtA==
X-Google-Smtp-Source: ABdhPJwJMmiOYDPicXwu33oqs9TY/hmcKJC1b+3L8fpmMemBdalMXX5WbxiE5C9+96fCPMhs7DwTzQ==
X-Received: by 2002:a9d:7088:: with SMTP id l8mr2850061otj.333.1612377015508;
        Wed, 03 Feb 2021 10:30:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o98sm587061ota.0.2021.02.03.10.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:30:14 -0800 (PST)
Subject: Re: [PATCH] selftests: breakpoints: Fix wrong argument of ptrace()
 when single step
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1612341547-22225-1-git-send-email-yangtiezhu@loongson.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f91f1e69-310e-5256-de6e-9bceeaa7b205@linuxfoundation.org>
Date:   Wed, 3 Feb 2021 11:30:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612341547-22225-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/21 1:39 AM, Tiezhu Yang wrote:
> According to the error message, the first argument of ptrace() should be
> PTRACE_SINGLESTEP instead of PTRACE_CONT when ptrace single step.
> 
> Fixes: f43365ee17f8 ("selftests: arm64: add test for unaligned/inexact watchpoint handling")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> index ad41ea6..2f4d4d6 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> @@ -143,7 +143,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
>   	if (!set_watchpoint(pid, wp_size, wp))
>   		return false;
>   
> -	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
> +	if (ptrace(PTRACE_SINGLESTEP, pid, NULL, NULL) < 0) {
>   		ksft_print_msg(
>   			"ptrace(PTRACE_SINGLESTEP) failed: %s\n",
>   			strerror(errno));
> 

Right before this it does a set_watchpoint(). PTRACE_CONT is what
makes sense to me. Error might be the one that is incorrect here?

thanks,
-- Shuah
