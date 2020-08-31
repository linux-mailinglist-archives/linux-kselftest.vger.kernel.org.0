Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17AA258300
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgHaUty (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgHaUtx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 16:49:53 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385AC061575
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 13:49:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z195so2184707oia.6
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Aug 2020 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXLdw2EqWHhI2TwwrM4XKt/5YHttNOrLrhTDhUQWFAg=;
        b=a58amqfO6WuUD4Noh1GsIb+tsswivJ0nu660wqYL5R2D7jdZaR8vqDpVk+wS5iFLgi
         BvReR4oTMyY5KUix15VtUCRDn7a3xjKWJX20qftFOJHCWEvuD0QQXkwAnPqfFR9LonOZ
         W7j1IXgpoeLq1x355d/+O+Ub8UcWA1QtCuF54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXLdw2EqWHhI2TwwrM4XKt/5YHttNOrLrhTDhUQWFAg=;
        b=K5l/t6mWuxkVNg5v/YyvFdDZ0QvXxE0uKCXDEQ/fTIBDpWlLMGy6DgYrZiH1WT8Pir
         nX1lPDcQ/RfnlEpsypMriv0izWGQC6N3PIY/cP/j9tFV1NH8naHwyROfc31ZK4xdx76s
         I5fTsWEh0PUNtfjFPFRUwa+0uQp4o56iohrn+G9h+cVrvBSt2QV0EpvEQ4GEx/rnsV5j
         m4X+6Piy77Ny9isThBOXZVFSsJ6zoI3c9mlCt4oVb1W4DTsHOXtiVWLFcS9D/wPcsDNo
         s7R0crzQ4C5E05ajqlH6c/dFPgIcwGjGA7kY2drKz80LHeJS77foxT7VxgfvPmQqD0ot
         FVsg==
X-Gm-Message-State: AOAM530oGCKpNIakZoJKlm8muRXYyYfnvDYC+kl79Q5iiO31SVEzVwmP
        6lu5DLsF3a468dE1//HboKpLmmFqHyd78g==
X-Google-Smtp-Source: ABdhPJyZnOHiWoW/j0WJMwcoA5h8XCMzg98FexYAoM57h/Zd3reUKXgNajigD561Ru00ls+Vhnee+A==
X-Received: by 2002:aca:ccd3:: with SMTP id c202mr695607oig.146.1598906992242;
        Mon, 31 Aug 2020 13:49:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm1983694otp.8.2020.08.31.13.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 13:49:51 -0700 (PDT)
Subject: Re: [PATCH] selftests: use "$(MAKE)" instead of "make" for
 headers_install
To:     Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200817150946.21477-1-dvlasenk@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8ea61655-c4b3-0fa9-ec70-b63adbbe5c84@linuxfoundation.org>
Date:   Mon, 31 Aug 2020 14:49:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817150946.21477-1-dvlasenk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/17/20 9:09 AM, Denys Vlasenko wrote:
> If top make invocation uses -j4 or larger, this patch reduces
> "make headers_install" subtask run time from 30 to 7 seconds.
> 
> CC: Shuah Khan <shuah@kernel.org>
> CC: Shuah Khan <skhan@linuxfoundation.org>
> CC: linux-kselftest@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> ---
>   tools/testing/selftests/lib.mk | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 7a17ea815736..51124b962d56 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -47,9 +47,9 @@ ARCH		?= $(SUBARCH)
>   khdr:
>   ifndef KSFT_KHDR_INSTALL_DONE
>   ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
> -	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
> +	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   else
> -	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
> +	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
>   		ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   endif
>   endif
> 

Thanks for the patch. Applied to linux-kselftest next for 5.10

thanks,
-- Shuah
