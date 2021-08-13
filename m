Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40433EB9BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbhHMQHk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhHMQHk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 12:07:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CEC061756;
        Fri, 13 Aug 2021 09:07:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso16633190pjy.5;
        Fri, 13 Aug 2021 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2HZmfNWRvGEoCRS06cZMTLlzgFfVxMJbsV7IaJqnVhg=;
        b=InkfaLY0ZCFXGoifgEOs48VdU5Jc2nx9zdixJj7MXoz71NPOd9R/5Djc+ydBfpFtC4
         U7i7R7lQHGegengPSWbI6FBgclDyJ+QYg9Y3rQAL5n4XXy6FmCv4P2ja1DedF1M1k566
         3sQ7P/9K4G8wvzRsUlBkW+9SrhtPKBNAMQIUziuOLTeiSRAaIgzdb+NO+xIj9Dhc1DlX
         +GT31B2T0I3oFoJ4SlosCJtzNHRwgl6oRkFCvuePaOQ06nPvp5u1k73RPa/4MkwkiXja
         NzXKhkthXwFpZyoJSqkiBLKSmxL/qsBDP4SY9Uou84ybT+2MWIlJibdv8EG0Y4da47oA
         xN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2HZmfNWRvGEoCRS06cZMTLlzgFfVxMJbsV7IaJqnVhg=;
        b=kt4mDW6R4NqNa5Tr1tihvo+ph0uqh/p6rY6D9mWDG0WnJul1nOtGBTMN5/GP6Q37/2
         Hc2ocBJ+eM8e8DhpHgIGf6MTNhK6vqL6D3uVvYnSB8CQlh8cRPJu8S2KPtjisnKFc+94
         HC4KaPplyhZoeLMliN1rWgjcTvqS6Yviacc+z2FSAr8smjKXL/LFH/YjRc6IbJqMsKjm
         T10oD83FT9aa2JSAUmlZyU3RfElKJRkFLlyRua7zJU5FfDMRsroxbq24iVa8SveAtcbG
         BvpWP0zrjpYth3ZhC3IdON1Fl/yjzPB4j6tUaZ7iYZqateYIMSAfPNgp95fVuMtFzyzd
         Y5OA==
X-Gm-Message-State: AOAM533BBUwPyMt/OanlHwRVtpm60KkXfJMQWr6qakZtndrtZPbF0IKG
        CB1ECgIFvy+Nqza25r3fRzY=
X-Google-Smtp-Source: ABdhPJz3R1A5NO638+ZUp0B36ATcaFEx5Zr17zv5kMxc2MYB1KhFNEa2YyDRNNu12Zcj44Ualq+Yqg==
X-Received: by 2002:a17:902:c40d:b0:12d:97e1:e19b with SMTP id k13-20020a170902c40d00b0012d97e1e19bmr1978773plk.45.1628870833217;
        Fri, 13 Aug 2021 09:07:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id m2sm3277407pgu.15.2021.08.13.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:07:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Aug 2021 06:07:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
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
Subject: Re: [PATCH v4 2/6] cgroup/cpuset: Properly handle partition root tree
Message-ID: <YRaYr0sf9L1GY7i5@mtj.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-3-longman@redhat.com>
 <YRQSKZB8rQUsfF2K@slm.duckdns.org>
 <b7897818-8fe6-8dd8-3ff6-6b15401162ba@redhat.com>
 <YRWeQH6gY5PqIanD@slm.duckdns.org>
 <55f61b66-5159-7e13-6e41-33df042612b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55f61b66-5159-7e13-6e41-33df042612b0@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 12, 2021 at 06:56:00PM -0400, Waiman Long wrote:
> That sounds reasonable. My current idea is to add invalid partition reason
> string to cpuset. So when users read cpuset.cpus.partition of an invalid
> partition, it will read something like "root invalid  (<reason>)".
> 
> What do you think?

Sounds good to me.

Thanks.

-- 
tejun
