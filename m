Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D36C406A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 03:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCVCdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 22:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjCVCdo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 22:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66724125
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679452374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BzR3eLSpqoTMzxh2NgN0pV0oM+P8NH9sKNgtkW4tjlQ=;
        b=IZi4b9wmRy2VokAZnpLkAKbkn5axwxhLgeVPtxgXzygCWcbs+UFiE1m/7dus1a2yL1JPG9
        R/C4B3Vi0DbeVa9TzpUzMUWudO4sRywTZQ8x63hRwwVRfD7ofV+WLaSLsUa55IE+XHg3rM
        IbyeFgD7Ac5J4+2JMimt7QWbKOKom40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-RmD2P0VDOtOezLiNyYYM7A-1; Tue, 21 Mar 2023 22:32:53 -0400
X-MC-Unique: RmD2P0VDOtOezLiNyYYM7A-1
Received: by mail-wm1-f70.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so7986119wmb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 19:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679452372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzR3eLSpqoTMzxh2NgN0pV0oM+P8NH9sKNgtkW4tjlQ=;
        b=7tsNIqzyuFLSzQ173eUo3eDgHkA1YVy4ek4j0S7ATvqZzqC/plBCUYHrxnKIMTfSYS
         eLs5kY0pECJonXqfHRMFKkou+p1PWxsqAdkOLYo3ftL55XpOZEIT/212PFZ337/AcjdU
         uJtMgk0a7KCTiIgZtsqBVFEMPIcOu5v/3kZ8dfTwB/QpEOuhqRXh00KDGkDGdNUVlpp3
         AERHRBtAUsp9KbE89PHdF50IhPRqEfhSfRaTzgMF5WmN4JKvsdoR3H5/XuWdn18rPGOZ
         ysbddcKX0WMoAUuB19HYHHQScknUH+vEpvhtbr1BRLmdnfB2jwDl3lah/jNjquI9uerz
         bFXQ==
X-Gm-Message-State: AO0yUKVlGzKesw4mgM5Y9JPvu6J1MmHmTQm1+yOwD4br4Ol+7kLQG9ya
        kI3VGju4UNJY2nLTdG1ubZld8eisa3t/DOOmQLwSiMU2KGsIacDY8kFimcp63U+1SKNm69DmL5Y
        Jbfg29chakoGCZIIp74C+nCC1VNmTPPN/AlnM
X-Received: by 2002:a5d:4521:0:b0:2cf:e827:b597 with SMTP id j1-20020a5d4521000000b002cfe827b597mr3982526wra.10.1679452371928;
        Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set+IAoeXaV5Ezy2+ySyjfqstu/owf9Mg6SdCShB52Q1gVgr7GbSGeNN3VY0ntYreU5GIBMrYUQ==
X-Received: by 2002:a5d:4521:0:b0:2cf:e827:b597 with SMTP id j1-20020a5d4521000000b002cfe827b597mr3982509wra.10.1679452371580;
        Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002cfe685bfd6sm12661630wrw.108.2023.03.21.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:32:46 -0400
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
Message-ID: <20230321223139-mutt-send-email-mst@kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

for merging up to patch 5 through another tree:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'll merge patch 6, no problem.


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

