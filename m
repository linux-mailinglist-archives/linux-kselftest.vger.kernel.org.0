Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E7140F7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAQQ7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 11:59:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45819 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQ7W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 11:59:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so23269806qkl.12;
        Fri, 17 Jan 2020 08:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zUnqRXYQtoyEF5UfPwWmYzCrDBoI5jZ6BUT1W4OJSHA=;
        b=dNwidGHTaO65iLrmuRFYsedrAORZcj1dlBJc6RMBU146ZCPVPbdo76G9xqEUHi/4Pt
         EOjOovq0mE5jq+flTugwLRNLMe/HfRwsgkV8518vOU7/DmxMI7XRE8vFRc/XRTgb/ICe
         rDke18QDeVAgygvYrcv/rpZui2Gx8OXVHY42jmMcwi2MkfLMXzY2zcHKratTxPYePE5C
         6/+6UJTgCLdF/6Q0CmUKGsNVRYhdpnM89yIl1USuXStY8jSq35oPPXc0UDZcFon7c8E7
         I38FBOrLF5KnNZx0uQLQ11UdW+T1YiVS3L6zDZSMoGQuQQo1a/NONcwN9ay/gtbQB1Jz
         70Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zUnqRXYQtoyEF5UfPwWmYzCrDBoI5jZ6BUT1W4OJSHA=;
        b=hk11AA/Adc1XVxQCk7Uz7vUakpQFLQJuD8+4xJmnt0ZwUzp9qJuJnNAcLg6h7S433r
         nkcllXa2w3O/H1Pp8Z9ShkzSoFyBQadbEgtQH8T8rA1PnpXCKbBUXKyfWtJ2ZOxP9qju
         zP5LdB6OHbWG1a2YPgUPdgprzAqGCS63WpmfItD3JQ7X71oYz+iUSXf0EHVwNk6XJj1z
         FScD8BR+gQGngbweH+of4hUC6XpmvZazjHujiZ8xk9drGsy87odiZKXBTVFYq6je1fh3
         V+xjn+1s+XRJoWrLzTPJ0bCDQEUtzqmtywM01ts8GRTj1NrCcGOsicGSn4Jb6XKwqHv5
         EpmQ==
X-Gm-Message-State: APjAAAV1l9pGOp6U29C1YttA9MMCugglGN3TAdGyWjem26+poaIhCEfR
        K8Hsm+sg2BfAB+/Q+XDh5T0=
X-Google-Smtp-Source: APXvYqxftns8R04Lq7DlRW0QHAR4L0VpzrsayZtZp6bJXTKdCVV6PA2/eZmoZzleZqMOolzPC/QbPA==
X-Received: by 2002:a37:7005:: with SMTP id l5mr37840890qkc.334.1579280361177;
        Fri, 17 Jan 2020 08:59:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:7d10])
        by smtp.gmail.com with ESMTPSA id g18sm12021690qki.13.2020.01.17.08.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:59:20 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:59:18 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, alex.shi@linux.alibaba.com,
        guro@fb.com, kernel-team@android.com, linger.lee@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, tomcherry@google.com
Subject: Re: [PATCH 1/3] cgroup: Unify css_set task lists
Message-ID: <20200117165918.GJ2677547@devbig004.ftw2.facebook.com>
References: <20200116043612.52782-1-surenb@google.com>
 <20200117151533.12381-1-mkoutny@suse.com>
 <20200117151533.12381-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117151533.12381-2-mkoutny@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 17, 2020 at 04:15:31PM +0100, Michal Koutný wrote:
> We track tasks of css_set in three different lists. The iterators
> unnecessarily process each list specially.
> Use an array of lists and simplify the iterator code. This is
> refactoring with no intended functional change.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  include/linux/cgroup-defs.h | 15 ++++---
>  include/linux/cgroup.h      |  4 +-
>  kernel/cgroup/cgroup.c      | 81 +++++++++++++++++++------------------
>  kernel/cgroup/debug.c       | 16 ++++----
>  4 files changed, 60 insertions(+), 56 deletions(-)

So, I get the urge to move the lists into an array and thought about
doing that while adding the third list for sure.  However, it does
make code paths which don't walk all lists wordier and the code path
is already tricky like hell.  Given that there aren't that many places
which loop over the lists, if you really wanna clean it up, maybe add
an interator over the lists so that both parts of code can look lean?

Thanks.

-- 
tejun
