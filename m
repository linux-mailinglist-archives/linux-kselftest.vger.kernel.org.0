Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D279515B34F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBLWDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 17:03:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37489 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWDJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 17:03:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id c188so3706752qkg.4;
        Wed, 12 Feb 2020 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vktZgdwHT9wecNxCGbvMxpCvSL0TwzAxN3Sq+MPR+iE=;
        b=nfgfpDftMtMJpWLxiSSs1X2OYcR9WlCI1amDpodmsLKxPgHkq8bnF4qf1qtxMLl199
         uWMc6cYmIs/jgWcwFKkmA1JHNWG82eW/IKsMlZpt3mUHo1pedk+LHU2F5vGJTvd7qkuE
         fNGTvtRWPXIit3HMzALvF1UOg3gvWURxXh51WA1HcgiQsiQD6P2hroKRk0XCvfHR6Dzc
         dUViLRXSEg/GOVAWO3L349vTzL+TvRhuWrvH/RL4CyOMUBipTQvLtVcjhMg5rGBxSPCP
         gHaie3hPJkpPL/U0oSQ8fkXX54m7zGqVd3HOJjXK3WbYxhlGgnFofw7ctLXn1muu7S9S
         mjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=vktZgdwHT9wecNxCGbvMxpCvSL0TwzAxN3Sq+MPR+iE=;
        b=Bevf1WQsvTnT9/37wzkjtf0pNzjoFW4Znr7v5VeCL7c6a/m0kH7FLso+bdxYX2HqKD
         4QrwokQ/DtRVnMtVr+CVrKbJcmNkO4ZzOL6yKFVzXrvMSOPswB57mQCYa4LexuDWs2xB
         +Fchd5KLybze9yhSPTuZNqKWmfaHWvF2uweyeuGkxuYnesc50J+6CchQFnbVJLUYxZC0
         k4ufVtJnICxFEsM2ztAUFD5k4HHKIMQVTdLyQ9QsYRLJgAG3tARITIli4N0JSOdiIeOo
         ACf1zAh9N8K5nb965xXWqy/A9u2A84XSOJlfkLXhgyv+/jcMh0NyIahAbD5TVfOmsMQu
         XDsA==
X-Gm-Message-State: APjAAAXDjNs5hH+THHuoLM41+meE0MBhuD13ofkvjG6d927/kv9pKUHf
        Ukhpjye9N7redyVp30NzUbU=
X-Google-Smtp-Source: APXvYqzT+6mBAxj1e5FLwLyZnqWru8muuUku/e/rxOQlawFETlZgZCjz3d0Bvp6LGi4KM4HKO8a+DA==
X-Received: by 2002:a37:7a83:: with SMTP id v125mr13061546qkc.22.1581544987943;
        Wed, 12 Feb 2020 14:03:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id z5sm335513qta.7.2020.02.12.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:03:07 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:03:06 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, alex.shi@linux.alibaba.com, guro@fb.com,
        hannes@cmpxchg.org, kernel-team@android.com,
        linger.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lizefan@huawei.com,
        matthias.bgg@gmail.com, shuah@kernel.org, surenb@google.com,
        tomcherry@google.com
Subject: Re: [PATCH v2 1/3] cgroup: Iterate tasks that did not finish
 do_exit()
Message-ID: <20200212220306.GH80993@mtj.thefacebook.com>
References: <20200120145635.GA30904@blackbody.suse.cz>
 <20200124114017.8363-1-mkoutny@suse.com>
 <20200124114017.8363-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200124114017.8363-2-mkoutny@suse.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 12:40:15PM +0100, Michal Koutný wrote:
> PF_EXITING is set earlier than actual removal from css_set when a task
> is exitting. This can confuse cgroup.procs readers who see no PF_EXITING
> tasks, however, rmdir is checking against css_set membership so it can
> transitionally fail with EBUSY.
> 
> Fix this by listing tasks that weren't unlinked from css_set active
> lists.
> It may happen that other users of the task iterator (without
> CSS_TASK_ITER_PROCS) spot a PF_EXITING task before cgroup_exit(). This
> is equal to the state before commit c03cd7738a83 ("cgroup: Include dying
> leaders with live threads in PROCS iterations") but it may be reviewed
> later.
> 
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads in PROCS iterations")
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-5.6-fixes.

Thanks.

-- 
tejun
