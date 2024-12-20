Return-Path: <linux-kselftest+bounces-23697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 742239F982F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4091F7A2B7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A057237FD5;
	Fri, 20 Dec 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="mVf7/5y6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF5236F9E;
	Fri, 20 Dec 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714852; cv=none; b=mbCFR6avvsJ3fI1enaE4Zxlf9w2pLcmHk0/0p5JCMjXLTnyMyLyT8OSvIQue2y38ohgndZxaOHi1HIxjz55Wa6PS1Cs/EaSUyJcO9aQXiVd6jNYed+Yltp2ieE0AN9ajbWIsTKL6Ugb1P6iMpYMFMvZfVfmdMDhTBsAnKWhvy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714852; c=relaxed/simple;
	bh=g8MmajGpCryOppfA63fHjKz/mZtKGSu/ZZtHktZuxGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbDjTQhlgw6hG1ZjiyOIbxfFOYYxai1u5ibML1JLi31TSxF9CRaM+iyrt3q6HLyZtVEDSySdzNZK8s++dnzjIQunrlgBrKKfcv14sCGrYjj6ythRn9qpqgOPPjVggeVTaqzdOGUcFyeeNWb/Kp7FwSl6D4F2zM8Kqrk7bk29f9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=mVf7/5y6; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov01.int.sover.in [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4YFDXs6yQwz5W;
	Fri, 20 Dec 2024 17:14:05 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4YFDXs2gyHz7g;
	Fri, 20 Dec 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=mVf7/5y6;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1734714845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gaZKpfziRG67bV977HCl8ofo0khBuyHFbx77kdqz1Q=;
	b=mVf7/5y6psrLcg5KE3ZbeR+21snSDaP92gk4MgHjadnT9ySALAEZUvxA4zJNfaQZN6Afw6
	ZCgRKDC+bGNcKVLL0CQj6YLXcLCiXaBACzzs/ED+SbNwClNwWFewIivwdaRKU9C8wHHPkp
	x1VWW/CuvUpwS9EUU7L/zJ3+mYuoheq61Q3gyN6s40mIn6MskpvJKjUQdpmg/uy7h9BoLK
	Kinq5oSvPq8xtnwuyWM6sZRm/Bn5VFdkTy6/TbL9Hh6r4nx2nDDrpXaFk4x8DXlLV1N4cl
	FYnQUHMG0xhCI9Un08kltxDvhgnSuaxzAcv/7S6fnqeUJGrWkK7UiKCVEJlxkg==
X-CMAE-Score: 0
X-CM-Analysis: v=2.4 cv=UsCZN/wB c=1 sm=1 tr=0 ts=6765a5dd a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=omOdbC7AAAAA:8 a=0-R-klbsrwS2BGA6U3oA:9 a=QEXdDO2ut3YA:10
Message-ID: <4e810697-dfb0-4729-a414-e5d545e61d90@qmon.net>
Date: Fri, 20 Dec 2024 17:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] Makefile: Export absolute srctree path for
 out-of-tree builds
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20241217031052.69744-1-lizhijian@fujitsu.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20241217031052.69744-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-12-17 11:10 UTC+0800 ~ Li Zhijian <lizhijian@fujitsu.com>
> Fixes an issue where out-of-tree kselftest builds fail when building
> the BPF and bpftools components. The failure occurs because the top-level
> Makefile passes a relative srctree path ('..') to its sub-Makefiles, which
> leads to errors in locating necessary files.
> 
> For example, the following error is encountered:
> 
> ```
> $ make V=1 O=$build/ TARGETS=hid kselftest-all
> ...
> make -C ../tools/testing/selftests all
> make[4]: Entering directory '/path/to/linux/tools/testing/selftests/hid'
> make  -C /path/to/linux/tools/testing/selftests/../../../tools/lib/bpf OUTPUT=/path/to/linux/O/kselftest/hid/tools/build/libbpf/ \
>             EXTRA_CFLAGS='-g -O0'                                      \
>             DESTDIR=/path/to/linux/O/kselftest/hid/tools prefix= all install_headers
> make[5]: Entering directory '/path/to/linux/tools/lib/bpf'
> ...
> make[5]: Entering directory '/path/to/linux/tools/bpf/bpftool'
> Makefile:127: ../tools/build/Makefile.feature: No such file or directory
> make[5]: *** No rule to make target '../tools/build/Makefile.feature'.  Stop.
> ```


Another condition to reproduce the failure above is to have have 
$(srcroot) in the Makefile set to "." or "..", for example when your
$build is located right under the root of the repo [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.13-rc3#n273


> To resolve this, the srctree is exported as an absolute path (abs_srctree)
> when performing an out-of-tree build. This ensures that all sub-Makefiles
> have the correct path to the source tree, preventing directory resolution
> errors.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Request for Additional Testing
> 
> We welcome all contributors and CI systems to test this change thoroughly.
> In theory, this change should not affect in-tree builds. However, to ensure
> stability and compatibility, we encourage testing across different
> configurations.
> 
> What has been tested?
> - out-of-tree kernel build
> - out-of-tree kselftest-all
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index e5b8a8832c0c..36e65806bb5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -275,7 +275,8 @@ else ifeq ($(srcroot)/,$(dir $(CURDIR)))
>      srcroot := ..
>  endif
>  
> -export srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
> +srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
> +export srctree := $(if $(building_out_of_srctree),$(abs_srctree),$(srctree))
>  
>  ifdef building_out_of_srctree
>  export VPATH := $(srcroot)


The patch does fix the issue in the case you reported.

Maybe I'd write the change differently, though; rather than potentially
overwriting $(srctree) before exporting it, let's unroll with ifdef's to
make it clearer?

	ifdef building_out_of_srctree
	    srctree := $(abs_srctree)
	else ifdef KBUILD_EXTMOD
	    srctree := $(abs_srctree)
	else
	    srctree := $(srcroot)
	endif
	export srctree

(not tested)

Thanks,
Quentin

