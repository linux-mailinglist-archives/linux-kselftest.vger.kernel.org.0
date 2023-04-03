Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174FE6D4EA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjDCRFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjDCRFm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 13:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7CD1FF0
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680541501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fB9l5DmMkkkgnxs6JL3bro+0KNlScQ1w3i/qgZyBoMI=;
        b=IK0deAic2MBaL61JVANxNnjgcAISHfe9gG9u+bHlt/S44hq1ecUiBCdJTci6loXqFbjK+8
        lThxV2+ajxFIkVaCeoA02gY4Azspip3fJf4uU5Fqsnz7il4XOSVqudyhqli0yFepU/rW9w
        UXXqTVZCW0O11lfTZ2QMO9udE5OJ6DA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-_PLesTW-OKmFn9C3EvnNZQ-1; Mon, 03 Apr 2023 13:04:59 -0400
X-MC-Unique: _PLesTW-OKmFn9C3EvnNZQ-1
Received: by mail-wm1-f69.google.com with SMTP id o37-20020a05600c512500b003edd119ec9eso14872696wms.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 10:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541498;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB9l5DmMkkkgnxs6JL3bro+0KNlScQ1w3i/qgZyBoMI=;
        b=7KhyuwYPH+Cn9LGHTzfHEVmtKQXrqn7AIN6p/lcOhLXWriK5O1geyywXwm7LjQMa1C
         iRoF4MAg/HzSrcRYxRa3a0oAjFhjp8/xILwNLALFftjQAb8A3/CcqymSKDmZ8Mdmlm3f
         NYN0R87F4XGOq1ZyApD1BsdbNBuAp01nIsM6FLho4IdCj4OKS3nvfHyBF8dC1OCF9PPt
         kYYfmSXZmm3kARRPcFWbXfUQnCwJrxMfHMjeHBnF+CU7hP7McCE3hbjZlrnua6XI1vty
         duOYsK59EQFbPE01FvaXfPX8RW+14F6zaL/GPyy5wFekZQYjvK9RLZ8NHjIoX7cHEiSj
         aaPw==
X-Gm-Message-State: AAQBX9fvByqhHYlM6f8C4Zmr0SiCq+zqDyZVJ1o6WUJeuHNnjqMTwXKi
        ifzS+f5LxXebo7Rr7w4HuHCJA71Z9pCQdYE2Dw/iGcLvgvRqsEI6VZl0OXH27bCGVz06kYTnrTU
        c+dykhERo0vQX600UYhey1JFXtbDi
X-Received: by 2002:a05:6000:1807:b0:2e5:1da2:2a06 with SMTP id m7-20020a056000180700b002e51da22a06mr9798604wrh.5.1680541498730;
        Mon, 03 Apr 2023 10:04:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZsdZhtaUQElV+DlNmNek3k6auOGEEWMuMoCKBGhq8HidqpSrroTqCEY45g9u3ktoFhKZe+g==
X-Received: by 2002:a05:6000:1807:b0:2e5:1da2:2a06 with SMTP id m7-20020a056000180700b002e51da22a06mr9798585wrh.5.1680541498435;
        Mon, 03 Apr 2023 10:04:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe8cc000000b002c7b229b1basm10137726wrn.15.2023.04.03.10.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:04:57 -0700 (PDT)
Message-ID: <39deb9d5-9f21-9d3d-0847-54e90491b0b1@redhat.com>
Date:   Mon, 3 Apr 2023 19:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
 <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
 <ZCWcJelF5bEdF4N3@cmpxchg.org>
 <ff599dc1-729d-52dc-d605-8a8ac890ad15@redhat.com>
 <qvqwv8ii89x6.fsf@dev0134.prn3.facebook.com>
 <f969cb1f-651f-592f-7540-89f73e175c7d@redhat.com>
 <qvqwlej8vrst.fsf@dev0134.prn3.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqwlej8vrst.fsf@dev0134.prn3.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.04.23 18:34, Stefan Roesch wrote:
>>
>> In contrast to e.g.:
>>
>> 1) THP resulted in many zeropages we end up deduplicating again. The THP
>>     placement was unfortunate.
>>
>> 2) Unoptimized memory allocators that leave many identical pages mapped
>>     after freeing up memory (e.g., zeroed pages, pages all filled with
>>     poison values) instead of e.g., using MADV_DONTNEED to free up that
>>     memory.
>>
>>
> 
> I repeated an experiment with and without KSM. In terms of THP there is
> no huge difference between the two. On a 64GB main memory machine I see
> between 100 - 400MB in AnonHugePages.
> 
>>> /sys/kernel/mm/ksm/pages_shared is over 10000 when we run this on an
>>> Instagram workload. The workload consists of 36 processes plus a few
>>> sidecar processes.
>>
>> Thanks! To which value is /sys/kernel/mm/ksm/max_page_sharing set in that
>> environment?
>>
> 
> It's set to the standard value of 256.
> 
> In the meantime I have run experiments with different settings for
> pages_to_scan. With the default value of 100, we only get a relatively
> small benefit of KSM. If I increase the value to for instance to 2000 or
> 3000 the savings are substantial. (The workload is memory bound, not
> CPU bound).

Interesting.

> 
> Here are some stats for setting pages_to_scan to 3000:
> 
> full_scans: 560
> general_profit: 20620539008
> max_page_sharing: 256
> merge_across_nodes: 1
> pages_shared: 125446
> pages_sharing: 5259506
> pages_to_scan: 3000
> pages_unshared: 1897537
> pages_volatile: 12389223
> run: 1
> sleep_millisecs: 20
> stable_node_chains: 176
> stable_node_chains_prune_millisecs: 2000
> stable_node_dups: 2604
> use_zero_pages: 0
> zero_pages_sharing: 0
> 
> 
>> What would be interesting is pages_shared after max_page_sharing was set to a
>> very high number such that pages_shared does not include duplicates. Then
>> pages_shared actually expresses how many different pages we deduplicate. No need
>> to run without THP in that case.
>>
> 
> Thats on my list for the next set of experiments.

Splendid.

>> Similarly, enabling "use_zero_pages" could highlight if your workload ends up
>> deduplciating a lot of zeropages. But maxing out max_page_sharing would be
>> sufficient to understand what's happening.
>>
>>
> 
> I already run experiments with use_zero_pages, but they didn't make a
> difference. I'll repeat the experiment with a higher pages_to_scan
> value.

Okay, so it's most certainly not the zeropage. Thanks for that 
information and running the experiments!

-- 
Thanks,

David / dhildenb

