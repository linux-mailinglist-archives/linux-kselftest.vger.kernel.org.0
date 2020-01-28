Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286E214ADEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 03:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA1COq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 21:14:46 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39702 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1COq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 21:14:46 -0500
Received: by mail-pg1-f173.google.com with SMTP id 4so6139977pgd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2020 18:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=DrrSxaqg+xMHJET+xxCFd4AzKeXkcnr9cON2fZed2UM=;
        b=RF9nMOM9cUcTpHOes6fCDFot2ORVBBSCK8xX151vp4yLYwGKEqjk1LuTUbuy/rYMUo
         OB7cLFZX3tiVGf3mh7j55tR2V/wRiwGIYn0Pp4DcnTb7qRrxNvUo99NGQVrNzDg5pkK/
         sSYcAjedIPNO4Uerbz8D6UaaqPtAyKJk0C0pm8A3nO3nfWqjC6PdUCrzye4Xbkpikeg8
         UOjEUmWm5kuJ9uwJphYlQDPai4Dm0JE5K5m3CgLTreFAFGEF7ZvE2dYE1D33MvPeCtik
         jcrDB1UucvsBipSDT9pfMlydmZVMDbaV1fws6wYK9YgRq8dTq5Il0or6opZDw4YxWxwf
         oYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=DrrSxaqg+xMHJET+xxCFd4AzKeXkcnr9cON2fZed2UM=;
        b=tGNpfoO7RoFFhYpsXgXeUhVcwXUxn8rVlbO+u/FwVSGSOgj6hjcV6VIt6pEP11XCy9
         S9IqfTeU20J0PlIWe2mdbRIeJn6WiqzFTC7U6Hs2bxxunn+DgYZCAJ3Njt7nV8g8dG6r
         HbyL05Ep3X8JszGalfIN24zCnCrcv1/pqG+yiIaHJ8LwN4yUObvk7AwZety8HzNfQJft
         DpB3S3KxXG/y3bFyGnX4uC8kvd8xqbLYGZTDfWod8J7EylM5AGdkTc6wvuQimJvp0uFs
         m7UaZZmrVgr97QVRkMhD8KJyFmBTWS1QYHzxt7+3xBhksXOMJqMLhJIqJjRjrDDkRGWh
         6VrQ==
X-Gm-Message-State: APjAAAXXseOsZyElFY6rAGXyxlDLv6KmfZ1Nu5aEB+EkDvAAPLEjWtEl
        XfUvvvBB0izpq5X1yyObfbkj1A==
X-Google-Smtp-Source: APXvYqzQaE82BkrwN8enKVWh7LhvYVblBpdtkI68w4zgo2qGK/PKGkjLJeYUCgcwMaQr9ym7GELY6A==
X-Received: by 2002:a63:ff5c:: with SMTP id s28mr22418848pgk.196.1580177685323;
        Mon, 27 Jan 2020 18:14:45 -0800 (PST)
Received: from localhost ([216.9.110.8])
        by smtp.gmail.com with ESMTPSA id b15sm17010169pft.58.2020.01.27.18.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:14:44 -0800 (PST)
Subject: arm64: bpf: Elide some moves to a0 after calls
Date:   Mon, 27 Jan 2020 18:11:41 -0800
Message-Id: <20200128021145.36774-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     daniel@iogearbox.net, ast@kernel.org, zlim.lnx@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        shuah@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-team@android.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Bjorn Topel <bjorn.topel@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There's four patches here, but only one of them actually does anything.  The
first patch fixes a BPF selftests build failure on my machine and has already
been sent to the list separately.  The next three are just staged such that
there are some patches that avoid changing any functionality pulled out from
the whole point of those refactorings, with two cleanups and then the idea.

Maybe this is an odd thing to say in a cover letter, but I'm not actually sure
this patch set is a good idea.  The issue of extra moves after calls came up as
I was reviewing some unrelated performance optimizations to the RISC-V BPF JIT.
I figured I'd take a whack at performing the optimization in the context of the
arm64 port just to get a breath of fresh air, and I'm not convinced I like the
results.

That said, I think I would accept something like this for the RISC-V port
because we're already doing a multi-pass optimization for shrinking function
addresses so it's not as much extra complexity over there.  If we do that we
should probably start puling some of this code into the shared BPF compiler,
but we're also opening the doors to more complicated BPF JIT optimizations.
Given that the BPF JIT appears to have been designed explicitly to be
simple/fast as opposed to perform complex optimization, I'm not sure this is a
sane way to move forward.

I figured I'd send the patch set out as more of a question than anything else.
Specifically:

* How should I go about measuring the performance of these sort of
  optimizations?  I'd like to balance the time it takes to run the JIT with the
  time spent executing the program, but I don't have any feel for what real BPF
  programs look like or have any benchmark suite to run.  Is there something
  out there this should be benchmarked against?  (I'd also like to know that to
  run those benchmarks on the RISC-V port.)
* Is this the sort of thing that makes sense in a BPF JIT?  I guess I've just
  realized I turned "review this patch" into a way bigger rabbit hole than I
  really want to go down...

I worked on top of 5.4 for these, but trivially different versions of the
patches applied on Linus' master a few days ago when I tried.  LMK if those
aren't sane places to start from over here, I'm new to both arm64 and BPF so I
might be a bit lost.

[PATCH 1/4] selftests/bpf: Elide a check for LLVM versions that can't
[PATCH 2/4] arm64: bpf: Convert bpf2a64 to a function
[PATCH 3/4] arm64: bpf: Split the read and write halves of dst
[PATCH 4/4] arm64: bpf: Elide some moves to a0 after calls

