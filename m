Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A647A35D436
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 01:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbhDLX6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 19:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238344AbhDLX6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 19:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618271877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk8f62xjqnl3mv3ljyxxc5ev3FlVYq11HMKlMY+I2mI=;
        b=bKMDXmtQUNLwEAPA+/Iw8zheAt0uvZRDnTX/sIbCVDPuh8U4KUWlL/VcaHpxW+UBw8wpIm
        IrEmpiat3SlzrUj8KxljfurZbZetD/jDX5p4D0xhaW4d6uCeFB9Io/WAlYwbh6wzCjDh+l
        DNYbIKDH4AAnJgxZVJIBvZYQ2eWtpYg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-rKexBiU5MR2X775YuY4xuw-1; Mon, 12 Apr 2021 19:57:55 -0400
X-MC-Unique: rKexBiU5MR2X775YuY4xuw-1
Received: by mail-qv1-f70.google.com with SMTP id a7so9018207qvx.10
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 16:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fk8f62xjqnl3mv3ljyxxc5ev3FlVYq11HMKlMY+I2mI=;
        b=IS5dZHbqQ1ZuZ0Bi98BFDD8vKt8HnUpwZ5+EYMM1Xii26qb7glfuf1oyIkY06uXQbd
         Mg6oRP8VsNFKVSHQSIGdukTDujd3HYRmtgmnvErOMYapMC6esdo59moQ4kz3i8iRPA7E
         YvewXHXh+/JD3FEu/qxz73Le+bHsWAjQiGMkaYumACM8Ezfhd5Ta5KBcXYXpVsPcD//e
         GCDoTC/6jyFq/ZJQxWo8aOqipuxFMvW3Dq3MTiz8kvxHe+i/aQ9NixYqoGXxVE6CMoCx
         vRYXWXsC4AEA0O+3k1GS8YKe65tXlSufPNts6aWdeFl8Cjn+O6Kj1fdE2YJYTRgK/qzG
         g3jQ==
X-Gm-Message-State: AOAM533psO9xLEZUzQUw8dchdIxRSlWksgKPhwNEaCeOdaAyCUpjzOfD
        RsY/Ek8zDXvZRrDY1qFpi6bHlHxgGmU/hadGyWVN9jA+siMSQf0IC50sQlcPoApF9Qgb4VBcKSa
        hTXcyKwbTeRR6rVnPldSiIOuFEcuQ
X-Received: by 2002:ac8:5bd0:: with SMTP id b16mr27256751qtb.265.1618271875256;
        Mon, 12 Apr 2021 16:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyINLu5vRRG0SiDZ5ReSE5VIP4sHwe9BnqH3/WUUNCWDJZ4MX4YNqZ5FmXfacMqWYulpB87ZQ==
X-Received: by 2002:ac8:5bd0:: with SMTP id b16mr27256724qtb.265.1618271875002;
        Mon, 12 Apr 2021 16:57:55 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id n6sm8421251qtx.22.2021.04.12.16.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:57:54 -0700 (PDT)
Date:   Mon, 12 Apr 2021 19:57:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 2/9] userfaultfd/shmem: combine
 shmem_{mcopy_atomic,mfill_zeropage}_pte
Message-ID: <20210412235752.GC1002612@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408234327.624367-3-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 08, 2021 at 04:43:20PM -0700, Axel Rasmussen wrote:
> Previously, we did a dance where we had one calling path in
> userfaultfd.c (mfill_atomic_pte), but then we split it into two in
> shmem_fs.h (shmem_{mcopy_atomic,mfill_zeropage}_pte), and then rejoined
> into a single shared function in shmem.c (shmem_mfill_atomic_pte).
> 
> This is all a bit overly complex. Just call the single combined shmem
> function directly, allowing us to clean up various branches,
> boilerplate, etc.
> 
> While we're touching this function, two other small cleanup changes:
> - offset is equivalent to pgoff, so we can get rid of offset entirely.
> - Split two VM_BUG_ON cases into two statements. This means the line
>   number reported when the BUG is hit specifies exactly which condition
>   was true.

(For my own preference, I'll avoid touching the latter one)

> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/shmem_fs.h | 15 +++++-------
>  mm/shmem.c               | 52 +++++++++++++---------------------------
>  mm/userfaultfd.c         | 10 +++-----
>  3 files changed, 25 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d82b6f396588..919e36671fe6 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -122,21 +122,18 @@ static inline bool shmem_file(struct file *file)
>  extern bool shmem_charge(struct inode *inode, long pages);
>  extern void shmem_uncharge(struct inode *inode, long pages);
>  
> +#ifdef CONFIG_USERFAULTFD
>  #ifdef CONFIG_SHMEM
>  extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  				  struct vm_area_struct *dst_vma,
>  				  unsigned long dst_addr,
>  				  unsigned long src_addr,

Not a problem of your patch, but it's just that we passed in odd src_addr
values into mfill_atomic_pte() for zeropage case because we loop on src_addr in
__mcopy_atomic()...  Then it'll further passed into shmem_mcopy_atomic_pte()
now after this patch (as shmem_mfill_zeropage_pte() probably only did one thing
good which is to clear src_addr).  Not a big deal, though.

All the rest looks sane to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

I'll wait to look at the selftests since in all cases they should be prone to
rebase (either based on the v2 cleanup I posted, or you'd need to post without
err() - then I can rebase again), so I figured maybe I just read the new
version.

Thanks,

-- 
Peter Xu

