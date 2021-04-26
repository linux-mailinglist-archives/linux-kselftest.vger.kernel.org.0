Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB36D36B089
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Apr 2021 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDZJ3V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Apr 2021 05:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232116AbhDZJ3R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Apr 2021 05:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619429316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtWVNId0H4MlH7zGbJHW4vVmuaAH+xdS1wmcTWoY6w0=;
        b=MGpMy4blRgdfHWBAG/8i9oVUjmPlEcQATJEG5ZVKmxzbMpN2l/bXUx6qmP3q1F23dF6sYz
        eZ73Sc7ZAUNeiJ9BYNAaK6xZEe1IFkUcJUF150MaYfcgKCrhH0/WQ8lktbIaNf270CYPG2
        udVKxttbXe0AMH8ztapoBr38SK5KRWA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-vo0W3vEWOW-y8CcKHT00ug-1; Mon, 26 Apr 2021 05:28:33 -0400
X-MC-Unique: vo0W3vEWOW-y8CcKHT00ug-1
Received: by mail-ed1-f72.google.com with SMTP id i17-20020a50fc110000b0290387c230e257so521112edr.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 02:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OtWVNId0H4MlH7zGbJHW4vVmuaAH+xdS1wmcTWoY6w0=;
        b=obkSELJgsX8bDKHKMycWEkWYOKCFdT1Q1GjKW6O6bKPW4RPq1SGYEKtor863M6acrO
         jhCJsaxaTN3bncvktP/rPREK4pU9LFdPqn/s8PMjGU3ctUCGrqplkY7VJgitOB12nG4Z
         UWRcQWWATeU+10+aYqanPJRzGgaPbzTZgZPq5lSItK/q39fXn5aI4dI9Xyz5r396GnEt
         6ZYnZMEyGQ4VDvHp5mBypX5xuejjziYYI7bLjTbEY9Fz/dDuWMxfD7ywXsBT2q92CszJ
         nI+p64cJr3rb9KeUDwGMlsfuFKrRBqNO3VTDDhjUrFt6yknUoOdrJHI70dVCaJs/e0k3
         SDLw==
X-Gm-Message-State: AOAM532smV7cFvgeQU2Q1fVCR3QoImsRMdinfG/d15QqMzuF8PTnhHSG
        O8r0VJ1K1z5mnCOmqwz/ZRxrGsF1hBcxaRNuPhiQU3V1FfW1LKfHj1qIFgreGI0Ab5E1udpruFa
        6y0M+jWmxdM/mO6Z6sJDgEVEOrMML
X-Received: by 2002:aa7:c4c1:: with SMTP id p1mr19783007edr.133.1619429311947;
        Mon, 26 Apr 2021 02:28:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytAfyLKl2YKK7lKos9PhDPbKzINP26aWILO7ar4wTBgQ7gjsJ4KrtD/Mf8e0g7fXX2pHMNmA==
X-Received: by 2002:aa7:c4c1:: with SMTP id p1mr19783001edr.133.1619429311818;
        Mon, 26 Apr 2021 02:28:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b8sm14195751edu.41.2021.04.26.02.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 02:28:31 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: Fix the check of return value
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        shuah@kernel.org
References: <20210426193138.118276-1-zhenzhong.duan@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d23822d-1510-d615-c3bf-200b6636b766@redhat.com>
Date:   Mon, 26 Apr 2021 11:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210426193138.118276-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/04/21 21:31, Zhenzhong Duan wrote:
> In vm_vcpu_rm() and kvm_vm_release(), a stale return value is checked in
> TEST_ASSERT macro.
> 
> Fix it by assigning variable ret with correct return value.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index b8849a1aca79..53d3a7eb0d47 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -514,7 +514,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
>   	ret = munmap(vcpu->state, vcpu_mmap_sz());
>   	TEST_ASSERT(ret == 0, "munmap of VCPU fd failed, rc: %i "
>   		"errno: %i", ret, errno);
> -	close(vcpu->fd);
> +	ret = close(vcpu->fd);
>   	TEST_ASSERT(ret == 0, "Close of VCPU fd failed, rc: %i "
>   		"errno: %i", ret, errno);
>   
> @@ -534,7 +534,7 @@ void kvm_vm_release(struct kvm_vm *vmp)
>   	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"
>   		"  vmp->fd: %i rc: %i errno: %i", vmp->fd, ret, errno);
>   
> -	close(vmp->kvm_fd);
> +	ret = close(vmp->kvm_fd);
>   	TEST_ASSERT(ret == 0, "Close of /dev/kvm fd failed,\n"
>   		"  vmp->kvm_fd: %i rc: %i errno: %i", vmp->kvm_fd, ret, errno);
>   }
> 

Queued, thanks.

Paolo

