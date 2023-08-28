Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D538478B91B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjH1UK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjH1UKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 16:10:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434418B
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 13:10:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-792726d3aeeso124740539f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693253416; x=1693858216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToWphglk+jIuHakrdkLEs6Kl6awIC29pkULLo3yXCKo=;
        b=opnfX7b9FR3Qkgauj6UCrsY7xR+J5wJYa42+TByn5zs9WuIDdwBZ/EyWTlLxHjGozd
         OWZE/Jpypl+dCk7Ci9R8//E58DBdZQD+ygj2hIVUa85drAGTVHz4nZCUeVcD3J36N4JP
         Ye8g8HF+YWnBiCSglWYj4qaKxJdQBlO9dphiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253416; x=1693858216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToWphglk+jIuHakrdkLEs6Kl6awIC29pkULLo3yXCKo=;
        b=k6+PpP2mOYB+UZTJp6y6zqtHVDPts6vkAxJC/FyND4Gm3mV2MdIOJfwKA128k4fnOX
         7daRpY4Pr+L93+jJWhILTxjkcGzN9+XVNKQdYULFRJhzStU3eGmE1Wwr+lumf66DaoB1
         8pqmjRi3aRuDzEP5VgpZfeg2BI+cNfBbjmm0nsrAn2CCSsytNUK8yFJwzfILKAbdu7aL
         CHxpyJbOiwWezzQ4yMyQtVETeR3xiCE0+CiTNL7ksDX5qNTKnYI939o1KRLKQ9wqpZyQ
         WHezl01J8HUe0tdgk3dqthFDL8ZvCgZj7Qe+VsbF6bqbJuCJe+HKJ3B8cFldT8GH1EcJ
         YlLA==
X-Gm-Message-State: AOJu0YxEMFKxh2Qn3kmPjdZz8KzMYHQBHRFsI9QzGajbOy8M30eYcPm9
        qkMWVJ73hQmxQhCoR4v6pSEG/w==
X-Google-Smtp-Source: AGHT+IERYLuZL1QL0QoiA84CN1/KLm1TA2o4+eMMfgLcKyh2olmnmGGumOzk6cul2wISK2HloiBTXQ==
X-Received: by 2002:a05:6602:4250:b0:792:931e:a93a with SMTP id cc16-20020a056602425000b00792931ea93amr7871160iob.4.1693253416305;
        Mon, 28 Aug 2023 13:10:16 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id s21-20020a02cf35000000b0041cd626ea0csm2704691jar.147.2023.08.28.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:10:15 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:10:15 +0000
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
Message-ID: <20230828201015.GE1621761@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-7-joel@joelfernandes.org>
 <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
 <fb429d82-4576-42d7-b51f-7a72f7f8caec@lucifer.local>
 <20230828185912.GD1621761@google.com>
 <ebcf8a58-84ac-4568-be2a-51826f384f4e@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcf8a58-84ac-4568-be2a-51826f384f4e@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 08:38:17PM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 28, 2023 at 06:59:12PM +0000, Joel Fernandes wrote:
> > On Sun, Aug 27, 2023 at 11:15:20AM +0100, Lorenzo Stoakes wrote:
> > > On Sun, Aug 27, 2023 at 10:57:59AM +0100, Lorenzo Stoakes wrote:
> > > [snip]
> > >
> > > > > +/*
> > > > > + * Verify that an mremap within a range does not cause corruption
> > > > > + * of unrelated part of range.
> > > > > + *
> > > > > + * Consider the following range which is 2MB aligned and is
> > > > > + * a part of a larger 10MB range which is not shown. Each
> > > > > + * character is 256KB below making the source and destination
> > >
> > > Just noticed, I think you misspeak here, as this test doens't seem to
> > > offset by 256 KiB? That is the strategy for mremap_move_1mb_from_start()
> > > rather than this test so perhaps comment needs to be moved around?
> > >
> > >  * 2MB each. The lower case letters are moved (s to d) and the
> > >  * upper case letters are not moved. The below test verifies
> > >  * that the upper case S letters are not corrupted by the
> > >  * adjacent mremap.
> > >  *
> > >  * |DDDDddddSSSSssss|
> > >  */
> > >  static void mremap_move_within_range(char pattern_seed)
> >
> > Here we are moving 1MB within a 4MB zone of a large mapping. Each character
> > 's' or 'd' is 256KB. The 256KB there is just for illustration and not really
> > significant as such. The 'ssss' is moved to 'dddd' 1MB each. Here we make
> 
> Ahhh I see. I find that a little confusing here, perhaps clearer to say 'each
> block of letters is 1 MiB in size' or something?

Sure, I'll do that.
 
> Cheers!

Cheers. And thanks for the reviews!

 - Joel
