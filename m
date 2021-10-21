Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CDB436B91
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhJUT4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 15:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231976AbhJUT4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634846072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQQxB68/bqgix0H59OBXlceD3gg5Noo7Iow2EZ2n7yg=;
        b=IPCHsUFujQzn7aTNpej8zRJrbF6mDzgwNsfjoDfb2TK+fkyyT9fGV1eleKlakTevTKD2zb
        KI4+s6w2qQ7BG0ts9wCzy+aYyOTwOuh+15jk+mVw2G0L6jYT4/Q4dhu8I6EouOHmcUL6B6
        +mk6avsUeX6oi2dvMWYeKfcGqYzuBaw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-mVQx0dkjPWOBZv5FB1RQxA-1; Thu, 21 Oct 2021 15:54:31 -0400
X-MC-Unique: mVQx0dkjPWOBZv5FB1RQxA-1
Received: by mail-ed1-f72.google.com with SMTP id i7-20020a50d747000000b003db0225d219so1533858edj.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 12:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XQQxB68/bqgix0H59OBXlceD3gg5Noo7Iow2EZ2n7yg=;
        b=J7s1LKqAcRDstKhL7YdXQ2RIcE+wOnCcOnj+tLbGVYwoahy2vM00YvUf20GXzbTc1j
         1gFPsaCVR6gdixmyMmJ51nLJQM6C7hqVlMgupupTcf/HUr6xIpL6v6GPg3zF3Pc57O2Y
         HN5d8KqN9ZFCJ27yb4Dvdc/irfCzdogP6tLqSeN7rHudazetcw4A6TjNekENsicCtShX
         dKcDwed5Qm0ulokMBF00HbYRUYzP2xlI9BvSlmShyfWL8hypHiasFgEGlunLy7dBx2cU
         TqS2F5eUXKalfNKs30jxlEW59HqjVqumy/gFnZU3m1ngchQNUT4Y0fV+IMqCXO76qF7I
         f3Rw==
X-Gm-Message-State: AOAM530O9JqSgrluMmPpnH939SIrg9/kXfUdvtDZrrJ8sVdduMSTTAOl
        tad4ANklVFwFUMt8znm2xmCSJvMNtOqNfcJipEUIduOgyA6/reSdw92E4jf9pWRb7ZSMEDEKrNN
        81GdfuQiloPGM6bUL6VRYgqxF45nq
X-Received: by 2002:a05:6402:50c7:: with SMTP id h7mr10509067edb.191.1634846070222;
        Thu, 21 Oct 2021 12:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmJnU7g6ZVD24HMPBsZgL0Jyl+qXHtE9LJnZE9S9oVAH4QKW2i7BfFAIN7nIyagvTLyj43JA==
X-Received: by 2002:a05:6402:50c7:: with SMTP id h7mr10509049edb.191.1634846070077;
        Thu, 21 Oct 2021 12:54:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id t18sm3616082edd.18.2021.10.21.12.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:54:29 -0700 (PDT)
Message-ID: <7edcd370-41a5-f7e8-1ea9-a6073c97638d@redhat.com>
Date:   Thu, 21 Oct 2021 21:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] selftests: kvm: fix mismatched fclose() after popen()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211021175603.22391-1-skhan@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211021175603.22391-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21/10/21 19:56, Shuah Khan wrote:
> get_warnings_count() does fclose() using File * returned from popen().
> Fix it to call pclose() as it should.
> 
> tools/testing/selftests/kvm/x86_64/mmio_warning_test
> x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
> x86_64/mmio_warning_test.c:87:9: warning: ‘fclose’ called on pointer returned from a mismatched allocation function [-Wmismatched-dealloc]
>     87 |         fclose(f);
>        |         ^~~~~~~~~
> x86_64/mmio_warning_test.c:84:13: note: returned from ‘popen’
>     84 |         f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> index 8039e1eff938..9f55ccd169a1 100644
> --- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> @@ -84,7 +84,7 @@ int get_warnings_count(void)
>   	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>   	if (fscanf(f, "%d", &warnings) < 1)
>   		warnings = 0;
> -	fclose(f);
> +	pclose(f);
>   
>   	return warnings;
>   }
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

