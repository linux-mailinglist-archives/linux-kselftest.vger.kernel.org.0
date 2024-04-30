Return-Path: <linux-kselftest+bounces-9118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514C8B6E36
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9253A1F21FB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19CB1292C8;
	Tue, 30 Apr 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA2HWGh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754AC12839B;
	Tue, 30 Apr 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468826; cv=none; b=oO9pi3PDBn7Dnir+/0mlZg0XQerbetXbW8yyr+5v6jjkItNETRGbCSnDqYpPg/4Vy9wd4XbcGqzujyr9H3zVHwBwUTTpJbnnMHQASgyE2wEeqza0OysHfS2e1QR91JILv0MhkbWul4k0nNEOlSaRG0AVRBfNN28DqFY9A9Y45Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468826; c=relaxed/simple;
	bh=Xbu2y6CEnMuOqaTTlEJrCaL9AxiPE5mbU/3qPzomh4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJtr8JTyFx5MxuRfIXzISBJjPfxjwXuWhyL9feEl5aqq7W8HQLmzapyk2eSVUDtTZvLHkAHASvqrNR0EP4OoXmdXbVuxsUxO8qqfkH7L9m6HbBQodDNnTqZGWdeFnEyo3UXSm4J2XyE70NM5MmsKvGEQbryf4gIHK9nBogvDrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA2HWGh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2EBC2BBFC;
	Tue, 30 Apr 2024 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714468825;
	bh=Xbu2y6CEnMuOqaTTlEJrCaL9AxiPE5mbU/3qPzomh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GA2HWGh+kXj9f0fz7r0sqxRweuRry/BPPh9hJXNUcZ7XWT4svfHvN0eTdsDl/6xce
	 nBhUMHvPX2geNdXPclSt5Eicmy7MO2LNua3z+yPv+K9udAIli7CQK3ECWy4jZHYuLl
	 p2AlHBDf/QGAn1JYh/yrK/q1YUXecScaX563AB64zeiW5nWj14KUwLWTY2w63KssbZ
	 Sef5paV+hFTLQAUV/QrYUtei6/WqPO/0VhaX/vU3AdJ8xkEVUejFFqbe0QpLeT8197
	 KWCTaRVVkVp69jgEz4088N9i+2PZSU+2l8FpRO1cAQgOM2DEW2oUePaiAa8D1PWQ8j
	 dTG2ZVWtShOQQ==
Date: Tue, 30 Apr 2024 11:20:19 +0200
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
Subject: Re: [PATCH 2/3] bpf: do not walk twice the hash map on free
Message-ID: <uaf4x2aczwt3fphtnxly4vvvnzcuq6wyhtawcoh6j3sjsf2f2w@6mmc3d5cwqev>
References: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org>
 <20240425-bpf-next-v1-2-1d8330e6c643@kernel.org>
 <CAADnVQK_7byWSkjVbmUFYLNA1+ER4xWz3dCE=K6ZCWLW=YMCBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK_7byWSkjVbmUFYLNA1+ER4xWz3dCE=K6ZCWLW=YMCBA@mail.gmail.com>

On Apr 25 2024, Alexei Starovoitov wrote:
> On Thu, Apr 25, 2024 at 6:59 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > If someone stores both a timer and a workqueue in a hash map, on free, we
> > would walk it twice.
> > Add a check in htab_free_malloced_timers_or_wq and free the timers
> > and workqueues if they are present.
> >
> > Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  kernel/bpf/hashtab.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 0179183c543a..20162ae741e9 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1515,7 +1515,7 @@ static void delete_all_elements(struct bpf_htab *htab)
> >         migrate_enable();
> >  }
> >
> > -static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer)
> > +static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab)
> >  {
> >         int i;
> >
> > @@ -1527,10 +1527,10 @@ static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer
> >
> >                 hlist_nulls_for_each_entry(l, n, head, hash_node) {
> >                         /* We only free timer on uref dropping to zero */
> > -                       if (is_timer)
> > +                       if (btf_record_has_field(htab->map.record, BPF_TIMER))
> >                                 bpf_obj_free_timer(htab->map.record,
> >                                                    l->key + round_up(htab->map.key_size, 8));
> > -                       else
> > +                       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
> >                                 bpf_obj_free_workqueue(htab->map.record,
> >                                                        l->key + round_up(htab->map.key_size, 8));
> >                 }
> > @@ -1544,18 +1544,12 @@ static void htab_map_free_timers_and_wq(struct bpf_map *map)
> >         struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> >
> >         /* We only free timer and workqueue on uref dropping to zero */
> > -       if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
> > +       if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE)) {
> >                 if (!htab_is_prealloc(htab))
> > -                       htab_free_malloced_timers_or_wq(htab, true);
> > +                       htab_free_malloced_timers_or_wq(htab);
> >                 else
> >                         htab_free_prealloced_timers(htab);
> >         }
> > -       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
> > -               if (!htab_is_prealloc(htab))
> > -                       htab_free_malloced_timers_or_wq(htab, false);
> > -               else
> > -                       htab_free_prealloced_wq(htab);
> 
> This looks wrong.
> htab_free_prealloced_wq() is now unused as compiler says:
> ../kernel/bpf/hashtab.c:243:13: warning: ‘htab_free_prealloced_wq’
> defined but not used [-Wunused-function]
>   243 | static void htab_free_prealloced_wq(struct bpf_htab *htab)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> 
> and prealloced maps with wq leak wq-s.

oops, you are right. Sending a v2 right away (sorry for the delay).

Cheers,
Benjamin

