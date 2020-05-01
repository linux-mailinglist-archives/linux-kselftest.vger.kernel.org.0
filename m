Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182AB1C0BCA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 03:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgEABq4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Apr 2020 21:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgEABq4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Apr 2020 21:46:56 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D812074A;
        Fri,  1 May 2020 01:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588297615;
        bh=3P5p+bdHuyBp+SqOjHHXaCjj2TvUx9DJz/NquFDT6ZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q0CDdN7suJSK0sEpGbP4hOTz+9BAfidNeze7mhTt1171gsP/IsO69kU2ENgf/Qro6
         t7/7mO0PaAtUUT+FEPtH3/nDI2T25Y8PrFQu7HG4sm8hegut7AMvrTOLPqi/sJP+cU
         sA5PRG0gD5IfZwye6b4QWZpUOIrp4wC48PlOraG8=
Date:   Fri, 1 May 2020 10:46:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Liu Yiding <yidingx.liu@intel.com>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kselftest@vger.kernel.org, "Li, Philip" <philip.li@intel.com>
Subject: Re: kprobe/kprobe_syntax_errors.tc faild on dash due to sh I/O
 error
Message-Id: <20200501104653.9f467442d424a010d5ca05fb@kernel.org>
In-Reply-To: <8efd4de6-dfaa-f94b-2119-40af5cc2898e@intel.com>
References: <8efd4de6-dfaa-f94b-2119-40af5cc2898e@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Liu,

On Wed, 29 Apr 2020 15:13:20 +0800
Liu Yiding <yidingx.liu@intel.com> wrote:

> Hi, all.
> 
> 
> I met a funny error when i run kprobe_syntax_errors
> 
> ```
> 
> root@vm-snb-35 
> /usr/src/linux-selftests-x86_64-rhel-7.6-kselftests-ae83d0b416db002fe95601e7f97f64b59514d936/tools/testing/selftests/ftrace# 
> ./ftracetest -vvv test.d/kprobe/kprobe_syntax_errors.tc [snip] + expr 13 
> + 0 + test 13 -eq 13 + echo p:kprobes/testevent _do_fork abcd=\1 sh: 
> echo: I/O error
> 
> ```
> 
> This error only happend on dash, use bash run this test is ok.
> 
> backslash ('\1') will be transferred into empty in dash.

Oops, good catch! I found that came from the built-in echo command
behavior.
Bash's echo doesn't interpret the backslash escape, but dash's
POSIX-compliant echo does.

----<dash>----
$ a='\1'
$ b=`echo $a`
$ test "$a" = "$b" && echo "same!" || echo "different"
different

----<bash>----
$ a='\1'
$ b=`echo $a`
$ test "$a" = "$b" && echo "same!" || echo "different"
same!

OK, I'll fix it.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
