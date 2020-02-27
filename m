Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57D81727FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 19:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgB0StZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 13:49:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB0StZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 13:49:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so295444pfn.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGeaLHlnGkG2EKVANYEasocr4XU2jYAIuDOZRJsT7Oo=;
        b=XyXxJgvedHV34V4WJqX+Hr1W3blvQ9Hasu/MLokQnm07W62Yj4XxYbDLBD+Oub9RHL
         LL1VgVjONRaR6ahJdPhB2b02mAwIwDg/WoQbB1E16zQJR9KVxb5Ap9cDaN80E1YWkkAG
         XMR45E0mtgatAGy5A/oijIwby9+b7QygKEBYrjZw6eRmifq6pJr+8YZrOZMz8yE1RKDT
         JmyvlF7U3P/vmhWuJ56dadoFI1e0Z2fibqXWNajTLAD8CpQm79ErQMfaAn/GHKT7OX+6
         8MB/26+0SzXiBTIZLUOylD6Fe31YzRhW2c6HGUjMrJr8f0CLEWIa1bmvfmteoHDMFg7g
         RpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGeaLHlnGkG2EKVANYEasocr4XU2jYAIuDOZRJsT7Oo=;
        b=JF5NFU7mDQRkVF6+3IH1kbwGhoMW7NzkJCPZ0e/bxg5m9BBHP5W3w3kYHeEWuHlsAa
         F/pQUWo/+qao3ia96mOh3TjzKIu6/J/oI7G9QsniJL9ez9DlrDuZtt6TCD+k5B4WGUNi
         5iDPPyE03v/orrruLBJOQHZ2Fi4D+nPbe9myHPhBcn3gWugInTgTJ3vQmFIMOIJ4se4q
         QIOPvqM10qlrR3ShSC6wN60E+x3H+QAt4ofXVZ0ikg5L+CN0S6bwQDQBAA1wuCD9iq3Q
         D8h3644bo2tcPKzQxF9wB1R5lQYWy5RPAoHY05AVtdUzbSQJd3bWUSsb97w94c6MyZ1s
         g9jw==
X-Gm-Message-State: APjAAAUqsmD7kAu2djSAXMWMqLLoZxSkHHVcdQTAl+r4gVf16Oa/egMN
        P3TW2NgIXCq0blszVHElIe04wgMIXow/YaHv6wil8ZPFRYYHDg==
X-Google-Smtp-Source: APXvYqymmOgdXa7CniObsx9VEGVRv2HX0Gml6mbnSA0rHlXFD0LPmOU7h+ebHH3tu2QnqHoViA3n/JuGoldtb3q0fdE=
X-Received: by 2002:a63:fd17:: with SMTP id d23mr711822pgh.159.1582829364378;
 Thu, 27 Feb 2020 10:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20200227063134.261636-1-gthelen@google.com>
In-Reply-To: <20200227063134.261636-1-gthelen@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Feb 2020 10:49:13 -0800
Message-ID: <CAFd5g45X_jW6=8XZ8JY3iMgO1wc92wec4WsKCqJvDmjss5d=5A@mail.gmail.com>
Subject: Re: [PATCH] kunit: add --make_options
To:     Greg Thelen <gthelen@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 26, 2020 at 10:31 PM Greg Thelen <gthelen@google.com> wrote:
>
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
>
> This allows use of the clang compiler for kunit:
>   tools/testing/kunit/kunit.py run --defconfig \
>     --make_options CC=clang --make_options HOSTCC=clang
>
> Signed-off-by: Greg Thelen <gthelen@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks! This is something we have been meaning to do for a while!
