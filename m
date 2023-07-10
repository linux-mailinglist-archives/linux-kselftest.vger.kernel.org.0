Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9ED74DFF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGJVBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjGJVBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:01:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1300FB;
        Mon, 10 Jul 2023 14:01:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b2886364so32103375ad.0;
        Mon, 10 Jul 2023 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022898; x=1691614898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzk4Zb/UOMk4q6SsaPq5WbyWefCvWA/AqIp31W/KVD8=;
        b=H6BC9RtRP0P20hEKbP+Uhd6OQuHBhPT9SfnS0pwXP24XbpLNWqk0FExxrS9awU95x2
         8B4Bbnjjw9RL05xU9E/YaRNOlTka+eSss8TVQdG7S1iNyRISMOYUtbKg9udky0slv/FF
         mDUFVKGHwjoZtEma/F37Rl2Dy1nhtW2iOQHwtEYwU0e9eiv5aEtkCvnCBP5t20/XtSzD
         5QMXCpb5ArjpjC1/08Euri6cpZpygC+4GlKZLWycDUd4d/ZfPRvtOu3L6QV3NPlRylKp
         TelCtPjzjGufaKH2E4Std+TYmAwWsMF9WkpohjwncUY0OcQU4dzzT6f4F6Uz+CYsSj5n
         7NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022898; x=1691614898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzk4Zb/UOMk4q6SsaPq5WbyWefCvWA/AqIp31W/KVD8=;
        b=ZtrgDkzwETLXfP+1uT6owv5sUGog6noCCuMqA4bq0SPw981cdb2IZliWo58VIz+sFY
         w0W8fJyAwuFMqyFmbh+DHb7moIEr/gbOj98sbiy09uiakoC8dlgNrOG+BlTiz7Ywq4in
         7VzdaK/tzYOlEKa5GC4yPTwyXA4zh/AWdJLzp3sjpiwn7TCilz0xYIGP9HhDn0a9dMIK
         7VPfstdCbVota3f1U0wrXpNd5giaJw4YsfcZ6CloFj7PFs9pntiZQ9ya73c0CYeOI/z3
         BRQYywUAM1faWFyvFbhmdEpC7qjlXLftD2ODp/64wQ/luw3nvWFw8/xa77HoAUi+nkzb
         2EnQ==
X-Gm-Message-State: ABy/qLZEwocGkih3noqTxNcvoBEya1Ec8o3lsyrHOLCDBHF5WUCXi3gX
        voFQYjOpKGLB/NCG0Bq1dqk=
X-Google-Smtp-Source: APBJJlFHcy2tvzWfCNeWSBgkI2pJBkziE/VqFLKjUNuGJj1R2pSUDQ/76neQ1bmZ0I0PFmcYUz8TZw==
X-Received: by 2002:a17:903:234e:b0:1b8:9bd4:297 with SMTP id c14-20020a170903234e00b001b89bd40297mr12123114plh.15.1689022897937;
        Mon, 10 Jul 2023 14:01:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902b10f00b001b9da7ae98bsm324904plr.122.2023.07.10.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:01:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 11:01:36 -1000
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
Subject: Re: [PATCH v4 4/9] cgroup/cpuset: Allow suppression of sched domain
 rebuild in update_cpumasks_hier()
Message-ID: <ZKxxsPKf4uGoJWdX@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
 <20230627143508.1576882-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627143508.1576882-5-longman@redhat.com>
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

On Tue, Jun 27, 2023 at 10:35:03AM -0400, Waiman Long wrote:
> A single partition setup and tear-down operation can lead to
> multiple rebuild_sched_domains_locked() calls which is a waste of
> effort. This can partly be mitigated by adding a flag to suppress the
> rebuild_sched_domains_locked() call in update_cpumasks_hier(). Since
> a Boolean flag has already been passed as the 3rd argument to
> update_cpumasks_hier(), we can extend that to a full flag word.
> 
> The sched domain rebuild suppression is now enabled in
> update_sibling_cpumasks() as all it callers will do the sched domain
> rebuild after its return later on anyway.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied 1-3 to cgroup/for-6.6.

Thanks.

-- 
tejun
