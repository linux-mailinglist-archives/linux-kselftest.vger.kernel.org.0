Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C23898D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhESVv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhESVvZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 17:51:25 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6CC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:50:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z1so13561075ils.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTt2FiDL6jKQ9igVcItFQGplYD9kRNczxqmA7iZyLec=;
        b=gMYMyF8xXR6YyM1Z1ZZZP1i6QZwNpTkUy9te3CL1Gi5sSyEohhxKoI1G7+Ky8Jo2Rp
         P/hgqo+/iZD1JqtJ6h9pWNvL0OFIIjKGn11knm1c7NVUGiQxFpybt5/SoAzx+5FM0nKe
         XSIwd7YCn7W8psxOVLwPq8nMDjJNDO6tilezs/YGIQI48Lnsjr/xrmfh7x/x2GSQPF7i
         jx5w83ML6Y93JBQ2K+IaOHgFK0is81rYAuFPGE04HtsjdQu1laiqsDCAduSY6DXO+TFs
         6GqBjbJunfoJ3tvy3WSsz0s8WMvIMOUGqMUidv6jkN/nw2RWGU7bWX7ibc+vQ9PjG1oW
         5z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTt2FiDL6jKQ9igVcItFQGplYD9kRNczxqmA7iZyLec=;
        b=mjB6T8iiXYpLenGD9FJQxUvdNH5g0+/D2RGjwALmOCUDu30rG+NEncYB9HWsSJpzrg
         iWxv96H5rf4vhEpobaz0wn2xvGPO73FlS7f9yWoBAm1uZ9ODR6Hwm5VSHP5QWugNXmp5
         +ZzQIYjxsG8ovJbF+UnZ8rfJrC9ZFt6MVfeWv2kTcW6pHmsf3zBhdXH0V3x/7rwBZQyo
         4jjYSwPf807U99jsXWi6FmoQ7t+NgvJbjaXIESgGKgEfkxXbMQjieVnwzS2FZAcpzPod
         3U3dXhpYPWBIDQId6zTjE0IY/N4LkCw+QONwmmE079mkaH7xSRLziuapRN0CC68roffJ
         bLNw==
X-Gm-Message-State: AOAM532D5MgEY2V4vhrLhlzE0M2uCs4oNYZkAIlAf8vEnX8+he0r6FKy
        dyTSSMEbucdtpRSjV3cmZK7+MzhPtriZkQjOTqbEgQ==
X-Google-Smtp-Source: ABdhPJwe90hZ9J1kloXU7jdOjRgtGJojwAt07kMzSrx8/hbwmcpx8Zrj4eB4T4bkQGA0Sm+6lw03cJIxkobG3qqh9kw=
X-Received: by 2002:a05:6e02:13ec:: with SMTP id w12mr1436148ilj.285.1621461004204;
 Wed, 19 May 2021 14:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com> <20210519200339.829146-4-axelrasmussen@google.com>
In-Reply-To: <20210519200339.829146-4-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 14:49:53 -0700
Message-ID: <CANgfPd_WV+8bAHucE=81eFTEEPv5Q-2ZjQ_beKhZyQnt4PX57Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] KVM: selftests: print a message when skipping
 KVM tests
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> Previously, if this check failed, we'd just exit quietly with no output.
> This can be confusing, so print out a short message indicating why the
> test is being skipped.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index f05ca919cccb..0d6ddee429b9 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -53,8 +53,10 @@ int kvm_check_cap(long cap)
>         int kvm_fd;
>
>         kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
> -       if (kvm_fd < 0)
> +       if (kvm_fd < 0) {
> +               print_skip("KVM not available, errno: %d", errno);
>                 exit(KSFT_SKIP);
> +       }

This is a wonderful change. I believe this will only be hit if KVM is
built as a module and that module has not yet been loaded, so this
message could also suggest that the user check if the KVM / KVM
arch/vendor specific module has been loaded.

>
>         ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
>         TEST_ASSERT(ret != -1, "KVM_CHECK_EXTENSION IOCTL failed,\n"
> --
> 2.31.1.751.gd2f1c929bd-goog
>
