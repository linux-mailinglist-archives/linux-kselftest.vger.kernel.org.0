Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C47BB7A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjJFMbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjJFMbD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 08:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76AE4
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Oct 2023 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696595411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8It8tkqkVjlZ4hD1o0BfKil40eztbarnBcDIj9TIgRw=;
        b=AL9bsp/99fpiM5GAJnm9dLb9vECeBmidViIy+eNTRYUecjJ8vdqF1pmRP75DC08GpV4SjG
        v22CdJwFE2mMKCcINJgwuYO08/hTKTZsz1Qq6GKR49WXWiOcSie9XFcT3s+QTCAPYjJAhF
        FtBEACJgy7GoGbVMEb6kHR5xGY4QEmY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-SMYE5Iu4M5GNWVmDFCIirw-1; Fri, 06 Oct 2023 08:30:09 -0400
X-MC-Unique: SMYE5Iu4M5GNWVmDFCIirw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40570ccc497so15258435e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Oct 2023 05:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595408; x=1697200208;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8It8tkqkVjlZ4hD1o0BfKil40eztbarnBcDIj9TIgRw=;
        b=ZRkEeh5j3vaRBUGFshLQ6Fnziszox3g1VsNtG1BN0VKZhG7YUMJplOeadjyJ7BXecb
         +P6TxcRatsa1FT0DtvR7UC8OzUHc7iM2s97kM1SA6+cgrwjNNftlfdam6P44vVGUg7dI
         wdNT9PQs18nu5Jdtd1DRP45cxHKg8KbYHjsQeCjfc9ekNUTUHtcKJbaog23wLgtJZXNK
         vl34BYHl/4Lr7rA2PlIBVK2e+0uYPLtxpob5UEutvwbtbKcBK+nWLBm2CMKm1KK56w0y
         ZEV1pZnRUYvzdhpKJtlKJAxHc/hHwka8t4UnSKeemiJisqR+cLBlnKSG0+D61lKUhJQ+
         Hp3w==
X-Gm-Message-State: AOJu0YzFGxDwPPLv3eCvULbk+IT157pWxE0YgrX5PXht/55w7o4IsOoG
        06WJKyzB+YBOFn785/DsKy698TIIgRpichJsHVQcwkk0531wlmedRf0T8xarTVFUN7t82MFVYRe
        T8NvKccZXPxgbvdyy9bbTHGAV+/Gw
X-Received: by 2002:a5d:654e:0:b0:31d:db92:31ae with SMTP id z14-20020a5d654e000000b0031ddb9231aemr7724611wrv.44.1696595408361;
        Fri, 06 Oct 2023 05:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPeDl/jbLTAu2J7xcFjLubeMat581zk8oYiD1AECauqAehKlE4r1vrKnp4LPajXvYKo35KQw==
X-Received: by 2002:a5d:654e:0:b0:31d:db92:31ae with SMTP id z14-20020a5d654e000000b0031ddb9231aemr7724581wrv.44.1696595407844;
        Fri, 06 Oct 2023 05:30:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b003143c9beeaesm1559784wrx.44.2023.10.06.05.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:30:07 -0700 (PDT)
Message-ID: <df0ccf08-1bbb-418c-0b3b-57c7288a9871@redhat.com>
Date:   Fri, 6 Oct 2023 14:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
 <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
 <ZRx31TKFDGRatoC8@x1n> <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com>
 <ZRyFnurIgVFVD8hd@x1n>
 <CAJuCfpFggFpPxJjx9uGe05x0fTNONgoUf=QzkpCHLx43Tbryjg@mail.gmail.com>
 <CA+EESO5UPJrWpUKLg6m=1EmG6P9oXW6ADRkbRKjijVxj641qFQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <CA+EESO5UPJrWpUKLg6m=1EmG6P9oXW6ADRkbRKjijVxj641qFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04.10.23 01:39, Lokesh Gidra wrote:
> On Tue, Oct 3, 2023 at 11:26 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Tue, Oct 3, 2023 at 2:21 PM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Tue, Oct 03, 2023 at 11:08:07PM +0200, David Hildenbrand wrote:
>>>> Sorry I have to ask: has this ever been discussed on the list? I don't see
>>>> any pointers. If not, then probably the number of people that know about the
>>>> history can be counted with my two hands and that shouldn't be the basis for
>>>> making decisions.
>>>
>>> For example:
>>>
>>> https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcange@redhat.com/

Sorry, I had to process a family NMI the last couple of days.

>>
>> There was another submission in 2019:
>> https://lore.kernel.org/all/cover.1547251023.git.blake.caldwell@colorado.edu/

It would be good to link them in the cover letter and shortly explain 
why that wasn't merged back then (if there was any reason).

>>
>> Though both times it did not generate much discussion. I don't have a
>> strong preference though MOVE sounds more generic to me TBH (it
>> specifies the operation rather than REMAP which hints on how that
>> operation is carried out). But again, I'm fine either way.
> 
> That's a good point. IMHO, if in future we want to have the fallback
> implemented, then MOVE would be a more appropriate name than REMAP.
> 
>> As for UFFDIO_MOVE_ZERO_COPY_ONLY vs UFFDIO_MOVE_MODE_ALLOW_COPY, I
>> find it weird that the default (the most efficient/desired) mode of
>> operation needs a flag. I would prefer to have no flag initially and
>> add UFFDIO_MOVE_MODE_ALLOW_COPY or whatever name is more appropriate
>> when/if we ever need it. Makes sense?
> 
> Agreed!

I agree. One could have UFFDIO_MOVE that is best-effort and documented 
like that, and a to-be-named future extension that always works but 
might be more expensive.


Ideally we'd have an interface that does not expose and/or rely on such 
low-level information and simply always works, but getting that would 
mean that we'd have to implement the fallback immediately ... so I guess 
we'll have to expose a best-effort interface first.

-- 
Cheers,

David / dhildenb

