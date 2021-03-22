Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6834514E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhCVVBc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 17:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhCVVAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 17:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616446837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6WtZIP3Pv8Sts2xBUJYEw6AY7dI8VFWAi8J8oYd58g=;
        b=cnNa14zJM7Iw0L9MacPUVRv78ekcTuGDFhh+VEJC4mgLPYkvReI6FEZiaGfWdGVhruXwFy
        rNU/mh4v3lBgJiaGsvYCl7PmLEqHHWmp5GK0pWdEzr0XzpnU0q+b7B9rZWrE68VH+IaOq7
        GFlL5duQCfAUm4jof0bRNuyEGrmACzw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-fSL959CeMN2NapDtAC5Kxw-1; Mon, 22 Mar 2021 17:00:35 -0400
X-MC-Unique: fSL959CeMN2NapDtAC5Kxw-1
Received: by mail-qk1-f197.google.com with SMTP id y22so408034qkb.23
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 14:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6WtZIP3Pv8Sts2xBUJYEw6AY7dI8VFWAi8J8oYd58g=;
        b=rwiss8gksnDgiaQPI530uCk9mpUsEnviVIQeq46+r6FO0E28HG3WKXmGAIDbdVhCNX
         /oyhmWI1JQQbGz7q6e+xXlpWXB6chpnW3xRBNje0WY/0H0m/GV49BO/0mn/SK/uuhgOk
         nYjg4OUYyDYOMEsdm7wGMjCcmgUksqZuyEL+jyyu1xSB3mxtnhKORsAA1LlCfl18QcJV
         aEHTHy98EFVEndYCCzl7YLp6Epsq3uxSLCUX4adMLhmNMxpHVxi8voS2l6U5hCZTrswD
         CJ96zzgRR6mFkJsOk8UJI9riMSZUv1x7biBoS40qBx3j6om6ZsrpmYMxGcwvdWIB+uJv
         ZAHA==
X-Gm-Message-State: AOAM533CHzswvtYtp3WrFarJVzSVvAVWgAfUhqkHodfLxO100dnMzQpn
        jWbDlGiRXkxs+vTSVt47n+4KPU7i0J2mtNNndiLhSxzYM+Xgg4S88ga8QZ1ODcQBTy+Mh+V1GWA
        0p70aP1/DlJMZbHlzG4aRnBWUBWFc
X-Received: by 2002:a37:b07:: with SMTP id 7mr1967520qkl.437.1616446834811;
        Mon, 22 Mar 2021 14:00:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQd0PhyYegD6z3hStlomrWz7fldh8CLfj/9QsIxn62XAVmyQ2p22XQ5XNwdBsS8CuH5dU6Lg==
X-Received: by 2002:a37:b07:: with SMTP id 7mr1967476qkl.437.1616446834557;
        Mon, 22 Mar 2021 14:00:34 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id b17sm9688484qtp.73.2021.03.22.14.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:00:34 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:00:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix minor fault page leak
Message-ID: <20210322210031.GH16645@xz-x1>
References: <20210322204836.1650221-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322204836.1650221-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 22, 2021 at 01:48:35PM -0700, Axel Rasmussen wrote:
> This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
> put_page() after getting the page out of the page cache, we leak the
> reference.
> 
> The fix can be verified by checking /proc/meminfo and running the
> userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
> MemAvailable steadily decreasing with each run of the test. With the
> fix, memory is correctly freed after the test program exits.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

