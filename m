Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614272F1036
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 11:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbhAKKgl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 05:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbhAKKgk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 05:36:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA1C061786;
        Mon, 11 Jan 2021 02:36:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so9307852plx.0;
        Mon, 11 Jan 2021 02:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCBsI/I9BYWRCcEQNc0hzhjykYA2RDPnLolTTqvRUro=;
        b=MPjV6oL0bHVVKbxdVwr/jz80SnlkCEsrMAey2CrWpdbrPal895fdfNU/CtgL/xil09
         kLqJ0T959MGMfYrmXp8WEi1jXqgxOraZFUVib284FouWguKSfbt/6i6pI18Q1hoxycvs
         F5qgyl6/V7BDR1ggp9TAzoGVWYg2YNkVRd7C9iYh6SEU+yPJg7PESXkEiUaKoV57Z+UZ
         +2WWjwKt4htE9mmTijUOuEB3/haaoi+OzngUv2D7fdb9uJTrlLu239bG9TPFlwvXwy7r
         vCE64zRpNpll1biCJeTQ3sgr15fmOAYT2H4mp8jsB2HMZ7OO0hd8n0RwcZ0gv+d4MSs1
         50nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCBsI/I9BYWRCcEQNc0hzhjykYA2RDPnLolTTqvRUro=;
        b=IXqRYp8D5/2nkTH635sUxoP659JsGys6d0E/Go2JIhl0znsqJXrYpmowP0FYZ94aMg
         6IWbi/mlxKrLi+QRAPY70pJALOXvq1MOsEasmH/tbdAT50qpKDiPTaPYmRV56DCITgbh
         z3x0RUeAjQX/nAltK9wM1CHFSvtaDoieYG6I097aS4EuWZC89x/7fn5PqZAK1n4V7GCC
         ci8AlfF1Gb4ehtJTy6fVSWliZeyVeQw41khILnXwhSwqQkS7rUka0dhYXqL4RffPQEVd
         Lt8R1Fw10vXbJ1R2jzcGQCJKZjmZqJS9q5Cy2GheGHcP36A3F4d6KFUB0+Fq8hWn9WXp
         ejxw==
X-Gm-Message-State: AOAM533bVRWkiReDgXYU1xx5o09lZ/JDOp9sh7E207v8Y+t8Xs54LokI
        n0hMCpXZqyz7ATiLhT3hOQFWOKY3+T41syQSl8s=
X-Google-Smtp-Source: ABdhPJwHLPzfB64UnO08I/gYtDmYehJDMMwJx3zRFZ57yGxIofK41A/oSADE0gpjrn5nheJ0q9ZCIw+GKRx1DN8T43w=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr15827839plb.17.1610361359970; Mon, 11
 Jan 2021 02:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20201217180057.23786-1-rf@opensource.cirrus.com> <X/wnoJLEt0zQskDU@alley>
In-Reply-To: <X/wnoJLEt0zQskDU@alley>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jan 2021 12:36:48 +0200
Message-ID: <CAHp75VfeccM8D=DT-j4ApPAbDhDgV_M_FKOyXEMP8YBJZMed=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
To:     Petr Mladek <pmladek@suse.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 11, 2021 at 12:28 PM Petr Mladek <pmladek@suse.com> wrote:
>
> Sigh, I have just realized that Andy and Rasmus, the other
> vsprintf maintainers and reviewers, were not in CC.
> I am sorry for not noticing this earlier.
>
> The patchset is ready for 5.12 from my POV.

Thanks, Petr!

I have one question, do we have a test case for that? If not, I prefer
defer until a test case will be provided.

-- 
With Best Regards,
Andy Shevchenko
