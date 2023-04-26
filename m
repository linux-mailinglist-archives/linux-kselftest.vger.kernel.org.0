Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336EE6EF615
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjDZOOh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjDZOOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 10:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27A6A57
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682518428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZY/DGd7KWtJA1mhxoodB4vkh85XMWSpyoDAgN9JXUHw=;
        b=Pz8CDg9zc4ci96yNBKX0Jui++dGYTNOvNuDxW1vVVFPzfn+SVvaPsV+MJgFLfOORnja/Ar
        kAHJkTIjuCui7TKADw8yhTUnVdhZhuwcHTX70CIfmZeLwO/raO70haBL9JQ+e4ETdR8H3L
        ecVQLrIRG9xxROptUK6MGgh+AntFuwE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ZPpkSyiKNp6TMtOLUJl8dQ-1; Wed, 26 Apr 2023 10:13:35 -0400
X-MC-Unique: ZPpkSyiKNp6TMtOLUJl8dQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74e0a11dce7so37807485a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682518410; x=1685110410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY/DGd7KWtJA1mhxoodB4vkh85XMWSpyoDAgN9JXUHw=;
        b=Tf8KSEevj7WGM9L6eQkzsNxA+R124vmLFiHALcdUJz0DohKE7djCwlJ1rY0TpNqeSX
         wFkPLtViCirTuEH9MaZXLXi6oHnGtc7JgTODJxZcLjGpe6r0x+L6nTMIDMU9O5ZL3GWW
         i56u4RNHt8dGZjqHZAwyeRlrRSbK53ZW4W1jjJ8zWJttCFnUsKzB1EL9yhpkL3/3/mNV
         mRoy+gfMKgJnFEpdFvFTScZ5KG/r/iZHYexBjqj9K1boqG8eGM+tJ0ppwGvhudWaY71E
         fJCri0iT0l+SOhU8BU+SvMnEvfDQwnZLbYdzvd4xgdK1kmz89Jmw6G28uVICoSMb1lbA
         Z8Hg==
X-Gm-Message-State: AAQBX9dfSuZ9MkVHYPumlkGYVlaSb8tUSWX259P50yENKX0F+TB3wsep
        /F4YbGbHwmlhA/UIIbenuxYLCmZZUFrjIVeEva1+jCco3kjYba+IBRtKNvsqxS5jYSVuQmbibJZ
        9/uTt2goAEAjAQUwxMKgq1UDSzaPr
X-Received: by 2002:a05:622a:1818:b0:3ef:59e8:511f with SMTP id t24-20020a05622a181800b003ef59e8511fmr35114557qtc.0.1682518410346;
        Wed, 26 Apr 2023 07:13:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ypb1WVI8Au+jeNnS1kOxOesFDM/LXy8R7e8LtLca5Jtza4C18yaEzzsP5hULc8x6Vg88C0Xg==
X-Received: by 2002:a05:622a:1818:b0:3ef:59e8:511f with SMTP id t24-20020a05622a181800b003ef59e8511fmr35114509qtc.0.1682518410050;
        Wed, 26 Apr 2023 07:13:30 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id y19-20020a05622a121300b003e390b48958sm2613867qtx.55.2023.04.26.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:13:29 -0700 (PDT)
Date:   Wed, 26 Apr 2023 10:13:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
Message-ID: <ZEkxh6dbnAOuYuJj@x1n>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Muhammad,

On Wed, Apr 26, 2023 at 12:06:23PM +0500, Muhammad Usama Anjum wrote:
> On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
> > +/* Supported flags */
> > +#define PM_SCAN_OP_GET	(1 << 0)
> > +#define PM_SCAN_OP_WP	(1 << 1)
> We have only these flag options available in PAGEMAP_SCAN IOCTL.
> PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
> be specified as need. But PM_SCAN_OP_WP cannot be specified without
> PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
> functionality which can be achieved by UFFDIO_WRITEPROTECT.)
> 
> 1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
> vs
> 2) UFFDIO_WRITEPROTECT
> 
> After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
> getting really good performance which is comparable just like we are
> depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
> PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
> performance and behavior wise.
> 
> I've got the results from someone else that UFFDIO_WRITEPROTECT block
> pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
> as I don't have tests comparing them one-to-one.
> 
> What are your thoughts about it? Have you thought about making
> UFFDIO_WRITEPROTECT perform better?
> 
> I'm sorry to mention the word "performance" here. Actually we want better
> performance to emulate Windows syscall. That is why we are adding this
> functionality. So either we need to see what can be improved in
> UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
> pagemap_ioctl?

I'm fine if you want to add it back if it works for you.  Though before
that, could you remind me why there can be a difference on performance?

Thanks,

-- 
Peter Xu

