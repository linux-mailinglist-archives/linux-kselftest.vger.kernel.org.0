Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA318171
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEHVGI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 17:06:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43437 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHVGI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 17:06:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so15311039lfg.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2019 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVp1WyottRqZ9+kDNkl5m+DUf/QkhjWuWQymJTyFosU=;
        b=HMKAum8oc7qqjOyz0KKGmVDLRtliLfjtSEJJELkhU2c+Zo+4XmOMuN68bbshRQ1HMZ
         CTiGiT3IGyJE2PdccKqKy+R3mbogPJHH+OL3GhsJo4e+KC4bDf/32UUzvKPYPNzu0BBf
         01jmZJPdQ69jkOGMtHMEBwdbuYUIGz1skqkkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVp1WyottRqZ9+kDNkl5m+DUf/QkhjWuWQymJTyFosU=;
        b=pEuWIrjbPNDMzF3aCeNx3qrZJc5tZbH5xLwbVRC+IAUmZPw475ImfBrP13Y6svXth4
         j4UMRsTgCNY8xcE7kSclqupZAiqrA+Ro/W/KQ0tKH6XddE+RL5nNn+xFDplrZC1t8x1h
         zfKU8AnBXI3SLhnnDtRXq2aIk56vTXRJSkrKtzVlD+WUXO2Q35k/lGKsJs8EnbNxkyD3
         1XOtg5+D7Hj5FtwzOKgCiwQnKyV0fdumYo7EDVtULHu/LWTCTc1m/fm0k7/DEOrASPU+
         yEuVSzZHpBpiZIU8mxoQUuUp9LSifxLGmA09eDz4UDVXhVwOvH+jKKN4Qbv4JLWxXYDX
         wO+g==
X-Gm-Message-State: APjAAAXLthfbeD+jrf+F1nI2sQRwqurGcZcsdFtQJdTPX6XSe3cXsJZe
        Bu66VRJcdZxFme+bHzq0iajK/p1hy1g=
X-Google-Smtp-Source: APXvYqxlGAwen3u6RHhPXJjGldqqBtr4j1cJ7pVMbLB8/mitVEh3Tg4mfxOLCIwRzvS8blVe3ufRXQ==
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr130730lfl.120.1557349565927;
        Wed, 08 May 2019 14:06:05 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s16sm4041988lji.61.2019.05.08.14.06.05
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:06:05 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z1so153633ljb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2019 14:06:05 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr6921501ljh.22.1557349138137;
 Wed, 08 May 2019 13:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190508074901.982470324@infradead.org> <20190508080612.832694080@infradead.org>
In-Reply-To: <20190508080612.832694080@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 13:58:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5EMx2vmLsFqLKmVtjFa6VnTs_MWfxX2N++CDd_UiOqw@mail.gmail.com>
Message-ID: <CAHk-=wh5EMx2vmLsFqLKmVtjFa6VnTs_MWfxX2N++CDd_UiOqw@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] x86_32: Provide consistent pt_regs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 8, 2019 at 1:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hated-by: Linus Torvalds <torvalds@linux-foundation.org>

I can live with this cleaned-up version. I'm still not loving it, but
at least it now tries very hard to simplify other code. You can remote
the hated-by.

                  Linus
