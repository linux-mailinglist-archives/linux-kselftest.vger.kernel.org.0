Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F405F0689
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 10:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiI3IeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 04:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiI3IeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 04:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB401C6112
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664526841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qO+BdsidXtPxlgGBkdeG85IbyU5cabWapFdrZ2axzLg=;
        b=LvsGB3BWosNMAnQ0TXQP132X4W+mdOPrYuRltGaO/VFUY7sh2RcCYT4JCh/OheHBopigyq
        Go/KVAQIACee8eEu5OKAEhQa043HhDClrWa9/8qWCIcR3An5fFzwi7F7HJC5sc72U3v1Z5
        lEFy+TkfQpuMS8nfX32iHYrQUsRbkrs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-b77bwhesNHOgX78lhSXFpw-1; Fri, 30 Sep 2022 04:34:00 -0400
X-MC-Unique: b77bwhesNHOgX78lhSXFpw-1
Received: by mail-wm1-f69.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so1765635wma.0
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=qO+BdsidXtPxlgGBkdeG85IbyU5cabWapFdrZ2axzLg=;
        b=hg+wIM0WEjBkDWcXHFX6MG7KquNavPMUX/bRf4e9cQC0EkmXy5Y06wKHsE5ZFizMwK
         kyWn8WjdhoXbQFuwLgmcRllEviZcM5akWmXB4S+9GdPXxhzVnoVo6ig5hCb/E9bbqYO0
         af55/JvFHQVFYRGWyEzJDukys6THalJ/FYuVx+yi+Tpmo1UQlYGgABAHFBH+3R/En2Pc
         sQBluruEa5LPgYRqjYPj0BZexKEjzOb/DTT2JyH5ThtsQ3DeSLjIgKI2olc91TPZC5+s
         ojjEyjPwl4BPTOb7SQ7yzoHf22IkIiG0l4BNYwsX7JciOQXJZt97ziwN3eDU4pO4ygNs
         q8KA==
X-Gm-Message-State: ACrzQf0MwCPiqAhUT9F8GO5XkusdFXEGUu7Xg3F6zoAPmENkbSJmmSlW
        ud3EW0dQrIv9Jyt+BSlKJliDtAAI24N29EEKHrBRNRmKz6qVU2rjXfiZ+IC1mOEU3Li3/RtR0DW
        2zdThW/bg6LjYhNXrY13Ocu4AWXXV
X-Received: by 2002:a05:6000:384:b0:22a:5d05:c562 with SMTP id u4-20020a056000038400b0022a5d05c562mr4999339wrf.701.1664526838893;
        Fri, 30 Sep 2022 01:33:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6NRmhoyd+3R2o1xuvY/2jTk5yngLV7dYKGrw8U3pNLD5NdDevDCS6YN3KRzA4TJTUkM4dd2g==
X-Received: by 2002:a05:6000:384:b0:22a:5d05:c562 with SMTP id u4-20020a056000038400b0022a5d05c562mr4999314wrf.701.1664526838661;
        Fri, 30 Sep 2022 01:33:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm6534230wmh.23.2022.09.30.01.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:33:58 -0700 (PDT)
Message-ID: <b90f1f32-eac5-a1cd-436a-3486b704c9c9@redhat.com>
Date:   Fri, 30 Sep 2022 10:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v5 2/4] selftests/memory-hotplug: Restore memory
 before exit
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220930063527.108389-1-zhaogongyi@huawei.com>
 <20220930063527.108389-3-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930063527.108389-3-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30.09.22 08:35, Zhao Gongyi wrote:
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

Do we need that output?


-- 
Thanks,

David / dhildenb

