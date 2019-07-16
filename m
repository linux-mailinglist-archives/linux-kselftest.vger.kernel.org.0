Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F636B28D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 01:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfGPXzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 19:55:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGPXzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 19:55:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so10913521plo.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2019 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NzEY+r09HUC2z4C48p6M8ATkm0m6ysiYYqTSVqgt1QE=;
        b=r0lm8+cFAneRrgEcwxzxGfTvtvluOpA3ESey7YY64X8gt3fRQhUMF/tPGTeEI67+VC
         8dZ3Mx6k0ebH9dAJeaWK9NCo0+7z8Si0r/ZCwwpT7MvCl2SzhYn+Kmzs/kv9C4uppEJF
         FDMOvZ1hgzELkujjJhQMnxXnkHe5FUeIpiuII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzEY+r09HUC2z4C48p6M8ATkm0m6ysiYYqTSVqgt1QE=;
        b=rpg6HqOh1PbEkgDPcvLNEEqtcwL0fMhN62xl5FfqhIws1YCcsllFhmFALdKg15mXjA
         Tip8n6nCvwELCTA8mRpjGqExCFFL9uOlWUD3NC2mj2VWv9oF4Zq/cBYjlyWQgI7ZG7bw
         gR9sG0cB8BPQptCHs1oq/jqh2KhRYW20Z1aE81N9pDuhZK4IOYmJ1vVblRSaKN9Vfixs
         gQo+a9WA1pKL7b9KMK0OY074jMY0hh7Kh07pQKw4jMR0hC/8qElbgyBdOehzGj3zXtnX
         cicMOPY9sutXEfZhUpysTLk/WYGZ0bNIvJWnIAwqzC4Ls2fnYT6Z4N7lotKoZyyzcaJY
         frFg==
X-Gm-Message-State: APjAAAVXOf58Y8dH4NqnL4FU/YmZA8uP9YujkPCBMc/KqZvMFsDl7hFt
        94kou1n+oXJgmjurIcVwjEQ=
X-Google-Smtp-Source: APXvYqwmCIcDYzjgLG0aaoMoodqVucYHLpTnPwPRge5tf+/2LiAcL4ZBidohGTpKLJGf1fMad/8jwg==
X-Received: by 2002:a17:902:7448:: with SMTP id e8mr39106404plt.85.1563321302615;
        Tue, 16 Jul 2019 16:55:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p67sm26885092pfg.124.2019.07.16.16.55.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 16:55:01 -0700 (PDT)
Date:   Tue, 16 Jul 2019 19:55:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Brendan Gregg <brendan.d.gregg@gmail.com>, connoro@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        duyuchao <yuchao.du@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        jeffv@google.com, Karim Yaghmour <karim.yaghmour@opersys.com>,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        Manali Shukla <manalishukla14@gmail.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matt Mullins <mmullins@fb.com>,
        Michal Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>, namhyung@google.com,
        namhyung@kernel.org, netdev@vger.kernel.org,
        paul.chaignon@gmail.com, primiano@google.com,
        Qais Yousef <qais.yousef@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 0/4] Add support to directly attach BPF program to
 ftrace
Message-ID: <20190716235500.GA199237@google.com>
References: <20190710141548.132193-1-joel@joelfernandes.org>
 <20190716205455.iimn3pqpvsc3k4ry@ast-mbp.dhcp.thefacebook.com>
 <20190716213050.GA161922@google.com>
 <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
 <20190716224150.GC172157@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716224150.GC172157@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 16, 2019 at 06:41:50PM -0400, Joel Fernandes wrote:
> On Tue, Jul 16, 2019 at 03:26:52PM -0700, Alexei Starovoitov wrote:
> > On Tue, Jul 16, 2019 at 05:30:50PM -0400, Joel Fernandes wrote:
> > > 
> > > I also thought about the pinning idea before, but we also want to add support
> > > for not just raw tracepoints, but also regular tracepoints (events if you
> > > will). I am hesitant to add a new BPF API just for creating regular
> > > tracepoints and then pinning those as well.
> > 
> > and they should be done through the pinning as well.
> 
> Hmm ok, I will give it some more thought.

I think I can make the new BPF API + pinning approach work, I will try to
work on something like this and post it soon.

Also, I had a question below if you don't mind taking a look:

thanks Alexei!

> > > I don't see why a new bpf node for a trace event is a bad idea, really.
> > 
> > See the patches for kprobe/uprobe FD-based api and the reasons behind it.
> > tldr: text is racy, doesn't scale, poor security, etc.
> 
> Is it possible to use perf without CAP_SYS_ADMIN and control security at the
> per-event level? We are selective about who can access which event, using
> selinux. That's how our ftrace-based tracers work. Its fine grained per-event
> control. That's where I was going with the tracefs approach since we get that
> granularity using the file system.
> 
> Thanks.
> 
