Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB06110303
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLCQ6s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 11:58:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37222 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLCQ6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 11:58:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so4138345qkc.4
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=awAZi9esbUnXwgXhwi5bh2eBiqCu026SUTMkAv+bcuk=;
        b=L22xBp2gKa6uy6Xb4JW/SOWjMtUgH90CP7cHfER4JiCqbsofhlGIkYBC8S714MZd0t
         JAc4BN2VdOXH1g5oVGh8kWYTew/jD17g0YkmUCJX94s7pIYrgAg3YB0K6+gALQ/CiJJn
         Jy3N4G13IuXQ5AfbjEVSd0l8y0VL9AoMYh7fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awAZi9esbUnXwgXhwi5bh2eBiqCu026SUTMkAv+bcuk=;
        b=pKCu8KiB2gquUX5vtzEY727xmtYUCTmbg3vDeJXd7HWYAViX+hslHyxbleAGyb60tI
         YFvKL+aBZ3sixr6/+BuaTsCSAvwJYLxfpegzSeq67xvbzSWrFyJItPDchdS+vho7/y+H
         bYBYVWAuv+CW4XwkYMqQIIffhE0enD+vDSK2kMQ2kiKyQSP/zXQutP7aMUFSHPRYjmdW
         809DaRgzgrzhaaBQBpbZc7eMDwTqsR/T3fLjB+eqOA/FnlgkqDwrHqeqe6OsU2bzEhu0
         LQDzzRXdSf48WP0cnjm1OAZtXmoqI77AlgMVsqgYhZGGiAOZCMZ+WcCfk+qohuDs6WiV
         NWJQ==
X-Gm-Message-State: APjAAAW9u9jQGn2iRhT6cIFSLnQkPKPiWNOwonWoAQ3KyOWc9X2waZ95
        GluOsMmYzDHKmtG1JfkLwkEtQA==
X-Google-Smtp-Source: APXvYqzPRcP0xDwFOlYh6VQJvJ3upogxLDCfmpeKQJYYXPnQMvIQnXAR62SHl+8BMMa/0Qr4zaQT0Q==
X-Received: by 2002:a37:4782:: with SMTP id u124mr6238808qka.8.1575392327688;
        Tue, 03 Dec 2019 08:58:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:49ea])
        by smtp.gmail.com with ESMTPSA id y10sm1959520qky.6.2019.12.03.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:58:47 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:58:47 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH kselftest-next 2/2] kselftests: memcg: speed up the
 memory.high test
Message-ID: <20191203165847.GB607734@chrisdown.name>
References: <20191202234212.4134802-1-guro@fb.com>
 <20191202234212.4134802-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191202234212.4134802-2-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Roman Gushchin writes:
>After commit 0e4b01df8659 ("mm, memcg: throttle allocators when
>failing reclaim over memory.high") allocating memory over memory.high
>became very time consuming. But it's exactly what the memory.high
>test from cgroup kselftests is doing: it tries to allocate 100M with
>30M memory.high value. It takes forever to complete.
>
>In order to keep it passing (or failing) in a reasonable amount of
>time let's try to allocate only a little over 30M: 31M to be precise.
>
>With this change test_memcontrol finishes in a reasonable amount of
>time:
>  $ time ./test_memcontrol
>  ok 1 test_memcg_subtree_control
>  ok 2 test_memcg_current
>  ok 3 test_memcg_min
>  ok 4 test_memcg_low
>  ok 5 test_memcg_high
>  ok 6 test_memcg_max
>  ok 7 test_memcg_oom_events
>  ok 8 test_memcg_swap_max
>  ok 9 test_memcg_sock
>  ok 10 test_memcg_oom_group_leaf_events
>  ok 11 test_memcg_oom_group_parent_events
>  ok 12 test_memcg_oom_group_score_events
>
>  real	0m2.273s
>  user	0m0.064s
>  sys	0m0.739s
>
>Signed-off-by: Roman Gushchin <guro@fb.com>
>Cc: Chris Down <chris@chrisdown.name>
>Cc: Johannes Weiner <hannes@cmpxchg.org>

Thanks, this makes sense.

Reviewed-by: Chris Down <chris@chrisdown.name>
