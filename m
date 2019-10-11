Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE40D43D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfJKPJ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 11:09:57 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43712 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfJKPJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 11:09:56 -0400
Received: by mail-oi1-f176.google.com with SMTP id t84so8264856oih.10
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJr8HBzMfU7kmiZCz9sHwsjTkr7yVBKTvuMk3ztn6oM=;
        b=bbv7ZbvPGd2Vy+OW6XTx5v8DO1t5PRQQIoAJ3CmOQOCFC+f4NEnTZbLbCAVKBxwxcH
         IIngYatL20o7Of46857CmUx5iKZmPTbazlS1+ULBxf1QsIdSeP/YDKCiDFIN++VIzLKG
         0g2Ja9ORAfWqhWGb2EM0A/6k18qXtfm4iKtWkLaCsxVA8Gv/gw+bMvouYSK8in6vYkDO
         czztQZBwBaxe89EtKiMuvMo6XGe728fyynOUlLtMgZ/Tc968p3+fuly7UgUqljSMnyoH
         LefxFFqhTB19GCYmjNMV6wrAZXtwJg9/Sf8cJapx9ICK8FfZCaBpmPvzdAiF48oOBs3m
         v7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJr8HBzMfU7kmiZCz9sHwsjTkr7yVBKTvuMk3ztn6oM=;
        b=BLd9zenywRuZIDVOKSFU2UfaUQhITfjgNO1ypshRgHjsAdt+iXFFsAkHgYvn6dz54l
         GH+qa+qMHn+zpXiS67kqgdMbr0Xu9BdiD6vMevRLETLKmtZcbbnFs4NIMM8rgrni8mko
         qqheHrWV1+JY9xR8QDblknpePQuCYV+5TeVAZRVnFFXVbzMyN5RTbVzRaLC2QZfobnZa
         DXWtY6UweMOnXTCE1tTIlhDDYc+RoRec4/DvhU3GrDcyf3jlYvjzH8njVyetDn+MgzXu
         at30NmHZZEZkKV6yVfmJglhZQaclW+5S8WdKa6c1+CiJR9hGwNSEqWQkxdeeF2CtPxWd
         fpUA==
X-Gm-Message-State: APjAAAXsZtazcODmvHeiY3z8bb6eZ2jVGAGbiKqqtcovHN/5JxZeWlyp
        1ClSpmVtK44IjnpQpkpVitF7ej56pNmAvDCwjbsMkQ==
X-Google-Smtp-Source: APXvYqxiUBiNWI0ojBaKuc9Wss6TByn/XWZWY72Z0YR+e6hD15VDtY6gxIhOQWm62gzHt+xWgxTf/fn46FfNp0cj1p4=
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr12669138oic.68.1570806595398;
 Fri, 11 Oct 2019 08:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191008133641.23019-1-ckellner@redhat.com> <20191009160532.20674-1-ckellner@redhat.com>
 <20191009160532.20674-2-ckellner@redhat.com>
In-Reply-To: <20191009160532.20674-2-ckellner@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Oct 2019 17:09:29 +0200
Message-ID: <CAG48ez0MyiTKO2MpNVQqavoTKo7FZXYAyohx1JTR=M9Uw=QJWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pidfd: add tests for NSpid info in fdinfo
To:     Christian Kellner <ckellner@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 9, 2019 at 6:10 PM Christian Kellner <ckellner@redhat.com> wrote:
> Add tests that check that if pid namespaces are configured the fdinfo
> file of a pidfd contains an NSpid: entry containing the process id
> in the current and additionally all nested namespaces.
[...]
> +static int compare_fdinfo_nspid(int pidfd, char *expect, size_t len)
> +{
> +       char path[512];
> +       FILE *f;
> +       size_t n = 0;
> +       ssize_t k;
> +       char *line = NULL;
> +       int r = -1;
> +
> +       snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);

(Maybe at some point the selftests code should add some more concise
alternative to snprintf() calls on separate lines. A macro or
something like that so that you can write stuff like `f =
fopen(tprintf("/proc/self/fdinfo/%d", pidfd), "re")`.)

> +       f = fopen(path, "re");
> +       if (!f)
> +               return -1;
> +
> +       while ((k = getline(&line, &n, f)) != -1) {
> +               if (strncmp(line, "NSpid:", 6))
> +                       continue;
> +
> +               line[k - 1] = '\0';
> +               ksft_print_msg("Child: fdinfo NSpid line: '%s'.\n", line);
> +               r = strncmp(line + 6, expect, len);

Wouldn't it be better to get rid of the nullbyte assignment and change
the strncmp() into a strcmp() here...

[...]
> +       /* The child will have pid 1 in the new pid namespace,
> +        * so the line must be 'NSPid:\t<pid>\t1'
> +        */
> +       n = snprintf(expect, sizeof(expect), "\t%d\t%d", pid, 1);

... and add a "\n" to the format string? It's shorter and doesn't
silently ignore it if the line doesn't end at that point.
