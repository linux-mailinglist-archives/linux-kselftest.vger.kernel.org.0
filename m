Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F85E113A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 06:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfJWEvp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 00:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbfJWEvp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 00:51:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE9A2173B;
        Wed, 23 Oct 2019 04:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571806304;
        bh=3zYRXJ+SRu8zwNp7IKIn6lBjU9+RRMxgTC+0RDpFeyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BV0cPNPy2Q/sISCUnkyYc4xqyMqagc5n9bVOGmRs4FCgplAi8B5jNG2GAgs2Wwnci
         EXNIbgRP65rKiXXIhRYlPkrQygRh8bZAQuRgCo3Cp3ujANxBJWoA7pRqJpD39VXj6t
         hS+69V/yugQ0tsr7FBN1hvtbcazoJGDI2i0wQY1U=
Date:   Wed, 23 Oct 2019 13:51:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH v2 1/5] selftests: proc: Make va_max 1GB on 32bit
 arch
Message-Id: <20191023135141.77aef5dc41182e069676d27e@kernel.org>
In-Reply-To: <20191023105618.48a8fcee869fbae8ead31cee@kernel.org>
References: <157164647813.17692.3834082082658965225.stgit@devnote2>
        <157164648909.17692.6080553792829040898.stgit@devnote2>
        <20191021173053.GB5355@avx2>
        <20191023105618.48a8fcee869fbae8ead31cee@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Oct 2019 10:56:18 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 21 Oct 2019 20:30:53 +0300
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Mon, Oct 21, 2019 at 05:28:09PM +0900, Masami Hiramatsu wrote:
> > > Currently proc-self-map-files-002.c sets va_max (max test address
> > > of user virtual address) to 4GB, but it is too big for 32bit
> > > arch and 1UL << 32 is overflow on 32bit long.
> > > 
> > > Make va_max 1GB on 32bit arch like i386 and arm.
> > 
> > > +#if __BITS_PER_LONG == 32
> > > +# define VA_MAX (1UL << 30)
> > > +#elif __BITS_PER_LONG == 64
> > > +# define VA_MAX (1UL << 32)
> > > +#else
> > > +# define VA_MAX 0
> > > +#endif
> > > +
> > >  int main(void)
> > >  {
> > >  	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> > > -	const unsigned long va_max = 1UL << 32;
> > > +	const unsigned long va_max = VA_MAX;
> > 
> > No, just make it like 1MB unconditionally.
> 
> Ah, I sse. BTW, would you mean 1GB?

I understand that 1MB will be good enough, since vm.mmap_min_addr is
64KB by default (except for arm/arm64 which is 32KB).
OK, I'll update and resend.

Thank you,

> 
> > This is not intended to cover all address space, just large enough part
> > (larger than reasonable vm.mmap_min_addr)
> 
> Then, should we better to check the /proc/sys/vm/mmap_min_addr?
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
