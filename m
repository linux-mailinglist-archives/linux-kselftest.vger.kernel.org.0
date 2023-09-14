Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1738C7A0D8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbjINSwh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbjINSwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 14:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74558269A
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694717250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91ItEaA48PaYp5ILUtPQ0EOz3NpWw/JFlwU7DDokP0U=;
        b=H8v7pz02M0YZQq83o6gHy+7Qxt9FBnoE/sk4FDzjyVAuH8UqbKVj44u5TCz8FUOd4cN40s
        /RzHppus6yrBrkPMUChcAe5vP9xBFPuzDvlZR2KdZxuvMMYBOXKAWhGoZLYKQDupUQOwF+
        MUltAVVxCiFMTM6NjZR9GiRI2voDs+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-9tEgmZe_Ns2kf6lVavgBGw-1; Thu, 14 Sep 2023 14:47:29 -0400
X-MC-Unique: 9tEgmZe_Ns2kf6lVavgBGw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4011f56165eso10401465e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717248; x=1695322048;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91ItEaA48PaYp5ILUtPQ0EOz3NpWw/JFlwU7DDokP0U=;
        b=odtpU1bGGKKl0piKTNgHasvf5SJ8k8+ZwE0UfAks6XmIbGNIy4HMPZ3+sgfJbuByXE
         BtPGdXj33awkLQX0Iiq01MVXKAZna0q+idNGYRJ9w4GSCgMjPzWxamX3zdr2a+s6U6IJ
         DoH1XWE738g4DU+Oas4Z/z3VWaY8Lx2tWEr3zSZUJVyozau6ItJhE371tiODduDKKrLT
         TShvELuzvQUZ2x9cNDarwNXLqsOUjh/QcW5gAfJXTOGs4KpCxPKQamAygGqYDdYDX2HN
         wk2nDASrL8o2FDHluYxBpItqPCQfRBhrkDOPAZJyGyLBhetJNFwsFglUe99lAO2cEvJp
         etYg==
X-Gm-Message-State: AOJu0Yzui+YOw1gYHDLZpl5oEtEqAIuskX6wRFzVCdPT9umO79qvxyjA
        hTROHRItGiwstZONTm1mrgV0DcGnxUO/S22uw4ETPmDe5guqGMYC8PT0CWG/oyzbkSGCtiBa2sF
        uaKAERmR6+VOQp3tJGiHaOnjsgUBm
X-Received: by 2002:adf:ef09:0:b0:319:6997:9432 with SMTP id e9-20020adfef09000000b0031969979432mr2074733wro.1.1694717248105;
        Thu, 14 Sep 2023 11:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy12DLRCd8OQHn+OojnAwrycBjGv1lx9Cp32vLLh8AHV2EYYDMTmO3oDXfBhNoF1kAoqLVgw==
X-Received: by 2002:adf:ef09:0:b0:319:6997:9432 with SMTP id e9-20020adfef09000000b0031969979432mr2074717wro.1.1694717247674;
        Thu, 14 Sep 2023 11:47:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:600:4630:4a91:d07:7095? (p200300cbc71c060046304a910d077095.dip0.t-ipconnect.de. [2003:cb:c71c:600:4630:4a91:d07:7095])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000120b00b003196b1bb528sm2456394wrx.64.2023.09.14.11.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:47:27 -0700 (PDT)
Message-ID: <b7f44bff-644b-8aa6-4d0e-8f1dfd6d03d2@redhat.com>
Date:   Thu, 14 Sep 2023 20:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230914152620.2743033-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14.09.23 17:26, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> This implements the uABI of UFFDIO_REMAP.
> 
> Notably one mode bitflag is also forwarded (and in turn known) by the
> lowlevel remap_pages method.

Sorry to say, but these functions are unacceptably long. Please find 
ways to structure the code in a better way.

-- 
Cheers,

David / dhildenb

