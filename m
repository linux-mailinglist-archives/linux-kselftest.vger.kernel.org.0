Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBA10EE25
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 18:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfLBR1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 12:27:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35497 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBR1S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 12:27:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so217859plp.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VefP/+cQ+dQ/UUR9SD7jeQ4+peUOMt+EfPp6hOKIcqA=;
        b=ZL8dY8guV22Uz06jo26bIIK1QZdQXlb4Tr9ScOe/VmZzsQs3GyGUfryAVSquNR5LWc
         xB0CotyQd3oBvrxauwgl9dJHeZUzrbCNYnPHS5lJ8BXvWdvUMn4hVGkyedG4AGdhmxYh
         xkurDdkUv61x8mkgp9/R0YiWxaamkKstqgkncC9sBElXJWlsAbX1dJTTZU11rs1FSk9X
         sCPbrg8hmikaRJ9r8IX+SGBxFGuEcfTPW41P3qAZxPnbSD+ANqK0jwwHNRwuWppfVFo8
         /QNthVMcvdtDr13co0H+UXGAno6rSHwrPBZZeEdeZRM4q4OF7+tf7MXokB+6B851h+D0
         uMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VefP/+cQ+dQ/UUR9SD7jeQ4+peUOMt+EfPp6hOKIcqA=;
        b=fU9fvHDWN+kG++E0UouCB6IzSBhsbDWZu6vY3YV07pUO66tb+/J+khbxeX/raaB3B6
         3AJeLa/QdhLV+mzbB7OKIh7re5hjk6V8YoNY1hTIhVpYd/8gahA1ZouMBPVHXl88rF3/
         SArNniFQLmUpnEwn0RUEOZsitLVGc1US/bTYrH9JWXGsxY19vbxQQdXGuvtwmkDsZ+FW
         VhiX2V0Mi7ARLM08WMcGi4kosN05+nSR5hDSE2tSflPwkVr1S/Dakf72AerJhXR4Aps4
         J3fSgIh4nKyaKX+PJhdBKEnl6Hs2rQjU086YPX8Bj/qTo/w0CM9MROAfy6aoVpCspsV7
         zKiw==
X-Gm-Message-State: APjAAAVlrQAVgCuv6CqEwjuL2aJEBvNIWEj1cKlo4tLthT5XUFd1Le1y
        RkoWAsWHY576LrI5EdWze4uPGPLkwCFEJEvlKXbwSw==
X-Google-Smtp-Source: APXvYqyo+U7FbkqdkHj8sWUhLZOOwg9M06lpZyP42lIWa4c2IcoppkM4L2SY7TH8Cos5EDfOIIj8q52YDOAY0opCjzo=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr312605plm.232.1575307637383;
 Mon, 02 Dec 2019 09:27:17 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-4-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-4-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:27:08 -0800
Message-ID: <CAFd5g45ofMTq7LA8vticE5bEySD+K0MudE0v2eiTTKzodJ0TDQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] kunit: Remove duplicated defconfig creation
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> '--defconfig' option is handled by the 'main() of the 'kunit.py' but
> again handled in following 'run_tests()'.  This commit removes this
> duplicated handling of the option in the 'run_tests()'.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
