Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847176B38AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 09:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCJIbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 03:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCJIbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 03:31:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2EEE9CD9
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 00:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678436997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VVY8kly3TcDFN9v8u5UAZIFaG8NcKB7KdRar2p0UPo=;
        b=gcwXZKdJjfaYpRzASdQdDUOcZK7GhWSEkLJoKJ5d2i8lsjarxzWzi7oPOEdnLop4WcCkq7
        EkTNWXM+7jbzKgHMAz23Cpw7GmvJ3aJYNmqRstxg0wvFwwzfqxcIjrTnKxoWqXTPrhZUSe
        cuxVpbQ9JeDdsbz7/2o6jPlkoeONqrs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-ySHwhy9TMHOACtMBMiQ4-g-1; Fri, 10 Mar 2023 03:29:56 -0500
X-MC-Unique: ySHwhy9TMHOACtMBMiQ4-g-1
Received: by mail-wm1-f69.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so1519326wms.5
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 00:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VVY8kly3TcDFN9v8u5UAZIFaG8NcKB7KdRar2p0UPo=;
        b=ShkxNLzJRzizIZQTWQf/zYt9cPN4T0S8c0SFawnKS44pHRV4Vjvbpf/aQLiRlVuiHo
         dHqvauQm4TahODG2dEXR7hnLbCYV+HX1p8biWt+lcoiY7yGZlfqcmSgG7JP+lokibj2v
         +xWgAUfzIaKpZAkvuvFuNGJ/5K0169MP4V0FgQBwF/v0WZRtOPmkgpyDV9xoFCzMtmW1
         fKLIQUT7ZtCwqoBop6VBjIo/3mtPJOW3JE5PyMlBeVUpjmimbq/Km19VHpienjeBJ691
         3nF3SOM47zlbAnTvVDwI6AaCiOEZq+qfxyFEJEffwxHnKdqs8z+W9HYoQfJadGx49f0N
         ZXKQ==
X-Gm-Message-State: AO0yUKWeqxTBHpRYlsLzwVw1t6BUVmeaDWqQB6t+K3Y9DDb9Dz7g217T
        aWEeJiSqmkSrV0mZVliz1MFxW1Wwimi3MwKRUxnl0oNkjbewYBZWYUHdrI6YI8/u0+6OpjNS9t4
        dbFYPLPxLffqCndBlwrsUmWJMooT/
X-Received: by 2002:a05:600c:46d1:b0:3eb:29fe:fe19 with SMTP id q17-20020a05600c46d100b003eb29fefe19mr1724978wmo.34.1678436994994;
        Fri, 10 Mar 2023 00:29:54 -0800 (PST)
X-Google-Smtp-Source: AK7set/3NDIB2yQpnAOJ1gLOd87qFJtloJUYcD7foQwbKEjLNGWL6NTidbGAfi/e3Esc+ca2i7/9Kw==
X-Received: by 2002:a05:600c:46d1:b0:3eb:29fe:fe19 with SMTP id q17-20020a05600c46d100b003eb29fefe19mr1724955wmo.34.1678436994706;
        Fri, 10 Mar 2023 00:29:54 -0800 (PST)
Received: from redhat.com ([2.52.9.88])
        by smtp.gmail.com with ESMTPSA id l14-20020a1ced0e000000b003eb20d4d4a8sm1415501wmh.44.2023.03.10.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:29:54 -0800 (PST)
Date:   Fri, 10 Mar 2023 03:29:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230310032921-mutt-send-email-mst@kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:
> Changes in v2:
>  * Dropped patches which were pulled into maintainer trees.
>  * Split BPF patches out into another series targeting bpf-next.
>  * trace-agent now falls back to debugfs if tracefs isn't present.
>  * Added Acked-by from mst@redhat.com to series.
>  * Added a typo fixup for the virtio-trace README.
> 
> Steven, assuming there are no objections, would you feel comfortable
> taking this series through your tree?

Acked-by: Michael S. Tsirkin <mst@redhat.com>

if you want the virtio patches through my tree after all, let me know.

> ---
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> There are many places where this older debugfs path is still used in
> code comments, selftests, examples and tools, so let's update them to
> avoid confusion.
> 
> I've broken up the series as best I could by maintainer or directory,
> and I've only sent people the patches that I think they care about to
> avoid spamming everyone.
> 
> Ross Zwisler (6):
>   tracing: always use canonical ftrace path
>   selftests: use canonical ftrace path
>   leaking_addresses: also skip canonical ftrace path
>   tools/kvm_stat: use canonical ftrace path
>   tools/virtio: use canonical ftrace path
>   tools/virtio: fix typo in README instructions
> 
>  include/linux/kernel.h                        |  2 +-
>  include/linux/tracepoint.h                    |  4 ++--
>  kernel/trace/Kconfig                          | 20 +++++++++----------
>  kernel/trace/kprobe_event_gen_test.c          |  2 +-
>  kernel/trace/ring_buffer.c                    |  2 +-
>  kernel/trace/synth_event_gen_test.c           |  2 +-
>  kernel/trace/trace.c                          |  2 +-
>  samples/user_events/example.c                 |  4 ++--
>  scripts/leaking_addresses.pl                  |  1 +
>  scripts/tracing/draw_functrace.py             |  6 +++---
>  tools/kvm/kvm_stat/kvm_stat                   |  2 +-
>  tools/lib/api/fs/tracing_path.c               |  4 ++--
>  .../testing/selftests/user_events/dyn_test.c  |  2 +-
>  .../selftests/user_events/ftrace_test.c       | 10 +++++-----
>  .../testing/selftests/user_events/perf_test.c |  8 ++++----
>  tools/testing/selftests/vm/protection_keys.c  |  4 ++--
>  tools/tracing/latency/latency-collector.c     |  2 +-
>  tools/virtio/virtio-trace/README              |  4 ++--
>  tools/virtio/virtio-trace/trace-agent.c       | 12 +++++++----
>  19 files changed, 49 insertions(+), 44 deletions(-)
> 
> -- 
> 2.39.1.637.g21b0678d19-goog

