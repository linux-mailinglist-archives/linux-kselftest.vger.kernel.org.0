Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE15F0682
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiI3IdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 04:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiI3IdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 04:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9B121656
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664526783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ5gZ6bT2BXV787qrrKGQYFWxueLE8QhlhnLUB2rrGg=;
        b=VziK5ZQdsfIwRGws6uU2Rl+FMO1T+qjJXhbjbxUcAQ+SCnUWp4MsqtC8XIIffpLWx1RKgi
        dGSgxpKm8XWNmRd/8v1viSNqL/c28UQ8fKvVTg5uzmLbpZTNNh9segikjg+OvWjRZ85vmZ
        ITfQULum+SJXTXfex0Io8ynEU0W7bd8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-i_zD5O5vORuFKiXUc2CVzQ-1; Fri, 30 Sep 2022 04:33:01 -0400
X-MC-Unique: i_zD5O5vORuFKiXUc2CVzQ-1
Received: by mail-wm1-f69.google.com with SMTP id b5-20020a05600c4e0500b003b499f99aceso4137731wmq.1
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BQ5gZ6bT2BXV787qrrKGQYFWxueLE8QhlhnLUB2rrGg=;
        b=lHz2DISE+H/Zbs/2Je4iPsAvOWofb3R4cK+I3ISr0BLnheyFIthaZGcfFX+qbcjTSP
         EJw2v9ez+x2Nmbw8ertjhhmhU3va0BkZ5EeAJWYRHMbyKfVL3Y30dlp/eW3zhNwev0KT
         BvqIWA//1VzveNhCV0SGwTtwILgyUEXSlZ1GFgHS0F9TQanKF+UI7ZfwesQ/KZbraMql
         i8pO5X+IZLKK9pNPE7QCpHOU11w347i1QElcb15ozobAZF1HGvk65ZzTwUxkkour3aQf
         DaI7ymnl25R96cXYpYdWT44cu++OsdaaVcWKZkuGqn2Iy5KApnXSyGTqzJlzflo0MlVx
         Teew==
X-Gm-Message-State: ACrzQf2CyMON//yowohhXdStl37qpTJ1KDLoNTWHAnnQRv3MFwB6CgbW
        VHoA1UCh+VHAYuGWebP9YP9vzR8o6fohUjRKXpdS0z8dQsHHM2668vp0bMZZnVNOHax9TBkSV6l
        QkFkQQLYKaFUFck+waC5tvpeZ/4cL
X-Received: by 2002:a05:6000:2ad:b0:22a:399b:5611 with SMTP id l13-20020a05600002ad00b0022a399b5611mr5097680wry.434.1664526780598;
        Fri, 30 Sep 2022 01:33:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6BggB4PAQL9WnQm9Jcg4NtjrhEsaMOQneWlKdBdhs/6z+OcuyCuOZtBBg4ExM/WvGTFSIg9g==
X-Received: by 2002:a05:6000:2ad:b0:22a:399b:5611 with SMTP id l13-20020a05600002ad00b0022a399b5611mr5097665wry.434.1664526780357;
        Fri, 30 Sep 2022 01:33:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a2f2bb72d5sm8554440wmq.45.2022.09.30.01.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:32:59 -0700 (PDT)
Message-ID: <ed43e84a-60af-1e04-b635-9f03a720f258@redhat.com>
Date:   Fri, 30 Sep 2022 10:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v5 1/4] selftests/memory-hotplug: Add checking after
 online or offline
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220930063527.108389-1-zhaogongyi@huawei.com>
 <20220930063527.108389-2-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930063527.108389-2-zhaogongyi@huawei.com>
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
> Add checking for online_memory_expect_success()/
> offline_memory_expect_success()/offline_memory_expect_fail(), or
> the test would exit 0 although the functions return 1.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

