Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94D96D083C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjC3O0v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 10:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjC3O0u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 10:26:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5724C7DBA
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 07:26:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so77133950edb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680186407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsGthCQYXjIfvDeabffEM/f5wN+q2oR2FxUqxZJndqk=;
        b=iyOo8bXd0VqmhAwD1Y2Tt4T1CILYurngj/BRCv0x3DA4rtsKkvX4E9Cxen1kc09QXo
         cPVQ7BZptrXsVbQoiOx/F+yvsn2a/42ksKi2dcrGdZDPb5n1VKRPwY1UPB/WoY7CbS1d
         4mu3l0VqjEe+29ETyOzZnRCQqQt4CRpZQ4WrCfnWdmZbq1UxlHQTNVkXTZTQs/5IXWJ3
         VKON+7XXVGQ9OxQqKDKUHU12NENFAMoBNnVeXvDjWdzPqA1RVeRHFUa8wPb5wFcDJULw
         DURUhpXnzSO8DXRgbJt+/IcwrhVWKd1UIg/acHvx6BqJNVGViszbLnFT+foHGrID8BmR
         aKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsGthCQYXjIfvDeabffEM/f5wN+q2oR2FxUqxZJndqk=;
        b=yCVCP0fwpM5ygXPvJlmLxYGiIjBPYdIFP1MBKvNCw1lNzvADF1AA1hriKWGOrC4kmB
         OuqYFevRDcf8scgZFFFHbGlx82Ck0fgwEjlpE11GXk9/jzereK+blK8HZSQWpsHeSPFA
         vQn3BG6OOaI7h3rNbyfwJ5e7T1GlKfJF1Fg7tXltWMCirpHjLKhLk0VJ/p0c9gU8W008
         uOeixRQj5jHUQHM9oU5Hc9hUgrdC/gBY1En1vDjMgDBHekvXv0UUzbQmwBAznjub8lzC
         OP/Kw40FJCNS2LAY3L75LUi8680JXRZ47fdAGi5rCBjpJvLgBTF2D779gqE0Q8SN7zhQ
         Q02Q==
X-Gm-Message-State: AAQBX9elXaPf3MFEAYV4ksFbGarf65crI3RTSsbg13tWavkiDP4dK6CK
        IEhcbOILA3Ii88tbrTAeTGJQ8KmLJX+tZRPvCFAhow==
X-Google-Smtp-Source: AKy350ZM1ex4+4TOh6/zBJT91Cxp19RJGKoOvW9DYZ7UIRVR22IZ6XlXoiGc92rtR1h0709uE2dxJw==
X-Received: by 2002:aa7:c141:0:b0:4fa:ada1:796d with SMTP id r1-20020aa7c141000000b004faada1796dmr22183584edp.10.1680186406820;
        Thu, 30 Mar 2023 07:26:46 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id a13-20020a509e8d000000b00501d73cfc86sm13253433edf.9.2023.03.30.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:26:46 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:26:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Message-ID: <ZCWcJelF5bEdF4N3@cmpxchg.org>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
 <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 30, 2023 at 06:55:31AM +0200, David Hildenbrand wrote:
> On 29.03.23 01:09, Andrew Morton wrote:
> > On Fri, 10 Mar 2023 10:28:48 -0800 Stefan Roesch <shr@devkernel.io> wrote:
> > 
> > > So far KSM can only be enabled by calling madvise for memory regions. To
> > > be able to use KSM for more workloads, KSM needs to have the ability to be
> > > enabled / disabled at the process / cgroup level.
> > 
> > Review on this series has been a bit thin.  Are we OK with moving this
> > into mm-stable for the next merge window?
> 
> I still want to review (traveling this week), but I also don't want to block
> this forever.
> 
> I think I didn't get a reply from Stefan to my question [1] yet (only some
> comments from Johannes). I would still be interested in the variance of
> pages we end up de-duplicating for processes.
> 
> The 20% statement in the cover letter is rather useless and possibly
> misleading if no details about the actual workload are shared.

The workload is instagram. It forks off Django runtimes on-demand
until it saturates whatever hardware it's running on. This benefits
from merging common heap/stack state between instances. Since that
runtime is quite large, the 20% number is not surprising, and matches
our expectations of duplicative memory between instances.

Obviously we could spend months analysing which exact allocations are
identical, and then more months or years reworking the architecture to
deduplicate them by hand and in userspace. But this isn't practical,
and KSM is specifically for cases where this isn't practical.

Based on your request in the previous thread, we investigated whether
the boost was coming from the unintended side effects of KSM splitting
THPs. This wasn't the case.

If you have other theories on how the results could be bogus, we'd be
happy to investigate those as well. But you have to let us know what
you're looking for.

Beyond that, I don't think we need to prove from scratch that KSM can
be a worthwhile optimization. It's been established that it can
be. This series is about enabling it in scenarios where madvise()
isn't practical, that's it, and it's yielding the expected results.
