Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F53F60AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhHXOlU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhHXOlU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 10:41:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64626C061757
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:40:36 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n24so26651331ion.10
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yM2wRe0FAaPF4wNtGebGZ9XSDA1WQ4g1RnY7t+QUM3E=;
        b=C0Wa2AmYXhKTH23luXVLHkWw9Na+lYWUCZAnTevEo5fiHfdD9uochlVa5nfp+S07yF
         MFBiHiHHUx5ZrR134maLKaHQT2qvPkXgQlsg7XZFPBeDs999r7gfuDKHnA2NX1L/Jm6x
         LXdsdpL+OxSXDYcqmJO9RW2u7tSFGDrrx1mLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yM2wRe0FAaPF4wNtGebGZ9XSDA1WQ4g1RnY7t+QUM3E=;
        b=gUME9ykJ57VdnnM4RwQgX0YbgmlovKJVIv766geSPPtQNbmCfHfJ3SD4SY76UrnBZ8
         DFyNfN6dxo88LEMOpTdYtA8GVNwQGSfIgAc3wb8leVqxAY7GnqdSDFbkBTWasqKNY3k0
         niJymJAS8lWVtfAymPEC7d9v+JTVZuJqkoiYs2XQfMRFGOcmwXb8db9uLGpZn0fnIGXq
         vJ7uI4QjNL07HxSj5gjPDu8JD/D06bmH63gSCCnnV5/Ya8GeBgtBTuztMgNmJXtpGSl9
         jti0neQoJ6SZuGgKmt9RwwlDBjqC9wIeWsevD751FN0e8r+paz0iXyOkvrQ6kgqkkmOQ
         c2DQ==
X-Gm-Message-State: AOAM531YFM528mJrsh2nChAo2T9gp/KvP6GH/JQvCXwbLnSEacY3Rr6d
        LC+MVT7iw1RIXvTW4Dmd0IqXZw==
X-Google-Smtp-Source: ABdhPJw2AYLp2tSjeFq+DpA2KvhyTaOcyPyaq5pPWr4XD6hX6Bz8iI9UvbBUxVwVFdE3h1YqpzOZRQ==
X-Received: by 2002:a05:6602:3293:: with SMTP id d19mr15743731ioz.158.1629816035889;
        Tue, 24 Aug 2021 07:40:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm10400848ioa.13.2021.08.24.07.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:40:35 -0700 (PDT)
Subject: Re: [PATCH linux-next] testing/vm/: fix application of sizeof to
 pointer
To:     CGEL <cgel.zte@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210820032430.12948-1-jing.yangyang@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76e5e569-0c43-241d-bdfa-5a8da79574b8@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:40:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210820032430.12948-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/21 9:24 PM, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> sizeof when applied to a pointer typed expression gives the size of the
> pointer.
> 
> ./tools/testing/selftests/vm/split_huge_page_test.c:344:36-42: ERROR application
> of sizeof to pointer
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>   tools/testing/selftests/vm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> index 1af16d2..54bf57f 100644
> --- a/tools/testing/selftests/vm/split_huge_page_test.c
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -341,7 +341,7 @@ void split_file_backed_thp(void)
>   	}
>   
>   	/* write something to the file, so a file-backed THP can be allocated */
> -	num_written = write(fd, tmpfs_loc, sizeof(tmpfs_loc));
> +	num_written = write(fd, tmpfs_loc, sizeof(*tmpfs_loc));
>   	close(fd);
>   
>   	if (num_written < 1) {
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
