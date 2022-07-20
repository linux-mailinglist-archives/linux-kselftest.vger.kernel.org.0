Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFE57AE05
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiGTCcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 22:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiGTCcr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 22:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2C0655AB
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658284365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uZbjgFMHeKFjmyd0QEm1xCO2NChsIABolYNiKdJ7Gg=;
        b=DKCKUgSgJw73xOthLFeDfsF0+Ctqv/ztwjqKW/ysHKmV/vs5FnCfrY47ufiZ7Ye2VfYawc
        g5z8N2hRt1h+5Bb3Vt24XS1H8ayuZgMpCQ47tUMHX7boH5NSctYFwruZBd40qbawdf1dX4
        OjZN3WxI8Sd8RZkeuoVUL3VbKGfgJt8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-T2BNtLgfP3CjjMJXA9cqlA-1; Tue, 19 Jul 2022 22:32:35 -0400
X-MC-Unique: T2BNtLgfP3CjjMJXA9cqlA-1
Received: by mail-qk1-f197.google.com with SMTP id f20-20020a05620a409400b006b5fc740485so3254746qko.12
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 19:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3uZbjgFMHeKFjmyd0QEm1xCO2NChsIABolYNiKdJ7Gg=;
        b=at2ac6jPffvB4LQGMMuUJ7RYkI/jt8S8ZFs08ZnSRNBirseQaIrWFDJ8gEodeh5LE6
         KCfdEmkfAJB6HZeohx/KGzy79l+9hYB8lJ0F+aDO8ssXCV5nPuSBEn8vkgBPK2aTvEb3
         ATzMbhJiG+RcNrR86mgS7euXg4xkliwr9O0N7Gd+PWX6baXgWt9QpKx/6F94ljHx+aWW
         zQ6stO4NHtwM8mpBf9y8YM1H5GcBaOJ/iwnOCKDvJwuPZZPDk9aHHAavgyNfs7KYAYqS
         17tfZzEGzBuRP1qohK9RLfsKskF2tfWiP5WgxG1kZhVE3Ig2XdAJVFURK+KqqwTg20lR
         5tpg==
X-Gm-Message-State: AJIora9Cwz3zPLVzib+yZQGMf+NMnEghfNlFtzTNIsJL4N0RGBIWAMzv
        FZLvviyFqWP++ZyFy9zvaIksZehdyoEP3CTHwiEhGdC6Uomz2LyxrXCRtvbRNzOMFVVu+SXta5U
        /iqFaBeJdfv1qpRvS8KBq7LoFPyE4
X-Received: by 2002:a05:6214:e41:b0:473:915c:3efe with SMTP id o1-20020a0562140e4100b00473915c3efemr27335399qvc.10.1658284355253;
        Tue, 19 Jul 2022 19:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqsBhXFhvJemKV/jwgAt84OQwS2X59Z2eXZUwYSIfKumUaM4t252ZCPnvZ1VuTZhBaV0SNdQ==
X-Received: by 2002:a05:6214:e41:b0:473:915c:3efe with SMTP id o1-20020a0562140e4100b00473915c3efemr27335384qvc.10.1658284354992;
        Tue, 19 Jul 2022 19:32:34 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006b5c5987ff2sm14701779qki.96.2022.07.19.19.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 19:32:34 -0700 (PDT)
Date:   Tue, 19 Jul 2022 22:32:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <YtdpQBrAGJwMnssj@xz-m1.local>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
 <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
 <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
 <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 11:55:21PM +0000, Nadav Amit wrote:
> Anyhow, I do want to clarify a bit about the “cross-process support”
> userfaultfd situation. Basically, you can already get cross-process support
> today, by using calling userfaultfd() on the controlled process and calling
> pidfd_open() from another process. It does work and I do not remember any
> issues that it introduced (in contrast, for instance, to io-uring, that
> would break if you use userfaultfd+iouring+fork today).

Do you mean to base it on pidof_getfd()?

Just want to mention that this will still need collaboration of the target
process as userfaultfd needs to be created explicitly there.  From that POV
it's still more similar to general SCM_RIGHTS trick to pass over the fd but
just to pass it in a different way.

IMHO the core change about having /proc/pid/userfaultfd is skipping that
only last step to create the handle.

-- 
Peter Xu

