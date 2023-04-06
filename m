Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DCC6DA016
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDFSnT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDFSnT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 14:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E47A8F;
        Thu,  6 Apr 2023 11:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84428649DA;
        Thu,  6 Apr 2023 18:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E09C433EF;
        Thu,  6 Apr 2023 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806596;
        bh=wObwsQJR3adxCPQNiwjaKcdVEBHcrio2cFl/+Gr1TY4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MNLw064vngfa1zFQGXXNoNZS11tu6DkgN8WleIEwolXgoJjLQWIU/D0IEXZlk/VTm
         i1/nJmNaK9wibYhiFEtUt8JRyCUFD17G6MLXT7AdF3+kLzLRZ0ZpXjMhC8+s09WKZ8
         1U/NkUg7rb+Khu0GDxVkQZ90pP3K+0k2/J8jb7niEfSSndn7POojTboURkR+lsqwvs
         0bMwuOX62UzCvSeIgru8Z5Qj2Izgf4yPbLkBBR1+Lt+bIgh9daC8ldCVfiuevo6WSB
         tA2vajubR/u8y7a4nEWro9LoPJLs1x0aWQCgBt/tlv+Rk72cX/hve0wLEuVlVnyhPL
         m+nDDNvhFzeWQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6CF6415404B4; Thu,  6 Apr 2023 11:43:16 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:43:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC8OwUPAC4s413jP@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 06, 2023 at 08:26:09PM +0200, Willy Tarreau wrote:
> On Thu, Apr 06, 2023 at 05:19:10PM +0100, Mark Brown wrote:
> > vprintf() is equivalent to vfprintf() to stdout so implement it as a simple
> > wrapper for the existing vfprintf(), allowing us to build kselftest.h.
> > 
> > Suggested-by: Willy Tarreau <w@1wt.eu>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  tools/include/nolibc/stdio.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index 96ac8afc5aee..6cbbb52836a0 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -273,6 +273,12 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
> >  	return written;
> >  }
> >  
> > +static __attribute__((unused))
> > +int vprintf(const char *fmt, va_list args)
> > +{
> > +	return vfprintf(stdout, fmt, args);
> > +}
> > +
> >  static __attribute__((unused, format(printf, 2, 3)))
> >  int fprintf(FILE *stream, const char *fmt, ...)
> >  {
> 
> Perfect, thank you Mark, I'm glad that it simplified the rest of
> your series.
> 
> Acked-by: Willy Tarreau <w@1wt.eu>
> 
> Paul, feel free to directly queue this one for 6.5. If you prefer I
> can as well queue it on my side and send it later, it's just that I
> have exactly zero extra value on top of this one ;-)

Alternatively, if it would be more convenient for Mark to send this
up via kselftest:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

It currently merges cleanly with the -rcu tree's dev branch, so this
should not be a problem.

Either way, please let me know, Mark!

							Thanx, Paul
