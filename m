Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1092F1CBA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfENPRN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 11:17:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42669 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfENPRN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 11:17:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so19656797wrb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kIhiqSMek0R4jDQ4M9fJjcqpAO0J7pAlAP0TmoL3YBU=;
        b=MWKf30+ckK2l4pIoW7kmWtx0es9Q5LydNiOLlasRlMt5eVKvpCpZc1Db8FeOn/7Lca
         qBezESV/vORAvhPKmSV37sHHSK9cL3DplJpiDhpdjicctYGm3kw5k4Eh4qT4ukjCZXRw
         8rpBWLBIXU7Zsz5fnrEvg5D3kl0yrssWtkueTsqB6u2hl5hq3S+uo5NVFQ9xcMVbaTkz
         QyNo/KspyptmClPv1NQdhYQlGUSmumdr8NwTJBp0m8TsbnugH49tZpIlkDTA6pLgxneX
         wuqZQZBdUcO3SgCnviUzoEIGYPmEb2dJco+lIwVACT+CTQnnSeZMqye7snSdWtlHPKOL
         nfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kIhiqSMek0R4jDQ4M9fJjcqpAO0J7pAlAP0TmoL3YBU=;
        b=XDRpvircDTnR/93QM96oi317qvJsixh1M7sjKkYotwsZIj1IJ41xjjgQxbWupkbB6C
         +Gv+E675coREMtkAOOhlVc9WPh737g8d5PPPHxjMk3u9JZPOaKZJgdLnlRGtbCR0Tm9D
         JCxWAcRPgA45twaaQYgDKZYLG3k50AD8SSVhAsdOIkUp0rV+Df0Qf2nOTyzEkkMK+NMV
         TbGmi3Vhqko5jTnf1w3hWkcuqikU8m20eQRpNf9L6qJqJq2Pz6l7Nc+xkHJLa1m7X2Yr
         xet1581LWItqQ0RGVIX+l0SN65LSHe1bWaft52B0g/KJbQDO0y4r1B1Ha4vZxE+5rGO9
         eOlA==
X-Gm-Message-State: APjAAAWojdIpMtawqMGPo9gMy/kD1On74UhuLOJD9hZvfEGwRVGjTXtg
        Z7ql9h//bQ9zGr55Uf2EfgAlyw==
X-Google-Smtp-Source: APXvYqwCt7I6lKBbVuVId5vRnhcFO7AfYJ93Tx7KMbKIS0tzJIR8arNbE4x5QxA2wyowIBcK6cEJYg==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr6473204wrj.262.1557847031802;
        Tue, 14 May 2019 08:17:11 -0700 (PDT)
Received: from brauner.io ([81.92.17.147])
        by smtp.gmail.com with ESMTPSA id n2sm29139738wra.89.2019.05.14.08.17.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 08:17:11 -0700 (PDT)
Date:   Tue, 14 May 2019 17:17:08 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Colascione <dancol@google.com>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Murray <timmurray@google.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 2/2] Add selftests for pidfd polling
Message-ID: <20190514151706.fu7ehba6hsxnvfaf@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190430162154.61314-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430162154.61314-2-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 12:21:54PM -0400, Joel Fernandes (Google) wrote:
> Other than verifying pidfd based polling, the tests make sure that
> wait semantics are preserved with the pidfd poll. Notably the 2 cases:
> 1. If a thread group leader exits while threads still there, then no
>    pidfd poll notifcation should happen.
> 2. If a non-thread group leader does an execve, then the thread group
>    leader is signaled to exit and is replaced with the execing thread
>    as the new leader, however the parent is not notified in this case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied to 

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next

and targeted for the 5.3 merge window.

Thank you all!
Christian
