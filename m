Return-Path: <linux-kselftest+bounces-23821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E249FF939
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82717160E10
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC81B0F21;
	Thu,  2 Jan 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="G25pdtLs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F31A8F71;
	Thu,  2 Jan 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819835; cv=none; b=qdVCXhMHfjqszhsjh5vVNlYxgIM862xYtE33BGkV4zTu1NG8VTapz+uVSKZ3dhz7NR3ov1FmvPbqu9tf25ycglEZwhLv612Xwv4R2NziFTNrzLkYqw05oZVbPOXk3g4KSn5UW6aHsey1DTlBA99kAouWxQwgt+CR/s03+y6qVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819835; c=relaxed/simple;
	bh=nHO7aMcaqWplyUVhEV3/XzoCazeJaQfAdkc4sWxxIXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgdCfOkESkdPyfiAjAnvVKsyGYdM/kYvEIxzVHwK7TisWglxnwu/amTqvVltbW0qtsA0P6jepB3GK8FQfil+KktqSm0MJ//wl18Dn2TDov5ucZMUW1BDXey0irzRk0QYtOcMrQnLvaOp6lHQikg7EFcbWmNEN24jPHGbEIn5k5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=G25pdtLs; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4YP52f6JKbzPl;
	Thu,  2 Jan 2025 12:03:38 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4YP52f291fzF1;
	Thu,  2 Jan 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=G25pdtLs;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1735819418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euA1s4tqvaa1JuxKiLr5lj/Tt4znoq56DOJJ9tN+nVk=;
	b=G25pdtLstq8tqtNNt2HnRpE2HfEqPa4HOs34v8BWLRmKSrvCr4IngnStM93T2krWHF9Bfa
	k84j4rwv23X5mjYjt92li9aJiy6dWMv6Tu1U7iC0uzUlGM8Hyh6+zukEDhfZZ/xEDfb1Mx
	gfLdSakD6cAU+biw3xgYxslYNmCfDgxUgJN+poHQZVr1PjJkvy46XAKC76teH26RQ0t8Ve
	UPigFEyFdnGt3hTRaWJxKioUffERs/J2Kr7IkAyzXtKe5Ty+k++2Nzw605YxSucEpOpYvt
	Ii4+2glgGuX/RUqQJMPOpdp0PM8BMyATdXADGGOuIhBbMPhZkbf+xLksnFQG8w==
X-CMAE-Score: 0
X-CM-Analysis: v=2.4 cv=e8f8Sbp/ c=1 sm=1 tr=0 ts=6776809a a=1BjqCW58WNvRLN6f/gJorg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=omOdbC7AAAAA:8 a=VwQbUJbxAAAA:8 a=cRoicrVNchjBets08OYA:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4xfGJp98eV3jbZTJH1JTmosxeJVXMU3nR520Q8ae/7RqtDavldxlp4+MR1Bc6C2B82Vb8u9kxBJA3d6AU8YULQm1vW6oyco97kwP6xxOP9jjm3lDoe3gin PJnB7IIa9qKO1mEul9QeXdOkcOwEIV2RouWTAkFY7Z0/u771DwGGMwklJDpIzWYM4No4aR8L08EI6lHVFbMvpHo34r0OqWAutYjmqrt8jFu9cN3ghipSfKLN foAZuo5edzgeIhrircod9YW2rFFu7Z98WsqmJLFwSoZoIRpt2yJLRRINY1g1EpQ6lOEYJkC526IhYL21LzrzWB19Q95i96QPdfGEQuLuIPcrCZwDRbq1pa3p zjSUH8FEEEvZ67wrSiDRMLSMAEMyVDKVeqTT3vWvp1DOs7xSSUDouaofVvyMvYhI7MD5rWcrxGMkfEKvADyavK+jARnmWVHKqJdKgq25nBOtWugQT00=
Message-ID: <56929291-3a6d-471b-8329-5acf5f3a7a0a@qmon.net>
Date: Thu, 2 Jan 2025 12:03:37 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] selftests/Makefile: override the srctree for
 out-of-tree builds
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20241223083342.1172756-1-lizhijian@fujitsu.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20241223083342.1172756-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-12-23 16:33 UTC+0800 ~ Li Zhijian <lizhijian@fujitsu.com>
> Fixes an issue where out-of-tree kselftest builds fail when building
> the BPF and bpftools components. The failure occurs because the top-level
> Makefile passes a relative srctree path to its sub-Makefiles, which
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
> 
> To resolve this, override the srctree in the kselftests's top Makefile
> when performing an out-of-tree build. This ensures that all sub-Makefiles
> have the correct path to the source tree, preventing directory resolution
> errors.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>


I simply tested with "make V=1 O=build/ TARGETS=hid kselftest-all", this
approach fixes the build just as well as v1. Thanks!

Tested-by: Quentin Monnet <qmo@kernel.org>

