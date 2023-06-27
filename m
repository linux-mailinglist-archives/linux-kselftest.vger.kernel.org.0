Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C27402CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjF0SCg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjF0SCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 14:02:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F2296B;
        Tue, 27 Jun 2023 11:02:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3113dabc549so6562277f8f.1;
        Tue, 27 Jun 2023 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687888951; x=1690480951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goa42M9DzRb9h/mnWpooF3Ny8vytrBBwoFO9ZHZqKto=;
        b=Fxc/Hj8LImN3leqe0w2ISJ37IyQdRyDIpDFaEUTQTlxQhSLTXhlYwUSjxy2dAt84qy
         v/vp/T2L9mwLR0s+mY2EHrKTnx29gii53ZVbysrO2hnjayS+8gHpNYiPi9E7kZo2zADO
         W2HKo6FAP+HDWNHlZLYwW1e9Ilzy8smxf5nQLDGOiVpWUakqWbV8Z9few9bxtCryRKaM
         /5rlOJMa5SMj6PUJgnKaIkjzbf9MTXnE6bu1zcLm33NZJGBkrR13N1UHR6f/UO5GP96g
         DEIomQYkXdo5Ar6cM3cJHd1FoHG/klNgp9aRDFMTxks/frlzfVIKOxM3Q/8Cok+ELTYD
         QRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888951; x=1690480951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goa42M9DzRb9h/mnWpooF3Ny8vytrBBwoFO9ZHZqKto=;
        b=bh6D9HRFkWoUkx0nzX70bukpV5PFpVtFVdUuOi4wxSfWgHoak0eY41XrKljTd0+AYP
         TRoV8N/7Fhizwu6NWUXJJyMFrN7HVmmaxht8LmnE1gbQ1D7l+93oRzzbCGg08aayoNI0
         FK/DziYq2Ah6mjHTnAKvfYus22sO1X6WKxqJ71RjtJgpHnDKJVCxOC+n9BgKs8ln47mN
         m8kpRKNS68wDQA4wA9o6fgO5iXVVqF1B/jONyps8VNZycihsoU1E2PQEiYiLEIwIm/5d
         +JLza3qz26w7kcy5dYixBMk5x1NyRMlld85gADzAS8aCvyTKb1fIcoSjPdd3j8a15If8
         Im+w==
X-Gm-Message-State: AC+VfDxpRGpz0VT4ifR4xP1AIJNCJsleAb3pJpBk9es9SX3oVoB0JjMx
        GRwoJl/7Pxs62dSgvvkRa9g=
X-Google-Smtp-Source: ACHHUZ4iMbz92ay0FqWK+4uSCi4J4aWB19HFktwq7p/WeH4WHqfgQZ006Vr1pCcCxn/m8FW1hYPJPg==
X-Received: by 2002:a5d:590c:0:b0:30f:ba85:52b9 with SMTP id v12-20020a5d590c000000b0030fba8552b9mr33941057wrd.37.1687888950771;
        Tue, 27 Jun 2023 11:02:30 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003fba2734f1esm2781378wmc.1.2023.06.27.11.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:02:29 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:02:29 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <e6da79b4-e48d-4b09-86b8-96bc66604694@lucifer.local>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
 <20230627175609.xrn4mle6hpi6exh7@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627175609.xrn4mle6hpi6exh7@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27, 2023 at 01:56:09PM -0400, Liam R. Howlett wrote:
[snip]
> > > How about something like:-
> > >
> > > return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;
> > >
> > > Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
> > > empty.
> > >
> > > But actually, we should be able to go further and replace the previous
> > > check with:-
> > >
> > > return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;
> > >
> > > Which will fail if addr_to_align is offset within the VMA.
> >
> > Your suggestion would mean that we do a full VMA search starting from the
> > root. That would not be a nice thing if say we've 1000s of VMAs?
> >
> > Actually Liam told me to use find_vma_prev() because given a VMA, the maple
> > tree would not have to work that hard for the common case to find the
> > previous VMA. Per conversing with him, there is a chance we may have to go
> > one step above in the tree if we hit the edge of a node, but that's not
> > supposed to be the common case. In previous code, the previous VMA could
> > just be obtained using the "previous VMA" pointer, however that pointer has
> > been remove since the maple tree changes and given a VMA, going to the
> > previous one using the maple tree is just as fast (as I'm told).
>
> I think there's been a bit of a miscommunication on that..
>
> If you have already found the VMA and are using the maple state, then
> it's very little effort to get the next/prev.  Leaf nodes can hold 16
> entries/NULL ranges, so the chances to go to the next/prev is usually in
> the cpu cache already.. if you go up a level in the tree, then you will
> have 10 nodes each with 16 entries each, etc, etc..  So the chances of
> being on an edge node and having to walk up multiple levels to get to
> the prev/next becomes rather rare.. and if you've just walked down, the
> nodes on the way up will still be cached.
>
> Here, you're not using the maple state but searching for an address
> using find_vma_prev(), but internally, that function does use a maple
> state to get you the previous.  So you are looking up the VMA from the
> root, but the prev will very likely be in the CPU cache.
>
> Assuming the worst case tree (each VMA has a gap next to it, not really
> going to happen as they tend to be grouped together), then we are
> looking at a 4 level tree to get to 8,000 VMAs.  5 levels gets you a
> minimum 80,000.  I've never seen a tree of height 6 in the wild, but you
> can fit 1.6M to 800K in one.
>
> I think the code is fine, but I wanted to clarify what we discussed.

Would the same apply to find_vma_intersection(), as they equally searches
from the root and allows the code to be made fairly succinct?

I really am not a huge fan of find_vma_prev() searching for a VMA you
already have just to get the previous one... would at lesat like to use
vma_prev() on a newly defined vmi, but if find_vma_intersection() is fine
then can reduce code to this.

[snip]
