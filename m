Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB817B23B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjI1RWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjI1RWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 13:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FAC0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695921678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLCvdP+ifYiv9tKvrBkXqvjWJNrinZhDljbzpgEPPfA=;
        b=jU3VoztufyamJ1hh8b+WGCqXyw88i2dcxCSnm9KfSUHqmbN3Xf8S8ZpuAlj2GxarSfhryf
        1uoYi8w9sFW4UClYyhrShAHm3YmwoWeep+Ia8cCzOEx6S4ZTcOf2uOUgTG1qEvA8CAEOvt
        63fHQq1RVI/njRCeKLBdC4QHRULZjzw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-HiDqDmooNSCJmBkl0cyH3A-1; Thu, 28 Sep 2023 13:21:17 -0400
X-MC-Unique: HiDqDmooNSCJmBkl0cyH3A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-774292de453so293686585a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 10:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921676; x=1696526476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLCvdP+ifYiv9tKvrBkXqvjWJNrinZhDljbzpgEPPfA=;
        b=ThlCUM8pkV3yDxOVdsW12Yc6GZyW+SmKbvTIlr4bSXgBatFqgogMFpxwe3Os6pa9yS
         RZBINvj1TODUmY2fgVe1CHn+VmTFlg2QsvHCmsHPLQpOVulhk1aTX6+1pPAMXjuqwTU/
         z9qxRxDgrGJQOy4sUVO7iroyRaRrcjnN0fqXscgxE0Afhc9evolp+JZ+GUk9zVB7B1vu
         cSKT8faX2AJsW16ZB8DhGSRC4iVV4FzJxX1YJIebYNp+fMzL12JPf5IBELJFHWxomf3u
         NlwBkxT5MH6sx2nfSs5EJdtfFqO4owqBD5OxyKetx54wzt5KerCCflyllDQN0m7jr138
         TyGQ==
X-Gm-Message-State: AOJu0Yz/7fH5fP7qKOSGTphaRnsrxzvz/sLx2JEK4zJj4p/3TJy8t7s6
        OM15rHwn4u0iE1R23SULeLXrkS09pegKVcV1Y3uv8bvZOYyJ32ls65jPtynsNaovVtkHj0jpaoJ
        yyV3J9bOt2COTHAMWpKYMMxSh9qAUbOEKwdrv
X-Received: by 2002:a05:620a:1aa7:b0:76f:2529:c06a with SMTP id bl39-20020a05620a1aa700b0076f2529c06amr1881936qkb.7.1695921676540;
        Thu, 28 Sep 2023 10:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY5MZ38G3zDUdTeFE1z7Vqza7falaPArMtp/kNBRT0uvWjSO0DcZ3GgFuB68ST5Lu5LJFozw==
X-Received: by 2002:a05:620a:1aa7:b0:76f:2529:c06a with SMTP id bl39-20020a05620a1aa700b0076f2529c06amr1881924qkb.7.1695921676307;
        Thu, 28 Sep 2023 10:21:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t12-20020a05620a004c00b00767dcf6f4adsm4198188qkt.51.2023.09.28.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:21:15 -0700 (PDT)
Date:   Thu, 28 Sep 2023 13:21:12 -0400
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
Message-ID: <ZRW2CBUDNks9RGQJ@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 07:05:40PM +0200, David Hildenbrand wrote:
> As described as reply to v1, without fork() and KSM, the PAE bit should
> stick around. If that's not the case, we should investigate why.
> 
> If we ever support the post-fork case (which the comment above remap_pages()
> excludes) we'll need good motivation why we'd want to make this
> overly-complicated feature even more complicated.

The problem is DONTFORK is only a suggestion, but not yet restricted.  If
someone reaches on top of some !PAE page on src it'll never gonna proceed
and keep failing, iiuc.

do_wp_page() doesn't have that issue of accuracy only because one round of
CoW will just allocate a new page with PAE set guaranteed, which is pretty
much self-heal and unnoticed.

So it'll be great if we can have similar self-heal way for PAE.  If not, I
think it's still fine we just always fail on !PAE src pages, but then maybe
we should let the user know what's wrong, e.g., the user can just forgot to
apply DONTFORK then forked.  And then the user hits error and don't know
what happened.  Probably at least we should document it well in man pages.

Another option can be we keep using folio_mapcount() for pte, and another
helper (perhaps: _nr_pages_mapped==COMPOUND_MAPPED && _entire_mapcount==1)
for thp.  But I know that's not ideal either.

-- 
Peter Xu

