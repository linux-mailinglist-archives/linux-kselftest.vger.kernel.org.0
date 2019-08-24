Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF799B9AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2019 02:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHXAaz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Aug 2019 20:30:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfHXAaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Aug 2019 20:30:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so6512758pln.6
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2019 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xnR71yxvWSFn7GNIN4j2Fr3rKuwX+n1QmLSLVRDzZPA=;
        b=W2AM6gexTKN/VXcMZcNlCQUd1t7QNxA2cYHEuT6iNPI+LLeisFbLGSp7EFWmfR/GqJ
         ukVzvf47sFPlyUlhrgBgefa3c7ywbe85INX7ypVuklNfnx6nvpvLMTazX+f0PYBsK3j8
         2eFIoiuvEZOQxF2Jqk0NRW4rLxK3k3vp7yuu3KLd805bbiw/GDeFzDlmTkMRh0b+e8u/
         6BdSDVqdKECnS95a+YReAWFtZyA/LxvK8E48vaGRDb5CzKWAI/aSoy+v3zqvrFPazhs2
         BfyBlcWZkL2HrkKyQ5wWUtZpK/NGNqqCX1lpcQrzvqJSlXIl3aUFcEwmhjE1//XwP4sl
         fDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xnR71yxvWSFn7GNIN4j2Fr3rKuwX+n1QmLSLVRDzZPA=;
        b=PpqMm5dCzLvvwvHKTuFnJ3M+K4Pcncq+wctU66rWR8jPHT39JAYk8zaiIp1KBbZVJ/
         FrH7CLnZiHLwBUb/RAR81i/TKhBi9uVCE61ZWB/Kos6gFih0qDRhbf3NSO3B7bm6jp/y
         FjMmJ7uwP1SDWx+P0+T2Wkngfgo9VUJwhhKP4HNZrjgNAI2MDthYPt4U8lKbQY/xQjFp
         5MX7q6e5lKVSzyy7FFUgUjKAb2wC+4R8XWwvBhJhCmWikFuJIjSCppMXzXmAZe14qpdJ
         ksW4JTiSBp8iLBJWQ3cdQ439h2PNq2VWnoh1fxi6HotKgtf1O3bc/ix9QI8dVbpdrMYq
         3+tw==
X-Gm-Message-State: APjAAAXNFUNJrG/NtYCQI9KxkspYeSH2wbSImE+iX5U3/pMvRbq8/q31
        5CD1btloVJHPAM9Xz+ng4j7G0A==
X-Google-Smtp-Source: APXvYqypnIHRw+gX7a2zAkaV+URyBUoTsPo6A6KcuRTTuMEOhltXd4pwHW+VP0k4vY8gZmJbUDCW8A==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr7207697plb.299.1566606654666;
        Fri, 23 Aug 2019 17:30:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h9sm2890450pgh.51.2019.08.23.17.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 17:30:54 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:30:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
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
In-Reply-To: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 22 Aug 2019, David Abdurachmanov wrote:

> There is one failing kernel selftest: global.user_notification_signal

Is this the only failing test?  Or are the rest of the selftests skipped 
when this test fails, and no further tests are run, as seems to be shown 
here:

  https://lore.kernel.org/linux-riscv/CADnnUqcmDMRe1f+3jG8SPR6jRrnBsY8VVD70VbKEm0NqYeoicA@mail.gmail.com/

For example, looking at the source, I'd naively expect to see the 
user_notification_closed_listener test result -- which follows right 
after the failing test in the selftest source.  But there aren't any 
results?

Also - could you follow up with the author of this failing test to see if 
we can get some more clarity about what might be going wrong here?  It 
appears that the failing test was added in commit 6a21cc50f0c7f ("seccomp: 
add a return code to trap to userspace") by Tycho Andersen 
<tycho@tycho.ws>.


- Paul
