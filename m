Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF83A78B74E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjH1ShP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjH1Sgo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 14:36:44 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C70BF
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:36:41 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34ca1bcb48fso12846805ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693247801; x=1693852601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9Wrti7ruRDIQ0mrefulR5Bcs52gq1wDF9eL/uOAQEA=;
        b=tl50VSvvgUvsBEbTZibn5u/+m7f6Tpq+NuNMY++rln1mIQXSnHT3Bbh/8YNDZ7adhR
         tr1D9FfOhLMF3vAXyxYbYfZL04iva7oDpJxa3KH/O5iWC14avrrYL2jyerbWKuV+40GX
         WwTM2Y0HNMZLjkC4YB1XnbvP/AHVr6nspTcRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247801; x=1693852601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9Wrti7ruRDIQ0mrefulR5Bcs52gq1wDF9eL/uOAQEA=;
        b=fQ6jHN5gtG8VktYwIOBZzHBQip3Zup+MmAQq4PR5fxL/ey/PurY2IreagSGoKV/MAs
         U7yZm2GyLUP0AFN+I7YCoY7uj6rxqaWUKUIJ4Wd3X1DeVY2i2s1+35iZhGMKmU+0UKE5
         BG5TrsuLhLwitr7XtLxvvm+62G4k9qzFW0vBfGivWS/ZfQJaQCvxwhJeQDQYJbRdvhzI
         06uJPFpUE113tnhpvjIIAWTpKdsvmnCqd2VR9U/UGrTGgziYkNQjIgf7VbsL0HIGnmfV
         a6a0GaWhiFBVgyEgN0250wdZRX1TeJ1MHogVUDVuAnCn4RwjgbakALgoRqbFSgy7GB3m
         J8Bg==
X-Gm-Message-State: AOJu0YyHClpOSRKM/PXB096U7n1HpZfa2ILwq4yFhpPZZtqvvY2EbM56
        Qbhd5/T6kTxF9uYkt8PkQjWGCQ==
X-Google-Smtp-Source: AGHT+IGOyfeSMdefU0zTM7+SmFnidblDIgXQ53RaTHOyBx8hogxbNx7EUOVZ+UUxiq/GAW3pMs0AQw==
X-Received: by 2002:a05:6e02:1646:b0:349:9745:89f with SMTP id v6-20020a056e02164600b003499745089fmr23108019ilu.17.1693247800771;
        Mon, 28 Aug 2023 11:36:40 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id o15-20020a056e02068f00b0034bae80711dsm2587715ils.82.2023.08.28.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:36:40 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:36:39 +0000
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
Subject: Re: [PATCH v5 5/7] selftests: mm: Add a test for remapping to area
 immediately after existing mapping
Message-ID: <20230828183639.GB1621761@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-6-joel@joelfernandes.org>
 <d31eb7c5-6509-47b0-a451-fba88cfa4d58@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31eb7c5-6509-47b0-a451-fba88cfa4d58@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 10:42:44AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 22, 2023 at 01:54:58AM +0000, Joel Fernandes (Google) wrote:
> > This patch adds support for verifying that we correctly handle the
> > situation where something is already mapped before the destination of the remap.
> >
> > Any realignment of destination address and PMD-copy will destroy that
> > existing mapping. In such cases, we need to avoid doing the optimization.
> >
> > To test this, we map an area called the preamble before the remap
> > region. Then we verify after the mremap operation that this region did not get
> > corrupted.
> >
> > Putting some prints in the kernel, I verified that we optimize
> > correctly in different situations:
> >
> > Optimize when there is alignment and no previous mapping (this is tested
> > by previous patch).
> > <prints>
> > can_align_down(old_vma->vm_start=2900000, old_addr=2900000, mask=-2097152): 0
> > can_align_down(new_vma->vm_start=2f00000, new_addr=2f00000, mask=-2097152): 0
> > === Starting move_page_tables ===
> > Doing PUD move for 2800000 -> 2e00000 of extent=200000 <-- Optimization
> > Doing PUD move for 2a00000 -> 3000000 of extent=200000
> > Doing PUD move for 2c00000 -> 3200000 of extent=200000
> > </prints>
> >
> > Don't optimize when there is alignment but there is previous mapping
> > (this is tested by this patch).
> > Notice that can_align_down() returns 1 for the destination mapping
> > as we detected there is something there.
> > <prints>
> > can_align_down(old_vma->vm_start=2900000, old_addr=2900000, mask=-2097152): 0
> > can_align_down(new_vma->vm_start=5700000, new_addr=5700000, mask=-2097152): 1
> > === Starting move_page_tables ===
> > Doing move_ptes for 2900000 -> 5700000 of extent=100000 <-- Unoptimized
> > Doing PUD move for 2a00000 -> 5800000 of extent=200000
> > Doing PUD move for 2c00000 -> 5a00000 of extent=200000
> > </prints>
> >
> 
> Have you additionally tested this by changing the code to be intentionally
> broken then running the test and observing it fail?

Yes I did! Because while developing the patch, it was broken many times and
the test failed during those times. ;-)

> Looks good to me,
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks!

 - Joel

