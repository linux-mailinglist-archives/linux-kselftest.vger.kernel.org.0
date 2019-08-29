Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD03A0EE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 03:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfH2BaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 21:30:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfH2BaQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 21:30:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so907438pfc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oNuMQ0k3tolgyGaRQrF7TXZFayppiTIHnhst6LSZzgM=;
        b=N0Tiu7A4E04tZ0bGKbShdzjcMamCLdZF8w9OOQK6PqJNfA15z95T1h2MEkAr1QGrkv
         MTmnaoNxMhluJ+2QIg5wgRlKZG4ebI1krbhI2gFwPGhzgjl3Mo9eYwmeXkS342XWdvW2
         6o8joBVW/w2HTRLZcmWXJgsyKzxaDVdpZopFc+IAFxfJItzbjS6MQxV8iMzvMh+wCbxD
         Jlu+YvTpNL5xNRiykc69s779w7U0EiJlNB8fL9OGeoCN3UhQ1qRDkxoOPgj2e9fdO+nP
         rUwqW2dh56+pi8vTJEXJED0sq/nTmn2tjeRp9FDE/GII0XdAAqqoM5RIQmupCWDxlq+V
         rHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oNuMQ0k3tolgyGaRQrF7TXZFayppiTIHnhst6LSZzgM=;
        b=VR5NViAEzocK6y+ykJ1QF07XP+qkwYiJN2hzA8hF3/gXKddlrZsK2Db1+bxagQgbxS
         J8mdaTWUzltMkrX3kFaPFZw5Sdg/LcJqlBZ0QmfgtHpPRmScuHV67WRSjvjfXVcbNj3T
         zJSiKFyeqofFv7BCC6gbV3dDZr8uJiO+wZa8OoqdyNpVzPi3t5tg+/dlmf2gRKJtHl8+
         ViNcSZq3VsE5PkQgPNbcXCnV758dnWs6MUDl8JRxomvRuRyMy6OJHRvK3X/MDtkkrGow
         /7It8Zl4dAB/bNlW2j4bf9Qisjo56byDKy2L0j/rcFtPc0AwfiCaS6SYHZir1BCr2Pa0
         l7XA==
X-Gm-Message-State: APjAAAVsAsqQW5hFziozWr5BmUxHt475mv//5UZubcyMDiENLV4PD32m
        vaoBkduwREo5XXISzrOJ4w2Hcw==
X-Google-Smtp-Source: APXvYqzneWTer11an0OtynaQ0NdmFFtoQFTgNrY29fSA6ajAUSOjqiO56Ptl9fWn/+Jpt6o1LcWHIg==
X-Received: by 2002:aa7:8602:: with SMTP id p2mr8123966pfn.138.1567042216270;
        Wed, 28 Aug 2019 18:30:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y13sm669451pfm.164.2019.08.28.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:30:15 -0700 (PDT)
Date:   Wed, 28 Aug 2019 18:30:14 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>
cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
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
In-Reply-To: <201908261043.08510F5E66@keescook>
Message-ID: <alpine.DEB.2.21.9999.1908281825240.13811@viisi.sifive.com>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com> <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com> <20190826145756.GB4664@cisco> <CAEn-LTrtn01=fp6taBBG_QkfBtgiJyt6oUjZJOi6VN8OeXp6=g@mail.gmail.com>
 <201908261043.08510F5E66@keescook>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

On Mon, 26 Aug 2019, Kees Cook wrote:

> On Mon, Aug 26, 2019 at 09:39:50AM -0700, David Abdurachmanov wrote:
> > I don't have the a build with SECCOMP for the board right now, so it
> > will have to wait. I just finished a new kernel (almost rc6) for Fedora,
> 
> FWIW, I don't think this should block landing the code: all the tests
> fail without seccomp support. ;) So this patch is an improvement!

Am sympathetic to this -- we did it with the hugetlb patches for RISC-V -- 
but it would be good to understand a little bit more about why the test 
fails before we merge it.

Once we merge the patch, it will probably reduce the motivation for others 
to either understand and fix the underlying problem with the RISC-V code 
-- or, if it truly is a flaky test, to drop (or fix) the test in the 
seccomp_bpf kselftests.

Thanks for helping to take a closer look at this,

- Paul
