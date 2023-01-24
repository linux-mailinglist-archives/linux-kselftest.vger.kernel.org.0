Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5C67A02F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 18:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjAXRbY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjAXRbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 12:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B444617F
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674581437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFq/mNBnI/BqcjC2peFCYxWVr3CPoW0svWlbdoxg4JQ=;
        b=hygyXt+OjGOzwDveKGXiV9lFOqImcwgi2utsYpJhlTdq9ezUjtySfYepQy5EpTTSG4vibB
        GI1JLbe0s2meyCeBZakDLbgVtnc6cT5M+grQ/TqQ+xIwsWL2FBv9KCEC+8nYZeAClvr1bT
        FPplrkDYGwmaKkjh85qcOTPW8/vtyG8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494-JgmbdZ9iMJCrbtGb3xQH0A-1; Tue, 24 Jan 2023 12:30:36 -0500
X-MC-Unique: JgmbdZ9iMJCrbtGb3xQH0A-1
Received: by mail-vs1-f70.google.com with SMTP id b65-20020a676744000000b003cedad0ea4bso3821303vsc.9
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 09:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFq/mNBnI/BqcjC2peFCYxWVr3CPoW0svWlbdoxg4JQ=;
        b=j5tQCA+T14Hy3gKn//3W0viyaF38OErWv8TNfI8J8Uc75jr5/FOTCUmAtUIOaIkULd
         bSXTOMIIXdQb4VweCVMdIPWbBh9u22QinUzOIsu9VcyspcVJGYgNnbEQ4lw2tYzHz870
         t7K5Ay20O2SpbbjNnbXSArJUDJ3RJKHocNVEQZi6glleQSVBOt/BpmWJEHpH/QRDl4PZ
         vo++A98mD2j/RnySuqJffKtytgTmakUQrSFe7NNxeM+Co5NEETC2lVOW+5cCAGDzSYmi
         cIamANRUDo6HtOPpGpu7nFBzNE87yCIBXmd6qXouV4HdrSKzFGx4oCzsuXCG2WRTOcy0
         tqqQ==
X-Gm-Message-State: AFqh2krEeMImxV8tlzb14nCfT04F/DmV4r5GaLIpfytMzy+jNJ4meiDX
        +WgbPojn801/1PaIEeOfeIHYKpM8zBbTYAL8+Z5TrlFVNBIKJRsWJZ+jqv0aHx/QGZO1TMbpHKl
        d5i25OtLqItSqBDTUz5E/qfyZsDti
X-Received: by 2002:a05:6102:3d86:b0:3b1:4999:1729 with SMTP id h6-20020a0561023d8600b003b149991729mr18463173vsv.32.1674581435823;
        Tue, 24 Jan 2023 09:30:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsyS/lviwCEpx4hKAW3VXvWWIWezeP2/jZ5CCZZkaNf6ca5wcGThV91c0/XonyDxlB64+l5aw==
X-Received: by 2002:a05:6102:3d86:b0:3b1:4999:1729 with SMTP id h6-20020a0561023d8600b003b149991729mr18463141vsv.32.1674581435542;
        Tue, 24 Jan 2023 09:30:35 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s133-20020a37a98b000000b00706afbdeb01sm1799074qke.8.2023.01.24.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:30:34 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:30:32 -0500
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
Subject: Re: [PATCH v7 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y9AVuF63y9UjEYcj@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-4-usama.anjum@collabora.com>
 <Y8hyqhgx41/ET7bC@x1n>
 <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 05:18:13PM +0500, Muhammad Usama Anjum wrote:
> >> +	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
> >> +		return -ENOSPC;
> > 
> > This is the function to test "whether the walker should walk the vma
> > specified".  This check should IIUC be meaningless because found_pages
> > doesn't boost during vma switching, while OTOH your pmd walker fn should do
> > proper check when increasing found_pages and return -ENOSPC properly when
> > the same condition met.  That should be enough, IMHO.
> This check is needed in case we want to abort the walk at once. We return
> negative value from here which aborts the walk. Returning negative value
> from pmd_entry doesn't abort the walk. So this check is needed in the
> test_walk.

Why?  What I see locally is (walk_pmd_range):

		if (ops->pmd_entry)
			err = ops->pmd_entry(pmd, addr, next, walk);
		if (err)
			break;

Thanks,

-- 
Peter Xu

