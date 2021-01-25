Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71C3028A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbhAYRTm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbhAYRTV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 12:19:21 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C95C06178C
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 09:18:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q8so18865577lfm.10
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF3PAS9R3ZcPxx4Z5KTeI/YMZHaaDZloSJa4zd+LcN4=;
        b=dcojzpvBme3j+zUhY3ahCgy1OWbsKkFNmO1SmDOVx9o3VOdmi1r2YX6L0pn3CYTKxE
         UuzL4cx554sA9UWfceH335k9zgKeNdNZbQkg0ruEwHt2oD7i5VhQHFj8dho+iNbxnOIi
         kbP6D0HNZYkv/fCic1j5WVLYkd7Cr9blj/atVb/ioXbDyORifrO8kcGBh7MCL0flLrDK
         D2ZQOL0FlMXMeBJEJSv+/JfLGOP1UGbY+1X/Y5zaitRWa/9P2DldYEEdQW4OPBEOCyLf
         c+RRNgmCaHeK6qP/DS1Pp+OIpiTReTg8yF4kHgiTCvjQR1HWcMVRmJAgmErZ8wIE4wHP
         EOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF3PAS9R3ZcPxx4Z5KTeI/YMZHaaDZloSJa4zd+LcN4=;
        b=hRZuyKHgUTpkdMUnyGasPgw62V88CHXGoP85mXTWDmdFTPortw7PkvuCiQVfjm00tV
         JIurjKDsW+9RYPa0dCH1gr4S4hhJUpho86KP8DlSiozyDFh5MVyYr0vZFgB7OcD01Cam
         va5/UCOs5UbnNWhq9rnDAGJce267FCKPLtJpyxNWyMRVWaLT5lbzVX4hKLikFpUw2O9Y
         s9ERHBIGlksxcBiWHXsbyWFRWE7PK9SLmPsuRcNKqQyZWOaRypximc0pLsGRwG/S4sBW
         p5SVWRZXolpjtoM3L9fRPkJZNXWB0IXmubwVRisRgRMqS6ouFV/ErWsYrDWqRlVaviRh
         GLQw==
X-Gm-Message-State: AOAM5330mZuIHUoCFmBboYT4QRLyRLZLjh+mUm9/RIw7HTEE8Dmhu8mZ
        mUQeMtZbYI4kxHvx2BaQUJHv5pSagDjj6eyn51awzg==
X-Google-Smtp-Source: ABdhPJwZgyZD9DAvRTvevIrwihPTON7uK5jWWLxrkR+Wnn2HSb0H7RhPgRrIgLYR899I6nP8mpJ+rzybzF2sMZbacI0=
X-Received: by 2002:a05:6512:79:: with SMTP id i25mr660173lfo.549.1611595095275;
 Mon, 25 Jan 2021 09:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-9-rppt@kernel.org>
 <20210125161706.GE308988@casper.infradead.org>
In-Reply-To: <20210125161706.GE308988@casper.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 25 Jan 2021 09:18:04 -0800
Message-ID: <CALvZod7rn_5oXT6Z+iRCeMX_iMRO9G_8FnwSRGpJJwyBz5Wpnw@mail.gmail.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 25, 2021 at 8:20 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 21, 2021 at 02:27:20PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
>
> I think this is wrong.  It fails to account subsequent allocators from
> the same PMD.  If you want to track like this, you need separate pools
> per memcg.
>

Are these secretmem pools shared between different jobs/memcgs?
