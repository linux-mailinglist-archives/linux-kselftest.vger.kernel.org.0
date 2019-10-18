Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A340DCAE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394122AbfJRQVk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 12:21:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33645 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJRQVk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 12:21:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so4214045pfl.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c9JZSN8H5620nC3cCVnr8OExnXCrnEqW30bH/LbdEfE=;
        b=DgdGU2GAaFqAGEyR6yogfhMtyiU68YPIS/csqCeEevD9VGx73H6IkY/qviecY9dqMd
         ITbjbFn45CElylafIln2kjPFW3CQq0Lll9BQgGQdIBHSwE2wYqUA9/v5dAcW8xrYKrCw
         x5uMd0yIWCJHwvseujAAeRvHoxsK9MEhLtd7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c9JZSN8H5620nC3cCVnr8OExnXCrnEqW30bH/LbdEfE=;
        b=Za9SVUri2CWSxfPv7HH4ELyv8BWaj1L8BLAMo2X0zZ+0G79AMG88XUc2rXCRFmujZ/
         Fpx+tIhnBjqFc8U5ZaSAT1k5DWKYrySgUYzitjACHJ+i+noKiomIbPi7tPOJbFeCPU6p
         6rGQmcaleaqw38XGBlk5HiDBj0/2eRH3T9mYyPkBYZKoZobVKmgYR69Vbg3UqNYxqmIX
         KAqg0jqsYIk9U/Aw62ojJSbtznBWOgr0Au8AJ4O5UN637ymOS8nF6r+xbMBnVFU64LQB
         u4VjL7HP6qp8W/F2IZcfDwL/ZDorDYdVayz6hXrA2TaCy31OF4e8Ger6N0se7YnyTUcs
         wtlg==
X-Gm-Message-State: APjAAAUjQE8al+DFJPr6n5Puv6HRZSErFB+QvPFTHvvW/lJeoBEAg9U4
        2qAMGaRqm2J8I7gHMRrTaxmD8Pt3/a4=
X-Google-Smtp-Source: APXvYqy6qfro9wiwqwP6E9JIe01QZjE+u/6bN8FlTN/OpmnGLQFMB1X7f/Fy45W0Z9yAU592vaaBUw==
X-Received: by 2002:aa7:87d9:: with SMTP id i25mr7945294pfo.244.1571415699752;
        Fri, 18 Oct 2019 09:21:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm7008102pfq.20.2019.10.18.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:21:38 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:21:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Cc:     linux-kselftest@vger.kernel.org,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Bug report] "make run_tests -C bpf" hanging forever
Message-ID: <201910180919.B3D3618@keescook>
References: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 02:32:15PM +0800, Liu Yiding wrote:
> Hi All.
> 
> The patch 5c069b6dedef "selftests: Move test output to diagnostic lines"
> from Apr 24, 2019,
> 
> leads to `make run_tests -C bpf` hanging forever.

I can't even run this, the autodetection seems broken. I have BPF and
libelf installed....

$ make run_tests -C bpf
[...]

Auto-detecting system features:
...                        libelf: [ OFF ]
...                           bpf: [ OFF ]


Auto-detecting system features:
...                        libelf: [ OFF ]
...                           bpf: [ OFF ]

No libelf found
Makefile:269: recipe for target 'elfdep' failed
make[2]: *** [elfdep] Error 1
Makefile:154: recipe for target 'all' failed
make[1]: *** [all] Error 2


> Bpf includes many subtest, when cmd `make run_tests -C bpf` runs to
> test_lwt_seg6local.sh, task will hang and runner.sh never run next task. I
> checked ps aux, prefix.pl will never exit.
> 
> ```
> 
> 91058 [  811.451584] # [25] VAR __license type_id=24 linkage=1
> 91059 [  811.451586]-
> 91060 [  811.455365] # [26] DATASEC license size=0 vlen=1 size == 0
> 91061 [  811.455367]-
> 91062 [  811.457424] #-
> 91063 [  811.457425]-
> 91064 [  811.460912] # selftests: test_lwt_seg6local [PASS]
> 91065 [  811.460914]-
> 91066 [ 3620.461986] Thu Oct 17 14:54:05 CST 2019 detected soft_timeout
> 
> ```
> 
> Ignore test_lwt_seg6local and run `make run_tests -C bpf` again, task will
> hang on test_tc_tunnel.sh.
> 
> 
> Kushwaha also meet this issue, `make run_tests -C bpf` hang on
> test_lwt_ip_encap.sh (This test failed on my localhost).

If it keeps hanging on progressively later tests, it sounds like some
kind of stdout/stderr flushing (or reading) is missing. This is hard for
me to debug without understanding how to have the kernel tree notice my
installed libraries, though.

-- 
Kees Cook
