Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEB5EBBC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 09:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiI0Hlb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiI0Hl0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 03:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AFB91DB0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664264483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz0ur1AHxlH7fz/miPX8mkQPPUSyAQo52GQCeq+89y0=;
        b=YZG4xQSg/Fqa4WjHC60QqdtbfUj4b8VC7NT18r4X4jG7pdV4WNbLgcH4Ofa9P4FqD///4V
        baYSGLtyMmwqcM1/1lKlJLiJ1wlG5OerOZerD9jYVsfwCkfpSO5YIYro79BFl4Nboxf8WU
        eslWmSu8JNbY96ldQaPq4NGNPAnrqSY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-EyDSXhp9NWGwtvLBV9slog-1; Tue, 27 Sep 2022 03:41:22 -0400
X-MC-Unique: EyDSXhp9NWGwtvLBV9slog-1
Received: by mail-wr1-f70.google.com with SMTP id j16-20020adfa550000000b0022cbdfcea2dso301949wrb.19
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 00:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Wz0ur1AHxlH7fz/miPX8mkQPPUSyAQo52GQCeq+89y0=;
        b=Rg6qpBiU9ePM2u9GfZWVLWfJ3sPJUcZjP+Ty+NHxE3e6znh8PmZ2dw+9R09Fd95fGd
         GqQrpQVjq5we3bZ/h+veV+tvHSg7HxIQ34hNfIcUcDph3jRCoIVq27lYESbg7bWc7Tao
         EpPES+rqLebdsoSblobF5umyed4/E3xfkiXHcSEronCkt1oxnx181//gbADOCVwM46d2
         I6T8/P3qk8reGZLEkzFkapnVHC/2i+XiV2VS9/0RMB2pbGEHKZ7okXsbPJ6P41EBUJtV
         nwu3ZUADNUdIbJOyZpsMARdcaKh6woa9hNAN7FF2AsAsNUV2/kOJV83ipENtMIXvh4Y3
         PCwA==
X-Gm-Message-State: ACrzQf1Iw9ij5CBbIHeld3fxTrDYGrp22YxVeie0yQqDNWqCl3CGQS8W
        6E/9KKtaMUvQvZzt2iaWQId7X0LdRw5sijqOAz+CbcgUk4thvv7Gh5imuV6XUhHq7fSoikYPs8O
        xMODKlrUTQ/wfYDlSbjqOsNmyjOaT
X-Received: by 2002:a5d:64eb:0:b0:22b:fe0:98e2 with SMTP id g11-20020a5d64eb000000b0022b0fe098e2mr15858720wri.178.1664264480858;
        Tue, 27 Sep 2022 00:41:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7e+48WcaWEDSJYJpZ1vL2d444VYu79LJ/bkUvle1DpEGVRI2Nvd7IRUsVqoVTh4Ecfwry9Og==
X-Received: by 2002:a5d:64eb:0:b0:22b:fe0:98e2 with SMTP id g11-20020a5d64eb000000b0022b0fe098e2mr15858710wri.178.1664264480570;
        Tue, 27 Sep 2022 00:41:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80? (p200300cbc705ff009ec26ff611a13e80.dip0.t-ipconnect.de. [2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b4fdbb6319sm15712391wmq.21.2022.09.27.00.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 00:41:20 -0700 (PDT)
Message-ID: <9178c097-664b-11ce-272f-c24d24f012e7@redhat.com>
Date:   Tue, 27 Sep 2022 09:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v4 2/3] selftests/memory-hotplug: Restore memory
 before exit
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220927032851.128174-1-zhaogongyi@huawei.com>
 <20220927032851.128174-3-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220927032851.128174-3-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27.09.22 05:28, Zhao Gongyi wrote:
> Some momory will be left in offline state when calling
> offline_memory_expect_fail() failed. Restore it before exit.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../memory-hotplug/mem-on-off-test.sh         | 21 ++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 1d87611a7d52..91a7457616bb 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -134,6 +134,16 @@ offline_memory_expect_fail()
>   	return 0
>   }
> 
> +online_all_offline_memory()
> +{
> +	for memory in `hotpluggable_offline_memory`; do
> +		if ! online_memory_expect_success $memory; then
> +			echo "$FUNCNAME $memory: unexpected fail" >&2
> +			retval=1
> +		fi
> +	done
> +}
> +
>   error=-12
>   priority=0
>   # Run with default of ratio=2 for Kselftest run
> @@ -275,11 +285,7 @@ done
>   # Online all hot-pluggable memory
>   #
>   echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
> -for memory in `hotpluggable_offline_memory`; do
> -	if ! online_memory_expect_success $memory; then
> -		retval=1
> -	fi
> -done
> +online_all_offline_memory
> 
>   #
>   # Test memory hot-remove error handling (online => offline)
> @@ -296,4 +302,9 @@ done
>   echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
>   /sbin/modprobe -q -r memory-notifier-error-inject
> 
> +#
> +# Restore memory before exit
> +#
> +online_all_offline_memory
> +
>   exit $retval
> --

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

