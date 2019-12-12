Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5E11C205
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLLBRb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 20:17:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36057 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfLLBRb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 20:17:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so210974pfb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2019 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9boV3Hg7emjeyUoekMzbEkEybPyhPn+8n735mHoCvA=;
        b=LUw50vEOj3BhWqCbIUbgX8ki5Vxlrc7te2m0hHZCilkluhkZlnh/GkOzqWJxDb3zV/
         /ZUELgAvbVzxkwGkuip2yFdzIbCG1GnGI6EKAXlm4KqjP2yOdhKhBnix4IdQ84LKTh8f
         dbeoWkQt50mdgf5d0IK5950WS5qFUn6r2DaYBsu1jabxJD6xU6VD+WG2fnSitB6Ts/s5
         gFxl7ImMAYZhpHfIbUyW+9r031qaB/BAUnldyMxCzLZQg7NQ+iPK8WflCmtWIe5BsIBm
         jw4rWE65xM78tSwtI2SHKyw4LYU5wMHQZCYcJKRbiPJST+9i69pLZcJ+7Ks4O9U0CDN2
         q1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9boV3Hg7emjeyUoekMzbEkEybPyhPn+8n735mHoCvA=;
        b=YarV0L2oej1UOMDupreowEcK0gONzvg7Dhfh6j09Png/UhfgpKPdXEB95isaQ2UXso
         Q/9L3RsCnUSDPK1eptKcbn/85pogo3elWWfiK0jm3RbaWmm3VbaVVJkrhrXDZz96krgd
         wN1B2/6L6DZM4fdqO8/S28w2b2Q4tc0y01O7Kphh8WtBJhYtw+QVtLr33ooiq9ecFRzX
         vMZdMsiEkON87HRsVVpAzbaJESo9wfoO7YJd+x1iYz+Es5ev0KH89+VzOAH2PZW78I2s
         Ig1sKYyZHYjvQ8LOqdQHjBEAaO+WrhrcWRbRQzfiNduIYe+4tvt+cZ5ufgE6GJXv4Gdn
         OqNA==
X-Gm-Message-State: APjAAAW6lRH+Fnp8phFw7Lrs7lQ2ymtDA0y3Zw0vVbnk1wCeRqkVaWiM
        MZBqFAyBDhvccJbBeNIKKiMmxb6HEpY2LAMDyHCShA==
X-Google-Smtp-Source: APXvYqzwKtBT8eiw5GuI3onlZz20uo+ZdmqbenynXPURvRO9f7Mcuh9oJQDwIhCknNgHXBLKYn7wQBvqXUgpWpWN8Lo=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr7630209pgi.159.1576113449800;
 Wed, 11 Dec 2019 17:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20191205093440.21824-1-sjpark@amazon.com> <20191205093440.21824-4-sjpark@amazon.com>
In-Reply-To: <20191205093440.21824-4-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 17:17:18 -0800
Message-ID: <CAFd5g453HrF-P9K8gCWKhTmCxoSODQ9RP3t+7njeHovT-_wpYQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] kunit: Create default config in '--build_dir'
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 5, 2019 at 1:35 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If both '--build_dir' and '--defconfig' are given, the handling of
> '--defconfig' ignores '--build_dir' option.  This commit modifies the
> behavior to respect '--build_dir' option.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Suggested-by: Brendan Higgins <brendanhiggins@google.com>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
