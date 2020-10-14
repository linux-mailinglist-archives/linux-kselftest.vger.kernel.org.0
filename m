Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2C28E39C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgJNPxX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgJNPxX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 11:53:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04B0C061755;
        Wed, 14 Oct 2020 08:53:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l24so3656586edj.8;
        Wed, 14 Oct 2020 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FCeRwnRHpBRW2gbHKnyqjomhwY8PEDcYxzfNQP/7LoU=;
        b=BsRDrsKkem1/EJ21sYF99A0VMAZTtevuW2QrYxYUmt6sYdyndmABJ/nmg6cKVDgXpw
         vHIGp6YKub+GJsoCObugr5wZ2Cv59thi76GG/Vy1ruIYmFtTaxwlk6+dZ8tzeWkez0/0
         XZXXE4UkjKnFu3HUw/Vo0ejrzm0/jt152eztZgoztDnhIGZwyB58Bp6C9pyqPDWukVsz
         wisbhHxfCaMw3p8G6rE9x8x/HQPXbJfJ1HCxW5aKzHCLGCBT2dXuqbkzsJL/pQcodaKi
         hjFaagvCG3FEoJLjhumYFw4HadWvZWasYUGRQZCE352W/8iw4F5rBQe/6F+SGHKK6kEf
         eKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FCeRwnRHpBRW2gbHKnyqjomhwY8PEDcYxzfNQP/7LoU=;
        b=aj49qYe8oOV7JR4KrT/ZO56z/b9Qpmgj6+lzbVlj2g8aWy9Ou1AAKLJb0BjUgKLzD0
         xUwNHxQ7X678Cx+OOPdqRIg1lAPuiaO9CNeos/w64qFAjeNir+MyGq6Jvs/ya+CTmX5f
         5vwyYZ5h8BsM5QnCaZBbT7T9im32O+R8AZVT2wnpYX0ilNPHQumgbcO+j8pTb5l/pIM2
         VgeuyrELo21ZPpttaGnCc5HfGxp6sf5MT3KAvTteaTi7fn3pAHtTFY5F4RvW4bXoh0/B
         h09QlE4j6t2xfRXst4qoi00UOJ5B9nPT0uobMESvkFenGdgvJxVqbtfgQaJutCSiBRN3
         G8Tw==
X-Gm-Message-State: AOAM533Mt4rom/bqJ8mqhGJr7pXPmxmXOTdCPlLvBWxSWTBnc3/7TNi4
        b0cOXQyKBEwlkO+zWPLGW1M=
X-Google-Smtp-Source: ABdhPJxEwur8sPLU2aoBqv3RE/RaHeiWbyEZv0tpx/0pn8DdiaO+u6EiBnlbQAjLeeZ9G+3Cw4+J7g==
X-Received: by 2002:aa7:d2d5:: with SMTP id k21mr5761855edr.62.1602690801739;
        Wed, 14 Oct 2020 08:53:21 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id vr3sm2018390ejb.124.2020.10.14.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:53:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 14 Oct 2020 17:53:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/5] x86: mremap speedup - Enable HAVE_MOVE_PUD
Message-ID: <20201014155318.GA3014922@gmail.com>
References: <20201014005320.2233162-1-kaleshsingh@google.com>
 <20201014005320.2233162-6-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014005320.2233162-6-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Kalesh Singh <kaleshsingh@google.com> wrote:

> HAVE_MOVE_PUD enables remapping pages at the PUD level if both the
> source and destination addresses are PUD-aligned.
> 
> With HAVE_MOVE_PUD enabled it can be inferred that there is approximately
> a 13x improvement in performance on x86. (See data below).
> 
> ------- Test Results ---------
> 
> The following results were obtained using a 5.4 kernel, by remapping
> a PUD-aligned, 1GB sized region to a PUD-aligned destination.
> The results from 10 iterations of the test are given below:
> 
> Total mremap times for 1GB data on x86. All times are in nanoseconds.
> 
> Control        HAVE_MOVE_PUD
> 
> 180394         15089
> 235728         14056
> 238931         25741
> 187330         13838
> 241742         14187
> 177925         14778
> 182758         14728
> 160872         14418
> 205813         15107
> 245722         13998
> 
> 205721.5       15594    <-- Mean time in nanoseconds
> 
> A 1GB mremap completion time drops from ~205 microseconds
> to ~15 microseconds on x86. (~13x speed up).
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>

Nice!

Assuming it's all correct code:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
