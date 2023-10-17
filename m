Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEF7CC837
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjJQP4N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbjJQP4C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662ABF5
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697558116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=lczccd5vGYHNveSJtrvYvza5KZbdNK74xDRFaP3BLsU=;
        b=gzV4Dsv0dWqYC0ap5wi2JpM9M6NWRyhowiA0BHbYSfnBtHZKBXwNYSJprnNsu/okCnMhpr
        k+LjDxRuWTgdVApLTWY5SrHAAGkz7LaAbrrk+oXtw/u8/fx9eamJLQPXkw6eLAGGNORyCe
        14QDcX/jiZgeoiDe4amb6vOOvSqzgj4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-jkdNOiK9McyU5lfXJeSWig-1; Tue, 17 Oct 2023 11:55:14 -0400
X-MC-Unique: jkdNOiK9McyU5lfXJeSWig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32da8de4833so1856925f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 08:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558113; x=1698162913;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lczccd5vGYHNveSJtrvYvza5KZbdNK74xDRFaP3BLsU=;
        b=xHu3MRFcVhwklcnIQOk10Le3KgW8xcBeqOqrvZgTXHverbALnM/SiXYj5ZNe7Gocl2
         YOMoqqD+I38bZYCQj5xoOdOzfQs+ochJJeLc4wWu+S5omV1u31Y9e+SZR7Yinz3eq/hv
         xj7noxTtEZ6c2ENa2VxGKgVQUYW7u1ehXZ8fRnukiUdO87/E4pnT/ncKpfIAmEdfa4aW
         BwFWVGM+36wYS0avNkxBDRPPzTessxwwnymsH21Kv4PMJAHdoSxcUPrHAS0p/L1gHL4G
         oWYsE65Su5TCIL3GW7m3tQrjVW3WOecnFXhEsr8Ycwmt54nv1wPNO7Gg0OMGbsU7lgf0
         MXkg==
X-Gm-Message-State: AOJu0Yyfj5sfT6SjQVcHosBPoekxBvc1jTl+88VFisokghaL+OvwK9yI
        T3iwR0+9fEMggINkIoY4ef31CNyv3RAaJumOfta5NGcaE8kVHypjypMN256M7jof4nDfHktGsyA
        qUXsHW5Z5B/HFVHZjuK7JxeWS8Mvf
X-Received: by 2002:a5d:4e90:0:b0:32d:a4c4:f700 with SMTP id e16-20020a5d4e90000000b0032da4c4f700mr2378807wru.38.1697558113293;
        Tue, 17 Oct 2023 08:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMTNi5yp+q9KhRwbZFlporOHnmTNt0F08bdCSYm6ry3kyMwqIR+9TO7W83KbpsF+QxwPkXeA==
X-Received: by 2002:a5d:4e90:0:b0:32d:a4c4:f700 with SMTP id e16-20020a5d4e90000000b0032da4c4f700mr2378780wru.38.1697558112865;
        Tue, 17 Oct 2023 08:55:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5100:93b1:f654:ad11:cd81? (p200300cbc743510093b1f654ad11cd81.dip0.t-ipconnect.de. [2003:cb:c743:5100:93b1:f654:ad11:cd81])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600010d100b003197869bcd7sm65944wrx.13.2023.10.17.08.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:55:12 -0700 (PDT)
Message-ID: <8d187891-f131-4912-82d8-13112125b210@redhat.com>
Date:   Tue, 17 Oct 2023 17:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZS2IjEP479WtVdMi@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16.10.23 21:01, Peter Xu wrote:
> David,

Hi Peter,

>>> Basically I see it a potential way of moving memory efficiently especially
>>> with thp.
>>
>> It's an interesting use case indeed. The questions would be if this is (a) a
>> use case we want to support; (b) why we need to make that decision now and
>> add that feature.
> 
> I would like to support that if nothing stops it from happening, but that's
> what we're discussing though..
> 
> For (b), I wanted to avoid UFFD_FEATURE_MOVE_CROSS_MM feature flag just for
> this, if they're already so close, not to mention current code already
> contains cross-mm support.

Yeah, but that implementation is apparently not sufficiently correct yet.

Don't get me wrong, but this feature is already complicated enough that 
we should really think twice if we want to make this even more 
complicated and harder to maintain -- because once it's in we all know 
it's hard to remove and we can easily end up with a maintenance 
nightmare without sufficiently good use cases.

> 
> If to support that live upgrade use case, I'd probably need to rework tlb
> flushing too to do the batching (actually tlb flush is not even needed for
> upgrade scenario..).  I'm not sure whether Lokesh's use case would move
> large chunks, it'll be perfect if Suren did it altogether.  But that one is
> much easier if transparent to userapps.  Cross-mm is not transparent and
> need another feature knob, which I want to avoid if possible.

And for me it's the other way around: the kernel doesn't have to support 
each and every use case. So we better think twice before we do something 
we can no longer undo easily.

Further, as we see, this feature without cross-mm capabilities is 
perfectly usable for other use cases. So even limited initialy support 
is extremely valuable on its own.

> 
>>
>> One question is if this kind of "moving memory between processes" really
>> should be done, because intuitively SHMEM smells like the right thing to use
>> here (two processes wanting to access the same memory).
> 
> That's the whole point, IMHO, where shmem cannot be used.  As you said, on
> when someone cannot use file memory for some reason like ksm.

Right, but as I explore below KSM will at least prohibit remapping the 
KSM pages, taking some of the benefit away again.

> 
>>
>> The downsides of shmem are lack of the shared zeropage and KSM. The shared
>> zeropage is usually less of a concern for VMs, but KSM is. However, KSM will
>> also disallow moving pages here. But all non-deduplicated ones could be
>> moved.
>>
>> [I wondered whether moving KSM pages (rmap items) could be done; probably in
>> some limited form with some more added complexity]
> 
> Yeah we can leave that complexity for later when really needed.  Here
> cross-mm support, OTOH, isn't making it so complicated, IMHO.
> 
> Btw, we don't even necessarily need to be able to migrate KSM pages for a
> VM live upgrade use case: we can unmerge the pages, upgrade, and wait for
> KSM to scan & merge again on the new binary / mmap.  Userspace can have
> that control easily, afaiu, via existing madvise().

MADV_POPULATE_WRITE would do, yes.

BTW, wasn't there a way to do VM live-upgrade using fork() and replacing 
the binary? I recall that there was at some time either an 
implementation in QEMU or a proposal for an implementation; but I don't 
know how VM memory was provided. It's certainly harder to move VM memory 
using fork().

[...]

>>
>> single-mm should at least not cause harm, but the semantics are
>> questionable. cross-mm could, especially with malicious user space that
>> wants to find ways of harming the kernel.
> 
> For kernel, I think we're discussing to see whether it's safe to do so from
> kernel pov, e.g., whether to exclude pinned pages is part of that.
> 
> For the user app, the dest process has provided the uffd descriptor on its
> own willingness, or be a child of the UFFDIO_MOVE issuer when used with
> EVENT_FORK, I assume that's already some form of safety check because it
> cannot be any process, but ones that are proactively in close cooperative
> with the issuer process.

Is that and will that remain the case? I know people have been working 
on transparent user-space swapping using monitor processes using uffd. I 
thought there would have been ways to achieve that without any 
corporation of the dst.

> 
>>
>> I'll note that mremap with pinned pages works.
> 
> But that's not "by design", am I right?  IOW, do we have any real pin user
> that rely on mremap() allowing pages to be moved?

If in doubt, usually "probably yes".

Hard to tell if the "remap" in mremap indicates that we are simply 
remapping pages , and not moving data.

> 
> I don't see any word guarantee at least from man page that mremap() will
> make sure the PFN won't change after the movement.. even though it seems to
> be what happening now.

If you managed to support page pinning with migration the exact PFN 
doesn't matter. Likely nobody would implement that due to the tracking 
complexity.

> 
> Neither do I think when designing MMF_HAS_PINNED we kept that in mind that
> it won't be affected by someone mremap() pinned pages and we want to keep
> it working.. >
> All of it just seems to be an accident..

Not necessarily my opinion, but doesn't really matter here. It's working.

At least It's reasonable to have part of a THP pinned and mremapping the 
other part of the THP. That makes things more tricky ... because you 
only know that the THP is pinned.

> 
> One step back, we're free to define UFFDIO_MOVE anyway, and we don't
> necessarily need to always follow mremap().  E.g., mremap() also supports
> ksm pages, but IIUC we already decide to not support that for now on
> UFFDIO_MOVE.  UFFDIO_MOVE seems all fine to make it clear on failing at
> pinned pages from the 1st day if that satisfies our goals, too.

Yes.

-- 
Cheers,

David / dhildenb

