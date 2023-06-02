Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE371FE83
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjFBKFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjFBKFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D44CC0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hyZGB3MGa7vf2rLRzCGFNwMw9GG2IWMkUvaL/SujQg=;
        b=c2q8LjwNnRvS/SDTzF5myjeC9SPBkFI231d2+ubaSMIdYTcbUdzzxsVcuVlaftsV0ZEuqU
        guBy3HHni/Nf5g5i7mZb7kkG2g7VkfM/Yl0YfwaX+wlCQUPxdMNqD3vHfXQVeGYAHikUWW
        kVuBm45ccJ7rgWHb1CqHbyQP1Usew74=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ukurCD2TM0SA70dlxnlp5g-1; Fri, 02 Jun 2023 06:05:00 -0400
X-MC-Unique: ukurCD2TM0SA70dlxnlp5g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b1a7e54365so9595831fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700299; x=1688292299;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hyZGB3MGa7vf2rLRzCGFNwMw9GG2IWMkUvaL/SujQg=;
        b=CVIyhYXHkaNzikg3o3s01s8d+OoTFh2A0Phyd+eQMwOXdVIjmlJVOf8O5g/nB1pOUF
         84aCxekWLRApGNNKiQFEVpB2QUUb9HIgyPRyLjNC7IMWyMLJHw5I0mY2WjJ0WSkcHJt+
         oXjZ58DKa07TWAdV2gvEK7I9nFcJjW8IHv0BR+6Cr3L1iWfA3PaZ4EVC9N0Mh7cyNWAx
         zIp6KiB9mhz7YNVx7/KXLP56sJiJlpbSUpNcpvFauLcC4OHag6qaqixL5aaBY3ll2x0W
         IMvJMbZYeuEhKtkCbNNsBAUrNwG7Bm/y8zOFWY44n6Ua69FSYGNZv3cfd95IZ/KFH7Vu
         eBew==
X-Gm-Message-State: AC+VfDyGksXrdlDepH07dePXhoQMlBQtPiQVRM+lXTNFGvX1f3TI9HrU
        yAMidqhXGRd794SPQFpmZOJtcLbvakqZb7zbLvUbJnEXXufIWlZ5d07ky+NobCD42aBuSP68W3o
        l9xXZpLx1/Y+8fd3LnUDi6L9lrn+U
X-Received: by 2002:a19:c214:0:b0:4f4:b92c:eef5 with SMTP id l20-20020a19c214000000b004f4b92ceef5mr1538954lfc.68.1685700299104;
        Fri, 02 Jun 2023 03:04:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4euVi2YxX2kiLZiXSZix61kY1chJny4ldV+5M2F0upuUba6zeVerZNKoZi8PAcRklKRWjZ/g==
X-Received: by 2002:a19:c214:0:b0:4f4:b92c:eef5 with SMTP id l20-20020a19c214000000b004f4b92ceef5mr1538940lfc.68.1685700298705;
        Fri, 02 Jun 2023 03:04:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0030647d1f34bsm1244929wrp.1.2023.06.02.03.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:04:58 -0700 (PDT)
Message-ID: <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com>
Date:   Fri, 2 Jun 2023 12:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 04/12] selftests/mm: fix a char* assignment in
 mlock2-tests.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-5-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-5-jhubbard@nvidia.com>
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
> The stop variable is a char*, so use "\0" when assigning to it, rather
> than attempting to assign a character type. This was generating a
> warning when compiling with clang.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/mlock2-tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> index 11b2301f3aa3..8ee95077dc25 100644
> --- a/tools/testing/selftests/mm/mlock2-tests.c
> +++ b/tools/testing/selftests/mm/mlock2-tests.c
> @@ -50,7 +50,7 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
>   			printf("cannot parse /proc/self/maps\n");
>   			goto out;
>   		}
> -		stop = '\0';
> +		stop = "\0";
>   
>   		sscanf(line, "%lx", &start);
>   		sscanf(end_addr, "%lx", &end);


I'm probably missing something, but what is the stop variable supposed 
to do here? It's completely unused, no?

if (!strchr(end_addr, ' ')) {
	printf("cannot parse /proc/self/maps\n");
	goto out;
}

-- 
Thanks,

David / dhildenb

