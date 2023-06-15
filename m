Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE63731342
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbjFOJLi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245471AbjFOJLg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 05:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D55D2D53
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686820239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jv6KFAXoteYK0f5ZCcCQQ5YKb/PGt9uZ7PhLXZP3wzo=;
        b=CqJC38lgP1ZI3HkagMlOZlhDASc97lYbliGkr5MtprGhdmAC6+s4TYAVlzUrKaeOvKamcK
        K79/Wkz0VQNSppepAQ4t0QkjH8I5VE1sX+GDg4XLNyzCApZxiqm2oJFHYGG3gn62NiTZj+
        AU4aAoQZwan0LsikGuOlQfP/pa6n4ZM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-HgD-t6QwPN6lqxfWs3DzEA-1; Thu, 15 Jun 2023 05:10:36 -0400
X-MC-Unique: HgD-t6QwPN6lqxfWs3DzEA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f59c4df0f9so6287546e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jun 2023 02:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820234; x=1689412234;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv6KFAXoteYK0f5ZCcCQQ5YKb/PGt9uZ7PhLXZP3wzo=;
        b=kuGxAuQrxd6xq8PCbwJIIsaoo32cQFxyAucgC6CjbzvDWZQ06/hblPiqE6w6UZWopo
         AknaDor9HpsrcEG6ZumaQggIFLHUmx93jR4VFtfG9/Oy6JvGMtKiqGEolgsizkT6W+4U
         /c+Gsatn9ZWOGSfkUu3ppzmyxLLdf82qUPhTj7nSZlAIxqeziC6ssR5KhRqHW3I5JaSy
         RlwMJNDDP+qWgYmzwr460KXp4UVVxJOXaVS8I1vLOjrNf2cf0rceRK3bj7YAYOMXVrDP
         dA8yDT8XAnvQ6+oM85FoJqyxMsDhStw+7YkX9DuDXB02aVB/phA/BPDtGAlypYagBrmn
         73tA==
X-Gm-Message-State: AC+VfDyG7AgZR2v867AdX9pNa9oiEcMDaMeDvKYMZ+VTm86vyucGdWTL
        0cvstArJEEl3Ul8KzcfW6VeSOIwwkaYnKfCyz8LjwsuO22x79AcJuWgaIL9EnTL8shVaJCbyOl+
        H0L7Og7h2kEGN5WPODwtlBI51+snID75XPar9
X-Received: by 2002:a19:5f45:0:b0:4f7:6238:4e52 with SMTP id a5-20020a195f45000000b004f762384e52mr3949938lfj.8.1686820234617;
        Thu, 15 Jun 2023 02:10:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c7QHcOyyddXm/rvL/xzVuaqmg0YuBctpdwXuD1hdnqKekHOPO+8Z+yTYcUcl2HnLjM/QyLw==
X-Received: by 2002:a19:5f45:0:b0:4f7:6238:4e52 with SMTP id a5-20020a195f45000000b004f762384e52mr3949914lfj.8.1686820234141;
        Thu, 15 Jun 2023 02:10:34 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b003f80946116dsm18381265wmf.45.2023.06.15.02.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 02:10:33 -0700 (PDT)
Message-ID: <c31e9046-02c1-9d4a-92d1-b96a8ed92cdf@redhat.com>
Date:   Thu, 15 Jun 2023 11:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests/mm: Add missing gitignore entries
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614-kselftest-mm-gitignore-v1-1-9c2643a25bbe@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230614-kselftest-mm-gitignore-v1-1-9c2643a25bbe@kernel.org>
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

On 15.06.23 01:23, Mark Brown wrote:
> We added the mkdirty and va_high_addr_switch tests but did not add the
> resulting binaries to .gitignore, do so.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 8917455f4f51..a94238e4fbc5 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -10,6 +10,7 @@ map_hugetlb
>   map_populate
>   thuge-gen
>   compaction_test
> +mkdirty
>   migration
>   mlock2-tests
>   mrelease_test
> @@ -28,6 +29,7 @@ mlock-random-test
>   virtual_address_range
>   gup_test
>   va_128TBswitch
> +va_high_addr_switch
>   map_fixed_noreplace
>   write_to_hugetlbfs
>   hmm-tests
> 
> ---
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> change-id: 20230614-kselftest-mm-gitignore-491da13f8ada
> 
> Best regards,

See

https://lkml.kernel.org/r/20230606071637.267103-6-jhubbard@nvidia.com

-- 
Cheers,

David / dhildenb

