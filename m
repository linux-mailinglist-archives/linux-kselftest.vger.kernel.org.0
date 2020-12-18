Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBA2DE9B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgLRTVi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLRTVh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 14:21:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D6C0617A7
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 11:20:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jx16so4767226ejb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HEr0MPReqXsQ4qjOEHDWj7dDqEmzb7cQ1SBc7J5+dw=;
        b=0gUyIB6kwj5RKOw851fk6tIuNDG4efEdNNdTwLooyi3Ofm0EJNVeG9KuAjSj3aMg6f
         Nwg+eoJoWVdwLtTY3Y8taw8Fef0vS6Q+iXd/8DHKpkBDllC+QxxTWM+tmflFQ56pKF9B
         r2XxuUfLtlwWmeTgBIAJmw9ETjSzKJTBTFdP2PkwnVqnR01L9FpICe97GYFCb2DWdW5K
         seQ68bOOeWzb3UjT1JmBfrvoBnu9/DfF7C6IExaFWhrhWglsaMg1lwmZ33uUG9d1/Sb+
         XYVWsgUrBCaZCqgbA6uAiGkasFBAenXSTwAqf6Hsd5Vrz7GPCAPk7LmnxkGUwVTkpXZL
         KpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HEr0MPReqXsQ4qjOEHDWj7dDqEmzb7cQ1SBc7J5+dw=;
        b=qe8LkjvogDdNTPrltlaMCj5TFxMI8OTR6NCbxN3l30S7ozDTxUnSHThClS5B8uXwM0
         16PrSK1xhu8oBlIHjb3httlnlPcB+G/V8TyaKj/R1DbX2VwIOTUr21eoRKiQQN33XKOm
         NaUjtXGUoa6Hq54ykghW3FUBtnyvMGo/drXkcPofNTfxBwDMXKFfmA4HzOU7Viu3T9qd
         GPKBXHnFUxXs2f016C1XCW4CKQ++uNDBtoBef1EHkUXqkO6xvr6hWGJCjoz9flkv/v9E
         Cj4gyssQdCXH43GCFUmhz6lMZGpMYxNxeYTxlEtBaslu5N0OyuRphk+DBEB78TTKILyF
         uQTA==
X-Gm-Message-State: AOAM532L7eSyHPT7Ud2H94Bjvgtd7EO+2eBfDut4VWhRDHHJg+qawofz
        2q6MoCz2Z8CIm+zZEXFm74PqNFq3yNTBwNLkOyNLUw==
X-Google-Smtp-Source: ABdhPJxz1FpFcD9v7zRsD1EJK/j02c+zOqLAfDerue66a4zrExXDdPTJUW4Jq8q7kbLcuvcZiWDBKJ5jeXELTUS5XC8=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr5459331ejk.341.1608319255787;
 Fri, 18 Dec 2020 11:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com>
 <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de>
 <878s9vqkrk.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878s9vqkrk.fsf@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Dec 2020 11:20:45 -0800
Message-ID: <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18, 2020 at 5:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
[..]
>   5) The DAX case which you made "work" with dev_access_enable() and
>      dev_access_disable(), i.e. with yet another lazy approach of
>      avoiding to change a handful of usage sites.
>
>      The use cases are strictly context local which means the global
>      magic is not used at all. Why does it exist in the first place?
>
>      Aside of that this global thing would never work at all because the
>      refcounting is per thread and not global.
>
>      So that DAX use case is just a matter of:
>
>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
>
>      which is effective for the current execution context and really
>      wants to be a distinct READ/WRITE protection and not the magic
>      global thing which just has on/off. All usage sites know whether
>      they want to read or write.

I was tracking and nodding until this point. Yes, kill the global /
kmap() support, but if grant/revoke_access is not integrated behind
kmap_{local,atomic}() then it's not a "handful" of sites that need to
be instrumented it's 100s. Are you suggesting that "relaxed" mode
enforcement is a way to distribute the work of teaching driver writers
that they need to incorporate explicit grant/revoke-read/write in
addition to kmap? The entire reason PTE_DEVMAP exists was to allow
get_user_pages() for PMEM and not require every downstream-GUP code
path to specifically consider whether it was talking to PMEM or RAM
pages, and certainly not whether they were reading or writing to it.
