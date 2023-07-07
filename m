Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE774B1E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGGNih (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 09:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGGNig (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 09:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2392102
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KhFL+CdFjQoImTlMil1bTnD3T/a7M0oGc4+Qhg9o8tE=;
        b=AygS4/TjjM1UAY2SrXBtIKi+rXqWyMnJnO4QC7dXi4j263G+rNEdE/Ac3V4b/sS91yw+1g
        9NA74dZEE4ebEDKQpW3kUtqqvEAmhR8flhbvz3744ZgWv7r3JJ+UEsKxBwJtduN0w2J8Ye
        Q0wrVw2gVQQIt/SaUYYoqOFFoT4DCrY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-C3g5VJzAPmy93iyQLp1cdg-1; Fri, 07 Jul 2023 09:37:52 -0400
X-MC-Unique: C3g5VJzAPmy93iyQLp1cdg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7672918d8a4so48901185a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 06:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737071; x=1691329071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhFL+CdFjQoImTlMil1bTnD3T/a7M0oGc4+Qhg9o8tE=;
        b=H2/lsWOGOEpUpDZCrUWM8LUdkfkwXEU08BczDIGtH0J7C6sWQ/E+IBmfjhPqg87zAr
         q2jflk3gGk1TmAKNTJsT9gaANdU6eGT6Qsv9KCRKFBU0hSiyl2log1GwBU3pAkyXTTd/
         9Y8FWXS45rKdGLDU51lLdHZOJlTXaQx+ouVv6sJW6/e/jPYIF9kc84jo/F49fNhvvleE
         UqjiTcEh/6yI0reiM4QJf1n8tflH5Js6tOBm878mYr7JvHUKRlE2jMRzFMz56l5adAsk
         70DjBBqF5QNA+SXFp1mWADHSCZ+lh+ShmbxLcIhMGhmcn4xZakZChaivMhE4I+XiTI4h
         oMqA==
X-Gm-Message-State: ABy/qLakklAH+r8Egh3ILLv/925RgtsUK+6F52cuKRt66lQDBGFjUh9C
        KcWy51C/qy8CrjQk3qRMZNX16T3DIKNmaZBgzdEH9HKsh31VXqfz+/Dw1u5Im1fcdPs5jzVg0MB
        seyUHWCJz9+nRo8UJqUYcar2bZlvZ
X-Received: by 2002:a05:6214:2aa3:b0:62d:fdc4:1e8b with SMTP id js3-20020a0562142aa300b0062dfdc41e8bmr5339522qvb.2.1688737071617;
        Fri, 07 Jul 2023 06:37:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFC170q8lMmSxujK34gxQ2iJ+dYHuBZDi6VgSNqYx5ivEJMdyfwY72N3ewBcYtgbwSE4Hi/HQ==
X-Received: by 2002:a05:6214:2aa3:b0:62d:fdc4:1e8b with SMTP id js3-20020a0562142aa300b0062dfdc41e8bmr5339498qvb.2.1688737071306;
        Fri, 07 Jul 2023 06:37:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a15dc00b00767b37256ecsm589724qkm.107.2023.07.07.06.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:37:51 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:37:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/8] mm: userfaultfd: add new UFFDIO_POISON ioctl
Message-ID: <ZKgVISe0vkRKVZuG@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:32PM -0700, Axel Rasmussen wrote:
> The basic idea here is to "simulate" memory poisoning for VMs. A VM
> running on some host might encounter a memory error, after which some
> page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> once poisoned, pages can never become "un-poisoned". So, when we live
> migrate the VM, we need to preserve the poisoned status of these pages.
> 
> When live migrating, we try to get the guest running on its new host as
> quickly as possible. So, we start it running before all memory has been
> copied, and before we're certain which pages should be poisoned or not.
> 
> So the basic way to use this new feature is:
> 
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.
> - If so, we can respond with a UFFDIO_POISON - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.
> 
> UFFDIO_POISON does not handle unmapping previously-present PTEs. This
> isn't needed, because during live migration we want to intercept
> all accesses with userfaultfd (not just writes, so WP mode isn't useful
> for this). So whether minor or missing mode is being used (or both), the
> PTE won't be present in any case, so handling that case isn't needed.
> 
> Similarly, UFFDIO_POISON won't replace existing PTE markers. This might
> be okay to do, but it seems to be safer to just refuse to overwrite any
> existing entry (like a UFFD_WP PTE marker).
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

I agree the current behavior is not as clear, especially after hwpoison
introduced.

uffdio-copy is special right now that it can overwrite a marker, so a buggy
userapp can also overwrite a poisoned entry, but it also means the userapp
is broken already, so may not really matter much.

While zeropage wasn't doing that. I think that was just overlooked - i
assume it has the same reasoning as uffdio-copy otherwise.. and no one just
used zeropage over a wp marker yet, or just got it work-arounded by
unprotect+zeropage.

Not yet sure whether it'll make sense to unify this a bit, but making the
new poison api to be strict look fine.  If you have any thoughts after
reading feel free to keep the discussion going, I can ack this one I think
(besides my rename request in 1st patch):

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

