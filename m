Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56AF3F7CAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 21:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhHYTZP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 15:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbhHYTZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 15:25:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154CC061757;
        Wed, 25 Aug 2021 12:24:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so4815082pjb.3;
        Wed, 25 Aug 2021 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:84;0;0cto;
        bh=PGxtjBFxPgG3Jd9Zpl37bDstSoJ0Gj+kNpbO5xi0BEw=;
        b=SqsbO1EwGVFKKZI4L7H6CKN1OWwR+R4V6j6RZ/XwrfaNg7tatBfXGORpM/dsXhuRWX
         1gGcpWO7f4fzfSW3sYTHcJzW74XYyF/lnRct3FlyvJdYRLeERW2cbhTE0121qCKQhbkO
         j7cUUVCjDL+r+QJMGc2QBnOeQwaVJ1fwStUtZWPCRkJLYsxEG1Dp8np9JLU5bnFM7d7n
         JMkhwIhU48DZ9uOPs5cIaW6cr8mIltTcfJ+woL5GfhljTDGhcYWcRo2CWIeqOs5u4FKh
         9LH75bTT9EP48nvcrzlGn1TH5wICzP5ov/p/cyLPTf8oZ1yMh/9k78X3Zi1L4UjoNDm7
         T0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:84;0;0cto;
        bh=PGxtjBFxPgG3Jd9Zpl37bDstSoJ0Gj+kNpbO5xi0BEw=;
        b=piUhJwUhpgYf9yKt4O7nnPp000Oz+yh+7jFGMHR7jINHSQkTATk9Lu8znnrUbYQpXx
         O92i1l7hrVEexoAbp3CY5LMZrS7BwVRb488K6dAEFOqesRygNDc/QXC8HF+enuEiQjHT
         KTbYFHP1AKi6sSVOaSlvZJz4UMGQ6IuM5kuiE5TqwkPtStfjOVst8cCID1bdbZYFvJpz
         T7wwKRBX8Fj9UufQ3slhnMZzEBaKQDZthLFJqw1n1vO4F8Ia96HkzOJjZEChfK1b6KmT
         9ZwL+QX8OahZgHrf1CIYIaACG302130hqbWTXQigdTt87uB0EC20VhdO5EjfStPZ2STm
         Cmug==
X-Gm-Message-State: AOAM533T63x83Kh8uvI7CPmMSJtmwcUZt1cENrNU8ORS68qxra0iS747
        YZty03cmvAw8SNHI+jObfXY=
X-Google-Smtp-Source: ABdhPJzcYsvA9r2rerZdhGMEavTs6kvS9wilCSHl3DkaXZchE9YYxbWlcghNlLlUYImzSpqn+Spu4A==
X-Received: by 2002:a17:902:b084:b029:12b:6caa:7d9e with SMTP id p4-20020a170902b084b029012b6caa7d9emr176051plr.57.1629919467563;
        Wed, 25 Aug 2021 12:24:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x4sm504283pfu.65.2021.08.25.12.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 12:24:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Aug 2021 09:24:25 -1000
From:   Tejun Heo <tj@kernel.org>
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
Subject: Re: [PATCH v6 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YSaY6SbKMD2b3Oec@slm.duckdns.org>
References: <20210814205743.3039-1-longman@redhat.com>
 <20210814205743.3039-6-longman@redhat.com>
 <YRqbj5+ZdS+7k0Fn@slm.duckdns.org>
 <95b72d36-32a9-8356-05b7-2829e4cc29ad@redhat.com>
 <YSVCv0WjTzwPUWUN@slm.duckdns.org>
 <af7ad628-62f4-848b-7eaa-1c9eb62355b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7ad628-62f4-848b-7eaa-1c9eb62355b6@redhat.com>
84;0;0cTo: Waiman Long <llong@redhat.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Wed, Aug 25, 2021 at 03:21:59PM -0400, Waiman Long wrote:
> I agree that the current description is probably more complicated than it
> should be. I will try to fix that.

To avoid repeating back-and-forth with all the code changes, would it help
if you first describe the intended behaviors whether that's in the form of
doc patch or just informal description?

Thank you.

-- 
tejun
