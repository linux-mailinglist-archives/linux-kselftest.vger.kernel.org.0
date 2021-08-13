Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5355F3EBAE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhHMRCK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhHMRBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 13:01:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5509C0612A3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Aug 2021 10:01:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h1so14053373iol.9
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Aug 2021 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=134w16+XL1sdqmwbmXVj+wovRChqhGlomUo4cVBsw7I=;
        b=EG7LfjPlTDfqpwLeqvHlztwswzmSgwfc2KG9Fe1qeyvHQyeyUX1eHSY93uNu7QXnkn
         vqpvR5WPHRjQSjwdB3OrtarucYEo7ZMfscPYqSVOf60HOQ5E947iU0FjcTpyNLn5zS4z
         Zu2t/BJU5Y+42MQDMhxJrFrRlNLaOmcIP9UKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=134w16+XL1sdqmwbmXVj+wovRChqhGlomUo4cVBsw7I=;
        b=jKj01cxoHHzayaH1YFOvt75Z5wHujXHDO44RGY0sq6Nw8UvlWs/XQ9G6vcKXrbF/fI
         iIcHdu2ljjp2iDSsl6cNuqJtlOGHSNN0OuFi4smbt1RME1YWDcBjj8F8Aiaj2j9GMH20
         JxUog+CPQ1jX6yLFlXXcqpcvPRSrGKuA7MabqRVB5aJ1mYVnn3GIvomg16g8YW2W74JM
         zUlaEcSdvQ+N1izE0+9098QaNu1b7/t395Mv283qoUAGRfOjKj7WJUvOILU4vKuG3ybq
         63IbXUhfLofNcL8zTE0Cz7zqrqHbD2zUWLCIr2YEG7/Q+dvuWVvkQ0l08oYKWitGeQ+9
         g4kA==
X-Gm-Message-State: AOAM532gnxYiRTKDnH0N+aouoYQPttdqnxFVYkPlYHS6Prqo7kIhrIJn
        DttpT+9255AaBnWrsV1/0HuCJw==
X-Google-Smtp-Source: ABdhPJwk/6vRPl8xVugiwth86cTaXEHJTpYNmDj9cN0Z1zCGNzij+Ag3N4VFhkVp8WRHmgNj80/1Ow==
X-Received: by 2002:a05:6602:2595:: with SMTP id p21mr2778138ioo.51.1628874077347;
        Fri, 13 Aug 2021 10:01:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l15sm1170696ilt.45.2021.08.13.10.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 10:01:17 -0700 (PDT)
Subject: Re: [PATCH -next 1/2] selftests: Fix vm_handle_exception undefined
 error
To:     Chen Lifu <chenlifu@huawei.com>, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, wangyanan55@huawei.com,
        axelrasmussen@google.com, drjones@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, dwmw@amazon.co.uk, joao.m.martins@oracle.com,
        yangyingliang@huawei.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210709063741.355325-1-chenlifu@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f130f6ec-0c80-7a83-fad2-7d72d389b96b@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 11:01:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709063741.355325-1-chenlifu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/9/21 12:37 AM, Chen Lifu wrote:
> Compile setftests on x86_64 occurs following error:
> make -C tools/testing/selftests
> ...
> 
> x86_64/hyperv_features.c:618:2: warning: implicit declaration of function ‘vm_handle_exception’ [-Wimplicit-function-declaration]
>    618 |  vm_handle_exception(vm, GP_VECTOR, guest_gp_handler);
> /usr/bin/ld: /tmp/cclOnpml.o: in function `main':
> tools/testing/selftests/kvm/x86_64/hyperv_features.c:618: undefined reference to `vm_handle_exception'
> collect2: error: ld returned 1 exit status
> 
> The reason is that commit b78f4a596692 ("KVM: selftests: Rename vm_handle_exception")
> renamed "vm_handle_exception" function to "vm_install_exception_handler" function.
> 
> Fix it by replacing "vm_handle_exception" with "vm_install_exception_handler"
> in corresponding selftests files.
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>   tools/testing/selftests/kvm/x86_64/hyperv_features.c | 2 +-
>   tools/testing/selftests/kvm/x86_64/mmu_role_test.c   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 


Please include kvm in the commit summary. I think it is not getting
the right attention because of the summary line.

Same for the second patch in this series.

thanks,
-- Shuah
