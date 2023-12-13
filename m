Return-Path: <linux-kselftest+bounces-1820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C85811033
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 12:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4733C281FC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0532524200;
	Wed, 13 Dec 2023 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZfPU5Fv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C60241EC
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BC4C433C8;
	Wed, 13 Dec 2023 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702467275;
	bh=FB61QkUhmBBoX1jpL4t7zTF9O9cz5293f+BUjVdgdW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZfPU5FvnLlC/I+TJW5gUU7zyoV7MBTQNtaFpkzsj9VeRiWrvdq3CMH1h0BOJ5ml0
	 ufGA/f2+2nG3H/hNi4amKJKC2qJURsxYeCEWvdlxtSHxyQgQEWewxgH3erTU4pQraO
	 TPqkNJJAnDB8/XdGC45i77mi+WDlVo4BEfsDIsbiOUsuX2rC1rFXDSZuBNUxLlLaom
	 kcxWAn5+d/VFlIgUCxD6mP95YE/SYWqmxwiy0nMFMHDQTjhJrrbZk+W9MI05EvAO/E
	 6K6E+gWBIz4RY99wpKrxQxQyypgrGzucaetlxwkVwNnWBEZqrENkTFf8Yby2AmbaFB
	 XwybkoATIv6sw==
Date: Wed, 13 Dec 2023 17:00:40 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/ftrace: Add test to exercize function tracer
 across cpu hotplug
Message-ID: <3juxoqz7kal42uowxfqvahtjpcla6mm6wv4dmoq7pxvjzg6f62@cwhzmibrqur4>
References: <20231212085607.1213210-1-naveen@kernel.org>
 <20231213094038.6c9518a2042b84c8388ec6ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213094038.6c9518a2042b84c8388ec6ae@kernel.org>

On Wed, Dec 13, 2023 at 09:40:38AM +0900, Masami Hiramatsu wrote:
> Hi Naveen,
> 
> On Tue, 12 Dec 2023 14:26:07 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
> > Add a test to exercize cpu hotplug with the function tracer active to
> > ensure that sensitive functions in idle path are excluded from being
> > traced. This helps catch issues such as the one fixed by commit
> > 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> > 
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> >  .../ftrace/test.d/ftrace/func_hotplug.tc      | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> > new file mode 100644
> > index 000000000000..49731a2b5c23
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> > @@ -0,0 +1,30 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: ftrace - function trace across cpu hotplug
> > +# requires: function:tracer
> > +
> > +if ! which nproc ; then
> > +  nproc() {
> > +    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
> > +  }
> > +fi
> > +
> > +NP=`nproc`
> > +
> > +if [ $NP -eq 1 ] ;then
> > +  echo "We can not test cpu hotplug in UP environment"
> > +  exit_unresolved
> > +fi
> 
> This looks good, but can you find the 2nd online CPU before
> this test?
> I mean, there is a case that cpu1 is already offlined and others
> like cpu2 is onlined. So we need to use the 2nd online cpu.

Good point, thanks. I will send a v2.

- Naveen


