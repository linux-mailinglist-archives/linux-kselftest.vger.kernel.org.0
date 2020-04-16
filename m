Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7C1AD320
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Apr 2020 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDPXUo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Apr 2020 19:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDPXUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Apr 2020 19:20:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E8DC061A0F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 16:20:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o1so237875pjs.4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oid4502jx5OsVv4L1q5Cd9rnzIb1+xycaGqywcIvDmc=;
        b=P1GARF+NJi/hKDeu3e7WXiqMUzJJ1TPa5ZL+H9WidK8i3Ok+u3ItGbMm8f0h7WKP8h
         VKvcDZV/uCrR72RmlTHJC2Wu2Ns8pOMvMIABo/jP57B5N0nfKzCh3eKh2zOCuYMB/8JM
         ES4CcSIF4ng+h0a+pk3r9bUXRAMWETWzdYO4QI38NLxXoEeuFbr1JiDFKWMzlbyKIkQW
         EJcsZsLkv2KnKK1fGR31Hr8XWI+PKmW9qRSoB3QdoSej0qDdHwn99ywssrxmsc+rUJtt
         KEDyymPb6uStMgTNzip2IAESB5GCJp7vdVrtw/amlJgcuU6oavtnKSCYJq1dvPve/+oJ
         W2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oid4502jx5OsVv4L1q5Cd9rnzIb1+xycaGqywcIvDmc=;
        b=swaH8rOBDSHwGiLnVtkUHYTttl/f/c21Prb/EGfo8MXhLTgi2F6wT2X7GhImj08Pdh
         owEuJBvFpQMH/0Pc5MBMgT1bWzQjePUCHCXfcw7I2EHhhjmYdAKZ9+w3cCvCHv1pubnj
         XoFl320C4evMpOrNEXuT82W8GFtdFsh20XpglIfW986WhRciYjc09eSN/JtIw3AV5l1+
         FD3kAt2H2tR9523gVQ+HBuLeGUrCz4A4dVkKFj+UT/5084y4FvhhSuXDkPWD89mNACIG
         TRzIf0RvXzZpeNLbhGw8d85bj1WURKWDjBpFaev2Et15cOTcWkYHxpNW+5X0hYmeg/kT
         vuiA==
X-Gm-Message-State: AGi0PuZp3HS0O6vHVUpaos82ajrrnNIslsGLdoc9xbTMp8Xoi2pe+WTR
        fh6F1wNRKBaRGbN8NFY28NcdRgKpj0KvfGl6XqZViw5GwXU=
X-Google-Smtp-Source: APiQypL1gv9lxNUxpuv/LgpCAKGRZAyBFLkc8zFH07ZvjhxVjxDqpX/VBKMtcVsZYhDRPwusjIukR+LAefhB2ibng7M=
X-Received: by 2002:a17:90a:e28e:: with SMTP id d14mr881656pjz.29.1587079242348;
 Thu, 16 Apr 2020 16:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200414233753.94978-1-vitor@massaru.org>
In-Reply-To: <20200414233753.94978-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Apr 2020 16:20:31 -0700
Message-ID: <CAFd5g442ka0c+D+qs7--_ERqn=Bqc3V4AHuER8FLsJi1oesirQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: use KUnit defconfig by default
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 4:37 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> To improve the usability of KUnit, defconfig is used
> by default if no kunitconfig is present.
>
>  * https://bugzilla.kernel.org/show_bug.cgi?id=205259
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
