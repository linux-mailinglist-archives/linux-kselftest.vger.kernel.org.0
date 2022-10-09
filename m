Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FD5F8D32
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Oct 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJISgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Oct 2022 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJISgN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Oct 2022 14:36:13 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C8D8120A5;
        Sun,  9 Oct 2022 11:36:12 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 299Ia4uU029192;
        Sun, 9 Oct 2022 20:36:04 +0200
Date:   Sun, 9 Oct 2022 20:36:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     lkp@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: tools/nolibc: fix missing strlen() definition and infinite loop
 with gcc-12
Message-ID: <20221009183604.GA29069@1wt.eu>
References: <Y0LsreRGq3nbe2xC@localhost.localdomain>
 <20221009175920.GA28685@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009175920.GA28685@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 09, 2022 at 07:59:20PM +0200, Willy Tarreau wrote:
> Hi Alexey,
> 
> On Sun, Oct 09, 2022 at 06:45:49PM +0300, Alexey Dobriyan wrote:
> > Willy Tarreau wrote:
> > > +#if defined(__GNUC__) && (__GNUC__ >= 12)
> > > +__attribute__((optimize("no-tree-loop-distribute-patterns")))
> > > +#endif
> > >  static __attribute__((unused))
> > > -size_t nolibc_strlen(const char *str
> > 
> > I'd suggest to use asm("") in the loop body. It worked in the past
> > to prevent folding division loop back into division instruction.
> 
> Ah excellent idea! I initially thought about using asm() to hide a
> variable provenance but didn't like it much because it undermines
> code optimization. But you're right, with an empty asm() statement
> alone, the loop will not look like an strlen() anymore. Just tried
> and it works like a charm, I'll resend a patch so that we can get
> rid of the ugly ifdef.
> 
> > Or switch to 
> > 
> > 	size_t f(const char *s)
> > 	{
> > 		const char *s0 = s;
> > 		while (*s++)
> > 			;
> > 		return s - s0 - 1;
> > 	}
> > 
> > which compiles to 1 branch, not 2.
> 
> In fact it depends. In the original code that approach was part of
> the ones I had considered, but it doesn't always in better code due
> to the prologue and epilogue being larger. It's only better at -O1,
> and -O2, but not -Os, and once you add asm() into it, only -O1
> remains better:
> 
>   $ nm --size len.o|grep O|rev|sort|rev
>   000000000000001a T len_while_O1
>   0000000000000022 T len_while_asm_O1
>   0000000000000026 T len_for_O1
>   000000000000001a T len_while_O2
>   000000000000002b T len_while_asm_O2
>   0000000000000021 T len_for_O2
>   0000000000000013 T len_while_Os
>   0000000000000015 T len_while_asm_Os
>   000000000000000e T len_for_Os
> 
> This observation seems consistent for me on x86_64, i386, arm and arm64.

By the way, just for the sake of completeness, the one that consistently
gives me a better output is this one:

  size_t strlen(const char *str)
  {
          const char *s0 = str--;
  
          while (*++str)
  		;
          return str - s0;
  }

Which gives me this:


  0000000000000000 <strlen>:
     0:   48 8d 47 ff             lea    -0x1(%rdi),%rax
     4:   48 ff c0                inc    %rax
     7:   80 38 00                cmpb   $0x0,(%rax)
     a:   75 f8                   jne    4 <len+0x4>
     c:   48 29 f8                sub    %rdi,%rax
     f:   c3                      ret    

But this is totally ruined by the addition of asm() in the loop. However
I suspect that the construct is difficult to match against a real strlen()
since it starts on an extra character, thus placing the asm() statement
before the loop could durably preserve it. It does work here (the code
remains the exact same one), but for how long, that's the question. Maybe
we can revisit the various loop-based functions in the future with this in
mind.

Cheers,
Willy
