Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4A74E2B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGKAm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGKAm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:42:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4F1B0;
        Mon, 10 Jul 2023 17:42:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3765647a12.1;
        Mon, 10 Jul 2023 17:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689036177; x=1691628177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqRUB5GOcQ1b+cRv1jVfh7t7hV1+cLaTJfgnZElCik8=;
        b=fStzMHOmVVj1XFBo8m8JIqOV4qRKdD6NBhDqvoD1ujGZh2PM6dkZ8MIBJ+nWzmHb4s
         UqTFODF5I1PwXsOX3QeWHl+IGXLA/luXJ/HBORQffFBKWEF8mYCkoUGBNi9JXkSLmF/C
         9mtLTd4VeoDQjwmzw2bjAPrjcJucK+SOmg2+XmTvGLYk6RyrraW+FuUg/KorzOo5C/gj
         fP7cTvV3NeWUFAXE1s0ueIlyV6YMAAuDjNiCTv45hXoCDcWSJwc7E56efvP4eH6FwNHg
         7GRnvAHRgCQ2K3DHxEnmoCDmBpyQ5Ao0kYyaUd66yabQyM1PyQhcz4h0ZAXL62K0rdlF
         Yztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036177; x=1691628177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqRUB5GOcQ1b+cRv1jVfh7t7hV1+cLaTJfgnZElCik8=;
        b=YWNGTKHLLSu1gVLQma2aQL1+0G7BdpSZxlM7iXO0b1i00xkjBuQryvN55tUS8xdvQT
         EwH1Pp8IAAbnQmUNgadqYZOw1Z8ZSYOjeGwjBjpk6rHOcZrdoJVN+63bBKiq4eFG5OAG
         Z/f8dPmprw+ARlfBy9aTpsR+INUOpcpqrPvSgQB9Gz0MPTXimniZyD6KjuyxcZ+NwLPv
         2yua4JmEioMTBBoWT6PQ0nBYQ7aE2zVxuHb1EQ+vgL3jjbZKOGks9QkvxvvqhvRAUAPd
         Uj/vtcvyOyaFGlkOcW0jYidIzNZHIZb26kElMIsrwUnbm1hJMhKmNY1yj+V5Fhu7ISyg
         i7kQ==
X-Gm-Message-State: ABy/qLZZaDBbsz1FLgf5sDPXyWg87y/MrcJI27QWh+DbG1t5n2RJoNdY
        9IfbRWuhEq4l0/iL2m7tkQM=
X-Google-Smtp-Source: APBJJlFW3dAXvvoia1OaNIJhpVDBxDZXQiA4agQuGbAvqgt4XW2Yse6iZra3wEctumB9ahPen88cqA==
X-Received: by 2002:a17:90b:4b8c:b0:263:730b:f562 with SMTP id lr12-20020a17090b4b8c00b00263730bf562mr14468738pjb.11.1689036176544;
        Mon, 10 Jul 2023 17:42:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id ep11-20020a17090ae64b00b0025bbe90d3cbsm484470pjb.44.2023.07.10.17.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:42:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 14:42:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 8/9] cgroup/cpuset: Documentation update for partition
Message-ID: <ZKyljsbJgLNpsBLI@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
 <20230627143508.1576882-9-longman@redhat.com>
 <ZKx4ZJowRhRtjZxB@slm.duckdns.org>
 <6d5aee58-f558-868c-76e0-0b58f8332110@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d5aee58-f558-868c-76e0-0b58f8332110@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Mon, Jul 10, 2023 at 08:21:43PM -0400, Waiman Long wrote:
> > Wouldn't a partition root's cpus.exclusive always contain all of the CPUs in
> > its cpus? Would it make sense for cpus.exclusive to be different from .cpus?
> 
> In auto-filled case, it should be the same as cpuset.cpus. I will clarify
> that in the documentation. Thanks for catching that.

When the user writes something to the file, what would it mena if the
content differs from the cgroup's cpuset.cpus?

Thanks.

-- 
tejun
