Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4495A41632F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbhIWQ11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 12:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242160AbhIWQ1Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 12:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8Ah2Qh7p6T0mn87VL57RtyibfllbNYrDwoM7m+3Joo=;
        b=Uhuknb7Z49e0mHtA97Khg5/6Fc/q9Hedh5N0DpzcrWc/2QO1ZtMD6eqoLUsAOMrD40A0DI
        j9pKdNZ7SM+GT+TIOdBSFPikFC6EIcxFUPI5Okk0auIXrI9eKGEdX+MfzEuBSBj1ewjUIv
        973x0Lf7XtRF4XdHA9go3qQIPfPNH2E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fG-Eo86XOpqu5L6LiOXt7Q-1; Thu, 23 Sep 2021 12:25:50 -0400
X-MC-Unique: fG-Eo86XOpqu5L6LiOXt7Q-1
Received: by mail-ed1-f70.google.com with SMTP id a6-20020a50c306000000b003da30a380e1so2565084edb.23
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 09:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8Ah2Qh7p6T0mn87VL57RtyibfllbNYrDwoM7m+3Joo=;
        b=abPxIjWh+QxrFizgw3/GOUdmJWtZHmbMQTgIZ/xjXxHiEopjE26/v+2gTEWBTFxKHl
         uZPatKtpD419uPBPUJW93Gu7opDSGhUG7K1LRhuRavF3g/exfILcDWqkn3g0o3FSKCcd
         XUXEhfmsdYMPXD1a9mfmRnX7qaeIqupGFQr3ztGP+gzdYqnbirIqSbQHotERnHWp0coq
         ibddaBObXLxkm2WWeVV4jNm+/2RKQQiSNatbermopPDyZ+ergCRf7ibbc+3zZ6lG45TC
         n4Zwf1Npb++pvo+C8OGIJzHxOyb4u0r2etpCEggSWMwtVKAvgfUa0w5H5OSFELGKPCZl
         hjjg==
X-Gm-Message-State: AOAM531mesHvfxI5fSPlF47TB0Aej5H5iJJz+8RAt/I5ozGvkDxjnKld
        7Gw3M0XBwknZxoQdjr52qGv3P0bnTME+/qMsruq3heREhKVGOATTs3qgXWV4oakYWOmkjXavcHo
        3vy+OPBz0mCXkSHtj63KVffotF5oD
X-Received: by 2002:aa7:da93:: with SMTP id q19mr6706451eds.206.1632414349553;
        Thu, 23 Sep 2021 09:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9XnSwLPcjGBamhpDTdT3EiRg8QNymAoajRgXO8jyqO9O2UVhfynrBSpJ2DkEt/MKXS42ECQ==
X-Received: by 2002:aa7:da93:: with SMTP id q19mr6706421eds.206.1632414349350;
        Thu, 23 Sep 2021 09:25:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gl2sm3237224ejb.110.2021.09.23.09.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:25:48 -0700 (PDT)
Subject: Re: [PATCH] kvm: selftests: Fix spelling mistake "missmatch" ->
 "mismatch"
To:     Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210826120752.12633-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02094ffc-11c4-8b72-f889-a0654f95d2bb@redhat.com>
Date:   Thu, 23 Sep 2021 18:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826120752.12633-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/08/21 14:07, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/testing/selftests/kvm/lib/sparsebit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
> index a0d0c83d83de..50e0cf41a7dd 100644
> --- a/tools/testing/selftests/kvm/lib/sparsebit.c
> +++ b/tools/testing/selftests/kvm/lib/sparsebit.c
> @@ -1866,7 +1866,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
>   		 * of total bits set.
>   		 */
>   		if (s->num_set != total_bits_set) {
> -			fprintf(stderr, "Number of bits set missmatch,\n"
> +			fprintf(stderr, "Number of bits set mismatch,\n"
>   				"  s->num_set: 0x%lx total_bits_set: 0x%lx",
>   				s->num_set, total_bits_set);
>   
> 


Queued, thanks.

Paolo

