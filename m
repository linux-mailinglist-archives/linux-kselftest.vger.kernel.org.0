Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F57B2559
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjI1SfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjI1SfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 14:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673651AB
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695926065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHgQXBAFMtt2xjDagTnzi+QIWg4ufIaPSkBrUwwCR20=;
        b=c+frV9aYUCZxINBBhgkusJi0oYAOXq/QDlqCjplcMjAbZarMLm6rahrVWGqcXqo5sdNLyU
        UUtzw+NIkzajm2kpG1Jue4m8f1uk+zCO6mZLTpPuY/wbE67Z0DJdMTOCeQnmRjUJ1/g1mn
        lmzTQ5xSBMn/el+6a6K4epwJR8kMp0U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-nbQnDwgvOiqyu7yknItemA-1; Thu, 28 Sep 2023 14:34:24 -0400
X-MC-Unique: nbQnDwgvOiqyu7yknItemA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-774292de453so295269585a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 11:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926063; x=1696530863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHgQXBAFMtt2xjDagTnzi+QIWg4ufIaPSkBrUwwCR20=;
        b=dUMNcFLc+xRlxkGOMjlG1plienihn1l7V+N3IMpePxdeuYm+kzITiY3Rcjx7vHHJTW
         V9SH63fnu9C5WEFlRJX73JfGP7sNugH489eBCl386y3gisM+UDw7i+UqFjhph5P7iY9b
         buPR9JPjLUAtgr3xkoxcLVyG3nx4BJGvNxAZ2BszCKMoX3AYz1lyewJ6LCB0AXM/Oh/f
         Q85oDxgmjq6Hg72qWUZKHhbVKOs5mcBZqWZXYVRX1oEQv0Cc0GV+mfeHPUdaSgs8IPf3
         wu7ztmFzMQHHltRDXlgCZPKcS6u5M88ibw5vubjzrYTuLmI2jS7XQiq0waQApAlJG3WC
         pBug==
X-Gm-Message-State: AOJu0YyYXdRuwUzcwlcToEsPYCkCyJ3ZEE/XXPMZTru+6kfcKT+iIMZm
        QlreLkWpM1b2GjmoKTaWUUHIHCYeDtrZ0Ol/mELhaU8BuBi2o5QbEjpBjaj9qP2dYeJcdtmADcK
        8f9Rwlu2FRcpYBH2ZAKoYC8ZwsZ6U
X-Received: by 2002:a05:620a:46a4:b0:773:ad1f:3d5b with SMTP id bq36-20020a05620a46a400b00773ad1f3d5bmr2297128qkb.0.1695926063522;
        Thu, 28 Sep 2023 11:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV57Cs3i99fylAO+fmIhSC7kjkZzQuC8SMTvaoqr4J38m/9B5Rlx8C4OeUA5D72OFiWkiufg==
X-Received: by 2002:a05:620a:46a4:b0:773:ad1f:3d5b with SMTP id bq36-20020a05620a46a400b00773ad1f3d5bmr2297110qkb.0.1695926063230;
        Thu, 28 Sep 2023 11:34:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id e15-20020a05620a12cf00b007756d233fbdsm1857612qkl.37.2023.09.28.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 11:34:22 -0700 (PDT)
Date:   Thu, 28 Sep 2023 14:34:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRXHK3hbdjfQvCCp@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com>
 <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 07:51:18PM +0200, David Hildenbrand wrote:
> On 28.09.23 19:21, Peter Xu wrote:
> > On Thu, Sep 28, 2023 at 07:05:40PM +0200, David Hildenbrand wrote:
> > > As described as reply to v1, without fork() and KSM, the PAE bit should
> > > stick around. If that's not the case, we should investigate why.
> > > 
> > > If we ever support the post-fork case (which the comment above remap_pages()
> > > excludes) we'll need good motivation why we'd want to make this
> > > overly-complicated feature even more complicated.
> > 
> > The problem is DONTFORK is only a suggestion, but not yet restricted.  If
> > someone reaches on top of some !PAE page on src it'll never gonna proceed
> > and keep failing, iiuc.
> 
> Yes. It won't work if you fork() and not use DONTFORK on the src VMA. We
> should document that as a limitation.
> 
> For example, you could return an error to the user that can just call
> UFFDIO_COPY. (or to the UFFDIO_COPY from inside uffd code, but that's
> probably ugly as well).

We could indeed provide some special errno perhaps upon the PAE check, then
document it explicitly in the man page and suggest resolutions (like
DONTFORK) when user hit it.

> 
> > 
> > do_wp_page() doesn't have that issue of accuracy only because one round of
> > CoW will just allocate a new page with PAE set guaranteed, which is pretty
> > much self-heal and unnoticed.
> 
> Yes. But it might have to copy, at which point the whole optimization of
> remap is gone :)

Right, but that's fine IMHO because it should still be very corner case,
definitely not expected to be the majority to start impact the performance
results.

> 
> > 
> > So it'll be great if we can have similar self-heal way for PAE.  If not, I
> > think it's still fine we just always fail on !PAE src pages, but then maybe
> > we should let the user know what's wrong, e.g., the user can just forgot to
> > apply DONTFORK then forked.  And then the user hits error and don't know
> > what happened.  Probably at least we should document it well in man pages.
> > 
> Yes, exactly.
> 
> > Another option can be we keep using folio_mapcount() for pte, and another
> > helper (perhaps: _nr_pages_mapped==COMPOUND_MAPPED && _entire_mapcount==1)
> > for thp.  But I know that's not ideal either.
> 
> As long as we only set the pte writable if PAE is set, we're good from a CVE
> perspective. The other part is just simplicity of avoiding all these
> mapcount+swapcount games where possible.
> 
> (one day folio_mapcount() might be faster -- I'm still working on that patch
> in the bigger picture of handling PTE-mapped THP better)

Sure.

For now as long as we're crystal clear on the possibility of inaccuracy of
PAE, it never hits besides fork() && !DONTFORK, and properly document it,
then sounds good here.

Thanks,

-- 
Peter Xu

