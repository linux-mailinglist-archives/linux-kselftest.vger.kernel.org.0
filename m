Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE15EBB6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiI0H0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0H0r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 03:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657E8564EB
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664263605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9ODtW5t5SdFcjBY6SIxecQUGUZ3KwRU79qXAI2vn/s=;
        b=DCLhUR2CbJNisa7OggIHHKIhyh/wbxz+hwJB9dFSD7CwgiE5z9pSAllz0DRlqNAiTFbORs
        fiHSz1RDcDtkU3rLgEeRsXaR+w6l4PTOKNEcUwfnJxNO3T9ZzIBLaQraYa2Rh86oinnSv1
        qpwTGWOCToqeaFT+kCWAWoWHdIuxipM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-I18ueXqoMZKBPgDjj097Xw-1; Tue, 27 Sep 2022 03:26:44 -0400
X-MC-Unique: I18ueXqoMZKBPgDjj097Xw-1
Received: by mail-wm1-f70.google.com with SMTP id r7-20020a1c4407000000b003b3f017f259so5153606wma.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 00:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=W9ODtW5t5SdFcjBY6SIxecQUGUZ3KwRU79qXAI2vn/s=;
        b=FvQowO33dU6KnVFQmbbYfpE85l8sTDuLvNlEtC8y0ZzhCcdIn9ykpZGyeBVssEcwHw
         a6hzB/LcN4vEhWLEgXdK+jr6FDaBvh0sKwaIAV9OZxOftMmuQbmHLM3+CseROVEoKNMA
         VIpmrtnARILA6fTO9zfJguZlOJTxS+TFfBbPDeYmEeb3lijbpusK9wZ6UcAGFg9TSY3G
         bvZqNG5XLe4jawc7xug67ObHYWOMJjuEtnpGosLVQvOJZNeAqx/4AAPjnzPPLXuzL667
         jtcyK1CtEE21vRXQ5xae2SagY3UGYTrveaaiodtSDxGb3xKR9Mbp+AanSuOhzj12Z6kh
         RvNw==
X-Gm-Message-State: ACrzQf2+AgWNmzWhXRBjaN1vsVnWfAaRC6sNB9ETybcvEArI227ecC5t
        VHIcGJQuEHfE2MJeY67KmzAl9arL56i3nyqp1Qy4ID4CELDG7ETIkpuQNcB2+JBDD9VfwU3Bz3V
        CylG0BSwWldDy11ob6waBFzOsEgac
X-Received: by 2002:a05:600c:19cc:b0:3b4:adca:a821 with SMTP id u12-20020a05600c19cc00b003b4adcaa821mr1501646wmq.37.1664263602895;
        Tue, 27 Sep 2022 00:26:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/u7dRyYkitd+pZfI4fWVynEDAa14tDXYouDfpjUugWODzpdBq08pRSKrBR8ZnTmXtzQFY8g==
X-Received: by 2002:a05:600c:19cc:b0:3b4:adca:a821 with SMTP id u12-20020a05600c19cc00b003b4adcaa821mr1501630wmq.37.1664263602593;
        Tue, 27 Sep 2022 00:26:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80? (p200300cbc705ff009ec26ff611a13e80.dip0.t-ipconnect.de. [2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80])
        by smtp.gmail.com with ESMTPSA id jb6-20020a05600c54e600b003a5537bb2besm885860wmb.25.2022.09.27.00.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 00:26:42 -0700 (PDT)
Message-ID: <5b62011e-e41c-ffb8-68f6-80e55925498c@redhat.com>
Date:   Tue, 27 Sep 2022 09:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220927032851.128174-1-zhaogongyi@huawei.com>
 <20220927032851.128174-2-zhaogongyi@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH -next v4 1/3] selftests/memory-hotplug: Add checking after
 online or offline
In-Reply-To: <20220927032851.128174-2-zhaogongyi@huawei.com>
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
> Add checking for online_memory_expect_success()/
> offline_memory_expect_success()/offline_memory_expect_fail(), or
> the test would exit 0 although the functions return 1.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../selftests/memory-hotplug/mem-on-off-test.sh      | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 46a97f318f58..1d87611a7d52 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -266,7 +266,9 @@ done
>   #
>   echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
>   for memory in `hotpluggable_offline_memory`; do
> -	online_memory_expect_fail $memory
> +	if ! online_memory_expect_fail $memory; then
> +		retval=1
> +	fi
>   done
> 
>   #
> @@ -274,7 +276,9 @@ done
>   #
>   echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
>   for memory in `hotpluggable_offline_memory`; do
> -	online_memory_expect_success $memory
> +	if ! online_memory_expect_success $memory; then
> +		retval=1
> +	fi
>   done
> 
>   #
> @@ -283,7 +287,9 @@ done
>   echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
>   for memory in `hotpluggable_online_memory`; do
>   	if [ $((RANDOM % 100)) -lt $ratio ]; then
> -		offline_memory_expect_fail $memory
> +		if ! offline_memory_expect_fail $memory; then
> +			retval=1
> +		fi
>   	fi


LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>


I am questioning the stability of the offlining test, though.
Offlining a random memory block can fail easily, because "->removable" is not
expressive:

# tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
Test scope: 2% hotplug memory
          online all hot-pluggable memory in offline state:
                  SKIPPED - no hot-pluggable memory in offline state
          offline 2% hot-pluggable memory in online state
          trying to offline 2 out of 96 memory block(s):
online->offline memory0
tools/testing/selftests/memory-hotplug/mem-on-off-test.sh: line 78: echo: write error: Invalid argument
offline_memory_expect_success 0: unexpected fail
online->offline memory10
online->offline memory11


I guess this test will almost always fail nowadays.

-- 
Thanks,

David / dhildenb

