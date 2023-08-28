Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC878B73E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjH1Sc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjH1Scp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 14:32:45 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53A5B9
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:32:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79289fefdbeso91692339f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693247562; x=1693852362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlH1F433gTQcUsEtLxKZUpHNUAMNhRhkYP0DbGmnz0M=;
        b=nFrb0GNPs/wTaQ8nE94D2sT5zOH75np79gen6grO8f06qzDww14rcelBIZ8AryJmtx
         ykbAJyUCuQOhz4qfjy3SCSQ6Zk7nW9JNYgSZn4AUNdQ4WCSRwZ8/RtnIKDm68XSqo3Zh
         jcaqMY9hihGchweqJvZBajTMOa2WtIolhXueg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247562; x=1693852362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlH1F433gTQcUsEtLxKZUpHNUAMNhRhkYP0DbGmnz0M=;
        b=FhOfCc+VADI7Vuv5KB3Zmv4aLu6VE01Tr8aW5kbVpsWX8QTCYuPDxAz1CyL0LN3te3
         vBzHtNLJotmDaOryGDavZceLENaoMUrNqSf3aHpIg0W2ed9HNIVrBF7nGzD5P42JyBW7
         7uN3q6c/TsCBF2eEPznq3ANrxbEs7Hx6pb83zTdcAelthPMpGLtQwAc39p00HatWWxYh
         0soA1t9ufWbmEQOrA1Bi/vUhMls3Wndqu7CPhBRw4Sa5fSdFPOyD0lr0o+Ik0m90K7kF
         9bgP+zhxWf32FySHAonY4b0wHbI3/88+rXVnS1m55gm4RDYRNd9rG9Lp18RYh+9Jt3jl
         +qIQ==
X-Gm-Message-State: AOJu0YxW75DWMrNlLmFWhF7t1KvhOPiNZu3Ni6gSaHtdoiakF5bYSPkj
        Ak5Cq57RDKK5YRHq2TeelA5Tag==
X-Google-Smtp-Source: AGHT+IFBKaZS5q2OBtEoOJhIJR2uV7Jev+fXXzpRuiK0lkyhalyR6TxJ2IhnOS+W5HHEfqZbHItCdg==
X-Received: by 2002:a5d:9718:0:b0:786:f47b:c063 with SMTP id h24-20020a5d9718000000b00786f47bc063mr17281322iol.21.1693247562178;
        Mon, 28 Aug 2023 11:32:42 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f7-20020a6bdd07000000b007922dc27aa6sm2677118ioc.24.2023.08.28.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:32:41 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:32:40 +0000
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
Subject: Re: [PATCH v5 2/7] mm/mremap: Allow moves within the same VMA
Message-ID: <20230828183240.GA1621761@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-3-joel@joelfernandes.org>
 <46196ba1-c54d-4c1d-954f-a0006602af99@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46196ba1-c54d-4c1d-954f-a0006602af99@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 10:21:14AM +0100, Lorenzo Stoakes wrote:
[..] 
> >
> >  /*
> >   * Flags used by change_protection().  For now we make it a bitmap so
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 035fbf542a8f..06baa13bd2c8 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -490,12 +490,13 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
> >  }
> >
> >  /*
> > - * A helper to check if a previous mapping exists. Required for
> > - * move_page_tables() and realign_addr() to determine if a previous mapping
> > - * exists before we can do realignment optimizations.
> > + * A helper to check if aligning down is OK. The aligned address should fall
> > + * on *no mapping*. For the stack moving down, that's a special move within
> > + * the VMA that is created to span the source and destination of the move,
> > + * so we make an exception for it.
> >   */
> >  static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> > -			       unsigned long mask)
> > +			    unsigned long mask, bool for_stack)
> >  {
> >  	unsigned long addr_masked = addr_to_align & mask;
> >
> > @@ -504,7 +505,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
> >  	 * of the corresponding VMA, we can't align down or we will destroy part
> >  	 * of the current mapping.
> >  	 */
> > -	if (vma->vm_start != addr_to_align)
> > +	if (!for_stack && vma->vm_start != addr_to_align)
> >  		return false;
> 
> I'm a little confused by this exception, is it very specifically for the
> shift_arg_pages() case where can assume we are safe to just discard the
> lower portion of the stack?
> 
> Wouldn't the find_vma_intersection() line below fail in this case? I may be
> missing something here :)

I think you are right. In v4, this was not an issue as we did this:


+	if (!for_stack && vma->vm_start != addr_to_align)
+		return false;
+
+	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
+	if (WARN_ON_ONCE(cur != vma))
+		return false;

Which essentially means this patch is a NOOP in v5 for the stack case.

So what we really want is the VMA previous to @vma and whether than subsumes
the masked address.

Should I just change it back to the v4 version then as above for both patch 1
and 2 and carry your review tags?

This is also hard to test as it requires triggering the execve stack move
case. Though it is not a bug (as it is essentially a NOOP), it still would be
nice to test it. This is complicated by also the fact that mremap(2) itself
does not allow overlapping moves. I could try to hardcode the unfavorable
situation as I have done in the past to force that mremap warning.

thanks,

 - Joel

