Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AFD21A9BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jul 2020 23:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGIV10 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jul 2020 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIV1Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jul 2020 17:27:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5871C08C5CE
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jul 2020 14:27:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so1523699pgv.9
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jul 2020 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6+NCDCknn8HOgMcidJ1cpk0+00o/dYEdlgP9Ug2JXQ=;
        b=U0K8hs7/zYjp7v6F9ZR0fL5JhJLp3BIds9vhqJf2265qv/ZHjllCR5v3zSFeia4CsR
         +EOcB437kV+ilxEY9/9dAmY0RNN9e4akCQ+yXnZZFh47RUQ2m07YrVaSJ4saerDfOXxz
         UbCF/9Uvk4aNIDng14O2SKqn/pJ87PuNKcNyIc+x2rKAUMFEObjYSSakH6bIrobp4Ntw
         qqi//hfYgvXoG+ru3XaE4AgodDXYWgilv3R0mumWm8lVsRpqLftnfh0DYv2gisIY2C/h
         38cIIqfAJfwIYqPViwrKxeazgqb58FCQW3W+yr1DKKIFOcn5WJIG/GR4qlUnw1g74olg
         ytbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6+NCDCknn8HOgMcidJ1cpk0+00o/dYEdlgP9Ug2JXQ=;
        b=TWeatfByBokz6YnBgt7sEZJ4Hcasf7ATcDkZKSVh4d/czMmmii2GWQZCoANN4NfWid
         e0izGRByu5Xf8XZCOzXZ4NdzYri8amUOxLLFGwZSlKR7rWy7k6nZ/9n7yHdFDsaH7UXi
         Dpl55UPMJbpc2yiIXNkeSb+a46tO0tadCy8q7rlVe35KTa011HjR4yCjfcJpILUqvver
         IaELxWe9wYrlr5dyFLX6asxr0v436KEE9KisjWnHS5r77T+232KOnkDNki1TpAEIbMen
         UCNhhc7ng4NCgRV4PZHPsfB+oQnMdDKpdBBvYyxQbio75npfwZJVeI9be2RrBGSft4YQ
         yFAA==
X-Gm-Message-State: AOAM533WTETvcbBFC8DwkHVFkksAiwLO04CLLzltKYMozM0FvqnzYU43
        1jxKLRPhshwqBje2w/gnjWOAOD9crQ3Kr/leaVg9Dg==
X-Google-Smtp-Source: ABdhPJx8egPGks6+3+oORiSQ45+RR3TBGylO9r7zpEbA49xi5mzsqd1sWKcvr8LLoluatQ8o7TnwdJ7iJmqu24JCpYo=
X-Received: by 2002:a63:4c08:: with SMTP id z8mr53932099pga.201.1594330045176;
 Thu, 09 Jul 2020 14:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200708213543.1365306-1-chenwi@google.com>
In-Reply-To: <20200708213543.1365306-1-chenwi@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 9 Jul 2020 14:27:14 -0700
Message-ID: <CAFd5g45C8Pn8-QaQxvQaAQcKHEtonw8CFaKEzqUd-ttG0ypWZA@mail.gmail.com>
Subject: Re: [PATCH] kunit: capture stderr on all make subprocess calls
To:     Will Chen <chenwi@google.com>
Cc:     David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 8, 2020 at 2:37 PM Will Chen <chenwi@google.com> wrote:
>
> Direct stderr to subprocess.STDOUT so error messages get included in the
> subprocess.CalledProcessError exceptions output field. This results in
> more meaningful error messages for the user.
>
> This is already being done in the make_allyesconfig method. Do the same
> for make_mrproper, make_olddefconfig, and make methods.
>
> With this, failures on unclean trees [1] will give users an error
> message that includes:
> "The source tree is not clean, please run 'make ARCH=um mrproper'"
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> Signed-off-by: Will Chen <chenwi@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
