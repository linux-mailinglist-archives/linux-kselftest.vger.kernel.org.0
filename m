Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202B843E1BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJ1NQN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhJ1NQM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 09:16:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176DCC061570
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 06:13:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w193so8244726oie.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iOMRY+5EQlt3AMhlWcF2Jku3DStXtwx/KpJdGp0gI2c=;
        b=Fs6zHdSI2uUASs/WQXD/oHus8l8cuQQ/q/FtJVBv4wUOpQD3iqU2AJP1/usYPkdkQm
         reXDFApWQCOoSBOz6QNEWmoAwSUTRLtzLKbj/IroQlrViHO6w6uWRpgfIIce2/jLRwJr
         6U6YczGQEuHf5UA2+jUTKbxhE/mPgG+s18xpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iOMRY+5EQlt3AMhlWcF2Jku3DStXtwx/KpJdGp0gI2c=;
        b=wtaCWgdlhRBYumcBtJqIn1kk3TYA/cxZ3WcWOB2iRRKFg0FIiq8w1I721HvHp+nTNR
         eH2KIioWGDKtCsBBmTPbQFnsm7wzwAjbMO/BO19f5kbZPdvnkpXqGwDsxWCXz9G84tQN
         yh5nGgM1VdzWjmdB1j/ZKiMW2SH3ripef81Eu4D5ho+Sdzg+UYx04LJ5kg1NgFABbW7m
         OeNDEkqxGUpDi6JLVp2A7EU4yw0ERMJGSrzVrp9ERYmHc63JXB/CzpQWHkC47imDeZ1O
         VQTKZvTptKoEEL3O/E7PqFkNYRbf/kNu/XCXo9Lohn/TctopB8Lfc08DUw6uG5mYxgND
         ws7Q==
X-Gm-Message-State: AOAM532DR9ydJTL4fDxWUkPeNli2WI2s25nONPVU09DlUJ03EmZJ7eMO
        1r6f/lLB15tmxxKJCADsL9A68g==
X-Google-Smtp-Source: ABdhPJxtHX+E8FMg+JPNf2ETnLpObNqAXNMo8H2E5oi3uH1xa7e2Pz3bAvrftKeKZx01BPrqlmoimw==
X-Received: by 2002:a05:6808:1791:: with SMTP id bg17mr8378167oib.94.1635426825463;
        Thu, 28 Oct 2021 06:13:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s5sm1111548ois.55.2021.10.28.06.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 06:13:44 -0700 (PDT)
Subject: Re: [PATCH] userfaultfd/selftests: use swap() to make code cleaner
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211028112331.16152-1-deng.changcheng@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f60560fe-ac6b-a48b-cc79-a3a42c22cc02@linuxfoundation.org>
Date:   Thu, 28 Oct 2021 07:13:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211028112331.16152-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/28/21 5:23 AM, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use swap() in order to make code cleaner. Issue found by coccinelle.

Please include the coccinelle log.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 8a09057d2f22..41dfe6f4ebfb 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -1413,7 +1413,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>   static int userfaultfd_stress(void)
>   {
>   	void *area;
> -	char *tmp_area;
>   	unsigned long nr;
>   	struct uffdio_register uffdio_register;
>   	struct uffd_stats uffd_stats[nr_cpus];
> @@ -1524,13 +1523,8 @@ static int userfaultfd_stress(void)
>   					    count_verify[nr], nr);
>   
>   		/* prepare next bounce */
> -		tmp_area = area_src;
> -		area_src = area_dst;
> -		area_dst = tmp_area;
> -
> -		tmp_area = area_src_alias;
> -		area_src_alias = area_dst_alias;
> -		area_dst_alias = tmp_area;
> +		swap(area_src, area_dst);
> +		swap(area_src_alias, area_dst_alias);
>   
>   		uffd_stats_report(uffd_stats, nr_cpus);
>   	}
> 

thanks,
-- Shuah
