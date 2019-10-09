Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5AD05B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 04:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJICuC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 22:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfJICuC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 22:50:02 -0400
Received: from devnote2 (p242255-mobac01.tokyo.ocn.ne.jp [153.233.233.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9B220859;
        Wed,  9 Oct 2019 02:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570589401;
        bh=c9ZsUO3Tnqh9b6HhdHVMOjLdz1Zzv2yW4eAWutX54fw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FHY4vzrRmHCoNoJUr2tDT7SUWxayXbylpuEe1ZedDwK38y9KqavCvnmMbork9vq0r
         rx5xDFQZJT9qGZXamrOnhTzXTJmfX8s5EOtdSXilktmrbwVFA+E0OwN1qZHK7HK/B5
         swC+H09+2847A0KuJhaZ6M/O4TJMw82cbu8TVEFU=
Date:   Wed, 9 Oct 2019 11:49:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH 1/5] selftests: proc: Make va_max 3GB on 32bit
 arch
Message-Id: <20191009114956.37f3771b700e438a90945408@kernel.org>
In-Reply-To: <20191008175916.GA20780@avx2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
        <157046102656.20724.3358140818300189230.stgit@devnote2>
        <20191008175916.GA20780@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 8 Oct 2019 20:59:16 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Tue, Oct 08, 2019 at 12:10:26AM +0900, Masami Hiramatsu wrote:
> > Currently proc-self-map-files-002.c sets va_max (max test address
> > of user virtual address) to 4GB, but it is too big for 32bit
> > arch and 1UL << 32 is overflow on 32bit long.
> > 
> > Make va_max 3GB on 32bit arch like i386 and arm.
> 
> IIRC i386 had 1G/3G split, so 3GB would be too much still.

Hmm, would you know what is the best value for that?
i386 can also be configured 3G/1G, 2G/2G and 1G/3G, so it
depends on the build configuration. Would 1G is enough for test?

Thank you,

> 
> > --- a/tools/testing/selftests/proc/proc-self-map-files-002.c
> > +++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
> 
> > +#if __BITS_PER_LONG == 32
> > +# define VA_MAX (3UL << 30)
> > +#elif __BITS_PER_LONG == 64
> > +# define VA_MAX (1UL << 32)
> > +#else
> > +# define VA_MAX 0
> > +#endif
> > +
> >  int main(void)
> >  {
> >  	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> > -	const unsigned long va_max = 1UL << 32;
> > +	const unsigned long va_max = VA_MAX;
> 
> This limit doesn't need to be precise, 1GB is "big enough".


-- 
Masami Hiramatsu <mhiramat@kernel.org>
