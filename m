Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4F78B880
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjH1Tii (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjH1TiX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 15:38:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AA0122;
        Mon, 28 Aug 2023 12:38:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4018af103bcso22602645e9.1;
        Mon, 28 Aug 2023 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693251499; x=1693856299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esAW1Vw3kz0RXHL7BJoZeroaJEwV9jtttk9VWFt4WEE=;
        b=iqykqWkgqBJKKiRSkIywBrMOKAzPP7boOhrfuCqhthSMpVqq0V8sTXhDiOvewIxfkt
         6kO+IEgGogUwOk6zkHPoBTNoPusYXqiN3O1oWoy20szfvJD4492odi+mh4uCKc5wOlpF
         iDuQNjPrFfTfvza/3e/Pfi0d4uqiwezEdzgY5WbPDJb2a6vurgQ9KM4cDB6tcpdyhNyX
         A222R7cirBODJ71VMGvQq1f1YMoNv94bkLozJpQj6XFdH6NlNHPvnB/WUNnMVrNZmbQB
         3ljPVZzbPfhNKt5pNqfnMUAj4X2ubwJNXIZ8BEV7FrXoXVnKR9KLn/vs+fLHvERLAUcG
         RoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251499; x=1693856299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esAW1Vw3kz0RXHL7BJoZeroaJEwV9jtttk9VWFt4WEE=;
        b=WOis5uU+qHqbHqHUVLTrha9yxFjtMHo7vr5I7pAvqQwpTOuvQ8EtYL2Y13PGVRAqw+
         hcDbD00tRof0af7m8kP/TrySkDCJVxoET1xcpGJGZtbK0F8WSr6u1KtvZZvIGV67WXYx
         cLxoLBDXKTJFoCfgu1j+DKscVoUl7NljFsFUnCDtPUbA8j5/fKB1v9yHqjbDO6kNZqH2
         mGTBw8RQs5FhdSXi/7T5LmkQ//Z74kAVw8PK6cXVH8yYwWkjXqpXKNymvfkVEU9eoBb+
         2RZBFQbdhr5+xCJAVUOj/rJMRDmQStlo+kCcxwyLo+0Lo1krKvNuLgjbbUAJz3wbOhgQ
         cmAA==
X-Gm-Message-State: AOJu0Yymrj0LtMXvzfQTUOtIrdMl40IT5g3WuA6ZfZ7mqph54rqF3eFc
        H3edoYROxlT1KDGBZEnv7E0=
X-Google-Smtp-Source: AGHT+IGADrSrhqf8727bLcRqdBYN69xQAHTrH64+PqYVOOYIf9AbtKTLrSDzAfsWwY6YciG7gRruew==
X-Received: by 2002:adf:f890:0:b0:318:720c:bb3 with SMTP id u16-20020adff890000000b00318720c0bb3mr373532wrp.20.1693251499037;
        Mon, 28 Aug 2023 12:38:19 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6107000000b0031c4d4be245sm11323906wrt.93.2023.08.28.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:38:18 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:38:17 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <ebcf8a58-84ac-4568-be2a-51826f384f4e@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-7-joel@joelfernandes.org>
 <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
 <fb429d82-4576-42d7-b51f-7a72f7f8caec@lucifer.local>
 <20230828185912.GD1621761@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828185912.GD1621761@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 06:59:12PM +0000, Joel Fernandes wrote:
> On Sun, Aug 27, 2023 at 11:15:20AM +0100, Lorenzo Stoakes wrote:
> > On Sun, Aug 27, 2023 at 10:57:59AM +0100, Lorenzo Stoakes wrote:
> > [snip]
> >
> > > > +/*
> > > > + * Verify that an mremap within a range does not cause corruption
> > > > + * of unrelated part of range.
> > > > + *
> > > > + * Consider the following range which is 2MB aligned and is
> > > > + * a part of a larger 10MB range which is not shown. Each
> > > > + * character is 256KB below making the source and destination
> >
> > Just noticed, I think you misspeak here, as this test doens't seem to
> > offset by 256 KiB? That is the strategy for mremap_move_1mb_from_start()
> > rather than this test so perhaps comment needs to be moved around?
> >
> >  * 2MB each. The lower case letters are moved (s to d) and the
> >  * upper case letters are not moved. The below test verifies
> >  * that the upper case S letters are not corrupted by the
> >  * adjacent mremap.
> >  *
> >  * |DDDDddddSSSSssss|
> >  */
> >  static void mremap_move_within_range(char pattern_seed)
>
> Here we are moving 1MB within a 4MB zone of a large mapping. Each character
> 's' or 'd' is 256KB. The 256KB there is just for illustration and not really
> significant as such. The 'ssss' is moved to 'dddd' 1MB each. Here we make

Ahhh I see. I find that a little confusing here, perhaps clearer to say 'each
block of letters is 1 MiB in size' or something?

> sure that this move did not accidentally corrupt 'SSSS' and 'DDDD' due to
> alignment optimization. Basically to protect from this, we check in the code
> that the source address is beginning of the VMA:
> +	if (vma->vm_start != addr_to_align)
> +		return false;
>
> But you did point an issue which is I need to change the comment from 'larger
> 10MB' to 'larger 20MB'.

Did I? Well happy to take credit ;)

>
> In the mremap_move_1mb_from_start() test, I request for an alignment of
> 1.25MB so that when I align down, I fall no mapping. This is to catch a bug
> that Linus found which is that just because an aligned down address did not
> fall on a mapping, that doesn't mean we can just move it at PMD-level
> otherwise we destroy the mapping.

Yeah that case it all makes sense in, just wondered if the comment belonged
there but just me not reading your comment carefully!

>
> I do need to update the test name in mremap_move_1mb_from_start() to: "mremap
> move 1mb from start at 1MB+256KB aligned src". So thanks for point this!
>
> Would that sort it out or is there still something in the comment I am
> missing?

Just the suggestion above re: clarification, however it's not a show
stopper more of a small nit.

>
> Thanks!
>
>  - Joel

Cheers!

>
>
>
>
>
>
> >
> > [snip]
