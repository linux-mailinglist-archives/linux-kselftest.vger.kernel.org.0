Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8271FE7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjFBKDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjFBKC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21F1B0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LeN1ZvKWASIvuhMUn/h41k33ceNTGk2ayxE3JMg58g=;
        b=iGf7G9F4skyx5qym0oMza4ZoFYtRierK8cBdW6Q04pn2B6pHfSB72ra3YyNu+xZu5n+YT+
        6eHLVE9LmncBuXTgFoitup7IHfoc+fTS3BAGUej9hqe7T39KFuppk/0HM5B0oswizSnfc6
        2jCUbFdTjdRp3dfuuBw/Xx0xA2QGt3Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-fA43wbNYP2mtXxlFxIECDg-1; Fri, 02 Jun 2023 06:02:04 -0400
X-MC-Unique: fA43wbNYP2mtXxlFxIECDg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so10393695e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700123; x=1688292123;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LeN1ZvKWASIvuhMUn/h41k33ceNTGk2ayxE3JMg58g=;
        b=OSvVsYVjSJxcR9j8bTeDWZWW0hTWZ4DqvZAr7SrqPRxk29warTm8YgLnUGPLr+Bof8
         V4yoZg4mP9G7fMh2TG3S3W3oPaBqYobZGUTds4OypLcaBv1IfRpB8YNHDQM6M4rfHGJs
         43Bq8BxwWTUkHORuqLKmtlUXqlebDs5Do4y+w608RoQjQTGozP8fWrIfeCuDB7KrD4Sz
         8EilRPDMMy2XImw5To5mbBUGk5+VKQdXDk+A5+FKCxnIAw2zaIcPZMT0Q+icvtWQMd4q
         LZbb0Ky0Mq512deheQ+SockULWRVo/xHQlXgaOD8Wn3m/poN+jeZnu6/cCptv2D460tc
         beoA==
X-Gm-Message-State: AC+VfDygnUCBqULRjrFN/nEKr8DUw1ish0FC/UVzu1PV6HUQmka4fKVN
        osqTRSY8rvYtgLmbBuXRlDcb/iZg3JZUUbhx1b+JjYBnGYw5uvnm2ZiYVqhYMRiRxKEfQmzgboJ
        QJR+pNTGekZq46XP/N1YP0dWponr4nfBG+XIX
X-Received: by 2002:a7b:ca54:0:b0:3f4:ed25:8aa9 with SMTP id m20-20020a7bca54000000b003f4ed258aa9mr1402120wml.36.1685700123016;
        Fri, 02 Jun 2023 03:02:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vn8po93EWcl8y+Md+1dkmCB87TioA1pld+VwWhSD0R2kUgLQWaJw2ea05+ATfemguHdoIhA==
X-Received: by 2002:a7b:ca54:0:b0:3f4:ed25:8aa9 with SMTP id m20-20020a7bca54000000b003f4ed258aa9mr1402106wml.36.1685700122662;
        Fri, 02 Jun 2023 03:02:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f6050d35c9sm1417655wmb.20.2023.06.02.03.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:02:02 -0700 (PDT)
Message-ID: <075c6a32-3829-b7fe-685e-0c19851788eb@redhat.com>
Date:   Fri, 2 Jun 2023 12:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/12] selftests/mm: fix unused variable warning in
 migration.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-4-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> Declare the variable as volatile, in order to avoid the clang compiler
> warning.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/migration.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 1cec8425e3ca..2dede662ff43 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -95,7 +95,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>   
>   void *access_mem(void *ptr)
>   {
> -	uint64_t y = 0;
> +	volatile uint64_t y = 0;
>   	volatile uint64_t *x = ptr;
>   
>   	while (1) {

Same comment as for previous patch.

-- 
Thanks,

David / dhildenb

