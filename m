Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8215372
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEFSMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 14:12:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42113 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFSMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 14:12:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so9841006lfc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QBasbgDBBBZgS2pVJekzI8/+EO3uoHDtSFy2Fyb2GE=;
        b=KY56o2zkPfttJHquP5i+aSm2DJQcYtHn8+L5gH++7lWF4448+Xba0wDZ28VwqzrGv1
         tcq/bdUNFwTDnHCXu5vdwHSNmP7T3yuhy8K9P+M95vYbA5STJOSfgc37VSP/ttbrK7R6
         jlISK8kLlMP2oYwfXqmkLs9dVgVVu51tUvEBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QBasbgDBBBZgS2pVJekzI8/+EO3uoHDtSFy2Fyb2GE=;
        b=WHJgQwPwdtjZYq41SO3Hl5yakSd0unRL6PBZ+Xro/IdaiG7zvl81lISzSva8YU+92P
         5PUUfBfOxl/VRIaGnxgPjn9AUbG7UlgDFA8MMt/5+/70O/BUtCaxHwzE7gCtqES+nNnJ
         nEm/61JGVz0a4REGa1qBlkFq3aokmD1TBBqU0ow+DGqpFqI+PwmwRET2WkQQb4vcZzoC
         7l4itprmmTZxgJ2hRoabYAwGqgGxKpeBDNmdfYBnKdvGGatsrhVj+FFfTTxMbTAVXcHo
         EsDYssaS3s37+iSnir7WktagffWkeAWGDSEYrjNsqaFgmVAmXyJ9IMJvi1flyXEgSnUI
         sguw==
X-Gm-Message-State: APjAAAWCGbkH3lF0FJcjuhuqlvlBxOsqEwy9zol3eAQ+3rfweUsL8GZ1
        VhI4jCSQzxJzWEe4lnvm8SSXRWa4Bcg=
X-Google-Smtp-Source: APXvYqzljtGtyTD/8gGJxi67//4cQf9APN2VNlI/ORO0McQRy6FxidiTN9MV3GLbn6sWSVacj5jWoQ==
X-Received: by 2002:a19:ec07:: with SMTP id b7mr7746108lfa.62.1557166363177;
        Mon, 06 May 2019 11:12:43 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f12sm2604901lfk.6.2019.05.06.11.12.42
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 11:12:42 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 132so4193697ljj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 11:12:42 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr13096464ljj.79.1557166027424;
 Mon, 06 May 2019 11:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com> <20190506130643.62c35eeb@gandalf.local.home>
In-Reply-To: <20190506130643.62c35eeb@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 11:06:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
Message-ID: <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 6, 2019 at 10:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Can you try booting with:
> [ snip snip ]
>
> And see if it boots?

No it doesn't.

Dang, I tried to figure out what's up, but now I really have to start
handling all the puill requests..

I thought it might be an int3 that happens on the entry stack, but I
don't think that should ever happen. Either it's a user-mode int3, or
we're in the kernel and have switched stacks. So I still don't see why
my patch doesn't work, but now I have no time to debug it.

                   Linus
