Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F26EEC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 04:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfD3Cco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 22:32:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43177 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfD3Cco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 22:32:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so9426344lfi.10
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bXLV+X1SboPUgfWfwBzkogeRLHq9rIZ+BOOT2J1Fvk=;
        b=NCQTeCycXmEyoLD3XSPWnZUF+hXdPskjwYAWiIQuU1WhztQQ6dqXbSCj4NSwXP8DWN
         ZjcvtRAgsvdgAc/3KSLAFxaK4kcCHoNxoycA6JsPI8ky1/xJP5BClUWpKZT4TRT9XT4m
         1DJsH/YCVSV0nucpo2++hoaf5DTQ5zm7Bsf9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bXLV+X1SboPUgfWfwBzkogeRLHq9rIZ+BOOT2J1Fvk=;
        b=XHjUrutrgC4fBRHv//58KFz9HUd8ifH9OWhBqWUcNPDSthgRvbkuve/RduB4fm/8ep
         jFbwu1PPXexR73j8+shdRX1dsSdfXQA+v7jNWBWmON8ciizqydHbuh8du/9JWUe2VmpK
         nJwI+/TmHbPGxYzGb0OcMJyCjuwyIevfkPMn2IJkLu7ffJS9llyIqSA+vfCLu06khaxf
         kACs967TdqcsXZwACA+drELJTYr260Ksk5AB/192sunZql1VE5JUmkNEAd3LjG/YFmyv
         5JbimpskP7EDhQQYNud4MjsAQxAVETl5Ekw6Zh1ztUdvKP9mNueKRyLbYcJa+uIG0wwE
         8Vng==
X-Gm-Message-State: APjAAAVlpIK2ZTvu7RqIpHzDpfN54UPj3CPm9RpeoKZhXD5H3rdx9qyL
        +O0SqKHyhQ/fDaSSYRniLoew0IJu8QY=
X-Google-Smtp-Source: APXvYqzFDb8a3d2iU7ZxZjBBVpAE7I18weZk+lI33KUbWLQfsgSHRNnuXHjoNXwbFVECW4yxMWHxQQ==
X-Received: by 2002:a19:6a06:: with SMTP id u6mr35642985lfu.26.1556591561912;
        Mon, 29 Apr 2019 19:32:41 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p90sm1157800lja.83.2019.04.29.19.32.41
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 19:32:41 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t30so9456788lfd.8
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 19:32:41 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr33690036lfg.88.1556591178970;
 Mon, 29 Apr 2019 19:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
 <20190429220814.GF31379@linux.intel.com> <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
 <20190430000846.GG31379@linux.intel.com> <20190430004504.GH31379@linux.intel.com>
In-Reply-To: <20190430004504.GH31379@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 19:26:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXHfVkrO6ftk9FGtAbpCsaEBa+tGrC8qjV6RUJHu+pCg@mail.gmail.com>
Message-ID: <CAHk-=wjXHfVkrO6ftk9FGtAbpCsaEBa+tGrC8qjV6RUJHu+pCg@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Mon, Apr 29, 2019 at 5:45 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Apr 29, 2019 at 05:08:46PM -0700, Sean Christopherson wrote:
> >
> > It's 486 based, but either way I suspect the answer is "yes".  IIRC,
> > Knights Corner, a.k.a. Larrabee, also had funkiness around SMM and that
> > was based on P54C, though I'm struggling to recall exactly what the
> > Larrabee weirdness was.
>
> Aha!  Found an ancient comment that explicitly states P5 does not block
> NMI/SMI in the STI shadow, while P6 does block NMI/SMI.

Ok, so the STI shadow really wouldn't be reliable on those machines. Scary.

Of course, the good news is that hopefully nobody has them any more,
and if they do, they presumably don't use fancy NMI profiling etc, so
any actual NMI's are probably relegated purely to largely rare and
effectively fatal errors anyway (ie memory parity errors).

                     Linus
