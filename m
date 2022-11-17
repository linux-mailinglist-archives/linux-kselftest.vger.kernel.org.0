Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5EF62D8DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKQLGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 06:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiKQLGB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 06:06:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4A286EF
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668683038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49gONeuNGJL5O9v8lyWQciucbbb4tR6ylBmMzSawcfo=;
        b=cPEnNW5QYankRD0MMiRie00p3oENwY4SuuCDFytaCN5fwjDhQmj0ROskRSL4MLbC2xKaaj
        ggM+j3n8QzLp+3lzfZyC153Divr8v883fI+gQ9AuWbWbTWGDsgf5gID6c+ky/K421Hf/n/
        N3ETJQ5d8b6xC6sObVhyYu4tgz4BmDI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-DUTsw0uePkCfjuOZkNgCJw-1; Thu, 17 Nov 2022 06:03:53 -0500
X-MC-Unique: DUTsw0uePkCfjuOZkNgCJw-1
Received: by mail-wr1-f72.google.com with SMTP id j30-20020adfa55e000000b00241b49be1a3so555897wrb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 03:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49gONeuNGJL5O9v8lyWQciucbbb4tR6ylBmMzSawcfo=;
        b=WksjveIGzTYpytD4FR9WJkNx9sAa1SS2Qn6FJHy26p5UspcG9tnUmQV5zkj19M9Fyt
         eLG/YtcZooMqSaw7RA4yu8P7JAce5IWJwQah5zz7FLax/IJfKqueMp8pf72fzYP3ipXf
         jX+o4vl2kbmO91NiXlcEcyyfOuw1/+yIoAKbvOzTRlwJJB2D6AZOgbv93MmeTFlVTFNX
         lqLDajLtLL5Cf9iBjlQyVCKTm/R1JQ1vTt5H8oYMss9o61MXGbl13rE18o+zuv375l96
         5vp+2oiOL2/HH7yqcJuqN4OmzWUBQa+NTidNjo2IojTEpXz6LS02BEZrP6347zSrYx1y
         rYng==
X-Gm-Message-State: ANoB5plVhyt+9n8zfjB76wyOIdw1LYv0ScQwFQwuJLwzM9IdyQ48/zsb
        TKnnsdKiVuRr4nCiqhd9vy1xuvaQqjvGswp52V2tbbAam7uTcETWJKdlTNP+FR8OiFY2QW7zBLM
        X/ACE8N6AJR+Ocu/fYv3RkT1dr0h4
X-Received: by 2002:a5d:4ac4:0:b0:22c:f296:1120 with SMTP id y4-20020a5d4ac4000000b0022cf2961120mr1077675wrs.369.1668683032797;
        Thu, 17 Nov 2022 03:03:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6pKgpZWq9qnIPGHXQLt6irt29PsCEpNu3cpSlNHTZ/BAPiXelpzL9B69HNimUlVLS5sxm4kw==
X-Received: by 2002:a5d:4ac4:0:b0:22c:f296:1120 with SMTP id y4-20020a5d4ac4000000b0022cf2961120mr1077657wrs.369.1668683032567;
        Thu, 17 Nov 2022 03:03:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5200:39a9:b834:27c1:4ede? (p200300cbc707520039a9b83427c14ede.dip0.t-ipconnect.de. [2003:cb:c707:5200:39a9:b834:27c1:4ede])
        by smtp.gmail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfaae07f68sm5862544wmb.17.2022.11.17.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:03:52 -0800 (PST)
Message-ID: <98ae206d-c132-7529-1b4c-7f51079d7fa9@redhat.com>
Date:   Thu, 17 Nov 2022 12:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH linux-next] selftests/vm: add CATEGORY for
 ksm_functional_tests
Content-Language: en-US
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20221027170043.2363797-1-jsavitz@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221027170043.2363797-1-jsavitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27.10.22 19:00, Joel Savitz wrote:
> commit e080ceaa69c1 ("selftests/vm: add KSM unmerge tests") in
> linux-next adds an entry to run_vmtests.sh. I recently submitted
> commit b5ba705c2608 ("selftests/vm: enable running select groups of tests")
> to linux-next which categorizes tests by functionality in order to
> allow more precise selection of which tests are to be run.
> 
> Since this newest test targets ksm and does not require more than one
> numa node, add 'CATEGORY="ksm"' to the invocation to group this test
> with the other ksm tests.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>   tools/testing/selftests/vm/run_vmtests.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index af35dd3bc589..fff00bb77086 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -252,7 +252,7 @@ CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 1
>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>   CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 0
>   
> -run_test ./ksm_functional_tests
> +CATEGORY="ksm" run_test ./ksm_functional_tests
>   
>   # protection_keys tests
>   if [ -x ./protection_keys_32 ]

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

