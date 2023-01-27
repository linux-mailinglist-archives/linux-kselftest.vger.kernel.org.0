Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2967EC22
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjA0RJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 12:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjA0RJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 12:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99C212A9
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674839162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PmxGa44W6isfjTBSzVfP/UwTsDElhnXKEsXbjHCdyrI=;
        b=FXrmoCriZHJfHWTWMh5dxJw9rVXJMusII24utF+WW3hBJ+HbDLj1gtQ9yeW5ooDVm9tLRO
        +sy+MnZ8pg+qVCeS3zfGIq4Rh5UXAqnISCYndzEtBsu0X80D4NKvgFOoYAXx1IiV7qUqba
        jjtSQj0jTELU927MPLsCvXcpdGpxeyQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-DDr5IepJP4aBx9hWZPehoQ-1; Fri, 27 Jan 2023 12:06:00 -0500
X-MC-Unique: DDr5IepJP4aBx9hWZPehoQ-1
Received: by mail-qv1-f71.google.com with SMTP id lv8-20020a056214578800b0053477624294so3082712qvb.22
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 09:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmxGa44W6isfjTBSzVfP/UwTsDElhnXKEsXbjHCdyrI=;
        b=WFx2WzR2YD8Odas7l/yfESFf/1GytmIRYcXIb0wJrRGQpu1uJW22MHKAaQ4FxmPgZi
         dW/GUX7x5vQYLwjhZ5LWHYXNKnCghc9EVly7mqX5JRKc/d/TVbTbjjKYHf5KA3ttdlD2
         DhODS8SrV3IrRUsyve9z5LON3eeQZn4IBaV8odFd5XYJ43jqLAk2UrEm/iDTY0xYMo9E
         ZXm4su5tHpe9lLQWk0/c9n/u9VOhWMXsAKFg7aud5VJ6r0y51YXPK6eBOJ53YaGqkxOu
         ZGrWH6ypLFVWL7eAA6Fh1uIgOi5YmM3w1SK1ZZZQEfbW1r/2M8fitFgLGNB6kok3wMv2
         3mxQ==
X-Gm-Message-State: AFqh2kqUmf/RcJOouft/X6guMSGuglS9dCqvwsvtIO+ntywK9CGtdA15
        Q4eAcqwYXSGL17d9OLqTGUJe/f3MH2CCJi6kW33pCQ2bRTSyd+qtu8JwiSZ+4+vSoB5GntAaGKU
        mL9ba4QU3bPFH0lCTS0eksGcIDfG8
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr63120118qtb.52.1674839160397;
        Fri, 27 Jan 2023 09:06:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBuMR76qCD9iNhA3MG7zbleHxGuuO1yl2hlMrlf18HF044I6aiUQq824mIaMRnIi9g+mEKbA==
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr63120073qtb.52.1674839160145;
        Fri, 27 Jan 2023 09:06:00 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x20-20020ac84a14000000b00399fe4aac3esm2949817qtq.50.2023.01.27.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:05:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:05:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
Message-ID: <Y9QEdbkZxOJ10oEJ@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 01:43:21PM +0500, Muhammad Usama Anjum wrote:
> Split mwriteprotect_range() to create a unlocked version. This
> will be used in the next patch to write protect a memory area.
> Add a helper function, wp_range_async() as well.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

IIUC this patch is not needed.  You have a stable vma, so I think you can
directly use uffd_wp_range(), while most of the mwriteprotect_range() is
not needed.

There's one trivial detail of ignoring userfaultfd_ctx->mmap_changing when
it's set to true, but I don't think it applies here either because it was
used to resolve a problem in uffd non-cooperative mode on the predictable
behavior of events, here I don't think it matters a lot either.

-- 
Peter Xu

