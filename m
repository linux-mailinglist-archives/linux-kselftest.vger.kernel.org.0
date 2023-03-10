Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2E6B5107
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 20:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCJThv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 14:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCJTht (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 14:37:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B61386BB;
        Fri, 10 Mar 2023 11:37:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 328A3CE2AC9;
        Fri, 10 Mar 2023 19:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD037C433D2;
        Fri, 10 Mar 2023 19:37:38 +0000 (UTC)
Date:   Fri, 10 Mar 2023 14:37:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230310143736.7d3b8656@gandalf.local.home>
In-Reply-To: <20230310190658.GA3723158@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
        <20230310032921-mutt-send-email-mst@kernel.org>
        <20230310190658.GA3723158@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 Mar 2023 12:06:58 -0700
Ross Zwisler <zwisler@google.com> wrote:

> On Fri, Mar 10, 2023 at 03:29:49AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:  
> > > Changes in v2:
> > >  * Dropped patches which were pulled into maintainer trees.
> > >  * Split BPF patches out into another series targeting bpf-next.
> > >  * trace-agent now falls back to debugfs if tracefs isn't present.
> > >  * Added Acked-by from mst@redhat.com to series.
> > >  * Added a typo fixup for the virtio-trace README.
> > > 
> > > Steven, assuming there are no objections, would you feel comfortable
> > > taking this series through your tree?  
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > if you want the virtio patches through my tree after all, let me know.  
> 
> Yes, please, that would be great.  I'll send out v3 with the few patches that
> haven't gotten a response, but I'll drop the virtio patches assuming you've
> got them.
>

Since the last patch 6/6 is not tracing related, I would prefer it to go
through the virtio tree.

For patches 1-5, please add:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

-- Steve
