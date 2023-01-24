Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073767913A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 07:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjAXGrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 01:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAXGrN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 01:47:13 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB8B27D55;
        Mon, 23 Jan 2023 22:47:12 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id E897B82EF1;
        Tue, 24 Jan 2023 06:47:05 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674542832;
        bh=ji1qYlM/NEIxpmkTGVfmalIw/nejW1Mp1PflUs7Ahts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ju3HN76Yj8FVoED4L1IiCSDh5eKvTZrk7CUdLLP1tgr0FPmijpZcn/b7G3onvps8I
         flxbrt+7PwetqVBONTXGmiXmDeSmQhV8eplWxHc9nzbIK96Moa3FzEsCT3Lwp9oHZX
         6mFqIIWJVFOVurOHPxmUnyTyhE1jqtVDDzpnLQ2LTrlMkcjJT8GMPSWO9WQx39MLQX
         YTeN5NRAN/auijD6wSsw3v72dawFMpLbWBsOLGre6GUw3XftnKZrSczvpJ3GSQ5t3l
         NIUreN5AMI+wlGuRfEWaCGBI0A6h5RqSfExWeQdYLXMl4pfMnHnXC1SvH6wKE1ZZLq
         ip8uSKhK5uK9g==
Date:   Tue, 24 Jan 2023 13:47:01 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 Mailing List <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] selftests/x86: sysret_rip: Add more syscall
 tests with respect to `%rcx` and `%r11`
Message-ID: <Y89+5R6pJDUfHUwH@biznet-home.integral.gnuweeb.org>
References: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 01:41:30PM +0700, Ammar Faizi wrote:
> On Mon, Jan 23, 2023 at 10:16:01PM -0800, H. Peter Anvin wrote:
> > However, you are not checking that you don't get a mix of REGS_SAVED and
> > REGS_SYSRET, which is a major part of the point.
> 
> Good point!
> 
> What do you think of adding this on top of patch #1?
> 
> diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
> index 75c72d34dbc5840c..3da827713831acbc 100644
> --- a/tools/testing/selftests/x86/sysret_rip.c
> +++ b/tools/testing/selftests/x86/sysret_rip.c
> @@ -47,11 +47,14 @@ static const unsigned long rcx_sentinel = 0x5ca1ab1e0b57ac1e;
>  static const unsigned long rflags_sentinel = 0x200a93;
>  
>  enum regs_ok {
> -	REGS_ERROR  = -1,	/* Invalid register contents */
> -	REGS_SAVED  =  0,	/* Registers properly preserved */
> -	REGS_SYSRET =  1	/* Registers match syscall/sysret */
> +	REGS_INIT_VAL	= -2,	/* For init value checker, never returned */
> +	REGS_ERROR 	= -1,	/* Invalid register contents */
> +	REGS_SAVED 	=  0,	/* Registers properly preserved */
> +	REGS_SYSRET	=  1	/* Registers match syscall/sysret */
>  };
>  
> +static enum regs_ok regs_ok_state = REGS_INIT_VAL;
> +
>  /*
>   * Returns:
>   *  0 = %rcx and %r11 preserved.
> @@ -86,6 +89,7 @@ static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
>  	register unsigned long r9 asm("%r9");
>  	register void *rsp asm("%rsp");
>  	unsigned long rcx, rbx;
> +	enum regs_ok ret;
>  
>  	r11 = r11_sentinel;
>  	rcx = rcx_sentinel;
> @@ -124,7 +128,14 @@ static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
>  	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
>  	 *
>  	 */
> -	assert(check_regs_result(r11, rcx, rbx) != REGS_ERROR);
> +	ret = check_regs_result(r11, rcx, rbx);
> +	assert(ret != REGS_ERROR);
> +
> +	if (regs_ok_state == REGS_INIT_VAL)
> +		regs_ok_state = ret;
> +	else
> +		assert(ret == regs_ok_state);
> +
>  	return nr_syscall;
>  }
>  

And oh, on top of that. Add a comment, just to make it clear...

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 3da827713831acbc..3d783f5baee1b66a 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -131,6 +131,10 @@ static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
        ret = check_regs_result(r11, rcx, rbx);
        assert(ret != REGS_ERROR);
 
+       /*
+        * Check that we don't get a mix of REGS_SAVED and REGS_SYSRET.
+        * Need at least 2 times 'syscall' invoked from this function.
+        */
        if (regs_ok_state == REGS_INIT_VAL)
                regs_ok_state = ret;
        else

-- 
Ammar Faizi

