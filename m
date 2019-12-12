Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97F711C219
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 02:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLLBY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 20:24:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46754 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfLLBYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 20:24:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so291721pll.13
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2019 17:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxfmdDL7T65vpl8mxodCbmEtdWkrwaTZC5+tzyhVGaA=;
        b=bRXwJmZHFv0/DvcR8LfYtM1OzaacaOYEZFWDRRvs+auLJumkDckP/tK4HXzXX0EDsA
         5a+xu78dCM+F+leSzcpQcllZzKsh/bltxO7tR0PDqSlBEzwhxPMDZOCjfPxKOdqjMzH4
         hjZKFpu0D9hv3HL6Y6H33Q949WW4CYgG0kQz0l5EwDy9d5WW9JCw0XngN9mLAZAYW/bh
         mD9VlPuPCpzqEdwPBII9BTNK2VTOEj+y0ixQXJX3Xj+qc6MaZ6txvGH5zovaunDkhpeo
         0gZzNR5sxFf+mbnAwvYvp/ZabyNwah5oDZ1c5ZUfoo+Co9G+yemh/eV7s0OFZL8Ix+5V
         j/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxfmdDL7T65vpl8mxodCbmEtdWkrwaTZC5+tzyhVGaA=;
        b=BKI+xap+b5BbIb1yBkeBBTyvNzin7Fn2uRS1rDimcd2lCIYRdvqR4/adxY6HlP/CtH
         F+PwVoAHnaG/zaFG3Ze3dI5gw7kPPAHDPTwyQI1RqJs4u8d2J8wddQZpV2PbnVRemJil
         ksFYK7TffWfmOky6kQi8wqaXfBP8bLyWz0WZGu7olcsKmMVwS+AHmAWvhIkyCACJ3QCk
         J8AELPifuVWEebSIBEcF4GH4Ul/OC0wPaFnyn091339Co4r3JbmA8rP0U7444eN4xao7
         oMC5S7gbUO/y4yKopyPsnkVX7EkD+dvf41v1xlUGfV/UF50ubda0BZA/GrRdxzjBlZuP
         aJEw==
X-Gm-Message-State: APjAAAUwKLtyOjxKMSj4Smkgrkmo4gEUN3rXLsPGZu40ik48lZFo0uAA
        1eC7R7J1/hXT70vg4XKuqMvWTSEUlhnewqD42XcLrQ==
X-Google-Smtp-Source: APXvYqwh1XJUkOPCF0dyTQQeW2Obj5SdR1i9KBjXveDUQi9/tEWPhx3U7JPzGxqbNmrqdb2cgomvPt7qSdwYBUlbqFc=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr6788276plq.325.1576113864508;
 Wed, 11 Dec 2019 17:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20191205093440.21824-1-sjpark@amazon.com> <20191205093440.21824-5-sjpark@amazon.com>
In-Reply-To: <20191205093440.21824-5-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 17:24:13 -0800
Message-ID: <CAFd5g46j137egWyACg-op7q1gQVMhYzbUdG9_a0hO8Zc9By0sw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] kunit: Place 'test.log' under the 'build_dir'
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
> 'kunit' writes the 'test.log' under the kernel source directory even
> though a 'build_dir' option is given.  As users who use the option might
> expect the outputs to be placed under the specified directory, this
> commit modifies the logic to write the log file under the 'build_dir'.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
