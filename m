Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EE5BDFE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiITIVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiITIUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 04:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C9EB7B
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663661968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gk3kLlspQCYjPujhZljAtxcOT9dALJ6AajDjY8rEpQ=;
        b=d3PXYXT+YXcQoPdJ7SmI+s9Guxv/wwEDvKFSGiUh+JMn24YBuP0Tv+HFVNub0GGFhdEaLw
        A2LYsDZAmjkuLlk8ppGDDk1rrhKixQxbgf4MCRUATRbpxPTDtAv816wnXDedFL6sNsapkZ
        5R2C8LY05fJfILxM6y2jMysVAjAowhs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-xSK4Q_gKMOeYAeyPZkrzlg-1; Tue, 20 Sep 2022 04:19:26 -0400
X-MC-Unique: xSK4Q_gKMOeYAeyPZkrzlg-1
Received: by mail-wr1-f70.google.com with SMTP id o7-20020adfba07000000b00228663f217fso830503wrg.20
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Sep 2022 01:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5gk3kLlspQCYjPujhZljAtxcOT9dALJ6AajDjY8rEpQ=;
        b=G4WkuyFlNSwx5JiwU1w9UFjDUb5WnHifJMVXt3U21XNsFoO56H3l2kJv2+pnF6+F3Y
         xPKrixGDkDXz02cSfUGF+PFLKtzGS6RbcgFWnDil2rIGKoyG94OJNTlchgPrnVfGWtWW
         427y8KjlubEO9NlgUb+srkpfPZaW6mnaln+RHEW0noiSPitPvejtNwESLrBaQnJMWY/9
         Vqc6ZK8E4rsnuoa6wEZwWHPjGirxNNxHHQteleYILJ3RM2LdM3Z6/g5947j5yuw8srPD
         8HrA3z3n1SxoKEkzwz0qiKBX+7/2ElqtoJS8tR1hSW8q8uO35TcfASnrHrHa4BMqCKK3
         Sslg==
X-Gm-Message-State: ACrzQf2zmij56bMkQsZEOYnQ1HliDbCCYkm32avzGiNx7Vd0KEmJwPI9
        2dN01Kf9kLALxbTADT5sTPSVqinlQ2kQJRZ5eGCw5IF3k7w6C6pOh4iT0kYUYXlLeDEjJjXYmv2
        8+T39Fb3doMH4KaBurj2CYAgo2fxh
X-Received: by 2002:a05:600c:5d3:b0:3b4:c326:d096 with SMTP id p19-20020a05600c05d300b003b4c326d096mr1455793wmd.98.1663661965721;
        Tue, 20 Sep 2022 01:19:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM699k74ssA2kGuvCCoIhZaRcQrvxVrQkbuqjTWhJzQr+8vhrPtqFiDe49El6iFxQE3O3R+O2w==
X-Received: by 2002:a05:600c:5d3:b0:3b4:c326:d096 with SMTP id p19-20020a05600c05d300b003b4c326d096mr1455764wmd.98.1663661965297;
        Tue, 20 Sep 2022 01:19:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id l9-20020a1ced09000000b003b49aa8083esm1325807wmh.42.2022.09.20.01.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:19:24 -0700 (PDT)
Message-ID: <a127720d-ed49-5d20-4d63-13da8914652d@redhat.com>
Date:   Tue, 20 Sep 2022 10:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 3/3] debugfs: fix error when writing negative value to
 atomic_t debugfs file
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
 <20220919172418.45257-4-akinobu.mita@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220919172418.45257-4-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.09.22 19:24, Akinobu Mita wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), so we have to use a 64-bit value to write a
> negative value for a debugfs file created by debugfs_create_atomic_t().

Is that comment stale?

I would ahve thought you simply document that we restore the original 
behavior essentially by reverting 005747526d4f ("docs: fault-injection: 
fix non-working usage of negative values") and the using 
DEFINE_DEBUGFS_ATTRIBUTE_SIGNED accordingly.

> 
> This restores the previous behaviour by introducing
> DEFINE_DEBUGFS_ATTRIBUTE_SIGNED for a signed value.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>


Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

