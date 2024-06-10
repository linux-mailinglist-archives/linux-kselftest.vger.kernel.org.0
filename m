Return-Path: <linux-kselftest+bounces-11582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F97902755
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4A9288974
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB89757E3;
	Mon, 10 Jun 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxLVmKdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B081EA8F;
	Mon, 10 Jun 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038749; cv=none; b=V1LRQ6utXvcvfFcBrZ5ftyvnSbwpOQZMeFvM3XfiMeTpNuerfIWCxasvgfma/n9IamC24k4tDkv3Wc7s5gEyHVaQ/QFKTeVsRqSPOE5Qdr7DKLAJR3ydhPaAvcQYXDgUuJiKZPf9hvEgikiE9FcGyJKMaqjcvYH2sWQy3UqdRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038749; c=relaxed/simple;
	bh=9D3+hG1aRfAFePtrgS5rz7tAOYVp4aSm+73FoWh/he4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzwINx5WIdvvfc0HaU3HTyzPweR6QmLt0LmTsHXmwG6w1SP7gOnBZOmzg9SRbd7GcRaXMZDzCe86jlZAMfFVY2efNTaKj4+wO5yyPqeQa5rI5KUWgdE9oqXwafrWKOJq24dwaCPXCW+cRmOYeSjcw1zmSBU2d1MtKFe1pe+9EiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxLVmKdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C5C32786;
	Mon, 10 Jun 2024 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718038748;
	bh=9D3+hG1aRfAFePtrgS5rz7tAOYVp4aSm+73FoWh/he4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxLVmKdSgBkH6q2ubwseqrRXZQ96btSv8+fPdDoV/au92GQCR7N4oaPEy+pXxhY8v
	 AS10HSs5e49HbTCYjrPWg8+tjXGaeflr0/QdEO1e/eGgaLI4aB3+AepDyI+8xbqZJ1
	 AL9afjm6ei9MwRbnmWkY7B3oC/UTdjKb0WdFdPA3qIiMElk/ikhAUdrduTh2+1RWbY
	 6X5A8YaAmc6IwTBjF8fS6aASNC3MARvaIRlUtzn2pL7jIJKJbLOL68XPXQ2HkWHLaf
	 iGYb92zGA5c8Fw4IQuprDoC9LbnE7fw4gi/vwB0dNonMpwShTtpm4vtXWzVe8WyoDd
	 r2CsodAQoKX/g==
Date: Mon, 10 Jun 2024 09:59:08 -0700
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Amer Al Shanawany <amer.shanawany@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] selftests: seccomp: fix format-zero-length warnings
Message-ID: <202406100957.750569FFD1@keescook>
References: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
 <20240607124117.66769-2-amer.shanawany@gmail.com>
 <a461ba9f-b171-4b49-b282-1f4e2830f31e@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a461ba9f-b171-4b49-b282-1f4e2830f31e@linuxfoundation.org>

On Fri, Jun 07, 2024 at 02:58:47PM -0600, Shuah Khan wrote:
> On 6/7/24 06:41, Amer Al Shanawany wrote:
> > fix the following errors by removing empty print statements:
> > seccomp_benchmark.c:197:24: warning: zero-length gnu_printf format
> >   string [-Wformat-zero-length]
> >    197 |         ksft_print_msg("");
> >        |                        ^~
> > seccomp_benchmark.c:202:24: warning: zero-length gnu_printf format
> >   string [-Wformat-zero-length]
> >    202 |         ksft_print_msg("");
> >        |                        ^~
> > seccomp_benchmark.c:204:24: warning: zero-length gnu_printf format
> >   string [-Wformat-zero-length]
> >    204 |         ksft_print_msg("");
> >        |                        ^~
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202312260235.Uj5ug8K9-lkp@intel.com/
> > Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> > ---
> > Changes v1 -> v2:
> > removed empty print statements
> 
> Kees,
> 
> Is this change okay with you. I didn't see any use for
> these empty ksft_print_msg().
> 
> I will take this patch if you are okay with the change.

Dropping these means that the "#" marks go missing. Currently:

# Running on:
# Linux proton 6.5.0-25-generic #25~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Feb 20 16:09:15 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

with the proposed patch:

# Running on:
Linux proton 6.5.0-25-generic #25~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Feb 20 16:09:15 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

This breaks the TAP syntax for the test, so we should find a different
solution.

Perhaps:

ksft_print_msg("%s", "");

?

-Kees


> 
> > ---
> >   tools/testing/selftests/seccomp/seccomp_benchmark.c | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> > index b83099160fbc..6fe34be6c693 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> > @@ -194,14 +194,11 @@ int main(int argc, char *argv[])
> >   	ksft_set_plan(7);
> >   	ksft_print_msg("Running on:\n");
> > -	ksft_print_msg("");
> >   	system("uname -a");
> >   	ksft_print_msg("Current BPF sysctl settings:\n");
> >   	/* Avoid using "sysctl" which may not be installed. */
> > -	ksft_print_msg("");
> >   	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
> > -	ksft_print_msg("");
> >   	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
> >   	affinity();
> 
> 
> thanks,
> -- Shuah

-- 
Kees Cook

