Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3374B78B755
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjH1SiT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjH1Sh5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 14:37:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE821BB
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:37:48 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34baf19955cso10886475ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693247867; x=1693852667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aeA+YemQ9g7XInX/f96izKvTfLcSSJK1SLJJW0jCfI=;
        b=SH8jxYzqPWl2O32h0Ogm94o1PofQqU6DaPrQRD/G0r8ur4Om+FS9pGS8xoQdQe6ZtN
         jonkZUnZz4vIHKnMvhPOWoiuW+zyMcHvTs26ojfEsa56CVAS5PqJ0jN56h8Qs62ZiNc6
         dhQ0/34QhWGk+P2JVk/2dUI1HdZyVA4GTu6Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247867; x=1693852667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aeA+YemQ9g7XInX/f96izKvTfLcSSJK1SLJJW0jCfI=;
        b=FtVt80W8eM/68HV4dZkvNi3cMi9WVNO3wd8Hgh8J8i0Dknqin0QrdYsGYXP0ajJVbH
         knPT4/Awh/LlqdvqjJkFGxaxTfelgyr9AJAvMxaXOZUPepWce5eQdTUcae/OgkzojB+o
         SFM8yRg3QL5FFht5Tu/TOcNUWsFg0MB7GQznby/nrG9+CoFbYEwLIgM991ARP4E98sBG
         zt7e8UIK+9qIeIQR21Nm11dCwlKJt5a0BsMs/GZCaellvhw/z4u74NEDI6QuwS2r9DmU
         SoPTv97cq6ufvGAKgSko7Ed4Piov3poz6LX4VPXoZ2wW8SJB4529Jb4Gnn/a+HNlvIqY
         VHrg==
X-Gm-Message-State: AOJu0YwTLgeKM89QTeJFBuoorNumgCyTrgajTad/BySKxZh5spGUwwop
        I0KksAchcRM4IHVJgI4WWnJP9Q==
X-Google-Smtp-Source: AGHT+IGuh45u033WSGbdyoxXgEFVHoRQLf8WpOIpwwKNP0a57n7PrCK5IlzOYqyZUn7LNJqiW0FyWQ==
X-Received: by 2002:a05:6e02:ec9:b0:348:7d72:86f3 with SMTP id i9-20020a056e020ec900b003487d7286f3mr15799100ilk.17.1693247867430;
        Mon, 28 Aug 2023 11:37:47 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id z10-20020a92cd0a000000b00345d10ea524sm2643310iln.65.2023.08.28.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:37:46 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:37:46 +0000
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
Message-ID: <20230828183746.GC1621761@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-7-joel@joelfernandes.org>
 <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 10:57:59AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 22, 2023 at 01:54:59AM +0000, Joel Fernandes (Google) wrote:
> > Move a block of memory within a memory range. Any alignment optimization
> > on the source address may cause corruption. Verify using kselftest that
> > it works. I have also verified with tracing that such optimization does
> > not happen due to this check in can_align_down():
> >
> > if (!for_stack && vma->vm_start <= addr_masked)
> > 	return false;
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  tools/testing/selftests/mm/mremap_test.c | 79 +++++++++++++++++++++++-
> >  1 file changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> > index d7366074e2a8..f45d1abedc9c 100644
> > --- a/tools/testing/selftests/mm/mremap_test.c
> > +++ b/tools/testing/selftests/mm/mremap_test.c
> > @@ -23,6 +23,7 @@
> >  #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
> >
> >  #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
> > +#define SIZE_MB(m) ((size_t)m * (1024 * 1024))
> 
> Nit in this instance since you always just use an integer, but generally
> for good practice's sake - shouldn't we place m in parens e.g. (size_t)(m)
> to avoid broken macro expansion?

Sure, I'll do that. Thanks.

> I drew a little diagram for myself and was thereby convinced this was a good test, therefore,
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks a lot!

 - Joel

