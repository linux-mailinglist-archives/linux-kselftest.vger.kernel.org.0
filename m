Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9360E481913
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 04:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhL3Dui (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 22:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhL3Dui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 22:50:38 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1975C061574;
        Wed, 29 Dec 2021 19:50:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v13so20307777pfi.3;
        Wed, 29 Dec 2021 19:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=9ufcOOZj6DSkYrnqVbPAtzoCPF2bpR1xB/9bt+Fbi1A=;
        b=gLNDXxb44nCUde9kyk0DFreZtWSZigIPGMJw+pXv/bSILddeueg2r+zbEUwV7p9pi1
         DUtYtxjmcvzqResD7R55E3TcuxzlyDs8q2FUBUobdDwGujmYp8GrRn5Op0JoOF1XhhGB
         xTv4cbsUly9p7duySCnB0xyGSqgpXBYOmFkFsPW2zXfROP/e2bu7cA0C6SfD3f1OV3aY
         A/XKxYv0Eh54q5m9ExIhcZgs3gzB2JmUKe9iJ1qyjuKg9ilm4t/4lNdlClK1seA7qYcO
         XveJxl3yvKQ0JpEYNKyVcnWprw0pE0Ai01GB6mOEQJfotbW/aUyTOwKAn2n45K+LHDSV
         cvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=9ufcOOZj6DSkYrnqVbPAtzoCPF2bpR1xB/9bt+Fbi1A=;
        b=DJTN+Ts6SfUPyHnmP5NJeEU1L5bvdxNruv4cHEbuzgOI7SgNYlvkD/ETEmy9sUEiqx
         pLZy+g2hz9rFBdZTdpySIS+PLbq1bvx7Mx8R4fUHb8V9XJ9GxMxn9lYPhWWv7s0e/jRq
         HwDN9L4E1aMfS0eam9QdmE3AFv2Sf0sc8enZQjui1E9/2100TNS8H/ZRzLnLNZJ8+E5y
         mTTBBIrVyrMZ3iMDxnpvzjYPV02BgTwiy4nw78dxK+OxrzLWxvJY+/exUZC9cmyKtnhJ
         fjt1seR0uJs5Mohj9bXY0ycGBXcWeWTIjTTgTcJ24dyLjQ5AkNhHhyO/ByFzCA24fBXk
         rHeQ==
X-Gm-Message-State: AOAM533rEPcJ9bC/W1hUsLW3crIJr2N0Jnebw45PLX0yf+uTRlP0gLU6
        fHEIXm4OG24x72lE1dKNH+vjXDZ/La73b9vK
X-Google-Smtp-Source: ABdhPJxGY67BylkZ2HMQnVsKWqo8/dkSZItxGn04J+RyJV/gc1mzsS2UZi8cQkVwiRp51ZG3J4iJhw==
X-Received: by 2002:a63:191a:: with SMTP id z26mr26120907pgl.593.1640836237527;
        Wed, 29 Dec 2021 19:50:37 -0800 (PST)
Received: from [30.135.82.251] ([23.98.35.75])
        by smtp.gmail.com with ESMTPSA id f14sm26196298pfv.215.2021.12.29.19.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 19:50:37 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.56.21121100
Date:   Thu, 30 Dec 2021 11:50:34 +0800
Subject: [Resource Leak] Missing closing files in tools/bpf/bpf_asm.c
From:   Ryan Cai <ycaibb@gmail.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <3772BC47-11E0-420D-A0CA-3F3EF279B26B@gmail.com>
Thread-Topic: [Resource Leak] Missing closing files in tools/bpf/bpf_asm.c
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Kernel maintainers,

          1. In ksm_read_sysfs, the file opened at Line 74 may not closed when going to Line 83.
          Location: https://github.com/torvalds/linux/blob/512b7931ad0561ffe14265f9ff554a3c081b476b/tools/testing/selftests/vm/ksm_tests.c#L74-L83

         2. In ksm_write_sysfs, the file opened at Line 56 may not closed when going to Line 64.
         Location: https://github.com/torvalds/linux/blob/512b7931ad0561ffe14265f9ff554a3c081b476b/tools/testing/selftests/vm/ksm_tests.c#L55-L65

           Should they be bugs? I can send a patch for these.

Best,
Ryan


