Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846252F6FBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbhAOAvu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbhAOAvt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:51:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844CC061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:51:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v3so3802967plz.13
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LK99iLF5P6tsrw5OA7X+pp8fm+cTT9/GqtRKEHMO/1A=;
        b=H4YfAppvSpecP86zHQORolAu+8hkTyMyUHBr9kgO0sSLctV570+6saV7UQe056Ieqi
         z+MQYST+dFfVzvkqxbhXbIzz/NZ9EzYOyhyOP+xwlUSaYp/uT6OFOkjm1VHev0b+CfVM
         BEaTqIiyzmjUwPeqbyEdjsB5qmBXx/IAutN5hFOjVcioMFAXyCohPkATNItHfycnj4MO
         ZZ6iE03hLVSii8tNfFieXhSlKAKBB9EdfHG+kFdngYv+/EMSfoV3ICrwVaxi4JdTCwyC
         DQIuXOji3UGflQVz1HtNTRfo3615Q+IgBuRNfflImr2yuuh8B0upc+SpmOcNTbEOMneG
         +ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LK99iLF5P6tsrw5OA7X+pp8fm+cTT9/GqtRKEHMO/1A=;
        b=l2HWzIxlsJT8fd/r8yeXy1wjLE2mT6K1zPGa8JZjoCEU7w38yzZxJfihAGK1yEJSWB
         iBWCnqL/td6BHmnMjhhNegK1dngfgv9HdsIEdhpfdeeGjHaiQzPJNy3oTnnLGhtLBJFf
         AuII0ln5Byz70geHcwEt0VG+k4C5JZ2AhCCoT9Llh3BlKcbzPIH85By/gaQPhMUWOoY2
         o2VkRnEw0/ximBnd2CLGCsWL+2H8fZRsJ9UT+9tKpqh8O0AwieGqWKzgPFwFTBw+SSia
         vhSb9QCzsyE9prW7tD3GW00lUr8uCN42uuObPdlQiUrzF3p/I404W2nrurLVl0yaQkY5
         UmDA==
X-Gm-Message-State: AOAM530zYmVt8Q3+irDhcOoKZd1OLSvJOYdu04jhWk0IrfhF1e/UfG7n
        y49w5goKA7kLUR9maFXqueU3nQtdIgwJxMoVrh0V1Q==
X-Google-Smtp-Source: ABdhPJxyZMXLWrvbbKiIyJ54pvieEW7ENKXC2rbQWffZ4Cj/9OM4fZsIU5N154v54Ij4feu4HNQD9YqgqdSlqJy25dI=
X-Received: by 2002:a17:902:694c:b029:db:d939:1061 with SMTP id
 k12-20020a170902694cb02900dbd9391061mr9978843plt.80.1610671868956; Thu, 14
 Jan 2021 16:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20210115003913.1406896-1-dlatypov@google.com> <20210115003913.1406896-2-dlatypov@google.com>
In-Reply-To: <20210115003913.1406896-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:50:58 -0800
Message-ID: <CAFd5g44TvORL0JteComXgS-G_JdgYW6nYako01oH6bENXdKESQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kunit: tool: fix minor typing issue with None status
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 14, 2021 at 4:39 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The code to handle aggregating statuses didn't check that the status
> actually got set to some non-None value.
> Default the value to SUCCESS instead of adding a bunch of `is None`
> checks.
>
> This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
> fail test suites if one of them is empty").
>
> Also slightly simplify the code and add type annotations.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
