Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8A24054B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgHJLXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 07:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgHJLVm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 07:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597058496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wbjRsGzwJSEIgmC6+jZ5HmKMMdsjr2TIwdTADa3P68=;
        b=VoueQ3j9dqQUxWZC1W4n8nyjj8kRjafV2QIdR74OtuXTlUqEWhiIL1/LB74yI9sanGMXlW
        YoKLpHdl0SmI1KAKFCXnDHGOHX53HPTImAoX6z4rZ6TPjRLXlK+9bkH86reGL96Rm2N07Y
        ZfHtAUZA24W7wR6JqG4A9nZjRv6meSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-isJaWk9pNeyLXzwBWa-CXg-1; Mon, 10 Aug 2020 07:21:33 -0400
X-MC-Unique: isJaWk9pNeyLXzwBWa-CXg-1
Received: by mail-wr1-f72.google.com with SMTP id e12so4094921wra.13
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 04:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wbjRsGzwJSEIgmC6+jZ5HmKMMdsjr2TIwdTADa3P68=;
        b=Cy5lu82SAl+5dBcB7HAFoOeVa4Mx8e6dHYuqGR0zPbz/xUeC+AXjzBZRM5z+Ahlsum
         UEd9wqfAly2yx7qMtfWz686uAagvdXToi5K+uuu9PfF903zrE+QNXN7bfVciONzvhkqQ
         NFp3JziQkSo0Yml86y3M8tvPd3FsZLBzQnRXts9S6Vv1JzQYxSMUFn4AhSN5FBEwNVJQ
         sv6GQo/BuMaub9WR0eXA0/blptjDR0OMn3soHLjpuTLfzszP40Y/VHfBHLsfB6JsLzms
         84YDNKzzLFN4zbbZBYcyTiMx7VPMTgyHUbdWotTcGaF6SK+vfUxCsO/+BOx93ttsYBjo
         IPOg==
X-Gm-Message-State: AOAM531Qc1/dv8RFNxPorXL/Ms84se6JDFzU71wJmxW5rzpgBLDGEgjf
        yv0BVc6saSc0J+FSQWSf1ebX/oEC5L7xqIdtIFcAFD3nJkWhBl4Z4bdx270NnKzETmLTQnET0mJ
        xfQpEjT24tqqgakOL3wm8aMlmmudd
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr24714529wmh.55.1597058491523;
        Mon, 10 Aug 2020 04:21:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4UxkLVkYR0qaII68uf1rniVKRN+p8dcjGLxPoccx8ZjhNhB4Iqyr7JqQEeHpxQbiDZVqm6Q==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr24714515wmh.55.1597058491320;
        Mon, 10 Aug 2020 04:21:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103? ([2001:b07:6468:f312:5d6c:f50:4462:5103])
        by smtp.gmail.com with ESMTPSA id o125sm23557595wma.27.2020.08.10.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 04:21:30 -0700 (PDT)
Subject: Re: [PATCH] kvm: selftests: fix spelling mistake: "missmatch" ->
 "missmatch"
To:     Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200810101647.62039-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb65571b-555d-c5e6-1242-a12881a13e01@redhat.com>
Date:   Mon, 10 Aug 2020 13:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810101647.62039-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/08/20 12:16, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/kvm/lib/sparsebit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
> index 031ba3c932ed..59ffba902e61 100644
> --- a/tools/testing/selftests/kvm/lib/sparsebit.c
> +++ b/tools/testing/selftests/kvm/lib/sparsebit.c
> @@ -1866,7 +1866,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
>  		 * of total bits set.
>  		 */
>  		if (s->num_set != total_bits_set) {
> -			fprintf(stderr, "Number of bits set missmatch,\n"
> +			fprintf(stderr, "Number of bits set mismatch,\n"
>  				"  s->num_set: 0x%lx total_bits_set: 0x%lx",
>  				s->num_set, total_bits_set);
>  
> 

If you have a script that generates the commit message, that needs a
fix. :)  Queued though.

Paolo

