Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264EC10EDDF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 18:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfLBRJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 12:09:39 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46751 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 12:09:39 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so5594012pjq.13
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDGGQHWpdkZIj81hxXdfawczIBgk86TVXpxZEqNBkKw=;
        b=qy1XX0NQtaJmJIk1WSswX5pJZErX2pRnSRnoUqnlqrxvfEfIdPE2rOIZfXv4W1NZX4
         rGki7kDJGQgC9QNz5h/BMIDI8PcBEHBAET/FtufdP8qVa+7E0j1+0gueUKOZvey7xV40
         ipOq2+hRM8AUag4zbb8uui/TQI7YALdkbuBkUeU2jw0/LwEC5TJd2lIYmAZsEWM6h4Kz
         ULeuV/etAnPSASnzO8ReR0Ve6D0Slh2WeHYBc634bc1ZtUxqWo9SnOYUzl/Dg+LIpiOb
         siGdXVqIA1rMRUNUnhlfzuAqV3jyDSRhDCDSLfFBAfTM+f2wK5f7F3+WE59nxKFLE2nW
         buHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDGGQHWpdkZIj81hxXdfawczIBgk86TVXpxZEqNBkKw=;
        b=mg+QXnEjOhuVhCDMYnmGSNVNNE02hTtlaoz5txRlaE8NkbVCxuWysPqUK9O/lpdo1i
         gIkaQsmaVqkS3o3ayx3f5IrriVuliqk0qtDjDLEepOmVCKniV8KC4lrAtaDWYNf1XH37
         e5BxZ/rKsfRaFkHnmtKqUDVbxqzjFnJ0KYQ54j6Z+XHwp3qZMoYvdud1p2TzzSTWSAWz
         duLltYwW9FbS59HhrjxXfAoWjYcsNtX9+cNb/BkIrfI3wCIPdKFddBsO/4I1mnRs2XiZ
         mjx8cRmAmlaav0vIMOJBdE0Qky83cVIIiimiRovIR5Ke6cAXDDABPj85efCmrzuWYPSN
         wNCQ==
X-Gm-Message-State: APjAAAWksqRbrB8PDJ1ZJmwWVeVZ1nf0s5qJuhzqW+vxkOLuIVG7P3f2
        PmxbYh3nWsq76J/AoOSbZ/0pSi1E7ssOG7nL1ueijg==
X-Google-Smtp-Source: APXvYqzqsLYh95mI5pQBPTRCrUh++E3DAxgln/usIn0Xc7WWl8bqC9mEjf/KwCQBB6K3knP54p0s/dChqA2Dqaj6CAI=
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr264576pjb.117.1575306578192;
 Mon, 02 Dec 2019 09:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20191127231926.162437-1-heidifahim@google.com>
In-Reply-To: <20191127231926.162437-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:09:29 -0800
Message-ID: <CAFd5g46TG-+baJE29dR8iUdBdWViO_BygKbwUQ5fHv8X3Jkpfw@mail.gmail.com>
Subject: Re: [PATCH] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Heidi Fahim <heidifahim@google.com>
Cc:     David Gow <davidgow@google.com>, shuah <shuah@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 3:19 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Assert in test_run_timeout was not updated with the build_dir argument
> and caused the following error:
> AssertionError: Expected call: run_kernel(timeout=3453)
> Actual call: run_kernel(build_dir=None, timeout=3453)
>
> Needed to update kunit_tool_test to reflect this fix
> https://lkml.org/lkml/2019/9/6/3
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> Change-Id: I6f161c72c6a5f071a4dc31582ba08b91974502ce

Change-Id should not be used on LKML patches. Did you run checkpatch?
