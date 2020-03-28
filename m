Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93D1965CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Mar 2020 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1Lbv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Mar 2020 07:31:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59310 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1Lbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Mar 2020 07:31:51 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jI9gr-0003tD-Am
        for linux-kselftest@vger.kernel.org; Sat, 28 Mar 2020 11:31:49 +0000
Received: by mail-wr1-f71.google.com with SMTP id y1so6102665wrn.10
        for <linux-kselftest@vger.kernel.org>; Sat, 28 Mar 2020 04:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qqy0+XOT8WqhQrltX5gCRS9oS4phxUfRkeGmoD35Mjs=;
        b=fQyvlnbXJjeX9ByFFnmMZgMR3q+OhAuHadVloDqTw22X3wkXOYswstMxS+dtykmBd0
         gHgaEl10UvQbvILt4vQNP3uhwq8+i5VsKKNYcOf75v9nCMC8jeORZwQUWwZOw9kabwz7
         8EPNYjd3m3goZmzNr2WLZd2eRc8ra51VMOoJBwrfz+V89voyxcZ3BLxL3hWKfH9XcqoS
         W3RNZqpdPJ+rzvyEX+aWOuUXCZd258zyNJJRcdAWFvzp0S80c0lXIPSz1gdbM6lf3yHx
         jMM3dqRvQKiMQ98W2iWNx6jXN1Uwd/IUblgxalomZ7rzprOfddYBmhEFv8P3lRcpnSPy
         dWbw==
X-Gm-Message-State: ANhLgQ16nHspIfPbfvjs9k2+3tQAfXHbBIz30JBBBCBK5keK58/mScJF
        LHI4A40NrAKEqa1XVdSNnszNHOzO+ePnjlY3EwMzG02JFPn9eRMWgsjsNoBNCWA2u1FzzBBcTOw
        8/psi38gcf0vf+KLlSNZqdUjDBgEoH2+t2Xe7Xu41gfxCgg==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr3551438wmj.156.1585395108832;
        Sat, 28 Mar 2020 04:31:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsG1dGyA/RHZAnl+8bj6tF2K1BBKGwMYgS9zLyphO5tObGfhkWizV9l3ZWrySWsH7pMn9qEzw==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr3551418wmj.156.1585395108528;
        Sat, 28 Mar 2020 04:31:48 -0700 (PDT)
Received: from localhost ([95.239.127.44])
        by smtp.gmail.com with ESMTPSA id o14sm11692573wmh.22.2020.03.28.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 04:31:47 -0700 (PDT)
Date:   Sat, 28 Mar 2020 12:31:45 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <20200328113145.GB1371917@xps-13>
References: <20200327093620.GB1223497@xps-13>
 <202003271208.0D9A3A48CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003271208.0D9A3A48CC@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 27, 2020 at 12:28:05PM -0700, Kees Cook wrote:
> On Fri, Mar 27, 2020 at 10:36:20AM +0100, Andrea Righi wrote:
> > Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
> > (disabled) in the "settings" file for a specific test.
> 
> That seems to be a reasonable optimization, sure.
> 
> > NOTE: without this change (and adding timeout=0 in the corresponding
> > settings file - tools/testing/selftests/seccomp/settings) the
> > seccomp_bpf selftest is always failing with a timeout event during the
> > syscall_restart step.
> 
> This, however, is worrisome. I think there is something else wrong here.
> I will investigate why the output of seccomp_bpf is weird when running
> under the runner scripts. Hmmm. The output looks corrupted...

Running seccomp_bpf directly (without using runner.sh) shows this error:

 $ sudo ./tools/testing/selftests/seccomp/seccomp_bpf
 ...
 seccomp_bpf.c:2839:global.syscall_restart:Expected true (1) == WIFSTOPPED(status) (0)
 global.syscall_restart: Test terminated by assertion

Instead, running it via /usr/bin/timeout (with timeout disabled):

  $ sudo /usr/bin/timeout 0 ./tools/testing/selftests/seccomp/seccomp_bpf
  ...
  [ RUN      ] TSYNC.siblings_fail_prctl

It gets stuck here forever, basically it's during the execution of
syscall_restart().

I'll investigate more later.

Thanks,
-Andrea
