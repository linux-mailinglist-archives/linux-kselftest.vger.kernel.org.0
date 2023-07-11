Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11574E3AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 03:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGKBpk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 21:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGKBpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 21:45:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD6FE1;
        Mon, 10 Jul 2023 18:45:39 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a3790a0a48so3980490b6e.1;
        Mon, 10 Jul 2023 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689039938; x=1691631938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpT1Zdi1tyj6h+VTlL69D/4kKVXAEIcYNY1HQcB2aX4=;
        b=djAxqkMNUbvbWccTngseI3ojv/tdct6mAnGVNvGsN66Rw0+/KG7ZP1kClU3wvuQ6c8
         GQ3KzQTxKalzx1Byuu+AtWpNXZKf1pOn/BjPXwU8xriOIpmywR5Cxe3H50bDyXGBkD7r
         xCf2GfJBLu8jwaE98lnR19uC0MBtGk7YoyMWMUoyCxojgfxDvlY+XTYzEHZHKe2zPKnR
         MnMJDm6w2ILbXhhgiiIjXW+yONQcPktxxcEGQg2VT34YKwlJKF6DXwCFWvdaAZ0HjZ/A
         xO4fVg3lf1hHzSlYuyu4WAil3G3kxest1hcp3YgefhVjBqd2A4195LYOjXdaHpsE5JjC
         jIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689039938; x=1691631938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpT1Zdi1tyj6h+VTlL69D/4kKVXAEIcYNY1HQcB2aX4=;
        b=mFnt0euKuGUe1yzx5bJp/cs1NAW4YFQM5F1+vaxoUG4EPVa8jrfyeUmbq8JH0m9Twb
         YRsimc8FzyiMsOENVd/yBxvw9+cfkYP+fwKZIKsvws9OUmmF5OUyBwZ9SvvNWN4dYxtE
         gcLLKNLq7dugXnPZS3jfiyfIm1y+HPRR1TMsn9GYGilwmg3Az/2gZE8LsM33sF2ezBKi
         7tM3s2v0BVjZJ7hET62VfsuNWB/bevqK10fvSw2D3wJWoncVUFj5hgNSjp4cGOviCeXb
         aN1wf40qhXBthFg14boAhUC3Z9ggqzund2IBGcLmXZlfClfsXWGIV+WeNGp73z3pHFoc
         MQjg==
X-Gm-Message-State: ABy/qLYMfvYoizqKyCLcTsM/mn9I7o+1BNtL6XvKEDiji3wGgu6yHm29
        IijDdofZc1SGKsb63Vtr+tWI7FAKxfv67w==
X-Google-Smtp-Source: APBJJlEy7PyAb4oSWWR+v7ueZ6ZgmdbI4AkEXXJGBxuBwPmWNdecumDYZPQGa9HxUFobEGELaE631Q==
X-Received: by 2002:a05:6808:23ca:b0:3a4:12ab:8033 with SMTP id bq10-20020a05680823ca00b003a412ab8033mr2593430oib.24.1689039938332;
        Mon, 10 Jul 2023 18:45:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id x11-20020a63b34b000000b005533c53f550sm292860pgt.45.2023.07.10.18.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:45:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 15:45:36 -1000
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
Subject: Re: [PATCH v4 0/9] cgroup/cpuset: Support remote partitions
Message-ID: <ZKy0QCBBFf3JZXuh@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
 <ZKxzTrN2yiKfXndI@slm.duckdns.org>
 <305038a0-1db8-3d0d-3447-48be1f03d41c@redhat.com>
 <ZKypl8cr3jxiZ6bo@slm.duckdns.org>
 <c0fb6438-8d19-9d75-d717-68f047465332@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fb6438-8d19-9d75-d717-68f047465332@redhat.com>
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

On Mon, Jul 10, 2023 at 09:38:12PM -0400, Waiman Long wrote:
> I don't want to add another cpuset.cpus.exclusive.effective control file.
> One possibility is to keep another effective masks in the struct cpuset and
> list both exclusive cpus set by the user and the effective ones side by
> side, like "<cpus> (<effective_cpus>)" if they differ or some other format.
> What do you think?

Hmm... if we go for separate effective mask, I think it'd be better to stay
consistent with cpuset.cpus[.effective]. That's the convention both
cpuset.cpus and cpuset.mems already follow. I'm not sure what we'd gain by
deviating.

Thanks.

-- 
tejun
