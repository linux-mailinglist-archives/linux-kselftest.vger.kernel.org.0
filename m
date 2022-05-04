Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC76351AD2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350300AbiEDStM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377302AbiEDStL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 14:49:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77BFD1F
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 11:45:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z16so1825146pfh.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FuAOc+wNIC5DOVBIAgkTsyelE5cgK01ek6zoAdzRvTk=;
        b=AZj0/ZHqXNuRK2uYtcC5j3klOWUuvIgC5dicdjXTF9pLrIj+jqWYXDsimJKMRUbnuX
         u3kU4GyhX8SXUXBHlcObDNCW2/t3LnxSTby/9rPiJamuyRGdKICMnfpg1a+AjFeQ+Ewe
         c5UI+PkvtT/l5u+QYnFoBl3jL0Ae9shZsWdSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FuAOc+wNIC5DOVBIAgkTsyelE5cgK01ek6zoAdzRvTk=;
        b=cS/vTnITIPb8yYosb8sxpObrYS/FJqzm0bnLSQfUnpIUdjSXmH3DKj2diN5+fvnz4X
         SQF2nUgsu8mhijbKLJ678L1v50g2Nztl0+CBRIHTqTDQw3neW/tX3xY+dUI+hXq72ArT
         A+HXqPzfOUbkMXA8P4zfLt1wpZQBdaPbTopFSNkyrqwuaXb2StaDJfhXo0E7g/2/St65
         uVRiFj/TYEFMZK9zqG3ynMrXHAh0iaN/p+k39vd86vWztuDHqPiC69GsR2s9E6MnAgMp
         byIcR6kUZnyvaveSZ6dbXtL8QP9eXm71J1oGNvWG7jcOif7K/WzfceuKBxu6C72yR7Iy
         fOFw==
X-Gm-Message-State: AOAM530Sou/hE1slAoPtIQz026oTBqzwYEJuaqcnhI3+qR/vWoylDfa3
        UJJ86VDEanR9k3XSvqGA476IAA==
X-Google-Smtp-Source: ABdhPJyPye6nL1nzMC2VY8GBKj09rnbsOJtsUkSsAuM0pZxQ+xALJkMM2Nq52jbHfhfB7B1Pfc1xbg==
X-Received: by 2002:a63:81c6:0:b0:3ab:616b:35b with SMTP id t189-20020a6381c6000000b003ab616b035bmr19183626pgd.256.1651689933870;
        Wed, 04 May 2022 11:45:33 -0700 (PDT)
Received: from [192.168.120.250] (wsip-70-166-189-147.ph.ph.cox.net. [70.166.189.147])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090340c900b0015e8d4eb222sm8533218pld.108.2022.05.04.11.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:45:33 -0700 (PDT)
Subject: Re: [PATCH][next] selftests/seccomp: Fix spelling mistake "Coud" ->
 "Could"
To:     Colin Ian King <colin.i.king@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220504155535.239180-1-colin.i.king@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f2dc58e6-0cda-581f-f026-64099494509f@linuxfoundation.org>
Date:   Wed, 4 May 2022 12:45:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220504155535.239180-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/22 9:55 AM, Colin Ian King wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 29c973f606b2..136df5b76319 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4320,7 +4320,7 @@ static ssize_t get_nth(struct __test_metadata *_metadata, const char *path,
>   
>   	f = fopen(path, "r");
>   	ASSERT_NE(f, NULL) {
> -		TH_LOG("Coud not open %s: %s", path, strerror(errno));
> +		TH_LOG("Could not open %s: %s", path, strerror(errno));
>   	}
>   
>   	for (i = 0; i < position; i++) {
> 

Thank you. I will pull this for Linux 5.19-rc1

thanks,
-- Shuah
