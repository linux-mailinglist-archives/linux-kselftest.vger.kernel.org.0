Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F328103CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 04:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEACGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 22:06:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47039 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEACGd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 22:06:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so12164866lfj.13
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmXNfPLOFbb8hAF6Vl5xp7lQQxPxX9F/tPvuKsQzATU=;
        b=Uv7TmbDCtMO9OVF1wwQKKT6KJaz16R9pk7p/lUNKiKQoViWyOjhOShjt1rXzEbmmks
         pmlBHurjILNX0wuRZI3kdDTmXE+0EIMcNfEle/j05RKDoGD+a48SSxnYFMopH7Zi/0N8
         k24pIeuX0qpCiaq30SlxmkHDKBRv2OvNH9Mws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmXNfPLOFbb8hAF6Vl5xp7lQQxPxX9F/tPvuKsQzATU=;
        b=TjrnergF7PilOGBqu70VV+JddW/nvuHLNr640LpOMxHLrCThO59D7WmpJTMRdjZQj3
         YFfol74q5Sfu39bG9Nw63qWd/+gQufVu4r+txp3j2EkdshzG4na2vbbYBTfM2uW5ipwP
         GccNg+sSbItrXmJTZ/XbG7mAhAVwNdMR4mbMk+kjmSSbYKfE8xTtymbOjVyermFxhwbI
         DIDDq1gI8ttYXnw06Tk+0HBKCbzNwdtIIq7bUoP3WtqzwOJPziP9SOWGhZWssh3iByV/
         W+2rIh66D0VV7jOoUsUvJLftmhpwdA8oGe08Zc5+UK4kT6j/LVDVEvv+JjF/NNbjVrLZ
         8EGA==
X-Gm-Message-State: APjAAAW6hKHaAwcVj2kjBX24mjvoLBaRxyYf7fHcKcunQx+Yy8G3iq6W
        4YqzpY21CWS7nCYAb5hxwwPdwzetIPI=
X-Google-Smtp-Source: APXvYqxJBlYqRzrPyiEPUU0oC8QzOJw+oSGbVI29vKuTfZIyumGck8vrN4yLOIzPFNrrKFtu8Sb3Qg==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr13841880lfg.133.1556676390568;
        Tue, 30 Apr 2019 19:06:30 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y10sm3782586lja.71.2019.04.30.19.06.30
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 19:06:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t1so4445337lje.10
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 19:06:30 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr34056779ljj.79.1556675903960;
 Tue, 30 Apr 2019 18:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190428133826.3e142cfd@oasis.local.home> <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net> <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home> <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home> <20190430175334.423821c0@gandalf.local.home>
 <20190430213517.7bcfaf8e@oasis.local.home>
In-Reply-To: <20190430213517.7bcfaf8e@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 18:58:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpS92oz-FkzaVdTEXVMre1NQioiLfqyEYYkmrVoVvgzw@mail.gmail.com>
Message-ID: <CAHk-=whpS92oz-FkzaVdTEXVMre1NQioiLfqyEYYkmrVoVvgzw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] ftrace/x86: Emulate call function while updating
 in breakpoint handler
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 6:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Probably easier to move it from inline asm to ftrace_X.S and use the
> lockdep TRACE_ON/OFF macros.

Yeah, that should clean up the percpu stuff too since we have helper
macros for it for *.S files anyway.

I only did the asm() in C because it made the "look, something like
this" patch simpler to test (and it made it easy to check the
generated asm file). Not because it was a good idea ;)

                 Linus
