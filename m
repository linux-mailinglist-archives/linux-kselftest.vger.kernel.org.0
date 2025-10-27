Return-Path: <linux-kselftest+bounces-44106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B275C0EBDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC62018985A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0825A62E;
	Mon, 27 Oct 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7eI11FZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DF2877DE;
	Mon, 27 Oct 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577123; cv=none; b=cDGM3dvXVntCKuerIovEci+8p7p5+2WjC0+kddgDncGSLO7Eu6yMuxU22eNzEEGKOWRn0iY0U+xLt+tmMYlOKLwtevY4UQuLSlMVsZlRAo13KqdqKJr71VhlAWNHfvw4hh1H51x7ZlbffuF9fdhlwkHJ5AgTrqV+VDCiSsn2bmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577123; c=relaxed/simple;
	bh=J4IcbHH72tttwScsxDcOZXYt/Xb1HXGYmpoD06P5Fm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2W8z1Y94WjENB8wWQ6JWQAPZl+yy/dG+rUnzPpobasQHhgIvpdFaGE5e5dUNtBJ7bm0GV0StRDZJYVLZNr3oqzM0btXmi5cOxcKVnR83DnsvMTc3IZX2kqo+NXA1iK6Jy922rDWQ+xRS8KiTmnZBM5ABIVxuKy3zDKdk4BLt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7eI11FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA48C4CEFF;
	Mon, 27 Oct 2025 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577122;
	bh=J4IcbHH72tttwScsxDcOZXYt/Xb1HXGYmpoD06P5Fm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7eI11FZ9cjFNlOnNHzau2ivoqgFCVM0rTfyq9weBdd5MLU7+Xkue3mz2aWuqoaBK
	 WCTC9l+AoJVf3JW3JNXAII/MM5gReqIHSL8J05EtTGR0TaNd2mmOfu63Mbc+YpKZ/k
	 h8mKtl0HcI0yOSCPZcs0IZtJmwebrNaqoQiLZMJ+uYrKWq9NRiHcsJ5QnrtCMvV1/m
	 PlJ6VwqJ2Dnz9V/6hh7ox5SAfgBDhuo9aInOoqPBzhV9eGd+fGHPaIX8l1S6gK3go/
	 UVMfPDSeuRbaCzjjjmLk2SUHHd8cavD8AzxMMknSlw/m+nIG8gGQx/sFBU4sQh31Ug
	 4ipDaeQ/TOD/Q==
Date: Mon, 27 Oct 2025 11:58:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alan Maguire <alan.maguire@oracle.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>
Subject: Re: pahole next->master. Was: [PATCH bpf-next v1] selftests/bpf:
 Guard addr_space_cast code with __BPF_FEATURE_ADDR_SPACE_CAST
Message-ID: <aP-InycOjSO8EqcO@x1>
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
 <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
 <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev>
 <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
 <CAADnVQKNpd8SCawQbW69ALWNZMoOvxwRbBQELqzh0P52iXG=kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKNpd8SCawQbW69ALWNZMoOvxwRbBQELqzh0P52iXG=kw@mail.gmail.com>

On Thu, Oct 23, 2025 at 08:42:34AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 23, 2025 at 12:50 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> > thanks, but version 1.30 didn't work in my tests - even pahole's master branch fails, only the next branch works...
> >

> > It seems that the 'old' pahole parses some kfuncs incorrectly, for example bpf_dynptr_slice().
l
> Alan,
 
> the introduction of the 'next' branch screwed up the workflow for many people.
> Let's remove it and merge everything into master.
> People expect master branch to be the one where active development
> is happening and the source of truth for the latest features.

My bad, I've been away for too long, next is supposed to be with things
for a short while, testing for a few days, for CI consumption, then move
to master, rinse repeat.

I think we should go back to that model.

- Arnaldo

