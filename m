Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE66768F9C2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBHVcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 16:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjBHVcL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 16:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB81C335
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675891888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIAor+VDsPlrB9lj+l3LEuEZ+2Aj/cQ4916Fau1bI0Q=;
        b=i0cuJ2Jpe8hbwK8DOSMOXS4S73rmdVB6vb2zc9Z+hhYuuWTrVRCIqE+apmi8q+G4Zyddph
        dsmcFz0cLiQ6Oxo5/IjFCQwuMdD8k3RsWNCGwYbEo2Tem/8Tk2u/1iWISnHxINIYu5gVE3
        WXxdj77n45E1oDgZxTpxIjo/E1l72S8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-xV6vWMgHOhm3KX6G37yiZg-1; Wed, 08 Feb 2023 16:31:27 -0500
X-MC-Unique: xV6vWMgHOhm3KX6G37yiZg-1
Received: by mail-qt1-f199.google.com with SMTP id v8-20020a05622a144800b003ba0dc5d798so9436742qtx.22
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Feb 2023 13:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIAor+VDsPlrB9lj+l3LEuEZ+2Aj/cQ4916Fau1bI0Q=;
        b=PYogDx+pXiKpkbHOsWHBlMRqvIAu/PQf5MUwtOMDcY1/e5xRGhlAPPFIv4wFWgvhjH
         V20sRCPCkaCgU6ihTaWHar3cUXqRrzcTQ2HuXCk/9k3x1GQr6c1M6AXNIwcGoN+wajJr
         kwNWBAg0s2P4IB6dgKRz5CAW0Jnm6sZh6GzdXwniYTNiJhak6bOaebSZlheRsMFuLgS8
         R/nLAUN1Bn+9r3R9VzJlCGcgwf/px3OYBldi9PTrUCVZUsMPiiNRE7cQhKtXBZ5IkKfZ
         P2c5y94OucN3xxSPsOmPM4fiRnIQy7PagP/GmEgdyaKO4eHbFXbqjbz7EkzowI9ibrEI
         j/uQ==
X-Gm-Message-State: AO0yUKVJj0kyHMG68qLJ7xEJZ/TNxF/LFvnqbm0dYewF6jr7LsTurjjm
        bCMn5vxnz7jlBtrTm7KvzI6ix5Lk/4gaziWydcgwdB6oTiOFoyMTz/8HgAmni9EUe+BlcjrlxSq
        sbyo6DIz3OGQ72lLs3vD9PjKj0gxd
X-Received: by 2002:a05:622a:4b:b0:3b8:6d44:ca7e with SMTP id y11-20020a05622a004b00b003b86d44ca7emr17516014qtw.4.1675891886296;
        Wed, 08 Feb 2023 13:31:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8MO3G4fUAKevd35vZj2kMQxmHZodb+yUyDlQNuQyvW5/EA2P822ioKc+/00V2eqHk7x67X+w==
X-Received: by 2002:a05:622a:4b:b0:3b8:6d44:ca7e with SMTP id y11-20020a05622a004b00b003b86d44ca7emr17515958qtw.4.1675891885909;
        Wed, 08 Feb 2023 13:31:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f4-20020a05622a1a0400b003b9b48cdbe8sm12419115qtb.58.2023.02.08.13.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:31:24 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:31:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 2/6] userfaultfd: update documentation to describe
 UFFD_FEATURE_WP_ASYNC
Message-ID: <Y+QUqrBCwQntpxFx@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202112915.867409-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 02, 2023 at 04:29:11PM +0500, Muhammad Usama Anjum wrote:
> Explain the difference created by UFFD_FEATURE_WP_ASYNC to the write
> protection (UFFDIO_WRITEPROTECT_MODE_WP) mode.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 83f31919ebb3..4747e7bd5b26 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -221,6 +221,13 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
>  you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
>  used.
>  
> +If ``UFFD_FEATURE_WP_ASYNC`` is set while calling ``UFFDIO_API`` ioctl, the
> +behaviour of ``UFFDIO_WRITEPROTECT_MODE_WP`` changes such that faults for

UFFDIO_WRITEPROTECT_MODE_WP is only a flag in UFFDIO_WRITEPROTECT, while
it's forbidden only when not specified.

> +anon and shmem are resolved automatically by the kernel instead of sending
> +the message to the userfaultfd. The hugetlb isn't supported. The ``pagemap``
> +file can be read to find which pages have ``PM_UFFD_WP`` flag set which
> +means they are write-protected.

Here's my version. Please feel free to do modifications on top.

  If the userfaultfd context (that has ``UFFDIO_REGISTER_MODE_WP``
  registered against) has ``UFFD_FEATURE_WP_ASYNC`` feature enabled, it
  will work in async write protection mode.  It can be seen as a more
  accurate version of soft-dirty tracking, meanwhile the results will not
  be easily affected by other operations like vma merging.

  Comparing to the generic mode, the async mode will not generate any
  userfaultfd message when the protected memory range is written.  Instead,
  the kernel will automatically resolve the page fault immediately by
  dropping the uffd-wp bit in the pgtables.  The user app can collect the
  "written/dirty" status by looking up the uffd-wp bit for the pages being
  interested in /proc/pagemap.

  The page will be under track of uffd-wp async mode until the page is
  explicitly write-protected by ``UFFDIO_WRITEPROTECT`` ioctl with the mode
  flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
  that was tracked by async mode userfaultfd-wp is invalid.

  Currently ``UFFD_FEATURE_WP_ASYNC`` only support anonymous and shmem.
  Hugetlb is not yet supported.

-- 
Peter Xu

