Return-Path: <linux-kselftest+bounces-8453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAE8AB286
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FF12866D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825501304B5;
	Fri, 19 Apr 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr4H5TbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573711304A5;
	Fri, 19 Apr 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542130; cv=none; b=j0ekU7IL0tRrbV7TrniHlHcOglxounnqsR08h5w+4RE/PYamYiEeHiHr8cVlnvQDS04VKo4udWKG1T8z9PdG0D27UoNgb61Bs93QErZpVZTa6MN1jrmvkiJ/2ACua8Dyk9HoxB4C8VxrIGEbfDWV6GjTksFKUUwiExFSXdR8SvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542130; c=relaxed/simple;
	bh=AdnkUZ4BxyxoMF4croWKhJcA1cUJ96+sbBUrt1HWBp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1CyVP5yGzrPAm3rCXkLiHaeBfjauac+bSLkNkGh7PdguMJn0baZTGP/MdIAUapMeGFDV6TnoyKTjz+iSXLf8GQFNJ6uNrWCyVLTT8zoY/q4/gB2L9kJCeqYW/B2zoDxvI4dts+D8TFvBImw6Y9uCtaW/ZjRiUweyP1QwgSAN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr4H5TbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C06EC3277B;
	Fri, 19 Apr 2024 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713542129;
	bh=AdnkUZ4BxyxoMF4croWKhJcA1cUJ96+sbBUrt1HWBp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr4H5TbJTo7tzx1BNWZxjH7hWqblNLozEhIN3T5lkjSv12y8/Fpf7nkpyD91BrAZe
	 qEgJGBsPr8dBFGZdPrlnvROC7IWkMie/odW5skJyu0TVte72KgLsYETxBA+K9r+fLk
	 I5gPpmSzTiICULjPr30mt/FV9IOLL0lroMhU+ENYMeIwdTB/bfSwi+GhfDc9vlOKVB
	 +BiU2To0dds8a+DtM1kLzluQmbeowvwVNG+xWGrakBKL5/+ErHlehhXu/DQSGlqCPS
	 3uIEEYDqrD82OrWkYny9a20MMYkbAidfh2QHBVvu+S3QdtY+NRfvsDmdmikdbJ9f8W
	 i8pLYKb08RScA==
Date: Fri, 19 Apr 2024 17:55:23 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 11/18] bpf: wq: add bpf_wq_init
Message-ID: <6zslg7atmsexqi3htt7auka3gvwx7pouxva4zsxv2pn5syun35@hgqunkasn2id>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-11-c9e66092f842@kernel.org>
 <f7awluzevpzqhqo5a65dxlfoo3dhkvbpntb4a5uueq2v7gjj7b@ddoyfpeymg3u>
 <tqj7biswz4ktars2mjrog35sijfgnm2nmvqrzbldphksbtj4kj@qd3digliqsjm>
 <CAADnVQKpC_11C3LNia6uGD5yAe5QeViYHD6TEHKBtEi3L6awLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKpC_11C3LNia6uGD5yAe5QeViYHD6TEHKBtEi3L6awLg@mail.gmail.com>

On Apr 19 2024, Alexei Starovoitov wrote:
> On Fri, Apr 19, 2024 at 8:12 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> >
> > It's something I added while adding the tests. And some tests were passing
> > in case I was having a non sleepable callback. But if we have
> > bpf_rcu_read_lock(), we are all fine and can reduce the complexity.
> 
> Not quite following what was the issue.
> Since the verifier is unconditionally verifying such callback as sleepable
> the callback won't be able to access rcu pointers without doing
> explicit bpf_rcu_read_lock() first (and few other code patterns
> might be rejected), but that's a good thing.

Oh, I missed that. Well, given that the verifier enforces everything, I
guess we are good :)

> Maybe next to set_cb kfunc add a comment that wq callbacks are sleepable.
> I think bpf prog writers are often with kernel background,
> so it will be their natural assumption that cb is sleepable.

I assume so as well.

Cheers,
Benjamin

