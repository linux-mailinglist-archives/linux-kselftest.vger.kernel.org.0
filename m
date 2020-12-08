Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6EE2D30E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 18:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgLHRWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 12:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbgLHRWd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 12:22:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3301C061749
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Dec 2020 09:21:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2so10612605pfq.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Dec 2020 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:references:user-agent
         :mime-version;
        bh=1txzdi4LrtLpEkhyaGd3WhDsio4NPh8e5/se8kxUFmA=;
        b=gEzxnXX4QgdBN1At+xjVEaEAe9lMGJXNhHwJsnH+AnJOJIrf/6DSYsEz9++pANskLT
         TD3iR6d0rgKKP03UfN2ERMwEI9IItHtHN1tcQIApSkfBBWCS+RabKvVmg+5L9G3GzKHo
         BCt6QYeRQCisUImoqbVrWMJoVpuhn/Km4GKB3doBTw/haqw1UW+xrFC3tZseuacaFmki
         VEXY1OwOoQrU5Uj4Ke6bGjwVDXpzfzT6NcRPhOET1CcHg4HN3ZqjfYQIykTWn2CHfWtF
         ppA/i1Yodo0SoqRIgejTHSYPDTi8kPp7s1WAQLfxiPnDwav7N5zj9pHlEPxuVw89ThUO
         AI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:references
         :user-agent:mime-version;
        bh=1txzdi4LrtLpEkhyaGd3WhDsio4NPh8e5/se8kxUFmA=;
        b=rqFhqyriCrJib74YO4VbScT+2p4j/4h1UolnWelQSR0ndRlUoUrEWjeg42RhZmmGyQ
         AXMaJNcZzPJdHgSv0jtmvtvMtkUQ9zrfoBM7Vaf6wSwQNI6/R+IXNJTU76tLYZYxihWH
         av6My/2wMb/M+ila4LuyYB5iPSZQl/bouaFa+G59uaeEx/quGeLkUE9A3vZFzY+n7bWb
         G9falHkX0SsVKmlzfzKaupc7tj+fgwSw60vEIsLUCI261IrcewUIx2PdAv41gyM4DCZD
         F5EmkpKWoQjGJhK88kviQaoY37F6y5b3cy/Dd0SYyHOOLtL/AfMKRLPznpIPbBNXRai2
         dErg==
X-Gm-Message-State: AOAM532lQshJVmzL74t8RQxUp+Ib3qk5HJ+bgwjvgfBptwesBz6Ljqqd
        yinN79FcTI0IG14VBmRnQT11MA==
X-Google-Smtp-Source: ABdhPJyV/JZEtgpK+FuUz+fVYukAiK4A3pbFw67xZzHeNTHEo2u77cIPxBzJzjEVWlvI6OmTRstR7g==
X-Received: by 2002:a63:1d55:: with SMTP id d21mr23041195pgm.324.1607448112434;
        Tue, 08 Dec 2020 09:21:52 -0800 (PST)
Received: from [192.168.0.4] ([122.164.38.199])
        by smtp.gmail.com with ESMTPSA id j14sm7219101pfi.3.2020.12.08.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:21:51 -0800 (PST)
Message-ID: <1b2a426b865df93c6e6d8efe8312b9591a1e4efc.camel@rajagiritech.edu.in>
Subject: Fwd: [PROBLEM] kmemleak: 2 new suspected memory leaks
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     brendanhiggins@google.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     kunit-dev@googlegroups.com, lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Dec 2020 22:51:48 +0530
References: <b65ca811947006b04e6027e30649c263a787323d.camel@rajagiritech.edu.in>
Content-Type: multipart/mixed; boundary="=-T7C4rXS5LInIDXAodK4F"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-T7C4rXS5LInIDXAodK4F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-T7C4rXS5LInIDXAodK4F
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [PROBLEM]
 kmemleak: 2 new suspected memory leaks
Content-Type: message/rfc822

Return-Path: <jeffrin@rajagiritech.edu.in>
Received: from [192.168.1.9] ([122.174.249.115]) by smtp.gmail.com with
 ESMTPSA id i14sm13522636pgm.35.2020.12.07.15.00.16 for
 <linux-kernel@vger.kernel.org> (version=TLS1_3
 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Mon, 07 Dec 2020 15:00:17
 -0800 (PST)
Message-ID: <b65ca811947006b04e6027e30649c263a787323d.camel@rajagiritech.edu.in>
Subject: [PROBLEM] kmemleak: 2 new suspected memory leaks
From: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To: lkml <linux-kernel@vger.kernel.org>
Date: Tue, 08 Dec 2020 04:30:15 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello,


kmemleaks  found. see related information below...

------------x------------------x------------------------>
cat /sys/kernel/debug/kmemleak=20
unreferenced object 0xffff8881105d2348 (size 8):
  comm "kunit_try_catch", pid 139, jiffies 4294898877 (age 6055.628s)
  hex dump (first 8 bytes):
    74 65 73 74 69 6e 67 00                          testing.
  backtrace:
    [<000000001d6f9546>] kmemdup+0x23/0x50
    [<000000007157804e>] unpack_strdup+0xc7/0x140
    [<000000000fcb0a94>]
policy_unpack_test_unpack_strdup_with_null_name+0xd0/0x350
    [<0000000043df290a>] kunit_try_run_case+0xa6/0x150
    [<00000000c069ee6a>] kunit_generic_run_threadfn_adapter+0x2e/0x50
    [<00000000929a25ad>] kthread+0x232/0x260
    [<00000000e5de2862>] ret_from_fork+0x22/0x30
unreferenced object 0xffff8881105d2bb8 (size 8):
  comm "kunit_try_catch", pid 140, jiffies 4294898878 (age 6055.624s)
  hex dump (first 8 bytes):
    74 65 73 74 69 6e 67 00                          testing.
  backtrace:
    [<000000001d6f9546>] kmemdup+0x23/0x50
    [<000000007157804e>] unpack_strdup+0xc7/0x140
    [<00000000ba70df5f>]
policy_unpack_test_unpack_strdup_with_name+0xc3/0x340
    [<0000000043df290a>] kunit_try_run_case+0xa6/0x150
    [<00000000c069ee6a>] kunit_generic_run_threadfn_adapter+0x2e/0x50
    [<00000000929a25ad>] kthread+0x232/0x260
    [<00000000e5de2862>] ret_from_fork+0x22/0x30
--------------------x------------------x--------------->

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--=20
software engineer
rajagiri school of engineering and technology - autonomous


--=-T7C4rXS5LInIDXAodK4F--

