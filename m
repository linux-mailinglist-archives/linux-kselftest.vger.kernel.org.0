Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3B74E2E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjGKBAM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGKBAL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 21:00:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F23C0;
        Mon, 10 Jul 2023 18:00:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8bbce9980so33173465ad.2;
        Mon, 10 Jul 2023 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689037210; x=1691629210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOeAkeIhbm63YH/6Gh4MSzxEDTnuHBi8ou4wGcdJFeM=;
        b=QCUFSSTuYfpZ4zZwxQRpvBHWwVt6JX2r4IaQWToH7ZnW53vdjoDh7gN1os71joy4CM
         WCD33PWj9Qn9jM4ckCcNXsxJ1CPVRzuOTB7VAabbKy3CGCk6p42MNquaIwRFww9tP8ax
         dn2jG4J5piZFk/emDQSQXbHAptZU0jKpXztCYa3P0qBfDSxsP3w+lP/kWJKSqY9THOUt
         W8pdf4e7FFt9H3itZ3WqcjwYEevNXyoCqCwspcLeDZqAH6AabUSFw1LNx6R+SpiwMhga
         o6nfXDNIU/o3RuD4GS2JH4AYYH9Hv+uUMJeCCMvJrPVRrPtI/Rj7HSH51WjI4OxP1czG
         ve7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689037210; x=1691629210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOeAkeIhbm63YH/6Gh4MSzxEDTnuHBi8ou4wGcdJFeM=;
        b=PmGZb5/bFJfwBhr1mxLGOPQbLy1xGygcxCGYXDX/g3Z/Sfvu8OqxRfaBQxNdqxlXIG
         LphPWAA4yNIY1NgsT2We1FqTe7ruYbK+bBZI7yAN99M/DLAMI8rMTdyweOU/fOTHlihs
         jxkX79QKQDjSTjdOxqeYp5FeTNrfYC8nJgMU8yt33LCHyRZbhIgMD3UrMiGkPK1iMqd3
         93vCxdBpM+C6GnoFjirwNJxXqISAMfWoZv/Q3/xQ2C7MgFrfwV7SC3k7rIrp05LHRkWZ
         SKwiDsnygGn+5VXQ8I+jm4Fj8/G29M/sF58YJwm5pMFuL/HSW946lEshIHeCz3UP3/Xk
         JY7g==
X-Gm-Message-State: ABy/qLbguVrPQa4+r2YpIZ5SQW6F3nIYXUGV0BebX3UuMeOFrSV8RG5K
        Uu37sRn/mq83h5w99g/YWmk=
X-Google-Smtp-Source: APBJJlF4tqyKaxe6FUTxBOKdQXS/veWIutnyD6e4IB24oquduS6Evm4yVFhziXaM6ohvz/uEaHf4YA==
X-Received: by 2002:a17:902:b110:b0:1b8:9cf2:35b0 with SMTP id q16-20020a170902b11000b001b89cf235b0mr9467584plr.41.1689037209850;
        Mon, 10 Jul 2023 18:00:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id bg4-20020a1709028e8400b001b53be3d942sm482388plb.232.2023.07.10.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:00:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 15:00:07 -1000
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
Message-ID: <ZKypl8cr3jxiZ6bo@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
 <ZKxzTrN2yiKfXndI@slm.duckdns.org>
 <305038a0-1db8-3d0d-3447-48be1f03d41c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305038a0-1db8-3d0d-3447-48be1f03d41c@redhat.com>
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

On Mon, Jul 10, 2023 at 08:33:11PM -0400, Waiman Long wrote:
> I would like to clarify that withdrawal of CPUs from cpuset.cpus.exclusive
> is always allowed. It is the addition of CPUs not presents in cpuset.cpus
> that will be rejected. The invariant is that cpuset.cpus.exclusive must
> always be a subset of cpuset.cpus. Any change that violates this rule is not
> allowed. Alternately I can silently dropped the offending CPUs without
> returning an error, but that may surprise users.

Right, that'd be confusing.

> BTW, withdrawal of CPUs from cpuset.cpus will also withdraw them from
> cpuset.cpus.exclusive, if present. This allows the partition code to use
> cpuset.cpus.exclusive directly to determine the allowable exclusive CPUs
> without doing an intersection with cpuset.cpus each time it is used.

This is kinda confusing too, I think. Changing cpuset.cpus in an ancestor
doesn't affect the contents of the descendants' cpuset.cpus files but would
directly modify the contents of their cpuset.cpus.exclusive files.

There's some inherent friction because cpuset.cpus separates configuration
(cpuset.cpus) and the current state (cpuset.cpus.effective) while
cpuset.cpus.exclusive is trying to do both in the same interface file. When
the two behavior modes collide, it becomes rather confusing. Do you think
it'd make sense to make cpus.exclusive follow the same pattern as
cpuset.cpus?

Thanks.

-- 
tejun
