Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A878B7BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjH1S7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjH1S7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 14:59:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563EE0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:59:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79241bb5807so128016639f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693249154; x=1693853954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOayUphw9rbYNSf22YYGNwEHqwC4UHEhlEANqh7uDo0=;
        b=tutcRQkkszGs2rz30qhCqzDMHK1Fv1Cbu+U0xiv7yVDh9UpJdnCNZqzuQrIKQy5BsW
         93rV5Fn0MoAIIWfwBWrqIL3acQGhgWuSA9ocdGWWK3z01nLvKv47zoZVozhi9cMbvzOX
         WlXj8LI8GK8PgGk8CP0cViYlFHoawo3RSWQWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693249154; x=1693853954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOayUphw9rbYNSf22YYGNwEHqwC4UHEhlEANqh7uDo0=;
        b=V/hE9clJd8pXPvvbkLV1g/PwbWsC7mSkRvQmw9qPQ/XKFPCvLlKKm5dChS+/WiDNZ4
         bSqnoD8xh9AqRyH7IxLkWhdD9FZivWDCgNfWFAMGEv99SVjLWRE0tsL3i5Jr/FqjF5aV
         uOIs9w6WEvCDn7oG83pu2Nci3E/rGeKxDAAapsDG0a/zAdPg3zO5yiB8DPbsTUSeZvCy
         IfvrBSL+6KWQOu/EF+uqdtnPoKinJB3e1okx6F3WdT3r8D/SWbmQaoZyVJAu2JBW7xqr
         pm6cKwXui9zwkrEklB9RuWHyfJ7ST4p8gko2627HZTQGRmt8/ZijojwkmhaKN9ZBH4uM
         5Sww==
X-Gm-Message-State: AOJu0YyzCj7y0N1u2hsMmuYn+IEx1FTUvMYnca0UxaB9GC4H0x7ui57r
        BoB0W7z+URjgjyZmj61I12s3Yw==
X-Google-Smtp-Source: AGHT+IEisyycO3POm2i80EtJIXlOwXcfn9iugZNdRMdhUFEp8AluNkfyKgouYOqpSK7cSrTi9P/vkw==
X-Received: by 2002:a92:607:0:b0:34c:fed8:8df2 with SMTP id x7-20020a920607000000b0034cfed88df2mr3603955ilg.21.1693249154409;
        Mon, 28 Aug 2023 11:59:14 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id u13-20020a02cbcd000000b0042b4b55f46fsm2553131jaq.117.2023.08.28.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:59:13 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:59:12 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v5 6/7] selftests: mm: Add a test for remapping within a
 range
Message-ID: <20230828185912.GD1621761@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-7-joel@joelfernandes.org>
 <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
 <fb429d82-4576-42d7-b51f-7a72f7f8caec@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb429d82-4576-42d7-b51f-7a72f7f8caec@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 11:15:20AM +0100, Lorenzo Stoakes wrote:
> On Sun, Aug 27, 2023 at 10:57:59AM +0100, Lorenzo Stoakes wrote:
> [snip]
> 
> > > +/*
> > > + * Verify that an mremap within a range does not cause corruption
> > > + * of unrelated part of range.
> > > + *
> > > + * Consider the following range which is 2MB aligned and is
> > > + * a part of a larger 10MB range which is not shown. Each
> > > + * character is 256KB below making the source and destination
> 
> Just noticed, I think you misspeak here, as this test doens't seem to
> offset by 256 KiB? That is the strategy for mremap_move_1mb_from_start()
> rather than this test so perhaps comment needs to be moved around?
> 
>  * 2MB each. The lower case letters are moved (s to d) and the
>  * upper case letters are not moved. The below test verifies
>  * that the upper case S letters are not corrupted by the
>  * adjacent mremap.
>  *
>  * |DDDDddddSSSSssss|
>  */
>  static void mremap_move_within_range(char pattern_seed)

Here we are moving 1MB within a 4MB zone of a large mapping. Each character
's' or 'd' is 256KB. The 256KB there is just for illustration and not really
significant as such. The 'ssss' is moved to 'dddd' 1MB each. Here we make
sure that this move did not accidentally corrupt 'SSSS' and 'DDDD' due to
alignment optimization. Basically to protect from this, we check in the code
that the source address is beginning of the VMA:
+	if (vma->vm_start != addr_to_align)
+		return false;

But you did point an issue which is I need to change the comment from 'larger
10MB' to 'larger 20MB'.

In the mremap_move_1mb_from_start() test, I request for an alignment of
1.25MB so that when I align down, I fall no mapping. This is to catch a bug
that Linus found which is that just because an aligned down address did not
fall on a mapping, that doesn't mean we can just move it at PMD-level
otherwise we destroy the mapping.

I do need to update the test name in mremap_move_1mb_from_start() to: "mremap
move 1mb from start at 1MB+256KB aligned src". So thanks for point this!

Would that sort it out or is there still something in the comment I am
missing?

Thanks!

 - Joel






> 
> [snip]
