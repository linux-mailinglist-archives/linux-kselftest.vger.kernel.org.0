Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC436BD4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Apr 2021 04:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhD0C2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Apr 2021 22:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhD0C2O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Apr 2021 22:28:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C0C061760
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 19:27:32 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dm16so3487261qvb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dY4l3ZATMLp2JOTXf4rDEqO/ylRoXp/3uMWEUkjvq30=;
        b=dFhbsAEcDdAR1SFON0zv0MPShUqJVIISts91w+JMRJcRl+DZGBxUcKLTsOKBdiR2aW
         fP8VOfNy5LLdVQg8MiH9SBu9vwCW+T0kfGBrZgMIKY+6vwakXclgu+WTdxfUhPgZm1MM
         RaNOG5AhrZj9bjEpvZK9oJt57Jq9wr9wARTHmbz35in3JWiTt1iSnXpG/yRchuvO+dSo
         d71UEAv99CtuSaOHEi0ANqs3LsBIyCFqii7IOrwtFbUJwBCaGVE0NPZV+983PLfrrAT8
         bEHbRD/16P6LHePBbU4iB7b3k+mpaW9TvVsp4k9ddj11QxGHQHQx6bGgOcjez8ovyzlw
         87yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dY4l3ZATMLp2JOTXf4rDEqO/ylRoXp/3uMWEUkjvq30=;
        b=mQiRWi5r0LNWHTLE00/IJ8s8vBnDwMOfhumnjrhc9OCQ+5cCNdjJVCGtL0Guz+Mot4
         Bh6xe8OV1aI0f0aLWphtfdr6zARGXmL4QcLcnl7smyPBp5BJcVa/tFvZn8MYXvXaUc1i
         jDWEgZLpsvHFmPkTj+d3zi1NhKa4KC+/Fx6N/mZPtpFLhTmwGZ0p2vHA/cnwWNB3uLqq
         dbx6REM+lZTZEbDn6sKbapV+mOXrVZ20Zh5pSbv+3PEDDyPUAAMeN+554bUxHQczRlP9
         GbYACb+JmW8w7fy0wCcl+0xhzqi3LltXp5I4rctropANXppbmFjQ32tA2eCbCSpansxv
         MWfQ==
X-Gm-Message-State: AOAM530M66nBnFMZp3VJJtwTOnx6fHZG8Xdo6h1/dkJ3Y8FP5l/fGiXB
        Bmx+vtYVOFBY3dlkjsizl6hwwg==
X-Google-Smtp-Source: ABdhPJy76WZplQrMDwftgO66Rd1PgPy/3pGOEqmlcXsWDiPfySSH5DYvmb2yLcoAF6uW/JgvB5NfkA==
X-Received: by 2002:ad4:4d94:: with SMTP id cv20mr390990qvb.26.1619490451117;
        Mon, 26 Apr 2021 19:27:31 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h62sm1774150qkf.116.2021.04.26.19.27.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:27:30 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:27:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 10/10] userfaultfd: update documentation to mention
 shmem minor faults
In-Reply-To: <20210420220804.486803-11-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104261924270.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-11-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 20 Apr 2021, Axel Rasmussen wrote:

> Generally, the documentation we wrote for hugetlbfs-based minor faults
> still all applies. The only missing piece is to mention the new feature
> flag which indicates that the kernel supports this for shmem as well.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

(but could be folded into the one which defines UFFD_FEATURE_MINOR_SHMEM)

> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
