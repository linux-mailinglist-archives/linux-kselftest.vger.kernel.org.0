Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C04F9D9F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiDHT0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiDHT0C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 15:26:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C01E348B0D
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 12:23:54 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so1634853oof.12
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6PPIy36napfU/u2aY/HoK3sVhuBmHd01Cv34ZWmAUo=;
        b=M17zIr6OGlaLbdBLFFfL57NpApXft6SDt7tcMN9vfIY3Yl4YX+yPGlwdd0sWOXGUCL
         DbJDsNM+T3+TCWjAGPMRjWjOI+BWitOTmPWAdEM9H5Wf0fOD/l0/eZqEvJ00HHpmVf5x
         8KHOcIstIm3k+m1qGvVbUmEnXjlZSSENuvNjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6PPIy36napfU/u2aY/HoK3sVhuBmHd01Cv34ZWmAUo=;
        b=RLWJ2WmIGVjkSXuG0SKUIdP9WMw0iSHwJvP4/oyU8CSjJWjKT2L4ypbQEy92dGysWJ
         w4k0YfT9atPRvJ7WFiT8wvrQaJFLfNp+CEmxBVnSGipV8eWXY5zkU/mFBQvzSw6A/eFA
         cik6/dQy0LgLBKFb/0FDbcNAOtWSeu2rKa2zauwmst8I0DgpfsZuVwqnopLX8q9oBtbV
         27WrBzT6XN+q8huvA22cvCkHZeuDGEbRV8JSrVCY9piP8CtpNdgfXtkn6DJS5dqofGyz
         PflxU4+7K+PLEp64+Zg20yvBf9/t29chohUboXHX/x68pJ7jFZeN4enJXwa++k8uwScB
         R/uQ==
X-Gm-Message-State: AOAM53312mHiJ9zOL/1fNcnn8iPJb1x13hAiRdujXZLq/cxx5XC2G+MU
        fTauXDNBgKQtdtWeeld7h/gyyw==
X-Google-Smtp-Source: ABdhPJwWcIPSf4bMVd1ad/gG9idPpq2ssdWRRIQ22dv8eLNNDKqX0ni/EbE82yE3fpqlJQJfX9wt7A==
X-Received: by 2002:a4a:2556:0:b0:324:bd36:f020 with SMTP id v22-20020a4a2556000000b00324bd36f020mr6730949ooe.13.1649445833546;
        Fri, 08 Apr 2022 12:23:53 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 15-20020aca110f000000b002da58c4ec52sm8888098oir.6.2022.04.08.12.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:23:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] selftests: mqueue: drop duplicate min definition
To:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1649424565.git.geliang.tang@suse.com>
 <36201289cc9281ea7653127b0008ba01a1c14290.1649424565.git.geliang.tang@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2d535cf6-d5dc-21fa-4456-d9fe06e9588d@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 13:23:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <36201289cc9281ea7653127b0008ba01a1c14290.1649424565.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/8/22 7:36 AM, Geliang Tang wrote:
> Drop duplicate macro min() definition in mq_perf_tests.c, use MIN() in
> sys/param.h instead.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---

Thank you. I will apply this for next.

thanks,
-- Shuah
