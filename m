Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572D841632C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhIWQ1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 12:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhIWQ1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 12:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWAQUvc9WZ1vqHaShxlPjUIFPCCCFA7GbKj7JUFPVOc=;
        b=Zho8tDgl3GjM1RdnsxUMj+NwcHpN9nvERmKuAfPfARvBr0YhgdsxiRZaNEpgZZ/eGhJf4v
        X8lof4kaUuV2Fk1B8rEQmXAaQZ3WS3hzZ1Nxie8JOzYKTlEKMJj2W+PrJ+zP6y9MLkT+Hq
        7+J9Kj5rtNbLvfEQuU2EZzj2IGPWGZ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-ktBF9z51PJWXEbLKnwWnyA-1; Thu, 23 Sep 2021 12:25:45 -0400
X-MC-Unique: ktBF9z51PJWXEbLKnwWnyA-1
Received: by mail-ed1-f72.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so7274316edy.14
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 09:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWAQUvc9WZ1vqHaShxlPjUIFPCCCFA7GbKj7JUFPVOc=;
        b=24eIs29bkCFmbhQjc381vEsnYZqVua+ZqGVJZIa1dnnF5L18+3ZyI+A9FeC6pDzsun
         fjq7vZlH2HfLxKDqKZqNB6tug16fniAOQdCECP0FQSHV3AjYKxENrIrJtpIU3fODDru1
         bThRWH+y+amyBoNcxNoxZrvO+nU8znxtg6e4e0lRt+dJsXO10CJeiw72X2eppemulFTr
         emNtTcUhhToik4gmWdPsOJD1TQi0FgY1kQbagDrIKj+6B06yc8uPJWVG6vH0Nro24NDD
         94n6eUZv3nXKZv1lqcFDZsukgkeH3BLx/l+p3E2eq4iQ/8yTSIwlem2H6CB0DK824RuC
         XruQ==
X-Gm-Message-State: AOAM531V3yPHf+IDptXApzOetnXMlpAOgpAd13LkpVUv0ic94a6LfBfE
        5+Z50w5FFapW7mgzcikaYQm/Ja/TJoKAeI5HbmyEI8EVGipcqCbiOWdYmBx2/7+4He18xf75n6e
        5QiB0O4vdz5U30DSyb5SJnpSrMXpN
X-Received: by 2002:a50:be8f:: with SMTP id b15mr6548778edk.200.1632414344680;
        Thu, 23 Sep 2021 09:25:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLPNCijm8vobMxCnfKUVsjGg5A9p8RGVLMgIZqTgCZT5T3yOUKBCQlwpq8PPv5EUorDNEyhw==
X-Received: by 2002:a50:be8f:: with SMTP id b15mr6548754edk.200.1632414344492;
        Thu, 23 Sep 2021 09:25:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t10sm3225755ejf.15.2021.09.23.09.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:25:43 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix kvm_vm_free() in cr4_cpuid_sync and
 vmx_tsc_adjust tests
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, Wei Huang <wei@redhat.com>
References: <20210826074928.240942-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75a3bb1f-ff4a-0f3b-6ffd-8118fcb40c5a@redhat.com>
Date:   Thu, 23 Sep 2021 18:25:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826074928.240942-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/08/21 09:49, Thomas Huth wrote:
> The kvm_vm_free() statement here is currently dead code, since the loop
> in front of it can only be left with the "goto done" that jumps right
> after the kvm_vm_free(). Fix it by swapping the locations of the "done"
> label and the kvm_vm_free().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 3 +--
>   tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> index f40fd097cb35..6f6fd189dda3 100644
> --- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> @@ -109,8 +109,7 @@ int main(int argc, char *argv[])
>   		}
>   	}
>   
> -	kvm_vm_free(vm);
> -
>   done:
> +	kvm_vm_free(vm);
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> index 7e33a350b053..e683d0ac3e45 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> @@ -161,7 +161,7 @@ int main(int argc, char *argv[])
>   		}
>   	}
>   
> -	kvm_vm_free(vm);
>   done:
> +	kvm_vm_free(vm);
>   	return 0;
>   }
> 

Queued, thanks.

Paolo

