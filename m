Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54922CE8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXTOw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 15:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXTOw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 15:14:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D33C0619D3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 12:14:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n5so5850021pgf.7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=7JZ2S26Mp9HFKKvrUwOtENSEqxbfxMtN/9CIzPVhh2w=;
        b=T2oFlEz4TmvdMXwnuWclbVop08KevXuDeNhfrLS06CL3ZiHmJWsBn5Cb9f9boJrAl9
         yek+a3n2GJrDuUvWm3dukkMFLlHEUmhN6XmS/yfdAfpIbxrvd+RIvJACpKZQhis4XCaA
         UNZtyGxRhnctin/iEfYgLqR0UDrcjbouCeG2faWlYKnLNKB2jOKEBHpG5+5R1raBB1h8
         kHkFrDhlekPf/H8rKw5AJuca4TMPy/9bWklIaAO8SXRaiyAT8L9ub9ILq9Rsy123mg9C
         2SE6fekXvjxI+AItrdzwO+YgKcPX3Q5Ga7PVWvQXxnuuuk78/tuRnysrKaEjtPE0vrgn
         ezyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=7JZ2S26Mp9HFKKvrUwOtENSEqxbfxMtN/9CIzPVhh2w=;
        b=qnvVj6XSFCrTzouJNBPm0BmiW7rgHHr4K3lvvakXrmp1LWGK9V6/g4gVSATt50CUer
         m/p2XmkP1+2ti0c1MidmdbkDvfsQtSMpGKAclwF7vspKc1lZ/Rp0KGh6MaJTAhnhTwYu
         o6ee2sZbt9MVpQvpdUviix5Em5neDPe+hWPga/fNj9sdgd5ktXq2nSZKtEYcrU/KBY5p
         6uAQqKxUF61zDqoQy1KQUU+MSD7MMWFgfYAMGUGCd/Z4q112qKoQwdIBhCCS+aY4ieQn
         WYNgFMlqY6NPD5a9XcfSVdbrvcltdd+yqQt7gz4RO62idVp7zhsQiBHbiZbHPW/deiu2
         Q8bA==
X-Gm-Message-State: AOAM532p2ROuMkotQmWbul0erpf+7iZEHI2n8gIf0CMl0FlvgVKrCAvW
        OdfhO4EA9YiDBqEkkU+teEggk9eAJrCs/Q==
X-Google-Smtp-Source: ABdhPJzYYHxQFb91TxlM/O7d/Itw0yDY4TRuOPM2GHM1HMgFpb901OKrg7gEeJrWU5NmLwn+WpLXvw==
X-Received: by 2002:a65:448c:: with SMTP id l12mr9615873pgq.234.1595618091724;
        Fri, 24 Jul 2020 12:14:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f131sm7121832pgc.14.2020.07.24.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:14:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     automated-testing@yoctoproject.org,
        linux-kselftest@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Sasha Levin <sashal@kernel.org>
Subject: CFP open for testing/fuzzing microconference at LPC
Date:   Fri, 24 Jul 2020 12:14:50 -0700
Message-ID: <7heep067yt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Linux testing enthusiasts,

The CFP is open for the testing/fuzzing microconference[1] at Linux
plumbers conference.

Please submit your ideas for discussion topics usin the LPC CFP tool:

   https://www.linuxplumbersconf.org/event/7/abstracts/

Click "Submit new Proposal" at the bottom of the page.

There are some suggested topics in the MC announcement[1], but feel
free to submit ideas that are not on that list.

And yes, LPC will be virtual this year as announced on the LPC blog:
https://www.linuxplumbersconf.org/blog/2020/linux-plumbers-conference-2020-goes-virtual/

The tools and logistics are being actively worked on, so stay tuned to
the LPC blog for all the details.

Thanks,

Kevin

[1] From: https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#tf-cr

The Testing and Fuzzing microconference focuses on advancing the current
state of testing and validation of the Linux Kernel, with a focus on
encouraging and facilitating collaboration between testing projects.

Suggested Topics:

    Next steps for KernelCI (data formats, dashboards, etc)
    Structured data feeds for cross-project collaboration
    Integration with kernel.org tools (e.g. b4)
    Continued defragmentation of testing infrastructure
    Better sanitizers: KASAN improvements, KCSAN fallout, future plans.
    Better hardware testing, hardware sanitizers: how the USB fallout was handled, are there efforts to poke at something besides USB?
    Improving real-time testing: is there any testing for real time at all?

MC leads

    Sasha Levin <sashal@kernel.org>
    Kevin Hilman <khilman@kernel.org>
