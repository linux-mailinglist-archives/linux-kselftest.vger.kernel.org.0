Return-Path: <linux-kselftest+bounces-31701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C1A9DA40
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01791BC65A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35656224B01;
	Sat, 26 Apr 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Y0zaE4Y9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDC18DB24;
	Sat, 26 Apr 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664890; cv=none; b=EgNemFBiPGdn+AHf/ZwFT6W3af71QBzBTnIZkq20iaDt/Xps9Br4mvgs2oW6GIwBh0D027o2KdTftg9tCb5ycQmeGyvaLCwOZSUIIGdI2RoNYWyds+pjkjFa52urAm0x+zJdm9Z+OUnQcY/gcFV947C2VZmQ2KWeEG5pmlngtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664890; c=relaxed/simple;
	bh=pfTUN7VblrVWs0X8J5yIVJ7DlvkoxvoG5PUJxWpJ3QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MhapexuxKfmoU2pG9KeF7Kn1IYn70Y9XHJcjxUjeH1KM5T5MKEZz8ogzqiuhJxIHZFuaxbKeNw9RBCK/+fr67TjNrV1hM6rvl71gCuC8VM3MC1FoZ0uZd6icK0wieqJXs3sxy6PxVui3dPVTa2fy/J/ozPWvl8J5NdkngRK4Cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=Y0zaE4Y9; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1745664879; bh=Ce0GIrbVfPWC7H8gy4FhbwT9KDZQbFbYWNbCLDBescY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=Y0zaE4Y9YZ0haQY9H50iAWqNCuovbbuQ7R25J9ew8C6QDDjBdXmPhnIaOdR7ckEuH
	 hMAoEYrWTjho84BJUjxwmy7qHUKTALqbu6vYKqX3ZIP53Pwa6YbZdN+9x+tPs0fk4U
	 natPf1ZcLG1WRhbeqA9mqq1aEEdOv0vcx5Z0DaGjT9mfjq16B6QFaHno2/nd1hTofx
	 rTDA7W35vkIwtud31kdGsJcLA+DWKpLTCbcA1quyi48iUmZ5ou3M6AeUJJHiEr2Xxh
	 yEo7p6HlwHUqb/6Cf5O9+SNrdyGEH9llvJd66rQ2B3AKpu8llaYHx+Pb9+kfW/s/nV
	 X9PcK+83aAJUg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zl66Q6ybQz1yN6;
	Sat, 26 Apr 2025 12:54:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:361b:dc00:c019:e67c:3dc8:e824
Received: from localhost (unknown [IPv6:2001:9e8:361b:dc00:c019:e67c:3dc8:e824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19VP6nuyGgC1ZFJikQ/3jfzd/7EixAh4QE=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zl66M4BX7z1xys;
	Sat, 26 Apr 2025 12:54:35 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: kernel test robot <lkp@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Puranjay Mohan
 <puranjay@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>,  Catalin
 Marinas <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Hari
 Bathini <hbathini@linux.ibm.com>,  Christophe Leroy
 <christophe.leroy@csgroup.eu>,  Naveen N Rao <naveen@kernel.org>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  Mykola
 Lysenko <mykolal@fb.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  Henriette Herzog <henriette.herzog@rub.de>,  Saket Kumar Bhaskar
 <skb99@linux.ibm.com>,  Cupertino Miranda <cupertino.miranda@oracle.com>,
  Jiayuan Chen <mrpre@163.com>,  Matan Shachnai <m.shachnai@gmail.com>,
  oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 06/11] bpf, arm64, powerpc: Change nospec to
 include v1 barrier
In-Reply-To: <202504220035.SoGveGpj-lkp@intel.com> (kernel test robot's
	message of "Tue, 22 Apr 2025 00:24:41 +0800")
References: <20250421091802.3234859-7-luis.gerhorst@fau.de>
	<202504220035.SoGveGpj-lkp@intel.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 26 Apr 2025 12:54:35 +0200
Message-ID: <874iyb6vmc.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> All errors (new ones prefixed by >>):
>
>    arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
>>> arch/powerpc/net/bpf_jit_comp64.c:814:4: error: a label can only be part of a statement and a declaration is not a statement
>      814 |    bool sync_emitted = false;
>          |    ^~~~
>>> arch/powerpc/net/bpf_jit_comp64.c:815:4: error: expected expression before 'bool'
>      815 |    bool ori31_emitted = false;
>          |    ^~~~
>>> arch/powerpc/net/bpf_jit_comp64.c:833:6: error: 'ori31_emitted' undeclared (first use in this function)
>      833 |      ori31_emitted = true;
>          |      ^~~~~~~~~~~~~
>    arch/powerpc/net/bpf_jit_comp64.c:833:6: note: each undeclared identifier is reported only once for each function it appears in

Fixed this for v3. For the other archs, the patches also don't add
declarations in a switch/case.

I also checked that there are no new W=2 warnings for the touched C
files on x86 with the vmtest bpf config.

I have not checked that all files that include a touched header don't
have new warnings. When doing -j $(nproc) the diff does not work and
with -j 1 it takes forever (e.g., because bpf.h is touched). If you
think this is required just let me know (and if you have a tip on how to
do it more quickly that would be great too).

