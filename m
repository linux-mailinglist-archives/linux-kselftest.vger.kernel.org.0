Return-Path: <linux-kselftest+bounces-29140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91440A62F03
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 16:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D685E17968F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EC2036E8;
	Sat, 15 Mar 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="mznAtxiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D917995E;
	Sat, 15 Mar 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742052054; cv=none; b=VDH/BjF+sCpWMd/74WeIm8etwG5nrIzDvq1d2cozm4wfnjR6eIuOWJ11P1pWLNuOIckVBQ7jabgabPuw1KwqoASXNXcM7p/Pd/gRLaByaLYew0DN0Y7kfl411gSNUl9iLLsXfJQGOzSXDHH/Uq86BfUL/4Sm26AK3lZP27de5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742052054; c=relaxed/simple;
	bh=08eKfAUvxdmkmUvYQ9Z9AT/EYdDCAc7pdtIm2LqpGzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1tYg7RndnSlMX6vvdB13F3a5TIozHsrKXkEsGCRJZw63K2SWfHcMbR3plZVh8S6CuS0GmY22/aijF7o2kbJN9P+ShQyDCrfGiHj3qkxn6VWAGhIdPwvKUSbHhmaPMK1dvL3biI7f6hxwJ7893KObXELZtHp5jALRI40TJIw7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=mznAtxiI; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1742052044; bh=08eKfAUvxdmkmUvYQ9Z9AT/EYdDCAc7pdtIm2LqpGzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=mznAtxiI1kJuIBGKAbfrHe6w8x8MA9DVTQPXk3d0my5iXVoXYyYABprKtB8tsWFBP
	 IkwTRc8+ap+WYBbwmrQWhSV0m9CL4aXTKUwg+EgWYk7H2Q9v6S26SmWQmn3h0tVjKP
	 PW4Hjph9jWSGlvjfSp3NqEYZMytJJebnCfFwlyQ8ItHpvN4IJwIJDGSJJj5nlIG8oB
	 f4y7PpcYRkrZFk59ynAPhYK+hN15mdRnsw+QqcsHbs4b5jq0Ljql5F3KPCtWe0TtvX
	 KOr+N2VQNrjSOSmQLSHS85rICmx9EfETv2j5XneoH+uB+VGhSTk9d7F9MyrYqRj2pR
	 UEDCDnkIFd04Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZFQ0q6mX6z8tyl;
	Sat, 15 Mar 2025 16:20:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:361f:c600:5210:4b80:a502:1f98
Received: from localhost (unknown [IPv6:2001:9e8:361f:c600:5210:4b80:a502:1f98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/OU7HXrel01HL8JhXs/U6F2fHJ1Gpb/vM=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZFQ0m590Xz8sYS;
	Sat, 15 Mar 2025 16:20:40 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>,  Xu Kuohai
 <xukuohai@huaweicloud.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Hari Bathini <hbathini@linux.ibm.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>,  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
  Mykola Lysenko <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,
  Henriette Herzog <henriette.herzog@rub.de>,  Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
  Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>,  Daniel Xu <dxu@dxuuu.xyz>,  bpf@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kselftest@vger.kernel.org,  George
 Guo <guodongtai@kylinos.cn>,  WANG Xuerui <git@xen0n.name>,  Tiezhu Yang
 <yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next 00/11] bpf: Mitigate Spectre v1 using barriers
In-Reply-To: <f6f08d64c777a6022771ab0adf96cefb6b631d75.camel@gmail.com>
	(Eduard Zingerman's message of "Fri, 14 Mar 2025 16:40:08 -0700")
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	<f6f08d64c777a6022771ab0adf96cefb6b631d75.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 15 Mar 2025 16:20:39 +0100
Message-ID: <87seneqq0o.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:
> I think it would be good to have some tests checking that nospec
> instructions are inserted in expected locations.
> Could you please take look at use of __xlated tag in e.g.
> tools/testing/selftests/bpf/progs/verifier_sdiv.c ?

That looks very promising, I will look into it for v2. Thanks for the
pointer.

I guess it might be worth it to add __xlated to at least on test per
nospec-related code path. If there are other rewrites at play that will
make it harder to adapt the tests when the other rewrite is ever
changed, but it might also help in catching interactions between the
other rewrites and the nospec.

Also, thanks for the review of patches 2 and 3.

