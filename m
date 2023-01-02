Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0665B502
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjABQVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjABQVl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 11:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B7BFA
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Jan 2023 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672676453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSm9E5rxDgi7DwJ0VMt6Hp3omj7CtMsgyOLZMGchtlU=;
        b=S4lH2pD3KTj/A9xEOpwwTA7px4iyHCyD79F3Sx8M0GqtVnXPvLkpGQsw1qNXFQl+jDhpIl
        ugUkvUImOFn/56ddvnnbp71bgUSMeejaBNWQqF3jfNwlctr5hD2+Ozr1XASnPbd7+NphfB
        M2MNtJhKr5xVVJxlIO7VQNdw7owbRNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-iUZL9fVtOU2SVy79YkAjvg-1; Mon, 02 Jan 2023 11:20:52 -0500
X-MC-Unique: iUZL9fVtOU2SVy79YkAjvg-1
Received: by mail-wm1-f69.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso9179540wmb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jan 2023 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSm9E5rxDgi7DwJ0VMt6Hp3omj7CtMsgyOLZMGchtlU=;
        b=d60tT54bWPx2zjW2s9SMAL8+EQwFqQudbxKc+8dM3hHcgEmrF2fd98Q96WJrNv4sU2
         wwdbal8FOTz4bH6btXpFbpoekgIuiHbTJVbzHySbKwF1VmBw1Zf80GGpjb85EFcIsVNq
         KlI0W6pS0TNiwpInb+Aa0hg/cD5MWXtN8E30lIX2mBsN2jYcjDU+tgT7DxAPN3OAaxhG
         DE0M23zrzT/C0n5SKAJIR5YuVeoHz3NOfWIk50CTC3Ust7zl8FemIyLsE1DIOrwMYGtM
         6Re7G3aI51JrWAKnigWuSNSZ13hmMu5GFVf9kA40HTSlb4YCT7Jgs7lRi2y3QXooeORC
         QirQ==
X-Gm-Message-State: AFqh2kpHmC8ch0/TLAfHqHWlSRoMWz6KPjKsurB64yYXkYcGptdTCpZ7
        u/EDPOaZWvIxHueR5ytjTw68T9kL4VPA1kl5OIw3bVdcP2qoSi1G8faUFagHjlonrPEAD7zcS9t
        V+6dIsR3GnvtozIfaR22QNGanjB3L
X-Received: by 2002:a05:600c:35d4:b0:3d2:2d2a:d581 with SMTP id r20-20020a05600c35d400b003d22d2ad581mr28436817wmq.30.1672676451102;
        Mon, 02 Jan 2023 08:20:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtzXRUkM+s5POwXYF4sAJXmfQyH3XWOyrl0suKMisN2guuCSOG41kkBU5NIvqoqUqfQ3jRVvg==
X-Received: by 2002:a05:600c:35d4:b0:3d2:2d2a:d581 with SMTP id r20-20020a05600c35d400b003d22d2ad581mr28436810wmq.30.1672676450906;
        Mon, 02 Jan 2023 08:20:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b002709e616fa2sm28859339wru.64.2023.01.02.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:20:50 -0800 (PST)
Message-ID: <b6b25373-ba6b-6610-1030-7f795f01987c@redhat.com>
Date:   Mon, 2 Jan 2023 17:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
 <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com> <Y7MBqfYv54rY48Wi@lucifer>
 <f29b6cb0-d46b-7d89-c8ad-12b9addf8ce8@redhat.com> <Y7MDVT4dO2pqxJwJ@lucifer>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7MDVT4dO2pqxJwJ@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.01.23 17:16, Lorenzo Stoakes wrote:
> On Mon, Jan 02, 2023 at 05:10:40PM +0100, David Hildenbrand wrote:
>> Maybe wait until tomorrow for feedback from others. Make sure to include my
>> acked-by.
> 
> Too late... I thought Andrew typically added these kind of things himself? As an
> Acked-by could be a reply to an unmodified patch for example. Though I guess
> it'd save you having to reply to the v4? Anyway sorry, already sent it!

Maintainers usually apply tags that are sent to the latest version, when 
picking up the patch. Maintainers usually refrain from going through 
multiple earlier patch versions to pick up tags -- especially, because 
some changes might require a submitter from dropping tags (e.g., bigger 
changes) and the tags might no longer be valid.

So better always include tags when resending, so they don't get lost.

> 
> It's sat in the mailing list so others can review further if required, this is a
> bank holiday in the UK, and as a part-time contributor (and otherwise distracted
> by book work) it is a rare moment to be able to respond to feedback so will tend
> to get squashed into evenings/weekends/public holidays :) If people have further
> comments I will, of course, respond as + when I can!
> 
> Cheers!

Happy holidays then :)

-- 
Thanks,

David / dhildenb

