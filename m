Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8245430D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 09:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhKQI6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 03:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234754AbhKQI6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 03:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637139318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xENkpia7n7HvGh692ZwbBL6DxWNpSkLGwR9xOlXO/HQ=;
        b=XzUbfAjB8E6UEe+NYoTuRIc1XwTQ3ApL29hcXXTnGyuhvAaVed8kObHvM2tyK6YdtA2R8g
        McPI8c4khOEu1KcMCrfxkj/8w2mPfUSNFKwklMF8QPXkDOB08zshO13V1f+m6MlM/8OKsd
        PSEfBgmfbtnfZctPqSf9SOaXwtmJANo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-sD_cSqbXNmqY5QAwKjSo3g-1; Wed, 17 Nov 2021 03:55:17 -0500
X-MC-Unique: sD_cSqbXNmqY5QAwKjSo3g-1
Received: by mail-ed1-f72.google.com with SMTP id m8-20020a056402510800b003e29de5badbso1476458edd.18
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 00:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xENkpia7n7HvGh692ZwbBL6DxWNpSkLGwR9xOlXO/HQ=;
        b=yl5LvramQZS51w/SkXkLjhqzPS4qo8Q4f7bEWPRqt2t22/0zCLM26rNy76Vsk8yfSq
         wCuDbhjq2Ewj6McURj2RB1Tu2HfmALdJA4f/1bdBFRu94ej56FZhKO0FZSJWIlUMWXMY
         mlIstCpRDYiSj7pz/K+IgJ8k7zfwKzP55ksDS1bFdLpfDN0BCKJRoqMfAh2y2jbYGzqV
         ouFpHSU8iNQgosCKWorg5ATaKVbc90Cr7wqnFmSbQOW4R0Tx1/5jbiRHOUshhNLfZ7DO
         qSG9VCkJl9ZkY3+Eb1iYJeNZXSlHr6qh6yu5M0Gs6gHBKqjojoSQ64j0SR0JQYd7qqBA
         nMzA==
X-Gm-Message-State: AOAM533yj34GPTAfMQMtlKsQCUbei4kt1RTM0NDCCcgfrTkdcJHW888c
        0j13vbnuuPuc7NfHkvvucqWw2byuKDshcgmvaGYF9RzfvA9agZYabZtbwnTAhAZEqGdwGys4i5Q
        Lzqsfu1rF4ih+UCQ92/9Ik/H77RfY
X-Received: by 2002:a50:e089:: with SMTP id f9mr20135873edl.290.1637139315750;
        Wed, 17 Nov 2021 00:55:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz1G7+KTukj7HLgCjEc7/KCSGVgACyqoSnQKGAUqn7klrNU2bvb7RRjM33xhq8AtxbEthYdA==
X-Received: by 2002:a50:e089:: with SMTP id f9mr20135846edl.290.1637139315562;
        Wed, 17 Nov 2021 00:55:15 -0800 (PST)
Received: from localhost (net-188-218-25-126.cust.vodafonedsl.it. [188.218.25.126])
        by smtp.gmail.com with ESMTPSA id b11sm11082878ede.52.2021.11.17.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 00:55:15 -0800 (PST)
Date:   Wed, 17 Nov 2021 09:55:14 +0100
From:   Davide Caratti <dcaratti@redhat.com>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     shuah@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org,
        lizhijian@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        lkp@intel.com, philip.li@intel.com
Subject: Re: [PATCH v2 1/3] selftests/tc-testing: add exit code
Message-ID: <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
References: <20211117054517.31847-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117054517.31847-1-zhijianx.li@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hi Li,

On Wed, Nov 17, 2021 at 01:45:15PM +0800, Li Zhijian wrote:
> Mark the summary result as FAIL to prevent from confusing the selftest
> framework if some of them are failed.
> 
> Previously, the selftest framework always treats it as *ok* even though
> some of them are failed actually. That's because the script tdc.sh always
> return 0.

yes, also tdc was lacking support for KSFT_SKIP for a long time.

> 
>  # All test results:
>  #
>  # 1..97
>  # ok 1 83be - Create FQ-PIE with invalid number of flows
>  # ok 2 8b6e - Create RED with no flags
> [...snip]
>  # ok 6 5f15 - Create RED with flags ECN, harddrop
>  # ok 7 53e8 - Create RED with flags ECN, nodrop
>  # ok 8 d091 - Fail to create RED with only nodrop flag
>  # ok 9 af8e - Create RED with flags ECN, nodrop, harddrop
>  # not ok 10 ce7d - Add mq Qdisc to multi-queue device (4 queues)
>  #       Could not match regex pattern. Verify command output:
>  # qdisc mq 1: root
>  # qdisc fq_codel 0: parent 1:4 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>  # qdisc fq_codel 0: parent 1:3 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
> [...snip]
>  # ok 96 6979 - Change quantum of a strict ETS band
>  # ok 97 9a7d - Change ETS strict band without quantum
>  #
>  #
>  #
>  #
>  ok 1 selftests: tc-testing: tdc.sh <<< summary result
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

Looks good to me!

Acked-by: Davide Caratti <dcaratti@redhat.com>

