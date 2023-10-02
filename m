Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EBB7B55A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjJBOn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjJBOn4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 10:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47E6B3
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696257786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyF1pnZ6qkmXa4qXcGzIhipUJOWvJDJpCe2ELEDUqZE=;
        b=GnZkE9Xiks2uUTTeInK2cuDoWsxb9ykY5zVwkMDwAyPAVIeYHW6F/tZpDHUhESfo3BLk/A
        IZV2XuZWn5NAkiPg6hKrQQSXpS4Qjbs5iB1w9RfZ8GWmMYawZD+cry0twSaLF6htc9k2MN
        U9oN/s4cRggfs4AiZHK7zFBVrkbHAFY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-AIh4Xq2SNpanR62f68oXtw-1; Mon, 02 Oct 2023 10:42:54 -0400
X-MC-Unique: AIh4Xq2SNpanR62f68oXtw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3248ebee5f4so2674994f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257773; x=1696862573;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyF1pnZ6qkmXa4qXcGzIhipUJOWvJDJpCe2ELEDUqZE=;
        b=ZeCAEM0FQKB3VlPKnrDK2ExsyEIPRXNQAjffd4I+3ZUBV1aQ7DKJpRUJDrX84qrpqg
         NzHs+C4ae77dm6lOKVaem+dQnDFujYP4UlJI5NubnO5wSI8KvB4MJ1d8fRoTOuHULb2d
         3lRgntrX+9rFUkTxBAUcw3wsznPBAv2apTQInKRWhooGOSylZqKKwq2DDgfQ/f+DDXXS
         TTtWCpkg0rDwIITrDsN0tnvSAGr9SBGroKKzbM6arXHPstVlFg+qdELBWcqFmxT5vjgF
         jfeG1t8HSjtZ0OnxywslS6ZSq3vcj9zqKgTt25fq4V/keOQP4+5LLuAKGjjjQnLpDnEE
         74qg==
X-Gm-Message-State: AOJu0Ywg33jmorN88UF0mFJzR9uOvtXu0NVS2ChK/YvqNaPGNdJ1ZjgR
        w/0gIv3Cs0Ts3yUd9mSXqixuIRHPAM7kacbMTV/l1lko/+Hptps0VAk4J/NBmix/wBaSgRl2aG1
        l4IbJFz5rO3waZT04XVsuSiEMJqxY
X-Received: by 2002:a05:6000:1d0:b0:322:707e:a9fd with SMTP id t16-20020a05600001d000b00322707ea9fdmr8891383wrx.34.1696257772792;
        Mon, 02 Oct 2023 07:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGymUSv8zl2ClRiKwhAr/NLjZAkFh/vu2pxeK/KZTOMETVSkxSO89mrdgd615CqhPnR+vID4A==
X-Received: by 2002:a05:6000:1d0:b0:322:707e:a9fd with SMTP id t16-20020a05600001d000b00322707ea9fdmr8891355wrx.34.1696257772272;
        Mon, 02 Oct 2023 07:42:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6046000000b003259b068ba6sm7972412wrt.7.2023.10.02.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 07:42:51 -0700 (PDT)
Message-ID: <27f177c9-1035-3277-cd62-dc81c12acec4@redhat.com>
Date:   Mon, 2 Oct 2023 16:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
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
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-2-surenb@google.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230923013148.1390521-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23.09.23 03:31, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> As far as the rmap code is concerned, UFFDIO_REMAP only alters the
> page->mapping and page->index. It does it while holding the page
> lock. However folio_referenced() is doing rmap walks without taking the
> folio lock first, so folio_lock_anon_vma_read() must be updated to
> re-check that the folio->mapping didn't change after we obtained the
> anon_vma read lock.

I'm curious: why don't we need this for existing users of 
page_move_anon_rmap()? What's special about UFFDIO_REMAP?


-- 
Cheers,

David / dhildenb

