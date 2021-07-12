Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B195C3C6413
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jul 2021 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhGLTuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jul 2021 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhGLTuQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jul 2021 15:50:16 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13495C0613DD;
        Mon, 12 Jul 2021 12:47:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id r125so11608912qkf.1;
        Mon, 12 Jul 2021 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=9o+O/qRFpQxkX5es5Tdd1bh1Vord+0B8VF72BRlyPaU=;
        b=llFphBnyL2gQwPFES6lZGOkrcxGnbYG186Ml2m5mcnudBujX/JsDY0qEn9OuHexbq4
         UjsrkKyEQ+ENgmbgkE6JyMWONj3rtsRZjclgcVAms+Tyk/oUGPoKidJ3tmwyvR6lI4N4
         cK4oD6yV93bhVDUsYPCbfMNI6huJdMGG0sv5BkIoNzibvrFCMBnSMsN/xMW5RWB99cW6
         mdtnPzzIhdtPIJfhHbCcQPkhVdZAZmfv5P/m0QdUiS0JIxlDZd2TzqffUIsMdgeY6Toi
         sr8w9dESj/knA9T3te6Lak+Q+elP11lhGaEYsbMyUDyyDwTnEFidteHm9lLDJLHgEipt
         gVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=9o+O/qRFpQxkX5es5Tdd1bh1Vord+0B8VF72BRlyPaU=;
        b=ZITCdmQYD3uHo4Wu6QpYWHGnPkdi9kX/GVUhB8ruNISR5+pjp6ejz95ef3MyS5BTDM
         EKCHxpyEWTlXW+Pke56w4ZO4CFqpV38BrDFdbWoopw5SKulAoO109DMogVSiiecLl1TQ
         L3RWdB3aJ4Ql4kMC3V/2dC5MZZCwap5GDUnnf/XD5a4CGVwYqqQXTI9DRSV/P3QT0+px
         zRqOHifLK4d6PfDIeGwbm0QPCBIfDHx9wzk/6WLE5B1hrGa8LprjX7qJONLAOuZ76tJX
         q6zf7ZyAl+VOnDrTRJ+THjKklMCrqw6HacYoStTc549Zs9XwDR4QxdsExpo9Sjb6TDhK
         eG1A==
X-Gm-Message-State: AOAM530UDVIzbJv/kmFQdIa2wCkYpXzFO2njbfr0j0ziPvoQbYiXggUi
        CsgFx28MkmlcAYBMYUstr7c=
X-Google-Smtp-Source: ABdhPJzpM42QM0BiJNuP9l/37ko1oUYwGvu3LqxdThP629l9qAaUVe+GGUiDcsMcFfYWRhGf6yhC0g==
X-Received: by 2002:a37:7045:: with SMTP id l66mr351080qkc.427.1626119246460;
        Mon, 12 Jul 2021 12:47:26 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id k66sm7254619qke.28.2021.07.12.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:47:25 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sj38.park@gmail.com>, dlatypov@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
Date:   Mon, 12 Jul 2021 19:47:18 +0000
Message-Id: <20210712194718.20813-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6fb4706b-ce58-a397-d777-10338c2a8d4e@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Mon, 12 Jul 2021 13:42:34 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 6/28/21 1:41 PM, Brendan Higgins wrote:
> > On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >>
> >> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> >> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> >> Because it is supported on only >=3.7 Python, people using older Python
> >> will get below error:
> >>
> >>      Traceback (most recent call last):
> >>        File "./tools/testing/kunit/kunit.py", line 20, in <module>
> >>          import kunit_kernel
> >>        File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
> >>          from __future__ import annotations
> >>          ^
> >>      SyntaxError: future feature annotations is not defined
> >>
> >> This commit adds a version assertion in 'kunit.py', so that people get
> >> more explicit error message like below:
> >>
> >>      Traceback (most recent call last):
> >>        File "./tools/testing/kunit/kunit.py", line 15, in <module>
> >>          assert sys.version_info >= (3, 7), "Python version is too old"
> >>      AssertionError: Python version is too old
> >>
> >> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Your from and Signed-off-by email addresses don't match.
> 
> Please resend the patch with the correction.

Sorry, my fault.  Will send fixed one as a reply to this.


Thanks,
SeongJae Park

> 
> thanks,
> -- Shuah
