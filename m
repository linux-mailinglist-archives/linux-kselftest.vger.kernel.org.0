Return-Path: <linux-kselftest+bounces-5368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D92861CCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC981C22CED
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EF1448F7;
	Fri, 23 Feb 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBY591L9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456F140362;
	Fri, 23 Feb 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717571; cv=none; b=pStvtSwAm80eKgo9MtFANMIJRCCGpveJJXBaigiIJ06kf9BrVW0kXx5GWAYtTHUUGOowGeQYT076f+IT6d9tMp1ozj1l4oOf6VpfSI8IVuToFu86gaPuyIUi1FgvwdzEK76DnuvVrDW5v4Sy6sNdiEPKKQ1pteVrLq0Boy3pZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717571; c=relaxed/simple;
	bh=mqXIqQqf6lEU0XrKwLtMVJZ8Wp9+q4U3TbvXwfpGX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOcnjnfY8dQCj6RL/RCbyUn56r7W24lPqrEg/AL0xpj38QEvNxMRGNgl1hsUipU0UDfgXukQ72kVW7vq1J7Rho2W5erjsEMo473odCW7f1FCddRaP6UY9JAbae99rf56Kc4SZ0TmAiBUuRS0ARTpq23Z9Q+hShYp9Vt6yH2jOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBY591L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F75C433F1;
	Fri, 23 Feb 2024 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717571;
	bh=mqXIqQqf6lEU0XrKwLtMVJZ8Wp9+q4U3TbvXwfpGX1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBY591L9wR07ev+vEtAYAv/reBCABFbtOgNeMpRxjnciE3UA7huMzcdReYLjVz3gi
	 KYhDSQVNFPE3o+Q00EqAC8c+XVTcVzFOtcdhpcP+EMvW8+8KoW0mJBYo5vulfCTnAy
	 CIsSN/G1XgaDiPxmL4rSUyqgfNbN9D1m66e3o8UDpBchfTj/dMHKeadLDNNcmfzMwc
	 r0s73vKccWUyjWcuy76K4kLrqJi7xJjMeDG9foZKLKdwCG+gNHzghar5lCllhLlld6
	 xC2S+NjQYOO38eNyEPgynt8iV5JzDyWkL3YiNF2HVApsc5ESZeFTfPdN8Fs4WoxxHa
	 vH5uKuyqvtDiA==
Date: Fri, 23 Feb 2024 20:46:04 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next v3 02/16] bpf/verifier: introduce
 in_sleepable() helper
Message-ID: <qajvrsg3neipbcmktzuxm7dpee6qaobgvq35bccupayoa6avff@56no2hfgitkk>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-2-1fb378ca6301@kernel.org>
 <CAADnVQKotZ0ki6p4DAydj=XE9hU6pPc+FdqU_WQ99NBK-qSe+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKotZ0ki6p4DAydj=XE9hU6pPc+FdqU_WQ99NBK-qSe+A@mail.gmail.com>

On Feb 22 2024, Alexei Starovoitov wrote:
> On Wed, Feb 21, 2024 at 8:25 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > @@ -18193,7 +18198,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
> >                                 return -E2BIG;
> >                         }
> >
> > -                       if (env->prog->aux->sleepable)
> > +                       if (in_sleepable(env))
> >                                 atomic64_inc(&map->sleepable_refcnt);
> 
> this one doesn't look correct.
> The verifier didn't start its main loop when resolve_pseudo_ldimm64()
> is called.
> It also loses symmetry with other sleepable_refcnt operations
> in syscall.c and core.c
> 
> I reverted this hunk and applied patches 1,2,3
> with minor edits, like removing unnecessary parens in patch 3,
> and patch subject rewords.

Thanks a lot. I'll work on the rest of the series next week.

Cheers,
Benjamin

