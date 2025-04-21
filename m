Return-Path: <linux-kselftest+bounces-31253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C457BA952AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B6F3ABE7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3841917E4;
	Mon, 21 Apr 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="orBiie4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215D18FDB9;
	Mon, 21 Apr 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245388; cv=none; b=CiNbTOzpAlbDgXBbdN0tWl0uuQZ4pPOL0JBZjJ+8PbCYO1z6U+CYHkkDi65FHim2H0YeC+5kZM2idDHBLKCa/5vAn6pfkI0PvZ1//4mX5v+5WP9F+3GDWXhkvQk3uhgbro27oU/ToRY/0iV3HkcyMV9m8ohumsWhowPn/GZQY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245388; c=relaxed/simple;
	bh=/UvmjxB5mlDWIFPWdct8ipmty768fSsHQ+TK4B982ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6L6l+Gh/9jiXx5NZqCyEtlB5/xLw3aGerwDrvt/ko9i8aorBAfs1ekeR7aEsfrvN//epRe3jBmUsYcje1j9TW5dFYKK3S3WDxvJGLewJaRz0iCRtlLvEFQP6sOzZs0IUOi4Yf1T9WmwTXySZaECBI2kV4fCiIlOK7SCe4pwDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=orBiie4c; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1745245384; bh=dHRKLKa57WaRcw3gsgSapFs5eoq+g/y962Gr8FAxtJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=orBiie4cvNrHVv1JbBWkrpOyYmyGmifj9slSFQzZ0sJetOlRXTDNVGexBpdHSLlCj
	 cIRmDtYCELKKpt25P9o50N7Y+j9jsWe+aLzGb7aUsWJA9N64p44PwD8KSuAJ4OjZJB
	 XZ/ImmqlxC4T3CkcYfAZJBcM3JIzvolN8AqEG1ESQtwmvQXdXlF0t9Lnu4dsv8XVMd
	 dOj+KKY125Rtr8bCcieX7+VlKdKSQWGglObQaut+Mmr0zxuF1dr3qH1s8G40zgEohX
	 itn/AJJ+UntW48id29kZH/dXMJJNuSAKYM4NQG3NbSOJdhyEJRv3pYs07IFq2UTGT0
	 zumuzse94SOdg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zh6zD2qDxzPjmG;
	Mon, 21 Apr 2025 16:23:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3600:7e00:5b67:6b9c:caeb:75c
Received: from localhost (unknown [IPv6:2001:9e8:3600:7e00:5b67:6b9c:caeb:75c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+yS0Gm16sXrv8zOrS9nARAtw0fhZkEU8I=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zh6yw2GKwzPjsn;
	Mon, 21 Apr 2025 16:22:48 +0200 (CEST)
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
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 henriette.herzog@rub.de
Subject: Re: [PATCH bpf-next v2 05/11] bpf, arm64, powerpc: Add
 bpf_jit_bypass_spec_v1/v4()
In-Reply-To: <202504212142.V3yjAcaI-lkp@intel.com> (kernel test robot's
	message of "Mon, 21 Apr 2025 21:17:56 +0800")
References: <20250421091802.3234859-6-luis.gerhorst@fau.de>
	<202504212142.V3yjAcaI-lkp@intel.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 21 Apr 2025 16:22:47 +0200
Message-ID: <87r01lzj9k.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> All warnings (new ones prefixed by >>):
>
>>> kernel/bpf/core.c:3037:13: warning: no previous prototype for 'bpf_jit_bypass_spec_v1' [-Wmissing-prototypes]
>     3037 | bool __weak bpf_jit_bypass_spec_v1(void)
>          |             ^~~~~~~~~~~~~~~~~~~~~~
>>> kernel/bpf/core.c:3042:13: warning: no previous prototype for 'bpf_jit_bypass_spec_v4' [-Wmissing-prototypes]
>     3042 | bool __weak bpf_jit_bypass_spec_v4(void)
>          |             ^~~~~~~~~~~~~~~~~~~~~~

That's because the prototypes in include/linux/bpf.h were in the #ifdef
CONFIG_BPF_SYSCALL. I fixed this for v3 by moving the prototypes out of
the ifdef.

