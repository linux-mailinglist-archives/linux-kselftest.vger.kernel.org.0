Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D942DD857
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgLQSaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgLQSaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:30:11 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1006DC0617A7
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:29:31 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z136so28482923iof.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TruuQuU7MOzIt57XJTFiqLwruTywKiNa+UyvVCpYR7k=;
        b=gok08EU6Rra3/VdbBGIJF+OIaszNIe/jgdNKNhoREVmm0+alu1rTyEvNoCOiwFeuqs
         WfGp9okjOAMMARoQ+ZAZ/c9IrsbHV2WTOp14q8sRH2uPlTZcTmo39ptQMMDW4mYbgwTx
         MXbly6u3SZ3sdOjZzU15f9EMfgWhcFeynQmis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TruuQuU7MOzIt57XJTFiqLwruTywKiNa+UyvVCpYR7k=;
        b=XC94tip+B+Jcuii1JPrRTWZxn7cM+VWOFfnSBarTNc7v83ruQV5sO5Z3Uzc2Y0QE+4
         S2MJRt4RQsVL9cEIOBjQAk54TA7se4LVALrCYhP0/Vfvrb6w3bEijL1wjTu6+foJfcO9
         6/6SuhKSWiLv6oT4uCEXlx9Fp4liVAOrtUaUW0oU1Z6Flfm2IH6/VDocqm0IRGTfBCON
         Nr0/+qjA/qPOtV/kzidwuluooNpej2/6hMcv4sLyENRXVgKC8SDi3j846I5ZOiMM0JGG
         MWObPTZI0VTYECKoN7CAnIuo9M46aEl79nGd3h1WFfKu+O99Qr6x5r+On0tZGE7BAI/6
         pniA==
X-Gm-Message-State: AOAM5336rhY/NGFxKT4JhxCel2y+zJweAMjybLglnG562lBAwZc7OP7m
        R47fFm2b+z4ay+DXcsVybUrKmA==
X-Google-Smtp-Source: ABdhPJzuzyfhbvjL83eLIzbSyMBtT/9HNWofLh4R5gDLHAm4IDRhU1bh137A8g68GUnhH/U/ToTWHA==
X-Received: by 2002:a05:6602:314b:: with SMTP id m11mr344157ioy.165.1608229770490;
        Thu, 17 Dec 2020 10:29:30 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n11sm1288961ioh.37.2020.12.17.10.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:29:29 -0800 (PST)
Subject: Re: [PATCH] selftests/vDSO: add additional binaries to .gitignore
To:     Tobias Klauser <tklauser@distanz.ch>, Shuah Khan <shuah@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201217163140.22635-1-tklauser@distanz.ch>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c3887a01-ac7e-21f3-8ca9-8b02b214da74@linuxfoundation.org>
Date:   Thu, 17 Dec 2020 11:29:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217163140.22635-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/20 9:31 AM, Tobias Klauser wrote:
> Add the test binaries introduced by commit 693f5ca08ca0 ("kselftest:
> Extend vDSO selftest"), commit 03f55c7952c9 ("kselftest: Extend vDSO
> selftest to clock_getres") and commit c7e5789b24d3 ("kselftest: Move
> test_vdso to the vDSO test suite") to .gitignore.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>   tools/testing/selftests/vDSO/.gitignore | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
> index 5eb64d41e541..a8dc51af5a9c 100644
> --- a/tools/testing/selftests/vDSO/.gitignore
> +++ b/tools/testing/selftests/vDSO/.gitignore
> @@ -1,5 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   vdso_test
> +vdso_test_abi
> +vdso_test_clock_getres
> +vdso_test_correctness
>   vdso_test_gettimeofday
>   vdso_test_getcpu
>   vdso_standalone_test_x86
> 

Thanks for the patch.

Applied to linux-kselftest next

thanks,
-- Shuah
