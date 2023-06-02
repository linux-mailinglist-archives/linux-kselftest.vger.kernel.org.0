Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9379471FED8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjFBKUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjFBKUd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D7E40
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685701170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgLDHXPX2IZLtz7SOTVGOnJeSheCUt+28MHjp4LRwzo=;
        b=CmkLXEcdJG6yey/Mv2xyOI4igZPMLkFZ1elGwzcTzl/73VtkIxJ9r2p6n881PjwudWjYx6
        YlfEpSE8lhbkYBVVVdpmMj+hQdAQ/DByQvKOGz3aQ3NJ9oD17o2KKMrMyc+AeWVxA8foCR
        +35T1PG3Cswr90x5Ct9zcEbAj9rtq+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-q5gQ2mUENgSifIi7JTS59w-1; Fri, 02 Jun 2023 06:19:29 -0400
X-MC-Unique: q5gQ2mUENgSifIi7JTS59w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30aefcc211fso971380f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701168; x=1688293168;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgLDHXPX2IZLtz7SOTVGOnJeSheCUt+28MHjp4LRwzo=;
        b=euUwXuxeJ6j94tWn7MNQyDuiei072gKy+SQ75QEPHsy17KlTNhbrBhXgw9Hfg3arhe
         B3Tq4M40ZdM81vvgHTPJ0dBl2vmwty5RE+cqVYav4GqPcb4QWe/8ozD0amKPuHyI3PsQ
         xiQxvyTGd9j4pk3kOlPle90iVWxitaMKfgzB1WGkDVeRlhMhTPjxhIkKcRNsbZMtz+07
         32ys94LmPuO/H/2zfQCOaa7UrRmx3yCSqEDl4COIgW/uUHMJwvrjCbF8tNobokwtBxf9
         jlLvZ2xHJ5Gfn8oojeYX0pHBb4QdCWUDxCTjarHpJQZR1q19Oj1yJNFu7ApADZjD2EP0
         6f5A==
X-Gm-Message-State: AC+VfDwZZBTwwkEg9uTySnFaSdbryjQ2MniK5A3SydwPkUV2BMPBu0cA
        S0eMHp+lAxyimP32iF7X7ZpqrqkDnDou/4GxFRlhK+KeP/g3giw1ZBqR46aEVU0VM/137IDPbW9
        KiI6yhG6c9kxbI07VCCXZY/6P5mFd
X-Received: by 2002:adf:e908:0:b0:307:a36b:e7b1 with SMTP id f8-20020adfe908000000b00307a36be7b1mr4270249wrm.5.1685701168058;
        Fri, 02 Jun 2023 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4E/eiNP/vn86p1E+l3RW0GQURo5l23eZb2+28Fm1bHrGkj3O36n10ajTDVlA2/H9wIv7YqQg==
X-Received: by 2002:adf:e908:0:b0:307:a36b:e7b1 with SMTP id f8-20020adfe908000000b00307a36be7b1mr4270235wrm.5.1685701167672;
        Fri, 02 Jun 2023 03:19:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b0030630120e56sm1236957wro.57.2023.06.02.03.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:19:27 -0700 (PDT)
Message-ID: <0a838454-90d0-9d85-fc2c-8c2571240fb5@redhat.com>
Date:   Fri, 2 Jun 2023 12:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 09/12] selftests/mm: move psize(), pshift() into
 vm_utils.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-10-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-10-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> This is in preparation for linking test programs with both vm_utils.c
> and uffd-common.c. The static inline routines would prevent that, and
> there is no particular need for inlining here, so turn these into normal
> functions that are more flexible to build and link.

I'm probably missing something important, but isn't it the most common 
thing to use "static inline" across multiple objects that we then link?

Hope you can enlighten me what the real issue here is.

-- 
Thanks,

David / dhildenb

