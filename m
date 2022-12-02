Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C99640D10
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 19:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiLBSZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiLBSZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 13:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A04ED80E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670005453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5BTufQpndp/9gXIDoDcOexJN+Na84y6kRix0xZynyE=;
        b=Htf8I9/Zdt34OD1r9VNhMUTXg+/RqXCqWT8j5ei2pXpnVXrZXtVnKQ2VBV5BvRMMmXJsm8
        S1x2WGFcVteYUjeZWI0PF3jJ2jgHaUql1lH22W3RdePvAnGVTFrSdTKvq3in3dUFYGFIGN
        R6RoKec15gTsOVY9BHo5iwC5UXZ6gBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-1XSS_Un1Nc-yDjuW4WV-Ug-1; Fri, 02 Dec 2022 13:24:12 -0500
X-MC-Unique: 1XSS_Un1Nc-yDjuW4WV-Ug-1
Received: by mail-wm1-f72.google.com with SMTP id 8-20020a05600c228800b003d0376e42deso2234485wmf.4
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 10:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5BTufQpndp/9gXIDoDcOexJN+Na84y6kRix0xZynyE=;
        b=w7pxvhRXqbnvrYa75jWvusVpzExYSBzaWqLT3Hp6J8WkufO5+Ynx6B9Zaxf2bP4EOX
         7GqXGu/SZRmLcXcScsXwU/D3QQsLoC5ZrhM1kCFfc4h/FYfMx1QIOOJVgK6+oN5Kr4BD
         9hwv2x1+H8jy1gbUF4VXXxcoMEjqJ6UbqXk9Ukpg2Q0ZB870ITahDgpbMdlGqlJ0Bvsx
         omI3gqQue7sbWeH2meGoJ+kFq45H5ASecFnbJN5rfagPYJhrn+qBDhOF2DOkLWQySt/g
         k9Qy2czuGxB7hZiSC0KD5szBWwRwCGu9s4k5xZAZ0BWqrddvN/6iS1vna56cc32dUEHK
         DfyQ==
X-Gm-Message-State: ANoB5plDLc0H/wbO7Fo3DaU1mSynsTl4VC3mWc9mtesFDXEXIFfKCNjD
        6UBWENOKnG3lRdpZ6u/EuhsGsshBpFrCvJzDrx7nAOAb/77OlJtqS54a4kUR3V/lTXHvmQG1Ky8
        sFhhtYb7Ucrn5v0rGWxlEMxXMdFzv
X-Received: by 2002:a05:600c:3d8b:b0:3d0:545:a0 with SMTP id bi11-20020a05600c3d8b00b003d0054500a0mr41074870wmb.123.1670005451144;
        Fri, 02 Dec 2022 10:24:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf79r6iGZnLxiQq0xFSEHBCA0qq6guXmdR+rJp0CazGPyxvYLlK7pomrpAN5b8b1jQb4w14YVQ==
X-Received: by 2002:a05:600c:3d8b:b0:3d0:545:a0 with SMTP id bi11-20020a05600c3d8b00b003d0054500a0mr41074863wmb.123.1670005450938;
        Fri, 02 Dec 2022 10:24:10 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bs4-20020a056000070400b0023677081f3asm7649064wrb.42.2022.12.02.10.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:24:10 -0800 (PST)
Message-ID: <809a6a89-1046-cd38-60ab-6c4c60045b4f@redhat.com>
Date:   Fri, 2 Dec 2022 19:24:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "probabalistic" -> "probabilistic"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201091354.1613652-1-colin.i.king@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221201091354.1613652-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/22 10:13, Colin Ian King wrote:
> There is a spelling mistake in some help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/kvm/dirty_log_perf_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index c33e89012ae6..e9d6d1aecf89 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -398,7 +398,7 @@ static void help(char *name)
>   	printf(" -x: Split the memory region into this number of memslots.\n"
>   	       "     (default: 1)\n");
>   	printf(" -w: specify the percentage of pages which should be written to\n"
> -	       "     as an integer from 0-100 inclusive. This is probabalistic,\n"
> +	       "     as an integer from 0-100 inclusive. This is probabilistic,\n"
>   	       "     so -w X means each page has an X%% chance of writing\n"
>   	       "     and a (100-X)%% chance of reading.\n"
>   	       "     (default: 100 i.e. all pages are written to.)\n");

Queued, thanks.

Paolo

