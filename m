Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAEE5FAD8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJKHbZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJKHbY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 03:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7389AEF
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Oct 2022 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665473481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JeVSXveS/kNQgmI8JGnjgb3M3A0IXYnCuYJT2dIjatI=;
        b=AlLwmS3Lw24pUqz9KKPGef1MXSUFQJ7B241p7nRfS9kVA4jGRrElxLTD6mG1YNIoyf6d9P
        zeoDfJkQiUvm/zrXdoFpyJ2Jhp8J6HJ3JPNmBGyzD6qBDepXMUYeY6OxIXVPOERyrz+4cu
        /SlCBTFMSbWOtQxcxLU4PKJ20WM9wAY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500--N1O4Ic_OVS-qFiBk1mSMA-1; Tue, 11 Oct 2022 03:31:20 -0400
X-MC-Unique: -N1O4Ic_OVS-qFiBk1mSMA-1
Received: by mail-wm1-f69.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so3450825wml.7
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Oct 2022 00:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeVSXveS/kNQgmI8JGnjgb3M3A0IXYnCuYJT2dIjatI=;
        b=bXxsT0TsgDfxeqNhzEoK+uTfdJxlFXKg3+b8Uv5xCvnC/vzjdNL36XhYHyzFUHcwSU
         IU5/4Bbu8xvgeM7N93umnehqnXvbk/OKSxiQf2gX9SOwihn1f3lJpxTTq9LnkLOvINGz
         R4RNgbouH1AzVFN/BfQdsoMoytBiVo366k6S1KolGNxb3rznqn5Dm4ZcC3TgewYIOSl9
         bWm8tkBnhjsIca9zAgj8tG30YrRlLHlClnBy4Za4M+nucigdvsr8iR/1NU+7iQI8fvan
         rrEin3cNN6Oo3sC+i+5edytLE8PTvlyAwGJ0jDaSwfiu2jppiyuXFKWelyzsW97T926J
         DNlQ==
X-Gm-Message-State: ACrzQf37HvFd59POtVpmZX0QKtCXo+u/QbWFpOb407r85U9rn/dc3YP1
        98YMbnijbKjekFwXlMrFqJW42P0/Sf5k73m4ERk3JtXlKbSrtVwDW6RUYuCcOTQ8qBHUsKEv9m+
        Dcs+Xbak7agdCZb/wZ4gfAmKarEVd
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr12167343wrf.141.1665473478947;
        Tue, 11 Oct 2022 00:31:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7r1GZcgsBLBlZVyDoGI+egr1BEdqjAarH2S2H6VNTDFxZziRZGyyHKBXhDDtBjK2BCNIbzsA==
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr12167315wrf.141.1665473478539;
        Tue, 11 Oct 2022 00:31:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6900:f110:6527:aa46:a922? (p200300cbc7096900f1106527aa46a922.dip0.t-ipconnect.de. [2003:cb:c709:6900:f110:6527:aa46:a922])
        by smtp.gmail.com with ESMTPSA id t128-20020a1c4686000000b003b4a699ce8esm9802959wma.6.2022.10.11.00.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:31:17 -0700 (PDT)
Message-ID: <eb839bff-90ff-adfe-c463-a20fdfa86b0e@redhat.com>
Date:   Tue, 11 Oct 2022 09:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next] selftests/memory-hotplug: Remove the redundant
 warning information
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     osalvador@suse.de, shuah@kernel.org
References: <20221011013926.200774-1-zhaogongyi@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221011013926.200774-1-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11.10.22 03:39, Zhao Gongyi wrote:
> Remove the redundant warning information of online_all_offline_memory()
> since there is a warning in online_memory_expect_success().
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 74ee5067a8ce..611be86eaf3d 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -138,7 +138,6 @@ online_all_offline_memory()
>   {
>   	for memory in `hotpluggable_offline_memory`; do
>   		if ! online_memory_expect_success $memory; then
> -			echo "$FUNCNAME $memory: unexpected fail" >&2
>   			retval=1
>   		fi
>   	done
> --
> 2.17.1
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

