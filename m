Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C66317B099
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 22:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCEVZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 16:25:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37791 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEVZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 16:25:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so37152pgl.4
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajV8smT+f8sjiZ+RvnRGvGz6QEWErk3TEm6WtYdFaY4=;
        b=PD4/aQa2ZLv3yStD0yB0ftfKVsfmPuxn8sddykSIcKSP9k2S2SZgmSvtk8Qci/seRO
         zqp5VQs2trR7GQT47cRxPmyfkGpOr1b3cIU7oNlG9BiSxtJ8g9XbFwC7yCzfX0vjbrVF
         vVLzXjnDDrax6SOgUnuX7AYkLp8DzaM6zHAYLTE/oVrRB6KSPxrG6pDr/vYvAPeXAWON
         vk91gC4iqYvNoX0rby45VaGLhvZsdXjuscR6G/+mSMtxAx+6YH/D2Ffeq0wT0uI5M/e7
         h1qNUtTmRaRWW+jieeapG55XxcQO5J+WRABXUC116zlQr85Vfgx3FZKLrL3HZovRQizK
         YH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajV8smT+f8sjiZ+RvnRGvGz6QEWErk3TEm6WtYdFaY4=;
        b=ZtJfiophscPRAXS2T/V8vxC3UnQ3hzRLUt8qG8bqyjbjlfRpGQBKwodSdTGkM2qiw2
         Fp0vyQj25i5J6jl5qeqGZm4Np0RsGV32SFHb261NjlFpjdv0VUgEA/0UMNS+t6Yv0qt5
         pzB69zXWDE8nHzBrzwIb9lp4D4rm2aoXBeV2HguAatPYvT0VNW+fvuZeGYByY2Z+VV3X
         Z/v320IiUcyobhRw177JXV3GHVZZ7lZG1HfK9bNTBnW+odT82KGfVxy1QDVmGgyaUGOc
         ow7k5YFK9hcbUoWzEP//RGlmiGasmO0oYGypwxxzmlFGLVwVNDF2OiolWVoViFvgcm0w
         fjbQ==
X-Gm-Message-State: ANhLgQ3A1nrFYaODN4+3niYzn0CndMuWUIUtUvOVD1mcgnHWZSpauKd0
        Z6X9iIUHjP8O5UEgLDL9uTdHUpiAXhj14XlEPub1jw==
X-Google-Smtp-Source: ADFU+vs/yd8sl8AGOF4udEAV6HbPfrhJNTZpdS0+B2FFxE8/Db+V/XPyzKCC8/zYHslLQzpePU8Xrg+lyAT+TBlzx7k=
X-Received: by 2002:a63:6cc6:: with SMTP id h189mr98575pgc.201.1583443552247;
 Thu, 05 Mar 2020 13:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20200305200409.239406-1-heidifahim@google.com>
In-Reply-To: <20200305200409.239406-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Mar 2020 13:25:41 -0800
Message-ID: <CAFd5g45HSuxcP8_-yaJY4M=Acy14L=FTwY3GT_m-eTVtP6NJhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: kunit_parser: make parser more robust
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 5, 2020 at 12:04 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Previously, kunit_parser did not properly handle kunit TAP output that
> - had any prefixes (generated from different configs e.g.
> CONFIG_PRINTK_TIME)
> - had unrelated kernel output mixed in the middle of
> it, which has shown up when testing with allyesconfig
> To remove prefixes, the parser looks for the first line that includes
> TAP output, "TAP version 14".  It then determines the length of the
> string before this sequence, and strips that number of characters off
> the beginning of the following lines until the last KUnit output line is
> reached.
> These fixes have been tested with additional tests in the
> KUnitParseTest and their associated logs have also been added.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
