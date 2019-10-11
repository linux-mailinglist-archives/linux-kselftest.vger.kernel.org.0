Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F7D463B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfJKRIx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 13:08:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48859 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfJKRIx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 13:08:53 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIyPK-0004El-S2; Fri, 11 Oct 2019 17:08:50 +0000
Date:   Fri, 11 Oct 2019 19:08:50 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Kellner <ckellner@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Kellner <christian@kellner.me>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] pidfd: add tests for NSpid info in fdinfo
Message-ID: <20191011170848.nbfxzzl5qckkshkr@wittgenstein>
References: <20191008133641.23019-1-ckellner@redhat.com>
 <20191009160532.20674-1-ckellner@redhat.com>
 <20191009160532.20674-2-ckellner@redhat.com>
 <CAG48ez0MyiTKO2MpNVQqavoTKo7FZXYAyohx1JTR=M9Uw=QJWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0MyiTKO2MpNVQqavoTKo7FZXYAyohx1JTR=M9Uw=QJWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 11, 2019 at 05:09:29PM +0200, Jann Horn wrote:
> On Wed, Oct 9, 2019 at 6:10 PM Christian Kellner <ckellner@redhat.com> wrote:
> > Add tests that check that if pid namespaces are configured the fdinfo
> > file of a pidfd contains an NSpid: entry containing the process id
> > in the current and additionally all nested namespaces.
> [...]
> > +static int compare_fdinfo_nspid(int pidfd, char *expect, size_t len)
> > +{
> > +       char path[512];
> > +       FILE *f;
> > +       size_t n = 0;
> > +       ssize_t k;
> > +       char *line = NULL;
> > +       int r = -1;
> > +
> > +       snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
> 
> (Maybe at some point the selftests code should add some more concise
> alternative to snprintf() calls on separate lines. A macro or
> something like that so that you can write stuff like `f =
> fopen(tprintf("/proc/self/fdinfo/%d", pidfd), "re")`.)
> 
> > +       f = fopen(path, "re");
> > +       if (!f)
> > +               return -1;
> > +
> > +       while ((k = getline(&line, &n, f)) != -1) {
> > +               if (strncmp(line, "NSpid:", 6))
> > +                       continue;
> > +
> > +               line[k - 1] = '\0';
> > +               ksft_print_msg("Child: fdinfo NSpid line: '%s'.\n", line);
> > +               r = strncmp(line + 6, expect, len);
> 
> Wouldn't it be better to get rid of the nullbyte assignment and change
> the strncmp() into a strcmp() here...
> 
> [...]
> > +       /* The child will have pid 1 in the new pid namespace,
> > +        * so the line must be 'NSPid:\t<pid>\t1'
> > +        */
> > +       n = snprintf(expect, sizeof(expect), "\t%d\t%d", pid, 1);
> 
> ... and add a "\n" to the format string? It's shorter and doesn't
> silently ignore it if the line doesn't end at that point.

Also, what Christian just told me and what I wanted to suggest is that
we add tests for sending around pidfds and reading fdinfo too.
