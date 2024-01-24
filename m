Return-Path: <linux-kselftest+bounces-3457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A528A83ACDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D841A1C23D33
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2EF22085;
	Wed, 24 Jan 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePlmf1xU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8777622;
	Wed, 24 Jan 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109152; cv=none; b=DdGmZsay+uThWdJC9gKlbezA+t6gm7wYSV6Mkh3rtkH3XCgqqYVlf7dIwdtufk+FkYtywWLSBntlXaOfuQa3ZlMkblNbY2suZgRQSbHqClpeFB8srTh9NZi9KLBSRqO61v839iiQCSwuw3sQUw8wCosBUpLP0Xv69seZB8iF8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109152; c=relaxed/simple;
	bh=wfC03zoZ3529QzlkL1NJxd4ZXGSNuHiPokwD376BEfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inqSxX5iYG3WUpnCZMhbdNK3GUzeQ0hV+GXAmymqrU8gMThjnDRR2CsH+APXUmDhtH3qTamTuXhmR4BTlLmPlTitZQMAJmIW+Qia1VETCIJsL1nnzU84diWUuLt66n4+L2AsxxBayFX/o9x4xjDUOsiiC1CnSeuXMQMP+nLbsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePlmf1xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5249C433F1;
	Wed, 24 Jan 2024 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706109151;
	bh=wfC03zoZ3529QzlkL1NJxd4ZXGSNuHiPokwD376BEfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePlmf1xUwF23xA/cp661E1kcGNECj8m+f6ryEwXXq8GOlxstCfllrybJV6LPGtNz4
	 ybkYUd6JQO67OTKgIDQ5O0ubWHEvb104gmNITK/JqvKGrvYQ7/5rVJz9pfY00qaK8e
	 Y1hrcW8XxWfXFy0jEke1cgQc5hFxA09i9hem1lbLFmKeN7qu73nwcIilbtLPK+Bz8c
	 tVJf/ruIDcpAprzGlrupxvLfsBYTaHhNokhNujxd0OTZITDMtaKXRDaH7dAoVCI1xK
	 ltNUWDw7Gf+JG44iZCdjrl+li29Y5AUyJFhZYlHsaVHaNDCiXbaTtV3/unoxhyf3iK
	 Gqgxth/7H5bow==
Date: Wed, 24 Jan 2024 07:12:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Message-ID: <20240124071229.6a7262cc@kernel.org>
In-Reply-To: <a9a5378d-c908-4a83-a63d-3e9928733a3d@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
	<20240118085129.6313054b@kernel.org>
	<358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
	<20240118091327.173f3cb0@kernel.org>
	<a9a5378d-c908-4a83-a63d-3e9928733a3d@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 18:39:14 +0000 Dmitry Safonov wrote:
> > You probably want something smaller to be honest.
> > tools/testing/selftests/net/config has a lot of stuff in it 
> > and it's actually missing a lot more. I'm working thru adding
> > the missing options to tools/testing/selftests/net/config 
> > right now so far I got:  
> 
> Thanks!
> 
> I'll send a patch for it in version 2 (as I anyway need to address
> Simon's feedback).

Hi Dmitry!

I put TCP_AO and VETH in the config and the tests seem to fail with

selftests: net/tcp_ao: rst_ipv4
not ok 1 # error 834[lib/kconfig.c:143] Failed to initialize kconfig 2: No such file or directory
# Planned tests != run tests (0 != 1)
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:1

The script does:

target=net/tcp_ao
make mrproper

vng -v -b -f tools/testing/selftests/$target
# build the scripts
make headers
make -C tools/testing/selftests/$target

vng -v -r arch/x86/boot/bzImage --user root
# inside the VM
make -C tools/testing/selftests TARGETS=$target run_tests

