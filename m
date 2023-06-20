Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339673768E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFTVVP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFTVVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 17:21:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE38183
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 14:21:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763a3699b9aso187066985a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1687296072; x=1689888072;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jcP/rm05RrInHETkeFjW0Eo/JiIhtFou4XrWSAd+wQ=;
        b=xVQxFtvINCiFD58bFiHYe1aaNqyDHDsRvXUtLyBCZQ4OLf5LG+wj4dz9IJT7bARDm8
         bndpbFIdIVhYMIXyn2vhnHPSX95zDd62o17nMugqLgSeM2YOobMUCCAS1Ip1HLcN+ESg
         nhyfiD/0m3FoPIOECqAJa4v472BYsAo6epunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687296072; x=1689888072;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jcP/rm05RrInHETkeFjW0Eo/JiIhtFou4XrWSAd+wQ=;
        b=WfS2x0xY2CfdoHa5vFgceBSC5PBaiaG8gTNqx51GKV4/7yIoLA3neOT559PNm5ptlA
         FPoSDu+sUENXqXjcNiFypftQld8kE9uBzK1MEBvGLjU2bCinXvdjjOetCWP9fy8D8QDr
         ay5Xi88uA6hR3Lqn7vtVBT9AtHIElPJGnxb0KtNt7ngxhlfhT2mK6vsqSsLLxnQ4baEF
         +CXRdejlExpPm+GI3cesZfJWjZkaEyuibaEM2esIAmA8/KP9BY1/D8/BGZM8hyJ6co9g
         RTU+IoqFWPQIGZrqOzKgQZagp1EPosF6UPnNdq+v4eqVHigMaSDUM5t1ZOKDQ+jT+iRd
         UJeA==
X-Gm-Message-State: AC+VfDz+RrEDQb+/Et1hHE6/odYgNKzARwqpkHt1dSj6DhP3m8TKsVJo
        7dG3Iie80GIoL5N+MIowh+LloQ==
X-Google-Smtp-Source: ACHHUZ4JrLF0b4oOsT9kMCPcCqgqzM5+OfFosKmIub96E+yaPuRpcx9m5LtP3kwYacB3vbBCwaTVGQ==
X-Received: by 2002:a05:620a:660a:b0:762:3a20:7719 with SMTP id qf10-20020a05620a660a00b007623a207719mr12345317qkn.18.1687296072551;
        Tue, 20 Jun 2023 14:21:12 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f502000000b0076087149a19sm1512897qkk.83.2023.06.20.14.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:21:11 -0700 (PDT)
Message-ID: <867bd9d6-1d00-0d9d-368a-8224cb40a505@joelfernandes.org>
Date:   Tue, 20 Jun 2023 17:21:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
 <f28eadbc-f40e-4286-bf7e-af0ac360617e@lucifer.local>
 <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
In-Reply-To: <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/20/23 17:16, Joel Fernandes wrote:
> 
> Considering our discussion above that hugetlb mremap addresses should always 
> starts at a PMD boundary, maybe I can just add a warning to the if() like so to 
> detect any potential?
> 
>      if (is_vm_hugetlb_page(vma)) {
>          WARN_ON_ONCE(old_addr - old_end != len);

Oops, I meant WARN_ON_ONCE(old_end - old_addr != len);

to make sure we did not mess up hugetlb mremaps.

thanks,

  - Joel

