Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1121EEB82
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jun 2020 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFDUG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Jun 2020 16:06:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49789 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgFDUG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Jun 2020 16:06:29 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jgw8B-0000Vw-QK
        for linux-kselftest@vger.kernel.org; Thu, 04 Jun 2020 20:06:27 +0000
Received: by mail-il1-f198.google.com with SMTP id a4so4760261ilq.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Jun 2020 13:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8BNrQ5EvO5CN1P54SLRxErq24g55GKkGlzRsUwueE8=;
        b=COmUqmAkUXM472LYFrOo22NJwGCG0QCmZHmVLhdZ6/SdkImh73E27dkRborhBPOeyv
         G0O5+DhbQH7IlxTklgM4p3mihAduF58dbIy4a9oIGnChurV8iFW19qXekH0OiAQPC94T
         b5ndPNoLHGuT90EV3X3y+fXLsF4BZUTgbRwTaSoEWqon8o40Zi6w0CMIrcpVo8Cpzh++
         sITVvlpEAqMrET7dCFTo9J2wUKNE0N+UT58k1zPvkTZiahSHIfeO8fjVwOFZCiysWaW4
         ujqJFSit01R7qX0lSkuKKA1mQ/K0JIHCNKoaBDdnRm2Z91uCZc1C2rOOIw/8Nu7mX+7g
         aw2Q==
X-Gm-Message-State: AOAM5327MtO1xHNInBFngYeTQ3haG2uRGmnSUcejZuKs3Fex9E5K9D9E
        2gmCZM0+rgcJrPDRAvbEV2/eXmI0QZ9Q3+17nki1MD86Xj44ZaaLcKfnBotEHq91WCZBGkcTn5E
        mxBV8srkNJ+/W4cCR9bsk5IZkE8DUhECmUTpl2K9o5/f1/Q==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr5546986iob.103.1591301186521;
        Thu, 04 Jun 2020 13:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbV+LEUf9tEApQ5CzjTpzWgDtZ35W682RhC2YNRXKY30uEF3BNkNH92/6pREx1x5YaL+IOGQ==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr5546945iob.103.1591301185990;
        Thu, 04 Jun 2020 13:06:25 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:2dfd:d485:5170:5d43])
        by smtp.gmail.com with ESMTPSA id z13sm1890628ilh.82.2020.06.04.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:06:25 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:06:24 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Use printf instead of echo in
 kprobe syntax error tests
Message-ID: <20200604200624.GD5650@ubuntu-x1>
References: <20200304222009.34663-1-seth.forshee@canonical.com>
 <20200529203704.GA57013@ubuntu-x1>
 <de431b0e-6337-b95a-15c5-1c0c6abe697e@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de431b0e-6337-b95a-15c5-1c0c6abe697e@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 29, 2020 at 03:26:06PM -0600, Shuah Khan wrote:
> On 5/29/20 2:37 PM, Seth Forshee wrote:
> > On Wed, Mar 04, 2020 at 04:20:09PM -0600, Seth Forshee wrote:
> > > Test cases which use echo to write strings containing backslashes
> > > fail with some shells, as echo's treatment of backslashes in
> > > strings varies between shell implementations. Use printf instead,
> > > as it should behave consistently across different shells. This
> > > requires adjustments to the strings to escape \ and % characters.
> > > ftrace_errlog_check() must also re-escape these characters after
> > > processing them to remove ^ characters.
> > > 
> > > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > 
> > Ping. Someone just asked me about this patch, and I noticed that it
> > hasn't been applied or received any feedback.
> > 
> 
> I pulled in this patch from Masami:
> 
> selftests/ftrace: Use printf for backslash included command
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=8e923a2168afd221ea26e3d9716f21e9578b5c4d
> 
> Looks like a duplicate.
> 
> Seth,
> Is your patch still needed?

Nope, Masami's patch seems to fix the issues addressed by my patch.
Thanks!
