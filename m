Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6409A766F95
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjG1Ogp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 10:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbjG1Ogn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 10:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4F3A9B
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690554956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3mxkjGtcV8TZJK530NSU7fYEop+9VqNToh3JhHeIwg=;
        b=Jo5LejLHO/2BHa8v97Vk1zWB6G6dgFlDA52as1i6x/e9ADs86re4ASzwYI1IbGZ5KMtmhC
        kzM5kOzRTr05oPEltSE/suWch94L4mDMDFY769W85zhLhyIuNidiBMgilGgJJjKy6lS+O3
        N9Ro0sKEGWMDmuAPXQ2nu5OYV1S+/W8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-QmiY6QX_OUO5KkVg10Lgsw-1; Fri, 28 Jul 2023 10:35:55 -0400
X-MC-Unique: QmiY6QX_OUO5KkVg10Lgsw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fd2778f5e4so11593015e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 07:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554954; x=1691159754;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3mxkjGtcV8TZJK530NSU7fYEop+9VqNToh3JhHeIwg=;
        b=NqxtqvLymC6BZENdC27dPAV5hD8++uBEzsJyJf4lmQiMQ+ZvvyubLFXApi0a8uZlUD
         d+uDS7TDHAbBkjgxQ6t/wS2qCLslsNZU+tOqziU+5iynPcnxuYXDQArXahovt2JXwb/U
         6xxN8AHR5lWMCUmuZn1PLo6vKKvS3tM3N4O16ftWCf4VcQo4//h9zzO3LQHKrYL8SyOi
         v53uPLs14+IimWpFNfMeWAXByBuo9Gtp3Abjo4yoSfwZNqG8meu4RCGhDi6GNwiuJeGE
         TjIXViMYhaJ3M0dWBP2W1qhX3iFnhBN3ynMzZt/ApB8tVFvzfxNmxszewqn/IeQ4iwD2
         wVEg==
X-Gm-Message-State: ABy/qLbr46c2Ws5f1LNDKTzwjGS1wfhtazMhETPEF37dvi2QfnENHOij
        TGZS2nyG/0fj36FtV5UIOmy/zB4MD6SVclqFmPHBSZfC+9hFrCnyqt//yJZsmBtnuAnFWJLb0Hb
        ajUSFRaTnAl9CEgKZnbglDXA/6oVd
X-Received: by 2002:a7b:cd0e:0:b0:3fd:2f7d:425f with SMTP id f14-20020a7bcd0e000000b003fd2f7d425fmr2289584wmj.18.1690554954178;
        Fri, 28 Jul 2023 07:35:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEB5lWPuA7eRPuJD3CSSZvgER2J6XBg3fBrdGXmDQKL7AOZkRBYSwd2RnwX37FLKrppdWMzbg==
X-Received: by 2002:a7b:cd0e:0:b0:3fd:2f7d:425f with SMTP id f14-20020a7bcd0e000000b003fd2f7d425fmr2289548wmj.18.1690554953644;
        Fri, 28 Jul 2023 07:35:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fbfef555d2sm7066391wmm.23.2023.07.28.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:35:53 -0700 (PDT)
Message-ID: <cb3494d7-2af2-5e15-98bf-74146801bdd5@redhat.com>
Date:   Fri, 28 Jul 2023 16:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] selftests: mm: add KSM_MERGE_TIME tests
Content-Language: en-US
To:     Ayush Jain <ayush.jain3@amd.com>, akpm@linux-foundation.org,
        shuah@kernel.org, pasha.tatashin@soleen.com,
        zhansayabagdaulet@gmail.com, tyhicks@linux.microsoft.com,
        raghavendra.kodsarathimmappa@amd.com
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Narasimhan.V@amd.com,
        Santosh.Shukla@amd.com
References: <20230728060109.4403-1-ayush.jain3@amd.com>
 <20230728060109.4403-2-ayush.jain3@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728060109.4403-2-ayush.jain3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28.07.23 08:01, Ayush Jain wrote:
> add KSM_MERGE_TIME and KSM_MERGE_TIME_HUGE_PAGES tests with
> size of 100.
> 
> ./run_vmtests.sh -t ksm
> -----------------------------
> running ./ksm_tests -H -s 100
> -----------------------------
> Number of normal pages:    0
> Number of huge pages:    50
> Total size:    100 MiB
> Total time:    0.399844662 s
> Average speed:  250.097 MiB/s
> [PASS]
> -----------------------------
> running ./ksm_tests -P -s 100
> -----------------------------
> Total size:    100 MiB
> Total time:    0.451931496 s
> Average speed:  221.272 MiB/s
> [PASS]
> 
> Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 3f26f6e15b2a..ca3738e042c2 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -262,6 +262,10 @@ CATEGORY="madv_populate" run_test ./madv_populate
>   
>   CATEGORY="memfd_secret" run_test ./memfd_secret
>   
> +# KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
> +CATEGORY="ksm" run_test ./ksm_tests -H -s 100
> +# KSM KSM_MERGE_TIME test with size of 100
> +CATEGORY="ksm" run_test ./ksm_tests -P -s 100
>   # KSM MADV_MERGEABLE test with 10 identical pages
>   CATEGORY="ksm" run_test ./ksm_tests -M -p 10
>   # KSM unmerge test

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

