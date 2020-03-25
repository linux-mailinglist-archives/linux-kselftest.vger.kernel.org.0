Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9C192F09
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCYRTJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 13:19:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36685 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgCYRTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 13:19:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so1283658pjb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rb8HC6WGsGE44SQ6X/4w8KC/GhzvOIVOOh1NOcuS0o=;
        b=kxiJeYFeSlAM1QBZhriylp7P3+E/0IlkMNbZs5HqHRHVo7fzk8AW0hOIAnuXBZsU+j
         OGdIVimcyjuLURvB/KI/st7FxzLqvk22hGA8quolTPLXu0Pn8KeLJVukPVN0rgDrAnbE
         4zCbNDfg0y3RWmPjpGXr18nxMSvaw+EV5Dm/9Qh7PRAbmt2YYu6v4LHbE79Q1EGvopTP
         hvHIcdzGHUeIEfrhVzndPiShG8Y/EoWEYFBPDoP0tc2KEpITQtmsUTyAQsFuLgjoxzgP
         8pcaqOMQvTncduAOG3JG/ekDM+ms7KLxSpZ3HiRTCqPne9H2f8TMFxvdDuoSneR6DgzA
         9Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rb8HC6WGsGE44SQ6X/4w8KC/GhzvOIVOOh1NOcuS0o=;
        b=DsbHKanL/5zSZrZYlR3ngyeldEGucxECbOlpJcTJZ4I48t/yhi4N0D7pTmf0VA7DC3
         h1C2Lpp/rTP8iFa/7dICtK8IHzkYnaakg/3bOrrJu8zwMzHhzUsSEW+gn1rvRtJ6o9Q9
         xrD5P7t7op8zjbrsIkisTry/RgC5n5r3at0sE3cMjuP+DWVm5sXBIwfQQzR5FFLnWDC0
         7Sv4cfJrtNT6Ixv0tkSnQC2MCAzlnEhwANoUJPhWk8EOFlBfpYj4StWMv02WI/CObU0j
         XOC1qeKS7AmY4SvetxN0dMei4CEanhOBpQIaTet8pP2hFNsyrAl6OWQbLIxFNwS1WpPN
         4oUA==
X-Gm-Message-State: ANhLgQ2TsZPbc1YIWXwB8yfM5VS6QqWIVWwr3dtSsyMD9Y2/TmbMEGI0
        G7yprIypRA1ILbrXBVx2PtIqzgpVZM3ovA6fDE4viA==
X-Google-Smtp-Source: ADFU+vuw8tjfEoctA9OGJGVVEc/U+r3gP9GtmCngawmj0t6q9H1tL86i8ssX8g7CQ3dny0tDhLG62Yx6AgnraK7Qsr4=
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr4220548plb.232.1585156745997;
 Wed, 25 Mar 2020 10:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200324024333.41663-1-davidgow@google.com>
In-Reply-To: <20200324024333.41663-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 25 Mar 2020 10:18:54 -0700
Message-ID: <CAFd5g451jGmh5xocZUOcDnFaSHRVBDnP=BznZ8mKefXV2XJxOw@mail.gmail.com>
Subject: Re: [PATCH kunit-next] kunit: kunit_tool: Allow .kunitconfig to
 disable config items
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 7:43 PM David Gow <davidgow@google.com> wrote:
>
> Rework kunit_tool in order to allow .kunitconfig files to better enforce
> that disabled items in .kunitconfig are disabled in the generated
> .config.
>
> Previously, kunit_tool simply enforced that any line present in
> .kunitconfig was also present in .config, but this could cause problems
> if a config option was disabled in .kunitconfig, but not listed in .config
> due to (for example) having disabled dependencies.
>
> To fix this, re-work the parser to track config names and values, and
> require values to match unless they are explicitly disabled with the
> "CONFIG_x is not set" comment (or by setting its value to 'n'). Those
> "disabled" values will pass validation if omitted from the .config, but
> not if they have a different value.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
