Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4651C3ABA45
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhFQRJZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 13:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhFQRJS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 13:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623949628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+a31S7my7GZ/Y4MvDMd+Xgr66kYGwopRSGlVKuP0z8=;
        b=jLgWeGWJwOAyozNUDuUNzJKWOKPedAspOITB9A9gCSw/OiP5iNgd1qsbhw1MtNEwI1epUk
        RLCqWXLgBn/si/Og60IHRC/nAimmXHOZtsTRgZ/rPl0HF5gAO2Pd1M41ESfOo46GsgbgdI
        ZoZwRrl1+tKjDlIpZiEvO/srFe+4pbM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-TgeRJS8hMSKi2mFiGO8q-A-1; Thu, 17 Jun 2021 13:07:06 -0400
X-MC-Unique: TgeRJS8hMSKi2mFiGO8q-A-1
Received: by mail-ed1-f70.google.com with SMTP id x12-20020a05640226ccb0290393aaa6e811so2016429edd.19
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 10:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+a31S7my7GZ/Y4MvDMd+Xgr66kYGwopRSGlVKuP0z8=;
        b=h5svzAYfxnBZdru/tRN1vxh/5MJyyrvqnaKei/i/h07H+e+lNhgqftAdcgKzGDX2pz
         2BAIXdhYqFRqedqjo70FEKQCG2U1iSd93587vSUmiERAGRUIPssGD1uxV0MFKvJCS9pm
         n1ouMYfP0q+vsGSBuWwo7uGDS25fewqQ5n+XXGbx+rqzaGel84VyJaIWfra0ESCh8msz
         CctdyYMFs3AsQZw4oxFl/SOY7Z5p15XPJ2jheF6OizcYwArhEylPfV0NlbIt276ibCyA
         2HVwFHcjEliIN38M42XIGpfe0x0tGsGAkx5AUjUy/FAF7JqwSeJULl1kQziJ4Ikn6K3v
         vUZg==
X-Gm-Message-State: AOAM532eim6fuhiOZ2BPhJIGFsybgXdn5s5InVVxh9hujMHM4uU4usTQ
        QxaRFnqNJbacooR30xI6t9X9FxkJr0eNIkLR1sQVNVCw0fNOpk5WjF6L+cCIxTD2bjwSXS4XRIm
        /1z1ymy3a+637+YoDupoI4b1m7hYS
X-Received: by 2002:a17:906:6b8a:: with SMTP id l10mr6272317ejr.125.1623949625716;
        Thu, 17 Jun 2021 10:07:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBQ1+tAZt7E3DGh3fI4tCCNq459QgOUf9lYOQCSk9FJgn1gHp6lSQqv0kJCv0hc/2D7vtieQ==
X-Received: by 2002:a17:906:6b8a:: with SMTP id l10mr6272298ejr.125.1623949625560;
        Thu, 17 Jun 2021 10:07:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id de24sm4121343ejc.78.2021.06.17.10.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 10:07:04 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix kvm_check_cap() assertion
To:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20210615150443.1183365-1-tabba@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea3ed990-5af2-6f1b-1e6f-eb45824b342b@redhat.com>
Date:   Thu, 17 Jun 2021 19:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210615150443.1183365-1-tabba@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/06/21 17:04, Fuad Tabba wrote:
> KVM_CHECK_EXTENSION ioctl can return any negative value on error,
> and not necessarily -1. Change the assertion to reflect that.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 5c70596dd1b9..a2b732cf96ea 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -82,7 +82,7 @@ int kvm_check_cap(long cap)
>   
>   	kvm_fd = open_kvm_dev_path_or_exit();
>   	ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
> -	TEST_ASSERT(ret != -1, "KVM_CHECK_EXTENSION IOCTL failed,\n"
> +	TEST_ASSERT(ret >= 0, "KVM_CHECK_EXTENSION IOCTL failed,\n"
>   		"  rc: %i errno: %i", ret, errno);
>   
>   	close(kvm_fd);
> 

Queued, thanks.

Paolo

