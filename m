Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20235F069E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiI3IfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 04:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiI3IfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 04:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906BA4B34
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664526908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSPa4FtzDmD4JTH1460N7eSs7BBD1Xd0E/VxTc3dU50=;
        b=IPQMOU669Jo8XIASV3Ns2hlzoDEr7lW4ovSLCCZDNDPU/3qnJMZGQzmIuSeOlYTZZ8/xCM
        VCdKBp5FoIWLD+k4Za4Cz1ss/RRo60jVdkA15GDTwELYpP6qe0Axeq48f1h4WiBNu+xXf7
        yOra6r5HD2qfmnJCQRroQgciN5G5aFs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-CstRhfYMPCWyMDzZYMzh_Q-1; Fri, 30 Sep 2022 04:35:06 -0400
X-MC-Unique: CstRhfYMPCWyMDzZYMzh_Q-1
Received: by mail-wm1-f69.google.com with SMTP id t14-20020a1c770e000000b003b4856a6ecaso1081920wmi.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=XSPa4FtzDmD4JTH1460N7eSs7BBD1Xd0E/VxTc3dU50=;
        b=gN5eX/qngqouMHXQsWghBSNa310m7CvKV3sYmMWECRp5KH3obYu/wbFO0Bej+Yq3us
         Ct2qeNyei6FIUkPbL4JV2Z5f8FxEW38VN0LsIAjnBNRa7XbHAvvYzsHb3skkr689Frt8
         3fEwJuG0nOmA9x1Pjnc5cjk9GvvV4/2Y3UvLZLy1nxmN0DSlfjMpo9QJh5eyY3a+yNGS
         oodwDGDHdZ0Now6XHZIsBDYyLOEcD7K4hib0j0ndjJYI8vhwLCAleqOwBrWsDvS6ZYyI
         nYnJApXUfZVvPs+dw59Ne5EcElczIUb3yDJNyZ5YUsGg1YQQVtdvPrqel7Dt0CHdelsJ
         pldw==
X-Gm-Message-State: ACrzQf1g5OoY0dSz7esAF1va7zGDzu5JYxp/RnTTFVzDHKcYXReZi9Vn
        8bp8Eitcrtg4eoUJk/6FGrvaP9MRAQ3Fs7XPdYdyQjRDcryOddhS/+zbPOyXK3Q1S1Lwc1nIbuS
        sNAxk7OwV6+4DjWotOAB6XwnnPy2e
X-Received: by 2002:a5d:457b:0:b0:22b:24d6:1a9f with SMTP id a27-20020a5d457b000000b0022b24d61a9fmr4791898wrc.201.1664526905291;
        Fri, 30 Sep 2022 01:35:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qbKFNb2m2Iu07r8/LxpIsS0EuY6Hrbu/kOEB16WwNHE5p0FYk3g9x2L3Nsyb/SpVgiNef4Q==
X-Received: by 2002:a5d:457b:0:b0:22b:24d6:1a9f with SMTP id a27-20020a5d457b000000b0022b24d61a9fmr4791882wrc.201.1664526905044;
        Fri, 30 Sep 2022 01:35:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4fc5000000b0022ccc22ca95sm1452643wrw.13.2022.09.30.01.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:35:04 -0700 (PDT)
Message-ID: <23acdcfa-efd5-755d-6cd5-0631fd3a721c@redhat.com>
Date:   Fri, 30 Sep 2022 10:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v5 3/4] selftests/memory-hotplug: Adjust log info
 for maintainability
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220930063527.108389-1-zhaogongyi@huawei.com>
 <20220930063527.108389-4-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930063527.108389-4-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30.09.22 08:35, Zhao Gongyi wrote:
> Redirect misleading error message to /dev/null for
> offline_memory_expect_success(), And, add an output
> for online->offline test.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 91a7457616bb..74ee5067a8ce 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -207,8 +207,11 @@ echo -e "\t trying to offline $target out of $hotpluggable_num memory block(s):"
>   for memory in `hotpluggable_online_memory`; do
>   	if [ "$target" -gt 0 ]; then
>   		echo "online->offline memory$memory"
> -		if offline_memory_expect_success $memory; then
> +		if offline_memory_expect_success $memory &>/dev/null; then
>   			target=$(($target - 1))
> +			echo "-> Success"
> +		else
> +			echo "-> Failure"
>   		fi
>   	fi
>   done
> @@ -267,7 +270,7 @@ prerequisite_extra
>   echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
>   for memory in `hotpluggable_online_memory`; do
>   	if [ $((RANDOM % 100)) -lt $ratio ]; then
> -		offline_memory_expect_success $memory
> +		offline_memory_expect_success $memory &>/dev/null

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

