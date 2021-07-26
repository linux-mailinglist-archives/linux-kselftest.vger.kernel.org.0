Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC803D69D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 00:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhGZWQa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 18:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 18:16:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAEC061757;
        Mon, 26 Jul 2021 15:56:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so2188756pji.5;
        Mon, 26 Jul 2021 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rywULGqqJHW4uW6Lie4psExGDsJbpbasiEeSTM/fJfo=;
        b=aH5KPGTtmHB56BZ+Xc8UtKMKCaLJy9PkkE+AXhNMxOw9gQkxFCCtD2uMyQ0cMIAi01
         ol8ew9gUmas1187lR12GPtdiM9K6AqgALsLefECSsBvi780ZQoyuWvz8yb0zegl4EAwN
         PmmaHFI6vByfskFP7MT5J5RPrG3M8kjy3TYZIibP27v5XNSq2YkYoGy76YRiRkfA/LMT
         tqkJCBcfwAFhDxb6gIy1wYgfgF8BRRNAUQ0h7YkRN45Z2tBBbxphB/KvHpcHb/lArIv3
         D/ViVSGKwIPbY/jGjleEPNfuRs7KONRUXze9JrnMpBORGehXmSGGEQvtX52n1r6WSua5
         RaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rywULGqqJHW4uW6Lie4psExGDsJbpbasiEeSTM/fJfo=;
        b=aSvHOPZgG20zPhmBjRgb9ILokFVuyuDRLeGfWmLhayRk5W25eLUVeRxCBeLwuIaP+M
         GNaGrywBGVSRZVOg4PZwwknN7+yPjIaS+jpunDjcm3FpIMD6wHzhv+vch7+pgW1Srqv0
         Wmc9PwshuJ+LEouVuaKgJXvgsy1lCffauIPvmfLhqhfmsrXMS3aF+x/L1Z5IMDxjtpmY
         GxZlmdAi2lVSmKG+cMbSyjSRxSVGUVwLKjfJ2meKWW7u4a2Z+hjESJkQtwJlHnjaHqd/
         uJGRLA4dSc5c4+ImIVWutRX/ieTIIc058RCqotuXQTvLiTKbhwxOXdQXbTiV45bRD07d
         x3cw==
X-Gm-Message-State: AOAM532UBTDbuidcc2gSNZrVFMKpK187ZvxG12i8RYq6lFrRZ8aU4gLy
        wccodTAfTV9+3+D1iXDQ8Os=
X-Google-Smtp-Source: ABdhPJwCPc+4Gdgco1MaqbsYdI/d/PD/ZKL9pXgKFhSJQ7T5l8vsVHtn4CtixVef/WjLDRMLoBPbtw==
X-Received: by 2002:aa7:8011:0:b029:336:162f:3417 with SMTP id j17-20020aa780110000b0290336162f3417mr19970728pfi.14.1627340216815;
        Mon, 26 Jul 2021 15:56:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id w2sm567213pjt.14.2021.07.26.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:56:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 12:56:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v3 1/9] cgroup/cpuset: Miscellaneous code cleanup
Message-ID: <YP89s+r6sIJfH1IP@mtj.duckdns.org>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141834.10624-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 20, 2021 at 10:18:26AM -0400, Waiman Long wrote:
> Use more descriptive variable names for update_prstate(), remove
> unnecessary code and fix some typos. There is no functional change.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
