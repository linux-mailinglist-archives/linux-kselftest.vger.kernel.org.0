Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C397C10EDFA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfLBRNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 12:13:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35597 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfLBRNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 12:13:47 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so1390pji.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64Rtkbp5lv2QBUlTxW71SlutJl/znQZhVAhGmRkDa5A=;
        b=Vk1wssvB/zZH8eG99umAlefNG1L3qcWJrGhvntSWhcfpVqIgNAxOidQi1rwq4EQIXn
         bN4vLm7U3VKPpBs9sda/OGs+oyh9PNagdmFLvXdLj/BS47NPntYenQZ5La3ndeMMvSdE
         skeX0zFDPEe2oYhEETSdTU90kbb3+PL8p4zstc5e0YlF0cKXQ92MxFz36GyVOGZ0X7/M
         K3MrdpOuSClJ+EaJxL7s+dztJNSPhojECu28cIb0F2l3WqnCnMDfk4C/Hj49DL952BEY
         BxZqmEm7yS/3E/w9YNyvwuwajKd5JfcTzCs/nbSRB1EuYZe1m8RWrwueCb+hlp03EFEM
         7wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64Rtkbp5lv2QBUlTxW71SlutJl/znQZhVAhGmRkDa5A=;
        b=az3YIyz+WJxglD7o+yNNPnG3wi26i9QWy7AGJPDr1AkkPRufOvJTimy4OxTr05mSFx
         eXnSO64Nd1WAHNv5mrSuFVMd0JhEAfxPhTayeo2q/f41kBP/RQYStv/CluywOPJfn6mt
         yj4QIyedxOc5RE5aN0fdrVyh3mlc7reqi1+yxmYb5XkW8AnNgGku7oVWa888Jp0JYqz5
         iREJsu3x2h5/kWokGTgpxcYEhKLBLK5Ynn//8ttZDPbBkCmg7T/sNoq4F69RggJjqlHY
         awbfYxG91gs86vkmt96zBsLhfpzwX+PB0IvAB/+/xE8m8eZ9+Z3SdAo3YSU6UuClAgXW
         aZMA==
X-Gm-Message-State: APjAAAVAA4VelrpWjfZV9P/a/DWcwVLUJy8efKvP8keAYFOkWLT5zogy
        VrrmJWB5t+gV1PaG8G5Lcj2FVrBBucwr1m4Y3GBuLA==
X-Google-Smtp-Source: APXvYqw2U7Pcn6yuncEv+9Hnh2ggnupoJ+IowA3xrDVuGtbGVVpYPNpOewznFvm7KtezB3JzP8UOxrp7rkAIVpmh7PQ=
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr16466pjb.117.1575306825934;
 Mon, 02 Dec 2019 09:13:45 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-2-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-2-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:13:37 -0800
Message-ID: <CAFd5g468=suYdH9No7f1qkr-oAvOFS3q4O1iW3ABs57fzsntdw@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs/kunit/start: Use in-tree 'kunit_defconfig'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> The kunit doc suggests users to get the default `kunitconfig` from an
> external git tree.  However, the file is already located under the
> `arch/um/configs/` of the kernel tree.  Because the local file is easier
> to access and maintain, this commit updates the doc to use it.

I agree; this probably makes more sense.

> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
