Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0CE67ACDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 09:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjAYIyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 03:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjAYIx7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 03:53:59 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1262B08B;
        Wed, 25 Jan 2023 00:53:58 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 15A9D81845;
        Wed, 25 Jan 2023 08:53:51 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674636838;
        bh=Usb1qIWIxd9/d0PmwEs4g3lE3pfBZkCsLqszsd3+X28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxBbdk9pxAWEK8b2xeerhWMFJ3XgZ3DUvXz2ht0O99oj1Mbn3udhDQg9f18sqadtN
         yubUBw1yJl1GrbUQid3fRXheb5YJwz+oNcaus/Ozd+RbzwqTUaCHhug2PDD+P3jWeS
         Hfc498yTBJPHLa195c6mjzTHEfEIxDXX+ga4ml8pN58bg2YRiWHzhhpOSR65Tpunsp
         FMyXwyC52TtcRhqL7xaWTysie1jtJZLV5RN0UbURt7FHXz0LHmkiMY0F03tjPAdaHA
         znROt5+w9y4/22ja8v4KXoWcGmBeJTVTvemVpldx8oSk0wOe2QgcOE75lNsotUKfwy
         IqGjWyx7EhzhA==
Date:   Wed, 25 Jan 2023 15:53:47 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Xin Li <xin3.li@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y9DuG5quQpfeVKJm@biznet-home.integral.gnuweeb.org>
References: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <20230125034958.734527-2-ammarfaizi2@gnuweeb.org>
 <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 12:39:26AM -0800, H. Peter Anvin wrote:
> > +	ret = check_regs_result(ctx->uc_mcontext.gregs[REG_R11],
> > +				ctx->uc_mcontext.gregs[REG_RCX],
> > +				ctx->uc_mcontext.gregs[REG_RBX]);
> > +
> > +	assert(ret != REGS_ERROR);
> > +
> 
> This instance, too, needs to be checked against regs_ok_result. It would
> make most sense to move that handling, and the assert() into
> check_regs_result() or into a separate function around it.

OK. Sounds better.
 
> >   	/* Set IP and CX to match so that SYSRET can happen. */
> >   	ctx->uc_mcontext.gregs[REG_RIP] = rip;
> >   	ctx->uc_mcontext.gregs[REG_RCX] = rip;
> 
> It would be interesting to have the syscall handler try both with and
> without this (so it would end up doing both IRET and SYSCALL on legacy.)
> Perhaps SIGUSR1 versus SIGUSR2...

We will have a new separate patch for that.

-- 
Ammar Faizi

