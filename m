Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5CE0FD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 03:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfJWB4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 21:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJWB4X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 21:56:23 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82B52064A;
        Wed, 23 Oct 2019 01:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571795782;
        bh=7K4aAK3LqRh8jXXyar1/Xb/Z6TWqqFQnOKm4QUrFieo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pC4WKRsLT4Eq3kgZaw8DuTmD/QC0WMjYDHLMLBOcyBV8tMKHYe5I7oRo0gXqtL3GA
         1mxLLvmFtnJHwDXBEWwHlckTDa7n+aqrUUjFfRGNQGgjDUVub3S8ArioIFjeDnI9I6
         OyTtxz0s5jjxPXA04EmhWdMmpSjAm5IPBVQ469TA=
Date:   Wed, 23 Oct 2019 10:56:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH v2 1/5] selftests: proc: Make va_max 1GB on 32bit
 arch
Message-Id: <20191023105618.48a8fcee869fbae8ead31cee@kernel.org>
In-Reply-To: <20191021173053.GB5355@avx2>
References: <157164647813.17692.3834082082658965225.stgit@devnote2>
        <157164648909.17692.6080553792829040898.stgit@devnote2>
        <20191021173053.GB5355@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 21 Oct 2019 20:30:53 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Mon, Oct 21, 2019 at 05:28:09PM +0900, Masami Hiramatsu wrote:
> > Currently proc-self-map-files-002.c sets va_max (max test address
> > of user virtual address) to 4GB, but it is too big for 32bit
> > arch and 1UL << 32 is overflow on 32bit long.
> > 
> > Make va_max 1GB on 32bit arch like i386 and arm.
> 
> > +#if __BITS_PER_LONG == 32
> > +# define VA_MAX (1UL << 30)
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
> No, just make it like 1MB unconditionally.

Ah, I sse. BTW, would you mean 1GB?

> This is not intended to cover all address space, just large enough part
> (larger than reasonable vm.mmap_min_addr)

Then, should we better to check the /proc/sys/vm/mmap_min_addr?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
