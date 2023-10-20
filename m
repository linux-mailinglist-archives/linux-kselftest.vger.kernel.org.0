Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169C7D0CA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376648AbjJTKDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjJTKDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 06:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB5D49
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697796145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DkCqzPplBFPYgjJf4t0QjtC4cYyCvLwawhN6fpCigWs=;
        b=MnUbM5d7Xt8KM+GqUZi5f6eJdsBT8BhsJL91b3VDO3hjE3oTLc+nNwdTUGfHLWOnd84cwv
        sBfCTv9TFay0jeBp/sGhkWh0CCXbOp7pbJQuG7X5vfGLBwHxxEgqaPYZEQjYBOHAMe9Bbf
        n2UYc4gSCWyfTmUwBEdLwWzmEkrVfns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-bwEOub2tNE62idF6A9v-Qw-1; Fri, 20 Oct 2023 06:02:23 -0400
X-MC-Unique: bwEOub2tNE62idF6A9v-Qw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084001846eso4011945e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 03:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796143; x=1698400943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkCqzPplBFPYgjJf4t0QjtC4cYyCvLwawhN6fpCigWs=;
        b=kmzoNzitUmfRHuRHevDv22YTpI6A/hOpfydUR3gedtWaGYTM4BhF9DxIfR8QgifTTZ
         so7c0GQv8bpL9/aspCRuA8BFjJnpTRAng4t5YFv67C/EhELpjolHy1lOH49uNFr64p/u
         myQMG7wMmbLbXVqzusXrqvvW9h1Z+U4zvlEjxQa0/HPKVlVYCuidFsgSyuZaNiJXWjnI
         XyLyiPrzwXZq1lm3EZXTr/3dkcjWEedGpZtAh1r6c++SbekVwzqNQ81+SZ+uGVft0VrV
         I5M2DeRdclMdo3MRvv0gEWbGR/K9M/kOUSJXiupOanYbQJnFRgV6AT2OZ/b0iA27uTtv
         GRfg==
X-Gm-Message-State: AOJu0YwvHJWYlozpSnFLyvoKjeU8NW1VadPRlLjYqBG0q7ps8zBsrEuN
        riuUatUo7S4Vuxe2FNeDAL+aeT6XsFiifG93+5zGBIZ0MdJcDWOHObphuiEYcVFk51RwUNFxqPj
        4p09VrETTouTXXzUsD1brLQXU9tOk
X-Received: by 2002:a05:600c:35ca:b0:405:3955:5872 with SMTP id r10-20020a05600c35ca00b0040539555872mr1138503wmq.18.1697796142642;
        Fri, 20 Oct 2023 03:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHM369pSv2IVpw5SDZC9sAjVu72UGtDGPQ01F6BNkUEB/ftsbIqn3tOfEmp6/+2/Z/fm+9XA==
X-Received: by 2002:a05:600c:35ca:b0:405:3955:5872 with SMTP id r10-20020a05600c35ca00b0040539555872mr1138457wmq.18.1697796142106;
        Fri, 20 Oct 2023 03:02:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:c100:5d8:2d46:b11e:6784? (p200300cbc719c10005d82d46b11e6784.dip0.t-ipconnect.de. [2003:cb:c719:c100:5d8:2d46:b11e:6784])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b00402ff8d6086sm1773905wmg.18.2023.10.20.03.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 03:02:21 -0700 (PDT)
Message-ID: <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
Date:   Fri, 20 Oct 2023 12:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
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
References: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n> <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n> <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZTGJHesvkV84c+l6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.10.23 21:53, Peter Xu wrote:
> On Thu, Oct 19, 2023 at 05:41:01PM +0200, David Hildenbrand wrote:
>> That's not my main point. It can easily become a maintenance burden without
>> any real use cases yet that we are willing to support.
> 
> That's why I requested a few times that we can discuss the complexity of
> cross-mm support already here, and I'm all ears if I missed something on
> the "maintenance burden" part..
> 
> I started by listing what I think might be different, and we can easily
> speedup single-mm with things like "if (ctx->mm != mm)" checks with
> e.g. memcg, just like what this patch already did with pgtable depositions.
> 
> We keep saying "maintenance burden" but we refuse to discuss what is that..

Let's recap

(1) We have person A up-streaming code written by person B, whereby B is 
not involved in the discussions nor seems to be active to maintain that 
code.

Worse, the code that is getting up-streamed was originally based on a 
different kernel version that has significant differences in some key 
areas -- for example, page pinning, exclusive vs. shared.

I claim that nobody here fully understands the code at hand (just look 
at the previous discussions), and reviewers have to sort out the mess 
that was created by the very way this stuff is getting upstreamed here.

We're already struggling to get the single-mm case working correctly.


(2) Cross-mm was not even announced anywhere nor mentioned which use it 
would have; I had to stumble over this while digging through the code. 
Further, is it even *tested*? AFAIKS in patch #3 no. Why do we have to 
make the life of reviewers harder by forcing them to review code that 
currently *nobody* on this earth needs?


(3) You said "What else we can benefit from single mm?  One less mmap 
read lock, but probably that's all we can get;" and I presented two 
non-obvious issues. I did not even look any further because I really 
have better things to do than review complicated code without real use 
cases at hand. As I said "maybe that works as expected, I
don't know and I have no time to spare on reviewing features with no
real use cases)"; apparently I was right by just guessing that memcg 
handling is missing.


The sub-feature in question (cross-mm) has no solid use cases; at this 
point I am not even convinced the use case you raised requires 
*userfaultfd*; for the purpose of moving a whole VMA worth of pages 
between two processes; I don't see the immediate need to get userfaultfd 
involved and move individual pages under page lock etc.

> 
> I'll leave that to Suren and Lokesh to decide.  For me the worst case is
> one more flag which might be confusing, which is not the end of the world..
> Suren, you may need to work more thoroughly to remove cross-mm implications
> if so, just like when renaming REMAP to MOVE.

I'm asking myself why you are pushing so hard to include complexity 
"just because we can"; doesn't make any sense to me, honestly.

Maybe you have some other real use cases that ultimately require 
userfaultfd for cross-mm that you cannot share?

Will the world end when we have to use a separate flag so we can open 
this pandora's box when really required?


Again, moving anon pages within a process is a known thing; we do that 
already via mremap; the only difference here really is, that we have to 
get the rmap right because we don't adjust VMAs. It's a shame we don't 
try to combine both code paths, maybe it's not easily possible like we 
did with mprotect vs. uffd-wp.

Moving anon pages between process is currently only done via COW, where 
all things (page pinning, memcg, ...) have been figured out and are 
simply working as expected. Making uffd special by coding-up their own 
thing does not sound compelling to me.


I am clearly against any unwarranted features+complexity. Again, I will 
stop arguing further, the whole thing of "include it just because we 
can" to avoid a flag (that we might never even see) doesn't make any 
sense to me and likely never will.

The whole way this feature is getting upstreamed is just messed up IMHO 
and I the reasoning used in this thread to stick
as-close-as-possible to some code person B wrote some years ago (e.g., 
naming, sub-features) is far out of my comprehension.

-- 
Cheers,

David / dhildenb

