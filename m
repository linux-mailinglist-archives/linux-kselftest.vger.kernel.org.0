Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23E1A08BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfH1RhK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 13:37:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34081 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfH1Rgd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so264509pfp.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBNYDOQLiPHI747g3CvJSLTMKiFZvSX4+F+h+ZK0RGk=;
        b=hBpwGl91JHahbLFCmv2w1Mjzc7Oz3kRyNRNlfokM3jA96+3Z6siqSGJK3qXqEvZYXw
         209fRwW977JPTkPz9WVu94EDq8zT1usK2FPzVbiynFtN99nMvFDHeFEXObaCht1TcFgd
         4xrqVdOp6iVorPHpgxumzhQ/jyb1V//MFBv7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBNYDOQLiPHI747g3CvJSLTMKiFZvSX4+F+h+ZK0RGk=;
        b=nT2hDs9s7VENnVO/zH2ABwvp4I+u71QY6CUkh85ffufYPKeb+yvyU3GS9AC9xVtool
         EbmBY17MlZBBsDWbAC3ip7qW+om76n7q/ToAWS5Td2yyfVvVPaqC6X7vOfrKUZSjB6BN
         ZT3NNpsH0cBTxFXPw3XQn0D7GzP8J4I55Nz39trP9rYFz6YbGi9P6eQphxtJWJTXGh6Y
         w7oNDFifoETxL4P9C1sixOwR2I7RLUfVKqEPlgT4d/fhMwU4SHJaGU4EhOM3L0QjcjRo
         ov7d9FHg2A3Tl5wmIFl1jDPiUxyVwS7As3AVprdTNUaddn2R+4UsDKxYUL1ltT9qvY78
         xa7g==
X-Gm-Message-State: APjAAAVZ0/RpyTPB//qr5X7AZ8Eh57Zeqrmvtfdt9htkByJNm99eK9bX
        b+9LjK4JqWo27mhK3x7yDKKdW7txv6s=
X-Google-Smtp-Source: APXvYqzwkMj0PJ8taLffJ8W2JrcvATme98GQGJX0LS7TPTRiUEPTNp5IYu8fT7uFmLx8nEqHd37GDw==
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr5639027pjb.142.1567013792822;
        Wed, 28 Aug 2019 10:36:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m145sm5047005pfd.68.2019.08.28.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:29 -0700 (PDT)
Date:   Mon, 26 Aug 2019 10:48:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <201908261043.08510F5E66@keescook>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
 <20190826145756.GB4664@cisco>
 <CAEn-LTrtn01=fp6taBBG_QkfBtgiJyt6oUjZJOi6VN8OeXp6=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEn-LTrtn01=fp6taBBG_QkfBtgiJyt6oUjZJOi6VN8OeXp6=g@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 26, 2019 at 09:39:50AM -0700, David Abdurachmanov wrote:
> I don't have the a build with SECCOMP for the board right now, so it
> will have to wait. I just finished a new kernel (almost rc6) for Fedora,

FWIW, I don't think this should block landing the code: all the tests
fail without seccomp support. ;) So this patch is an improvement!

-- 
Kees Cook
