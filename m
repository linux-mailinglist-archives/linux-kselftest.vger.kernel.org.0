Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7243C67ABCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjAYIdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 03:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjAYIdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 03:33:13 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CFDEC41;
        Wed, 25 Jan 2023 00:33:02 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 7EDA281845;
        Wed, 25 Jan 2023 08:32:56 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674635582;
        bh=zDeLmzQPm93U+1kPQg4ObjXt+rkhyk8qLPHh119Sj5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XU78U6h3+y0Kl84D4OS9urUwnfIr+dTbMvY3NGAYJWw8EaZGl+Mly84tE7s1W2RtJ
         Axvh4vrMMWVzZEX30MvX4A6fDMj2/nYwyW0ceUiBxatQPXS8CwLBs4S2UiTrDYjzxM
         AQCGV6wdxwkkzG/En3e9/GpGcblsKX5ADFV4rTQmMcYdq2jDWzS7r90l3vwTCdJVfh
         2BvX0e7QXPi/Yw9BqjO0fKkKduX5nJPRlezAzzk30POV0iQOzJ3pWohao7UX7b5kja
         jy9uVZXLYt6H2Mv1ynYCFNj7Ium8gY2iU4k0cL8foqMvsSgy8ZdP8nQmxoq7TRh2fr
         nkGfEgcuKkIBQ==
Date:   Wed, 25 Jan 2023 15:32:52 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Message-ID: <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org>
References: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 08:22:48AM +0000, Li, Xin3 wrote:
> This version passes on FRED, thanks a lot for quickly fixing it.

Great!

Can you pick these two patches and include it in the next version of
"x86: enable FRED for x86-64" RFC patchset?

-- 
Ammar Faizi

