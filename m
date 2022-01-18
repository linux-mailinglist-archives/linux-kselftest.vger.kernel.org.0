Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3D492733
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 14:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbiARNXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 08:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243680AbiARNXj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 08:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642512218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMJxvTYPAO2Woc0KNl4Uc9BZK4KZwIBCLQmQ1uUCVf8=;
        b=MyaKPMubkshhoWxAv4U0lTr+mdvgrfGhA7ic31Yhk674b8lz8tGhJUusvK7oCEsQrStmNd
        /72fuMPRs93tTv2ArpkjAsar2CQ67XPW4DF+VeFTLIF0Yd5128Mh2vCqCa+QPiTiGCKLlR
        Gg5yfUXqHbeDYYxkMd1xd1+M8DLCdEw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-scoaLUkhN7ez505pQB-AJg-1; Tue, 18 Jan 2022 08:23:37 -0500
X-MC-Unique: scoaLUkhN7ez505pQB-AJg-1
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso16934095edt.20
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 05:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sMJxvTYPAO2Woc0KNl4Uc9BZK4KZwIBCLQmQ1uUCVf8=;
        b=VbjCUQsGXlnS2tikQQkc9GALIfrngdaAcFJBOFlcOxvEj50JFPQDKK+Q9TuydOdHP7
         sDmDGUSE/x/R6ranQTYtXKiQ/iYinrsQRmYX2yygG9qRCMl60rVxnJPbfbCbIK8r83z3
         WwcBiOLzkuQ1msJ0NSHRUDpqiUipu3DNBA3XV1ZeswzZkE7AxZWspGXomExMFWeG0J3L
         8chDKobX8tpQgIcnJqI6HVR7Iyo5zMS3fFz9HiQiniejWuC/Oxez07bagi7P7etbFbYM
         NXAfUiFthrJfU2GHhYvGjgLEKdUffjGUbzCh7Resp2YekjQ7VL5DKuykLSrpFRFEYIqW
         O63A==
X-Gm-Message-State: AOAM531W4vUG9r+iuOhRowwEOtMZQNMxgiRichdO29QsInJiv5b6iNve
        13x5eZpmttqI6QFcUaY/FA+z+F0cRh9yVDODPuOAe2rXXJVe091o127zSn6fZ0zwh7QTTxe5SuA
        Ux/iTzzbAbiffuU+qvWO6Z8txW3o7
X-Received: by 2002:a50:8a94:: with SMTP id j20mr1916732edj.388.1642512216295;
        Tue, 18 Jan 2022 05:23:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytWJp4uNsT0KmcH7Y3k3MrNh8mEQR13qd+NiOFs9BRb4oschFyAsxAjto4TKyZfUnG5eXY4A==
X-Received: by 2002:a50:8a94:: with SMTP id j20mr1916715edj.388.1642512216051;
        Tue, 18 Jan 2022 05:23:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id i23sm7080513edt.93.2022.01.18.05.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 05:23:35 -0800 (PST)
Message-ID: <c7e4a2f8-e840-5f0d-9bed-fc9b96b220a5@redhat.com>
Date:   Tue, 18 Jan 2022 14:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] selftests: kvm: add amx_test to .gitignore
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Yang Zhong <yang.zhong@intel.com>
Cc:     kernel@collabora.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118122053.1941915-1-usama.anjum@collabora.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220118122053.1941915-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/18/22 13:20, Muhammad Usama Anjum wrote:
> amx_test's binary should be present in the .gitignore file for the git
> to ignore it.
> 
> Fixes: bf70636d9443 ("selftest: kvm: Add amx selftest")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/kvm/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 8c129961accf..780066ae092c 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -8,6 +8,7 @@
>   /s390x/memop
>   /s390x/resets
>   /s390x/sync_regs_test
> +/x86_64/amx_test
>   /x86_64/cr4_cpuid_sync_test
>   /x86_64/debug_regs
>   /x86_64/evmcs_test

Queued, thanks.

paolo

