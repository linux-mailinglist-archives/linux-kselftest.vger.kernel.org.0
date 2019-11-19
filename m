Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35A102BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKSSsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 13:48:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41182 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKSSsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 13:48:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so12616778pfq.8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2019 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36jpGIQcZ4lU6TqRvBSPN3Oc7gVUnBFQ0lBJ+9WKKcg=;
        b=kCduduS8sUz7ZMjCUdC5gY5VD/uZm5eD+8jxwwMRL6DFz4MIafJkNv4XkD0U2xp20S
         ixo4VwHZtd76EFCFueeKOEIVmlVl5As75mVIQLGELq4LCap/sRuvvfgW2YYrLk9UArvI
         9OdAQgnqi5kYsmFXVB2E6b6NZU6KCSBNtzLNw5D+/rEkgOzgDQ7OefR+PCPXQVBDN3rp
         jVHpMuoRusV1L2X4KhI1ANNExs/nJG8rpdqMNI4wPDUywevajs1M4wQ+P+bxfiPggP/y
         eyVtu7WJHbSxbS09MX8/DvcOf2I51yTSrmKEhgGzN3mpKe4qjtUREEzdGFBDLV0iX5X0
         hktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36jpGIQcZ4lU6TqRvBSPN3Oc7gVUnBFQ0lBJ+9WKKcg=;
        b=LB1IeIWv75LmH+Axx6VQ8OcMpiul9YUshXJYEFEcSpi+aWh6wYc33nx/Eqkbnxu8RW
         YzY8n8BqzSXC0Tjp0j3Jf/b8IJaT5Jp7v9Ck4RuGuqQEYmIp6Uv40p2/v2hqqJTb2zXr
         JTuk0RNRU9TkA2wRFbq1BxYbwjOvpgh2136R7Klr+KYC0OBveC5Flx0JuE8hvIzEFtP8
         J9vT2tXzOlZFxXT43ZYyJtHfQGACOo3IQsj/EmcnmmZHaGW9ghyP2KH9Nx3u2MYLg4W2
         Z/zyTp1qp+SMf4LKdpZ8MWn2UWpOn7TebirnHfSRC+bDu3+OSEUGR5i+xLb+4NUMbb2l
         t1yw==
X-Gm-Message-State: APjAAAXd+SOXhJj3qHHv5oTrIDs8O1qYfji+O/UIUlYE3JZXZyir6Q6Y
        A5jIVl+PaOab8fSHWdHS4B0uYhjA7NUVw1Uc/zDmHQ==
X-Google-Smtp-Source: APXvYqyO0WMb0y6EdLj/2mxu5pbnY05u1W4YT8PJ6G6+TwoxewCaTUmBLujPNM+Ngg6p0Nx1tBw0sbvWbk6Wp2rW+CA=
X-Received: by 2002:a63:712:: with SMTP id 18mr1286147pgh.384.1574189292526;
 Tue, 19 Nov 2019 10:48:12 -0800 (PST)
MIME-Version: 1.0
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1573812972-10529-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Nov 2019 10:48:01 -0800
Message-ID: <CAFd5g47f3-k+VxNRAJgfZ=Xr_bMD8huEkKj42U7ybMtb18pbSw@mail.gmail.com>
Subject: Re: [PATCH v4 linux-kselftest-test 2/6] kunit: hide unexported
 try-catch interface in try-catch-impl.h
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>, changbin.du@intel.com,
        linux-ext4@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 15, 2019 at 2:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Define function as static inline in try-catch-impl.h to allow it to
> be used in kunit itself and tests.  Also remove unused
> kunit_generic_try_catch
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Aside from Stephen's comment, this looks good to me.
