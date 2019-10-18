Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C8DBAED
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393047AbfJRAee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 20:34:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46625 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfJRAee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 20:34:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so6487135qtq.13
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUlu1SWs2RKAwKCxV/9R7y8e+BDWGAAyqQ0an1Lsr9Q=;
        b=OXsvF7SQN+XYVlWUa+QkhyzQlY82oddbjvaFWnStUlidnn51dbg5obEKiaFj5zoc6y
         vwi5qirf6p/I0EprCYIHbJ5s7+dKa9zNJS8Qct/sXCBLvXojZX4N73eeclUdVuTxr2on
         fZXxUG70SWof9y9B7g5dOIsLuBZ7XoEFF9ecWJvzkLQKUHpTID6x+qqIrr18yBuXY8dt
         zYEoKT5bh90GuwYNAIGH9pzHKtKGDQmuA/V53vp9QsYW8ruCmJvctmoiowhBgqny1/H5
         hYvFurEpJdqTOzUYmmTUEqt0V85cGgxkNayG1xlayYRjioTgROxq8AM9L70jMK/3QGEx
         O06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUlu1SWs2RKAwKCxV/9R7y8e+BDWGAAyqQ0an1Lsr9Q=;
        b=V0m/X+LnrWquWUyC/UUiLembwaRCqSUtBIhJt8H63iik/nPeD3GR8sRY6Z9XxJuEdU
         GT1f00OI/o86b/PbGFekLn6r7HKUoh6SomZw65TyE8Z6qQ+E3YDOjIuTY6LTaeqi5emX
         wPgIz0ps4mSoTcgilOoyntnL4rDTbrSNCpw4LjriOdtyPPRwxXNnETdVCbJ6PO/0xSYF
         dE/p3H5c97prSl+CIOAhXtmrdwNYvs5HTuQd7IHhoQ3oAtC9C7mVn5/ZVya8gvD/9IXu
         2Nmsk6j5jCaz/vv4YFoGZe7K9RaIcvtc1UAEuJHygNAjUjA1IAv0Tz56jBasHhD54akn
         cgnQ==
X-Gm-Message-State: APjAAAVrzKFvGVFhqqvxJ0cW2cH/beqXBVg8DyS3MD4PTY4GKMKbRD4y
        PJo+S3XZM6lJN0GYeza9Qp2sW5dz0GPY/7X/+mfq
X-Google-Smtp-Source: APXvYqysQ8azqkhvfL+IXNSJUTjI5cgJ7rhGxwOr2jR4+xdknSlXEXLf5ULzXQL+NHfP+CJNDsIennPxYQdpYJ61h60=
X-Received: by 2002:ac8:5147:: with SMTP id h7mr6962616qtn.160.1571358872431;
 Thu, 17 Oct 2019 17:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
In-Reply-To: <20191018001816.94460-1-brendanhiggins@google.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 17:33:56 -0700
Message-ID: <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        alan.maguire@oracle.com, davidgow@google.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
<brendanhiggins@google.com> wrote:

> +config SECURITY_APPARMOR_TEST
> +       bool "Build KUnit tests for policy_unpack.c"
> +       default n
> +       depends on KUNIT && SECURITY_APPARMOR
> +       help
>
select SECURITY_APPARMOR ?
> +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> +       KUNIT_EXPECT_TRUE(test,
> +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
otherwise there could be a buffer overflow in memcmp. All tests that
follow such pattern
are suspect. Also, not sure about your stylistic preference for
KUNIT_EXPECT_TRUE(test,
               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
vs
KUNIT_EXPECT_EQ(test,
               0,
               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));
