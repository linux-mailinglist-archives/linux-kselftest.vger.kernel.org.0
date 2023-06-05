Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228757224C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjFELje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFELjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 07:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9991A5
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685965117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nw6c3Frym7PEsE78EAla72qbR0TE8qr6R9Rp/jfKLzY=;
        b=c3KCDTA2x1/0uawrkpqtcSTPcNEpw8/R8gs9uTdC2Ia8khwdFXe1DsB+oOtNhuP48Ti78L
        mpA27sLC6hiSFaZ/p4oDwOh7YtQJtk6pO9FPPK5WZN6Bki08eO+PMxUwPDhwVr1oMIv8Sr
        CA7auRZ7su/duDubpbEnziB27EbXPvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-4D56wSNDP6u0J3Npa7aZLQ-1; Mon, 05 Jun 2023 07:38:36 -0400
X-MC-Unique: 4D56wSNDP6u0J3Npa7aZLQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6f58e269eso25871235e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 04:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965115; x=1688557115;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nw6c3Frym7PEsE78EAla72qbR0TE8qr6R9Rp/jfKLzY=;
        b=Y9xe1JtTZKyn2gWdhL5VusuppKWloNreRDVMyzG+iPbL4fKgQujzblGJWQI3RgtPze
         Zo+n/kXoI9RcT9ahZXLXvZue1n7ejl9kxhIVB8IO1h6+V4rQrl3R51NizTN4Hnp27My6
         o0BNW35pLvzWkIss1zikuRBqHLkUm17an9hN5mbU6L/phu4ALD7q6kxs84PLIT1YsJha
         06mOe1SSypkWrosPvbFVxpDJWHzDiaOyF8isBYh+gM1gYtw9WdVNvm4OwCpXjMVdbcC8
         w20D8ffiZARdq8mh2GXoBJu7g3zlLblircZnbqT4w4MEZGvUR6tcq0ZvvQZ+sT6WoOOI
         As7g==
X-Gm-Message-State: AC+VfDyxjIO9Uj6zQeNHoffoWU3vlSZPX+lVFmnAfPs0GUtXJL2FR7rW
        IguPTwpSUuLMD+/kEARbRvatSonut4e7yYb6jzk8KCNCqhm0Ey84IDxJpgMLWLRzH3m5NhaR7EJ
        ET4Wa0BcKuD/nzi/9VV7ZBORp2mLM
X-Received: by 2002:a05:600c:294b:b0:3f2:549b:3ef2 with SMTP id n11-20020a05600c294b00b003f2549b3ef2mr7114538wmd.17.1685965115490;
        Mon, 05 Jun 2023 04:38:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kvL4JlLeuJgsapJ+Y6U3lmqfa/03WInR1fTsMNi3NgkfaVjGeDxgrx8WocL5SlrBLyA73Ng==
X-Received: by 2002:a05:600c:294b:b0:3f2:549b:3ef2 with SMTP id n11-20020a05600c294b00b003f2549b3ef2mr7114527wmd.17.1685965115287;
        Mon, 05 Jun 2023 04:38:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b003f1978bbcd6sm24406738wmo.3.2023.06.05.04.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:38:34 -0700 (PDT)
Message-ID: <c9ff1306-9918-5ca5-6578-9a05a164de26@redhat.com>
Date:   Mon, 5 Jun 2023 13:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 11/11] Documentation: kselftest: "make headers" is a
 prerequisite
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-12-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-12-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
> 
>      make headers && make -C tools/testing/selftests/mm
> 
> However, that's not yet documented anywhere. So add it to
> Documentation/dev-tools/kselftest.rst .
> 
> [1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   Documentation/dev-tools/kselftest.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 12b575b76b20..6e35d042199c 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -36,6 +36,7 @@ Running the selftests (hotplug tests are run in limited mode)
>   
>   To build the tests::
>   
> +  $ make headers
>     $ make -C tools/testing/selftests
>   
>   To run the tests::

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

