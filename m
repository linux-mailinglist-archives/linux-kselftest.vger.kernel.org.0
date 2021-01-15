Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D684F2F6F74
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbhAOA1Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbhAOA1X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:27:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427EC061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:26:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c132so4915055pga.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrR4pCt2QpQ9EObd7CgJ7W4oxOaFcsdsZorMfy/tWv0=;
        b=tWHF9b7E+s658hVcVQWZ7xA7N39BrCFFPLzoS0ymT8X3+KazjEqdCiYhzgz9fN9qj+
         5dWtOWUIgnrqGVT6/86ihJfKIkeqRsfBWheF6ZeIgyqkaBFkA2KzRM2PK8887qeFpz5h
         hbajFFpi8WKfnzNsAv2zg3gIW3RTfGPf5Pvo47H7g+3eErORkbVzZI46rnsN5uxigBZ5
         isJ8CIrkjq0spXsL0L8vpa3Nz6MwJDiKtgSKys9I8xD6q/PgAAvbWmWNmDYU7neWVaVm
         iJ0WQbCPnbVPXPUR9CoOMJkSH1gk8xO58aKcdt1OWq9T5qYgLbhc3fQd+wFiQ5SkZivR
         q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrR4pCt2QpQ9EObd7CgJ7W4oxOaFcsdsZorMfy/tWv0=;
        b=bNjrkiSg5geHVb8KLBhmyxirBkMIUNQpJ2sTeHpNCYkE02jQdor7juXzBMAFhysFbv
         sBLKRRUtiFYgOdAeLItfACnUttP7uvLYPJd08+/5pM/gQ/la3do8EhMmPo8ZK0AVs8+i
         0Mjw0kLUdhDFPxJl7EiLDlw1yLCa8rOz4jSn3Vp069jw+upC8iMRaI4MXTmCxl24c+EJ
         xFkpzS/RJayDhGD/klsikunsmOd9Hy+LIpA+3qmVzsyBAKcqXLLGeFzodH9mP5J+sr4B
         e3tdntcpYRE2jgazbBs5iveV243ZNMmja2eK+rR1QAr4PIWx4kavmpQHZF2m41/LniRk
         78yA==
X-Gm-Message-State: AOAM532Pp78kZDURIlRwrjPilc7AMkwCYFjnpQrzD4WtKnTji3vkfwQI
        j5Mopqr8asQu4wQlJj55mHyzQiXOq90EjadF6KAkQv44Wo851A==
X-Google-Smtp-Source: ABdhPJxu3zfPxFZyoIathC3722ixEjnt64UfpFHbWXcvYgdgtrv91Naw97mNoXKEslKAcpYV6r3ZPMILsPZntqZb7R0=
X-Received: by 2002:a63:5d7:: with SMTP id 206mr10239836pgf.384.1610670403049;
 Thu, 14 Jan 2021 16:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20201211223232.697679-1-davidgow@google.com>
In-Reply-To: <20201211223232.697679-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:26:32 -0800
Message-ID: <CAFd5g45xaOE0KOeOoHzY9NsJRbtDUimto1rDs0+aD6hw4zbogw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix spelling of "diagnostic" in kunit_parser
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11, 2020 at 2:32 PM David Gow <davidgow@google.com> wrote:
>
> Various helper functions were misspelling "diagnostic" in their names.
> It finally got annoying, so fix it.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
