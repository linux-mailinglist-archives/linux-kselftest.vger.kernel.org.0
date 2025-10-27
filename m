Return-Path: <linux-kselftest+bounces-44143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB2C1195B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 22:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CADE4E4D14
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD12F39CD;
	Mon, 27 Oct 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDOWOWpY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833722D948A;
	Mon, 27 Oct 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602220; cv=none; b=cEP2sn7LVfrLHqD0G+GSpeFkFKATh98epg9nbXsGF7v/m9btzdmiXLH+Yt08AwbiCZUwt0ODnnNeiu4ppfWf8cFD46m4REBC755BoOSMfZR8GF3AR4ezWIB+ZqnW8AGYjdMnubxG+Y9lfI8ASN3aIj/iidRs9dewpOD9//FMt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602220; c=relaxed/simple;
	bh=PhTuulUnuNJxdh+bqpaUAUviCKrrigpWKFSlbU6eK6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQx3meM/h578ygSf6JPiu6xbJqp1P67ZLAN2VBE5MAPo2+vwCrbavSWWAA6mMdqOECQod3SN5U7enwccN1xHlVkhaPG71tqC00yEJ3DTM1s4PC+tKhfh7Sy5t2arl7RfIBUfyNId1082pV2ugFu4nrFgUQ4ejFkZrxVIsREOT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDOWOWpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E989C4CEF1;
	Mon, 27 Oct 2025 21:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761602220;
	bh=PhTuulUnuNJxdh+bqpaUAUviCKrrigpWKFSlbU6eK6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDOWOWpYdC3iUEABEyDdOZfN1doQMoHd828VGip0za1SZuOHiwWMA7pSWpquVqMV/
	 ZbUh8mqPfyHEXOooC8nlSyJraxoZ0FNwf/TwtcNDo4JLEyGqvqArNdwNHqBP44icRT
	 Wt113dUBaFBPEAlEEDDLrCTTyyF2K/MLBYM5+TvrqCHC79wZga6yGa0dwqrQmgF8sQ
	 jRfG3yT6AWyI8vJbLEyInWEuN82QA0H5LE7Ak3ZAlR9VKXpGW5RrH2I9BWSN+2uuWL
	 /qCt18OSTflX/srFi8SmJfygw288pjHN2AxzKmXCOJGFc/DzdZzkW2fyPGHPBrl0AZ
	 BgAgeWLr63cVQ==
Date: Mon, 27 Oct 2025 18:56:57 -0300
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
Message-ID: <aP_qqVvDjB99NQNk@x1>
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
 <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
 <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev>
 <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
 <CAADnVQKNpd8SCawQbW69ALWNZMoOvxwRbBQELqzh0P52iXG=kw@mail.gmail.com>
 <aP-InycOjSO8EqcO@x1>
 <aP-LE7ssid10iKw-@x1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aP-LE7ssid10iKw-@x1>

On Mon, Oct 27, 2025 at 12:09:11PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 27, 2025 at 11:58:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Oct 23, 2025 at 08:42:34AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Oct 23, 2025 at 12:50 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> > > > thanks, but version 1.30 didn't work in my tests - even pahole's master branch fails, only the next branch works...
> > 
> > > > It seems that the 'old' pahole parses some kfuncs incorrectly, for example bpf_dynptr_slice().

> > > the introduction of the 'next' branch screwed up the workflow for many people.
> > > Let's remove it and merge everything into master.
> > > People expect master branch to be the one where active development
> > > is happening and the source of truth for the latest features.

> > My bad, I've been away for too long, next is supposed to be with things
> > for a short while, testing for a few days, for CI consumption, then move
> > to master, rinse repeat.

> > I think we should go back to that model.

> The difference is small but can explain as has changes to the btf
> loader, and the reporter, as I now checked the whole thread, says that
> 'next' works for him, so I'll move what is in 'next' to 'master' now.

> Just for reference since I had done it, my investigation is below.

So I had some random 'korg/next' local branch and a 'korg' remote and
that messed up my analysis, there are more csets in the 'next' branch,
so I'm doing more tests, tomorrow I'll probably have more news.
 
- Arnaldo
> 
> ⬢ [acme@toolbx pahole]$ git remote update korg
> Fetching korg
> ⬢ [acme@toolbx pahole]$ 
> ⬢ [acme@toolbx pahole]$ git remote -v | grep korg
> korg	https://git.kernel.org/pub/scm/devel/pahole/pahole.git (fetch)
> korg	https://git.kernel.org/pub/scm/devel/pahole/pahole.git (push)
> ⬢ [acme@toolbx pahole]$ git diff --stat korg/master korg/next 
> warning: refname 'korg/next' is ambiguous.
>  .github/scripts/build-pahole.sh      | 23 +++++++++++++++++++++++
>  .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++++
>  .github/workflows/test.yml           |  4 ++--
>  .github/workflows/vmtest.yml         |  4 ++++
>  CMakeLists.txt                       |  5 -----
>  README                               |  4 ++++
>  btf_loader.c                         | 23 ++++++++++++++++++++---
>  dwarves_fprintf.c                    |  2 +-
>  8 files changed, 84 insertions(+), 11 deletions(-)
> ⬢ [acme@toolbx pahole]$
 
> Related to btf bitfields:
 
> diff --git a/btf_loader.c b/btf_loader.c
> index f4f9f65289b5acac..64ea68022ab04e60 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -645,9 +645,15 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
>                 pos->byte_size = tag__size(type, cu);
>                 pos->bit_size = pos->byte_size * 8;
>  
> -               /* if BTF data is incorrect and has size == 0, skip field,
> -                * instead of crashing */
> +               /* If the BTF data is incorrect and has size == 0, skip field
> +                * instead of crashing. However the field can be a zero or
> +                * variable-length array and we still need to infer alignment.
> +                */
>                 if (pos->byte_size == 0) {
> +                       pos->alignment = class__infer_alignment(conf,
> +                                                               pos->byte_offset,
> +                                                               tag__natural_alignment(type, cu),
> +                                                               smallest_offset);
>                         continue;
>                 }
>  
> @@ -672,7 +678,18 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
>                                                         pos->byte_offset,
>                                                         tag__natural_alignment(type, cu),
>                                                         smallest_offset);
> -               smallest_offset = pos->byte_offset + pos->byte_size;
> +
> +               /* Compute the smallest offset between this field and the next
> +                * one.
> +                *
> +                * In case of bitfields we need to take into account the
> +                * actual size being used instead of the underlying type one as
> +                * it could be larger, otherwise we could miss a hole.
> +                */
> +               smallest_offset = pos->byte_offset;
> +               smallest_offset += pos->bitfield_size ?
> +                       (pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
> +                       pos->byte_size;
>         }
>  
>         tag_type->alignment = class__infer_alignment(conf,

