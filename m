Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BC57A8D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiGSVSm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiGSVSl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56FBC5F13D
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658265519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQ4UdihwA3u3irfHx6eGnZO09RoO1lQsj+Krqj+1YXg=;
        b=B/JdtpHQWtKdfD+LvEB+aT/uqawBNZCOUx0Edeto+TFfdEW2Jr4SoyfjiPvbSpSJBS0CFV
        ydKfnm356G+0QfFDLbQUODC3H7Cbx+ye2qe+RSOyxUaTEGDeTPv7kDXD1CKwASVEfElpU7
        nkOrYqjuBsslp+s5Ga5JZWFPX1MTQDs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-koxVXbbxOdCvWCh8L0v9HA-1; Tue, 19 Jul 2022 17:18:38 -0400
X-MC-Unique: koxVXbbxOdCvWCh8L0v9HA-1
Received: by mail-qt1-f198.google.com with SMTP id u12-20020a05622a010c00b0031ef5b46dc0so3584540qtw.16
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 14:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQ4UdihwA3u3irfHx6eGnZO09RoO1lQsj+Krqj+1YXg=;
        b=UTaDX/6at2pBFMWJ3i//ddA9GZ/nOpZIqdDtBpGQ4iNjEka1ukbtEpC5fCZmEXAc82
         7KxXf4scE7B/iw5jpPOONBbV1CXKSy0eZfIpMyPDuBweVjAmjxQqMvFOfRhC0VCVA5MI
         O/ZlWR+olpdZQ0MD1ZZiPDhWBR2mbRdjBIjaGKHTfWnUHrA72LG/clCX6YttShz6w1W5
         y3KJ3ypWiE7S3/adz0K3iEvXv13INc0HBAHOQ3TFGxDSm7ymR24xLoUZzbiSZffm0DZ0
         UrC+PIP0u4bEyIbs57P2hLyVlsJR1t6Cy+pZFpXBPSsIJrOOXEVvIQHVb4J5zwp6jX+d
         dbZg==
X-Gm-Message-State: AJIora9GuGk/MzV7Fkla5tYXdWLe04vDsyrN8s07pfl1bCkQgBh3zGQ+
        WX8ga8HGb4uS44g14nd4eBabIVqLnqo13jvdtHg6lQnhzNH1uJeY3Ek+1R3qRqlOFTToAdo4aJ1
        CBenP52/lWt/se/k3kJTi6Sqkcnxl
X-Received: by 2002:a05:620a:469f:b0:6b6:74c:6b10 with SMTP id bq31-20020a05620a469f00b006b6074c6b10mr2002410qkb.80.1658265517809;
        Tue, 19 Jul 2022 14:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1solk9LbHq5kw8KaBY3e4msSDmv+aW7vjooY/eq2+EXMQV5yRa7rp8kr6cJ8pNcJb3bUwoNpA==
X-Received: by 2002:a05:620a:469f:b0:6b6:74c:6b10 with SMTP id bq31-20020a05620a469f00b006b6074c6b10mr2002393qkb.80.1658265517591;
        Tue, 19 Jul 2022 14:18:37 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s10-20020ac85eca000000b0031ede43512bsm8530570qtx.44.2022.07.19.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:18:37 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:18:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <YtcfqpmpkVXz/Frl@xz-m1.local>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719195628.3415852-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 12:56:25PM -0700, Axel Rasmussen wrote:
> Historically, it has been shown that intercepting kernel faults with
> userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
> of time) can be exploited, or at least can make some kinds of exploits
> easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
> changed things so, in order for kernel faults to be handled by
> userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
> must be configured so that any unprivileged user can do it.
> 
> In a typical implementation of a hypervisor with live migration (take
> QEMU/KVM as one such example), we do indeed need to be able to handle
> kernel faults. But, both options above are less than ideal:
> 
> - Toggling the sysctl increases attack surface by allowing any
>   unprivileged user to do it.
> 
> - Granting the live migration process CAP_SYS_PTRACE gives it this
>   ability, but *also* the ability to "observe and control the
>   execution of another process [...], and examine and change [its]
>   memory and registers" (from ptrace(2)). This isn't something we need
>   or want to be able to do, so granting this permission violates the
>   "principle of least privilege".
> 
> This is all a long winded way to say: we want a more fine-grained way to
> grant access to userfaultfd, without granting other additional
> permissions at the same time.
> 
> To achieve this, add a /dev/userfaultfd misc device. This device
> provides an alternative to the userfaultfd(2) syscall for the creation
> of new userfaultfds. The idea is, any userfaultfds created this way will
> be able to handle kernel faults, without the caller having any special
> capabilities. Access to this mechanism is instead restricted using e.g.
> standard filesystem permissions.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks, this looks much better.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

