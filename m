Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE90E5BDFB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiITITP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 04:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiITISm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 04:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DB66A4AE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663661730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/e/evqGTFru+f3l3LD+eG8BtO8WljnsYCWvP+vFWoVo=;
        b=eDQaU4MR3EIT167SGXa3MGrrjXE9bWfuIGaq7QyMV76+JpYfCqFx5kXzjTIjaeWX6fTGlB
        cyPqXImMoYyBCaKmKg5DO0P29gPoo4SDMMWjSSrjXUcY0g3MZWYA9Er8h/kSJLtat4lAky
        /AbmpB5h+vDcE7BVoXA+nVYz5xX6HJs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-0EzyKdSGNxKKnD_IvVgPXA-1; Tue, 20 Sep 2022 04:15:23 -0400
X-MC-Unique: 0EzyKdSGNxKKnD_IvVgPXA-1
Received: by mail-wm1-f71.google.com with SMTP id c128-20020a1c3586000000b003b324bb08c5so5911030wma.9
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 01:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/e/evqGTFru+f3l3LD+eG8BtO8WljnsYCWvP+vFWoVo=;
        b=LN+NNcIk132AepXg/v0mlTDzOL+vsciqnvSH+LsdL4ohQ6VMm+YKFeuoew129wGD4Q
         Sh/uVKZRBw5QPCGzHohTp9juTZvZ+kzyII0oSLtrKo+zI0XvXu4j/V5yM12nHXf/CLbV
         AxSa+kKACHt8+QM1vYuK634sIQ4PRh5R5E3pK4otxKvGUQyrxj2uuN55iOMt99Cfmk+H
         bqNO4zTZ1tdlet8kJ31u1RL29BXW2lrXdAFVowft6H9+W8A0++fI6MDCdhmnlswsWJV7
         fnJYCsYjL3iHI8hrUmDJPFVaP7+LuMWHm8leV3pvLrOG5ONScNDMW6NnARewWiw6WwPh
         1t8g==
X-Gm-Message-State: ACrzQf2O7F3HvzuiMrSsDc1jNadMpcyJ2Wk2QRW9dh9ZkUiiu2/GKNja
        3Y6cfhxQvc+OsK91ySPTv7UX3oFbfGi0vxheOFonOLM1gCshUl1uL/UVDVFctqRkpjpfau9FrI2
        llzd2TLEdbCwQ4OB2Z0XB66bkwwiZ
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr1396442wmb.20.1663661722198;
        Tue, 20 Sep 2022 01:15:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pb0rzdBr6watv2OP+RIFajUY8ofPhVTXwU2pExV8u2gef6cxMTASlsrhhKQd0N+G4n5cOww==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr1396424wmb.20.1663661721920;
        Tue, 20 Sep 2022 01:15:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id a5-20020adfe5c5000000b00228de58ae2bsm901775wrn.12.2022.09.20.01.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:15:21 -0700 (PDT)
Message-ID: <749470a3-e1c7-dc60-d7b7-4e5e3ffde8dd@redhat.com>
Date:   Tue, 20 Sep 2022 10:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/3] lib/notifier-error-inject: fix error when writing
 -errno to debugfs file
Content-Language: en-US
To:     Akinobu Mita <akinobu.mita@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        corbet@lwn.net, osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
 <20220919172418.45257-3-akinobu.mita@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220919172418.45257-3-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.09.22 19:24, Akinobu Mita wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()").
> 
> This restores the previous behaviour by using newly introduced
> DEFINE_SIMPLE_ATTRIBUTE_SIGNED instead of DEFINE_SIMPLE_ATTRIBUTE.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>   lib/notifier-error-inject.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
> index 21016b32d313..2b24ea6c9497 100644
> --- a/lib/notifier-error-inject.c
> +++ b/lib/notifier-error-inject.c
> @@ -15,7 +15,7 @@ static int debugfs_errno_get(void *data, u64 *val)
>   	return 0;
>   }
>   
> -DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
> +DEFINE_SIMPLE_ATTRIBUTE_SIGNED(fops_errno, debugfs_errno_get, debugfs_errno_set,
>   			"%lld\n");
>   
>   static struct dentry *debugfs_create_errno(const char *name, umode_t mode,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

