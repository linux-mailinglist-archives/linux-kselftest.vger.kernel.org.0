Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B641B946
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbhI1V3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1V3W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 17:29:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65367C061745
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 14:27:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 66so24016pgc.9
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=br290Tj/mSC90lE7ySVxFB9stZwop7hbq88H7crcvgg=;
        b=e5HTGsZJi6fWGBM6AcacATHhN8c7bLc2anp+Y4oDB6okK2n79Hix9DKEYuNb4lOwxT
         Mstp/i2VVgVatfhTy8j7w/goxqiZvwPb7O5XciG371Guj9ch9f5u7V2V3TmlFelcJGhD
         S4TFG31sulRIwSfhxR9X3+dHIjcjHAYdpuwB23m37i+7rJYrfsfkWBb+V6dojiDvgp70
         itfhwHrLZGK3lHc4JMu3sU69gwCRj4t+35XzanzngwDIZMJwsocXi5L8XsJH7ALEjtE0
         Zz07wCM3dpQI8mPMvhL4gZdf0HeU5TGueulmypJBFrAKLBWa9f2M8AqdcPAzVfOHQ5By
         GCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=br290Tj/mSC90lE7ySVxFB9stZwop7hbq88H7crcvgg=;
        b=Xod+c5DCMVRbPnpQubBUJGkzWFAOtkg7S6GFynKejrGf96jCtaTOPOMRgne6TVUfJY
         aCE9b5wwW2C0H/wNwzgywut3xiB7eFtrnYh+64p9dqmmENuOs/X67FWQSey67IVBtvMg
         L7qh95MEr/yVPGzaSZ5P58Kmaak9HPDOM7k0Z4upJgsRC1AvTanmMfBxJqF78jsKDgGf
         6xkgY4feItcdqEUt34URg8vw9P3cM2DJlOo6F7KEpcBaGRfDggczCmqKej5jsh37/fxP
         UP4RP//gop7d0xl+8bfeUNmydTQfQ3K+Kv3aCWENdhPcD90dRRUt3ewH6OxJQVIRHMpO
         U6kA==
X-Gm-Message-State: AOAM533LDVUo8uWlej70Lk8kkwP7EQmoM0cQp+c8RRUmNPIhhrM+zouX
        2m+nbeJNXSxjF67gcaj5c3pNyX/COnSP6rICtas2CQ==
X-Google-Smtp-Source: ABdhPJxHoUUGD6Zt1BOyA5p0v05lqpOjQkL2Ew5z+83KrKSa2vasHq17v12TTddQEdUMYE6JPJW/TBHPHITq8xq/qhg=
X-Received: by 2002:a63:1550:: with SMTP id 16mr6551694pgv.442.1632864461688;
 Tue, 28 Sep 2021 14:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 28 Sep 2021 14:27:30 -0700
Message-ID: <CAFd5g45mgi-bnTEiHshpyxnah74toncgCgmcQcHq=kP3L3r+Vw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix reference count leak in kfree_at_end
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 9, 2021 at 12:26 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>
> The reference counting issue happens in the normal path of
> kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
> function forgets to handle the returned resource object, whose refcount
> increased inside, causing a refcount leak.
>
> Fix this issue by calling kunit_alloc_resource() instead of
> kunit_alloc_and_get_resource().
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
