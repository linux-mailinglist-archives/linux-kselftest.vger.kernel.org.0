Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D162EA4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 01:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiKRAb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 19:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKRAb1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 19:31:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A16E568
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 16:31:26 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 130so3611129pgc.5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 16:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdXW0qNT9EJ55g7ZecMibSPRKy2hZHqw3Yh8nMlwERE=;
        b=aU25zccRjTs3wP43k0MIJn4DgVbsnZCNuzNnI2CpXWYIZxXulCGxIQevzOUHHZBnNX
         P9dqjL6CLaVk8Gd/8VV9yHkQnYw6wZLIF25d9n4/Hz+qw11dfo4C3uVe8ugX4akyWpVq
         2j/LOKCC5xRDK3aE2eqqxuB+wZP/Rdy2IY2yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdXW0qNT9EJ55g7ZecMibSPRKy2hZHqw3Yh8nMlwERE=;
        b=sRoDurUO8mvqgO8sIMudEQaHcC1j4jvrI1XzuX5SXOobTWEBWdXxO5DcdeGVA/M5or
         /deXyWv2qJK399pqxa5gGAXgctBSYVr3BEINMQMuTxYXuZVlxLky0/Z1iriuaBQCKp9L
         Aa/sz6QvNLrXvZ0u65GYIrYjrez3UuW2noZeUnFdfX6uno6sb3kR9Nn4pOPw2TJVPU5D
         wcs6HqfqihocLOBq2wRQGWjxylzXaMYjFYXFl0rYphrTr653pcDJZJQBWW//kOmiWmTC
         y5phllMP/rQ6b/2dUwDgfg00smXdlUEKcrRheNfmFQ4JKTO8BNpyX2QYfyRCcqbuDKaX
         ompw==
X-Gm-Message-State: ANoB5pnrJgpIdKuYf/lcOfEvY6K4i4umTqhu+Hc932MmMUvSzVRHlsdx
        TdKnMwQcGp7NqrqELmhHWmVQYw==
X-Google-Smtp-Source: AA0mqf4Eg6efWFkC4PcZKO6M1HjEMRT/hWrF7/OJe6t0KCBzvaZRup/szSwa3Jgy88qqEUfyA5B6Hg==
X-Received: by 2002:a65:53ca:0:b0:476:dd80:fb29 with SMTP id z10-20020a6553ca000000b00476dd80fb29mr4360083pgr.619.1668731485545;
        Thu, 17 Nov 2022 16:31:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00186b6bb2f48sm2022328plk.129.2022.11.17.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:31:25 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:31:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
Message-ID: <202211171630.8EABF5EDD@keescook>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
 <202211171439.CDE720EAD@keescook>
 <CAHk-=wjykbz-4xVTWF7vkvGJnFoTSXNVeMzfsXaLnGm3CRd8rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjykbz-4xVTWF7vkvGJnFoTSXNVeMzfsXaLnGm3CRd8rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 17, 2022 at 03:20:01PM -0800, Linus Torvalds wrote:
> On Thu, Nov 17, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Oh, er, why does get_arg_page() even need FOLL_FORCE? This is writing the
> > new stack contents to the nascent brpm->vma, which was newly allocated
> > with VM_STACK_FLAGS, which an arch can override, but they all appear to include
> > VM_WRITE | VM_MAYWRITE.
> 
> Yeah, it does seem entirely superfluous.
> 
> It's been there since the very beginning (although in that original
> commit b6a2fea39318 it was there as a '1' to the 'force' argument to
> get_user_pages()).
> 
> I *think* it can be just removed. But as long as it exists, it should
> most definitely not be renamed to FOLL_PTRACE.
> 
> There's a slight worry that it currently hides some other setup issue
> that makes it matter, since it's been that way so long, but I can't
> see what it is.

My test system boots happily with it removed. I'll throw it into -next
and see if anything melts...

-- 
Kees Cook
