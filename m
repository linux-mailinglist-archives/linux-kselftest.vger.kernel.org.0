Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D7A08AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfH1Rgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 13:36:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43694 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfH1Rgx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so91891pgb.10
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M47pTZiAE3Wr8BbtgIHsQv1k4WtO4wX2CZjP2HeXAjI=;
        b=LS7sDUBjIS1Uff386cu0zqhDdYqMUwYYKZKmEjwIsi9QTzN89/DsKYkhHeAzX+HiWz
         XUGR2aF5xzEjpRru0i1N004SQj75D1ew2JaMZGVGSMb1w0/XqTl0B3R7YnrgYSZbcJln
         64EK3Y0c7M9n+gQt3BqNXH4dE9RFbDkXKcD/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M47pTZiAE3Wr8BbtgIHsQv1k4WtO4wX2CZjP2HeXAjI=;
        b=LUlifryXrddD5ZqNkLrW5N/fwBzqT1XK+jeiQkCT9aIsLr9hFj8XxH5fVfVo7oEbx4
         5Az5ctO13Nuf3COsMwBQ9MGBbme536/nSRiqg3DLTKcHXoozve+AAolYTd0JvC50mUdd
         p+DsE9H4jguMaAMVnm4uySGRk8GMmtHu3urYwuGs/xQVK2gMEAkISLSCcn+qVle9tGj1
         M4SU+jY43fugl9u1xenijNUtLOoFOJ7pGspk8K7lXQD5EwqllcN/iFTBEhC1/ujaThRt
         FaE0rsQ02n7+MxqaEpXOAUNd3owVfbmPm4bonLoyDrzlMiwFJmqJXxe0dittTvSyv+8P
         DKag==
X-Gm-Message-State: APjAAAVfQS6yfv7QhYTlZGshq9zeJDKo9ZMHFcpW/XCbYLVNEMl3LMun
        j4UjUgmTCH8gIB9RKHYqZ697mQ==
X-Google-Smtp-Source: APXvYqw01wf5KpqvU0SBLWBJjcZSJTFTWWCu5dmEtVFN/KxdMMnVgA4WZSzYIDlb53k7Xqylep0gCg==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr4431758pgc.20.1567013812543;
        Wed, 28 Aug 2019 10:36:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w207sm3832866pff.93.2019.08.28.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:51 -0700 (PDT)
Date:   Sun, 25 Aug 2019 14:51:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
Message-ID: <201908251446.04BCB8C@keescook>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 23, 2019 at 05:30:53PM -0700, Paul Walmsley wrote:
> On Thu, 22 Aug 2019, David Abdurachmanov wrote:
> 
> > There is one failing kernel selftest: global.user_notification_signal
> 
> Is this the only failing test?  Or are the rest of the selftests skipped 
> when this test fails, and no further tests are run, as seems to be shown 
> here:
> 
>   https://lore.kernel.org/linux-riscv/CADnnUqcmDMRe1f+3jG8SPR6jRrnBsY8VVD70VbKEm0NqYeoicA@mail.gmail.com/
> 
> For example, looking at the source, I'd naively expect to see the 
> user_notification_closed_listener test result -- which follows right 
> after the failing test in the selftest source.  But there aren't any 
> results?
> 
> Also - could you follow up with the author of this failing test to see if 
> we can get some more clarity about what might be going wrong here?  It 
> appears that the failing test was added in commit 6a21cc50f0c7f ("seccomp: 
> add a return code to trap to userspace") by Tycho Andersen 
> <tycho@tycho.ws>.

So, the original email says the riscv series is tested on top of 5.2-rc7,
but just for fun, can you confirm that you're building a tree that includes
9dd3fcb0ab73 ("selftests/seccomp: Handle namespace failures gracefully")? I
assume it does, but I suspect something similar is happening, where the
environment is slightly different than expected and the test stalls.

Does it behave the same way under emulation (i.e. can I hope to
reproduce this myself?)

-- 
Kees Cook
