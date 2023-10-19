Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5256E7D0346
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbjJSUo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbjJSUoz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 16:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CD9E
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697748246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUmq71SFaV76lBrVYh6+KvqO/bkIhCdS1UYE4ErabTM=;
        b=ADarALipSI+9tWnfNZwWvC02+wg0BkVQPSyaNxEoU7GaTLXs1pcYWluANe8BwG6ifZDUfV
        6rqhWtjF/Migq4jhyEERmCMyTecvQ9HSy4XmFSMvalF1pe2rMo+H0K520TsgKZTvtlXAmR
        HDltxyb9ATHp2VQ/2ihZbw5PF9UITXk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-kmvFWgXvNJ6Z_Ay9oGnO9Q-1; Thu, 19 Oct 2023 16:43:59 -0400
X-MC-Unique: kmvFWgXvNJ6Z_Ay9oGnO9Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-59bbd849b22so146907b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 13:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697748239; x=1698353039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUmq71SFaV76lBrVYh6+KvqO/bkIhCdS1UYE4ErabTM=;
        b=Ffsx3y3jF7dWZVlAJiG2Msvro3Jqr0+xHqM+S+dNbzQl4JFs24047SDNs/xStYvzcV
         +lOYgaVCBkKOOHf0mMuvLLCXLErjkQ29PN805RzbUCzp1Uf+tCbING1gMg0E0qolySZx
         yqB3xfj4ueu6aqeXrRy+oe9FDlRj/laA01xAGIuzr4A5xD6GuPYMT1fedIfTaLK3kks/
         CI48IjljH+65ACbJdZYWYpPoC+syZggOWPwUAZHXS+N5sHmVDn1kYixLwVSN8gtAvlAb
         9dJujN8YWKwY3mlMBCvGebxz0nTe83tCaTPuZJ8QL5c6bABF+/O5CATViR6WLXySrfJp
         BSZA==
X-Gm-Message-State: AOJu0YxMznGIUmNhbbKRpYHcBXxq7/kGvmIMCG4h/algAWZxWiCtUeCQ
        WGgu2lNBl2sA4DamrFMCCdCZQYZxyDXzeyynA9JDcG6+fx1xufzEZqEWD0N68vHbiOzgWHUc/oR
        PTb5cRknFjYoKlrnNCqeQ+Py3QICi
X-Received: by 2002:a05:690c:dc9:b0:5a7:b928:9e93 with SMTP id db9-20020a05690c0dc900b005a7b9289e93mr4048141ywb.5.1697748238850;
        Thu, 19 Oct 2023 13:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh6w+8ZXZ57cfOnUfzaZAee9HlNSSE1wHtnL/nhH2FMh9qNnuc/g7W0l/g4crX2wbdluxT3Q==
X-Received: by 2002:a05:690c:dc9:b0:5a7:b928:9e93 with SMTP id db9-20020a05690c0dc900b005a7b9289e93mr4048123ywb.5.1697748238545;
        Thu, 19 Oct 2023 13:43:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05620a318c00b00772662b7804sm82248qkb.100.2023.10.19.13.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 13:43:58 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:43:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTGVDF5lJPyDF+c1@x1n>
References: <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n>
 <CAJuCfpEVgLtc3iS_huxbr86bNwEix+M4iEqWeQYUbsP6KcxfQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpEVgLtc3iS_huxbr86bNwEix+M4iEqWeQYUbsP6KcxfQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 01:02:39PM -0700, Suren Baghdasaryan wrote:
> Hi Folks,
> Sorry, I'm just catching up on all the comments in this thread after a

Not a problem.

> week-long absence. Will be addressing other questions separately but
> for cross-mm one, I think the best way forward would be for me to
> split this patch into two with the second one adding cross-mm support.
> That will clearly show how much additional code that requires and will
> make it easier for us to decide whether to support it or not.

Sounds good, thanks for that extra work.

> TBH, I don't see the need for an additional flag even if the initial
> version will be merged without cross-mm support. Once it's added the
> manpage can mention that starting with a specific Linux version
> cross-mm is supported, no?

It's about how an user app knows what the kernel supports.

On kernels that only support single-mm, UFFDIO_MOVE should fail if it found
ctx->mm != current->mm.

I think the best way to let the user app be clear of what happened is one
new feature bit if cross-mm will be supported separately.  Or the userapp
will need to rely on a specific failure code of UFFDIO_MOVE, and only until
the 1st MOVE being triggered.  Not as clear, IMHO.

> Also from my quick read, it sounds like we want to prevent movements
> of pinned pages regardless of cross-mm support. Is my understanding
> correct?

I prefer that, but that's only my 2 cents.  I just don't see how remap can
work with pin.  IIUC pin is about coherency of processor view and DMA view.
Then if so the VA is the only identifier of a "page" for an user app
because real pfn is hidden, and remap changes that VA.  So it doesn't make
sense to me to remap a pin in whatever form.

For check pinning: I think I used to mention that it may again require
proper locking over mm.write_protect_seq like fork() paths.  No, when
thinking again I think I was wrong..  write_protect_seq requires mmap write
lock, definitely not good.

We can do what David mentioned before, after ptep_clear_flush() (so pte is
cleared) we recheck page pinning, if pinned fail MOVE and put the page
back.  Note that we can't do that check after installing it into dest
pgtables, because then someone can start to pin it from dest mm already.

Thanks,

-- 
Peter Xu

