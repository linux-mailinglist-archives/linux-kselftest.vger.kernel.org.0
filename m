Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1745D326922
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 22:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBZVGv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 16:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBZVGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 16:06:50 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7604C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Feb 2021 13:06:09 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o188so418777pfg.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Feb 2021 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvXG077daJU6YKmJEh5vf6RSoJYeHMnEiVy+ciL3dZw=;
        b=v+lyrEIhvM2RoELrx4WSpKrFldfnEnnubFNueDvBWmOB4ljdeK1vHN2XQ3SAqLZbLr
         56nsTTa6S7+NU/ghxzwBbTHh4sf2NZx/DPkLgzneKHPvax+/AfU+cq5+lhdigNd/xFdb
         4OZ8++FobRu8QnfwuSMJnoQ9BvZlj3VtgAUU6vBygdgnb+5sfHiFnDyjl1dHRIzmhOxc
         k20/MfU4F3s4G52QWKcIwVwxWdGSZbCkz7/vfHKiVlGsSH9DwyBf+N5M6rB4vfk+s0MO
         Mri/ZmfijbA4158GysuTf843FEDqMgCTEM+W4EV+UAvUyN78epmV9pO3GOSVlE+Lnw5x
         v67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvXG077daJU6YKmJEh5vf6RSoJYeHMnEiVy+ciL3dZw=;
        b=qlnrlPesHf/mtXlo+R2P05hxI/BFfflAy8sYLrR07ACpM2/BGtyi74g+Xrc2w+YNcX
         Elr6MjVMojE9leE5wAubcyORJ3diGC6+riqK0ANkKZ7bOag9GhG3dasoz20XP/SYzhRZ
         YlgCjr8dpPPIl25MpVHAXRbESDmpNoKl1Vwni7VWKGxTW33VFV4nMbRJRdUdwq+eGmXU
         D5wlu8QoOGDJfZ2h1h0ZRRbwQFitBWlKFdoLmaH1xc579FlrMMbs44Q0l2mhZ49OVqAJ
         MA3UOo4P4bcW/J1Pjp/6k0kNjX1yh1oGFF1Rzy4tID8GomHJu429cQcVCB6MbIcO18s9
         RqEw==
X-Gm-Message-State: AOAM530c/QLige5UHCuysbMpo5wZdifabvgp3lgXFF5XPZq0bop7ZW6t
        dCOynIAjy8JT9Ikba7xXA2b5cPc6ZFNB5v9aXrspFg==
X-Google-Smtp-Source: ABdhPJzY6R0ydSSn6upRS+o2TR+UM6INNbm7O5j7v7e3+DL10exfal8ujruHzSDVABPTMqXrQaGLuXUpsRu82ayEjOA=
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr4481140pgk.201.1614373569051;
 Fri, 26 Feb 2021 13:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20210226205410.nnwstno5xrsb5ci3@smtp.gmail.com>
In-Reply-To: <20210226205410.nnwstno5xrsb5ci3@smtp.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Feb 2021 13:05:57 -0800
Message-ID: <CAFd5g47ebZFOA6myhJHykt=nG5SwgJmuVAjr=CSkeO06iNg5AA@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix checkpatch warning
To:     Lucas Pires Stankus <lucas.p.stankus@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 26, 2021 at 12:54 PM Lucas Pires Stankus
<lucas.p.stankus@gmail.com> wrote:
>
> Tidy up code by fixing the following checkpatch warnings:
> CHECK: Alignment should match open parenthesis
> CHECK: Lines should not end with a '('
>
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
