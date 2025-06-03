Return-Path: <linux-kselftest+bounces-34252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112CACCEA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F06D7A79E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807D223DF1;
	Tue,  3 Jun 2025 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="IBFvhYON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9D223DC0;
	Tue,  3 Jun 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984858; cv=none; b=HhF9xXp7+Cv9in1yxuQ3ZLWjtCa+bAfeZIv+bUkrs9KySin+K9rNwq7vWONL9xMMhS1c/Hzbxr7nO0nZJK7FPErDre7muzhkdzaRUzyLOGlRzWzIKlFpJwSkLSzwjetCwsXNPD7Qn4LO+h3AaRmXxN/pIvB6v3Fy0yAG6ETnwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984858; c=relaxed/simple;
	bh=14iBWL0wepR+/NLmlKQ5GYaXgIUdICdBtkY2wCSNDec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3LPKvw+SEYLGVY2mua7Udq71wq4+9tFhBLOcny9KilgvR5zcNcJ2XJA586b/kq8TCR5wM1BM+hS0LONaz3v/Czyu4TowkJhX9/LuYYLPYbJsTyHHysFJFvS98lqQx+qtZAd7BMrVnsYo3fYTVAsutsN59RwU9kqO1GV1ttCo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=IBFvhYON; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1748984854; bh=14iBWL0wepR+/NLmlKQ5GYaXgIUdICdBtkY2wCSNDec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=IBFvhYONv1CxQ8hzdbccA0do1pDzSADmtjNUFlQU2JzbsM12pPTYhLqvp37pahvoE
	 rrSrdmfNp3Nt5YGuMGnGjDGzELq5uRsNqxzq59EQ9Y+oEFk/5LUgAmyLeW3lTt8liJ
	 PlK98jVBngVNcPhrktkxboft4I+BIC2odUZKVqEsSrdJKgB98QfpDecgaq8hYROMWk
	 rqSxwb0QPnb1QogbfEmhDL03tC4gSOK4xXbwLWMwnOZLdU7sIjNK2N2/70zNkTHzr5
	 Ick8KcekAT4d/emYkOsQucPmA6u70cGX/m+ebNbKfXlTQlmQzIjB+icu8wvzfzGkSX
	 sHL3W5JZwzsBA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bBjw63sNsz8swQ;
	Tue,  3 Jun 2025 23:07:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3639:fe00:a21f:4ce4:8495:5578
Received: from localhost (unknown [IPv6:2001:9e8:3639:fe00:a21f:4ce4:8495:5578])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19rrgm+35nUwSoCdL9l4H5ISQMck9KR3zw=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bBjw24t9Nz8shV;
	Tue,  3 Jun 2025 23:07:30 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
 Lysenko <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  Henriette
 Herzog <henriette.herzog@rub.de>,  Saket Kumar Bhaskar
 <skb99@linux.ibm.com>,  Cupertino Miranda <cupertino.miranda@oracle.com>,
  Jiayuan Chen <mrpre@163.com>,  Matan Shachnai <m.shachnai@gmail.com>,
  Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>,  Daniel Xu <dxu@dxuuu.xyz>,  bpf@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kselftest@vger.kernel.org,
  Maximilian Ott <ott@cs.fau.de>,  Milan Stephan <milan.stephan@fau.de>
Subject: Re: [PATCH bpf-next v3 10/11] bpf: Allow nospec-protected
 var-offset stack access
In-Reply-To: <CAP01T76HZ+s5h+_REqRFkRjjoKwnZZn9YswpSVinGicah1pGJw@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Fri, 2 May 2025 02:03:12 +0200")
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
	<20250501073603.1402960-11-luis.gerhorst@fau.de>
	<CAP01T76HZ+s5h+_REqRFkRjjoKwnZZn9YswpSVinGicah1pGJw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Tue, 03 Jun 2025 23:07:30 +0200
Message-ID: <874iwwlejx.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Hmm, while reading related code, I noticed that sanitize_check_bounds
> returns 0 in case the type is not map_value or stack.
> It seems like it should be returning an error, cannot check right now
> but I'm pretty sure these are not the two pointer types unprivileged
> programs can access?
> So smells like a bug?

I now looked into this and as suspected it does not appear to be a bug
but only misleading code, I have sent a patch with a detailed
explanation and an assert:
https://lore.kernel.org/bpf/20250603204557.332447-1-luis.gerhorst@fau.de/T/#u

