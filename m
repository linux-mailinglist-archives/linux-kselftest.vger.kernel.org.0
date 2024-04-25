Return-Path: <linux-kselftest+bounces-8878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD658B2922
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 21:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB1A1C213A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017215250D;
	Thu, 25 Apr 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQkvF1UN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F314D70C;
	Thu, 25 Apr 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074531; cv=none; b=PN7UVJaKiBiqpzFzFS/C70zY6dp2waoQpBGJcm5I1dL1rjFrA5WVWXojg4poC8AtmtZclPGJa/k35K9KPxlSV9MYo4FTMfpLXG9tdjPLrdQBdYu1RZPFIqnOGb2qvr+NKNJNiiRgwNQ2oGPcQFt4ZwiXzBMtzKkY6SayGdGmji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074531; c=relaxed/simple;
	bh=f06bKjxosNqzVCgffaQZfH2FehyF+hFriMTlQfc5egQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJce1msIQlS+4lP5UqK66TkV7pomP1Jfs3FwAgwOnbY7h8RNiY7wN+ss/xSwIGe07Xvo5aGkKS1tPG3EbNW0lhEno7TLRSTFQwIVaxMk/o+AO+2ypB9+BkXLQ/C7TrU901EpRFXEAVBuKk4ept720QTMVBktx3LN7yKR0VJX/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQkvF1UN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3499f1bed15so1509979f8f.1;
        Thu, 25 Apr 2024 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714074529; x=1714679329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htAT7EtjhF7pbsJMji3zhseRMQK3h5kfe4HgcsBoeuU=;
        b=kQkvF1UN8bnvTP79VUWkZIXxqrzuVeIRQMZiDjUfPc4I3so1cy4R4hHbL5f0uAfRcA
         pufwbjODgIZ7P7UyPZjPZT6savhFpdprmdmyWqIFZPNe8hU7fbWRxUcKT1jhqckSYskX
         udkFKWyM8RH1UfxZfQ2AfM/QN7Ed/OmTjOVtfAhv/LowlFbnjfTGfsbIijm6ZcCJwdKI
         T7lTKQzq10bxPBKRWU0mTGP3jRIbsvG/ZBoOKv1ikpJZzOAgwpaVlpntvybWjBtHHgLP
         59hAMvb/dp0dw6hJJ9WTRSCJWpaLNSrqPF3MMRKaEcjlJ1Seg4oBa8UV3tyZZw2l4o6J
         wLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714074529; x=1714679329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htAT7EtjhF7pbsJMji3zhseRMQK3h5kfe4HgcsBoeuU=;
        b=r4ZYqBjfQM2oN22GvHRDKg5kPTt0vgX+g/RxLJCsVRSPkb40fJ3mFONgGWDGtpHQmO
         5blunDdf68RvJjVlk1KF499iLjDJDUXTi3rfpsh3JaikfUfxp12Tk8THRA4fFM1OsAxG
         IX0k3DRD6Rx+IO93qsfbYPDbGqAnx0K8/4fc5NnVarTLsNrKzwJYK1Bc3iuk6S5UZcvu
         idAWmSssoQ/QktwyTXsoXg5wwKVuMnxBxJF3fSVvEmdrkAB0nHk/54O0an4MfFW3fxpg
         CTzl+uO5Elkk2ZKTryvNuf/ix0CYxsPVQ65W12+u2KJX7CkzuheyvDNK9hH/miFQnRta
         bLOw==
X-Forwarded-Encrypted: i=1; AJvYcCWDe6mydpQS3Ew+Vx20onqOdhUVBx5meTmUtV9FwQr7Weh1pPLugYjB+wCILRULeDeyb1v1UCgJN6IrPM+thwO/S3aNmXAydyyRUBvA9R6VGymp20zsoTEzVugPZjYAGEzeAze7ISFjGe61RV0Yit3OkorGt14DWCz7+TsOL/02lG3l
X-Gm-Message-State: AOJu0Yw2/rAZAbAcOLfU5sYt/BQWPl6dIaaINbfPprjLbcn/YQttgOD0
	YXamRupRTt0HXVnkLg/BvZEsZpwynLJr6SUzSyI/navxvVKabC2Y5GiYv7XDr3iYivHN74QEKEP
	xOo1D+yWrO8nkctNgLtOhYe8Ouyc=
X-Google-Smtp-Source: AGHT+IFrP+6/kMSMo6TgTTZPw2wLhZbtWDvCatg0SXqfZLi8tOu5tq/3vWf3YdbuA2Ph4CeUWPu5BQ38TxpsnwCOCq0=
X-Received: by 2002:a05:6000:1567:b0:34a:5d48:a708 with SMTP id
 7-20020a056000156700b0034a5d48a708mr914529wrz.0.1714074528359; Thu, 25 Apr
 2024 12:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org> <20240425-bpf-next-v1-2-1d8330e6c643@kernel.org>
In-Reply-To: <20240425-bpf-next-v1-2-1d8330e6c643@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Apr 2024 12:48:36 -0700
Message-ID: <CAADnVQK_7byWSkjVbmUFYLNA1+ER4xWz3dCE=K6ZCWLW=YMCBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: do not walk twice the hash map on free
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 6:59=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> If someone stores both a timer and a workqueue in a hash map, on free, we
> would walk it twice.
> Add a check in htab_free_malloced_timers_or_wq and free the timers
> and workqueues if they are present.
>
> Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymap=
s and hashmaps")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  kernel/bpf/hashtab.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 0179183c543a..20162ae741e9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1515,7 +1515,7 @@ static void delete_all_elements(struct bpf_htab *ht=
ab)
>         migrate_enable();
>  }
>
> -static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool =
is_timer)
> +static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab)
>  {
>         int i;
>
> @@ -1527,10 +1527,10 @@ static void htab_free_malloced_timers_or_wq(struc=
t bpf_htab *htab, bool is_timer
>
>                 hlist_nulls_for_each_entry(l, n, head, hash_node) {
>                         /* We only free timer on uref dropping to zero */
> -                       if (is_timer)
> +                       if (btf_record_has_field(htab->map.record, BPF_TI=
MER))
>                                 bpf_obj_free_timer(htab->map.record,
>                                                    l->key + round_up(htab=
->map.key_size, 8));
> -                       else
> +                       if (btf_record_has_field(htab->map.record, BPF_WO=
RKQUEUE))
>                                 bpf_obj_free_workqueue(htab->map.record,
>                                                        l->key + round_up(=
htab->map.key_size, 8));
>                 }
> @@ -1544,18 +1544,12 @@ static void htab_map_free_timers_and_wq(struct bp=
f_map *map)
>         struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
>
>         /* We only free timer and workqueue on uref dropping to zero */
> -       if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
> +       if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQU=
EUE)) {
>                 if (!htab_is_prealloc(htab))
> -                       htab_free_malloced_timers_or_wq(htab, true);
> +                       htab_free_malloced_timers_or_wq(htab);
>                 else
>                         htab_free_prealloced_timers(htab);
>         }
> -       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
> -               if (!htab_is_prealloc(htab))
> -                       htab_free_malloced_timers_or_wq(htab, false);
> -               else
> -                       htab_free_prealloced_wq(htab);

This looks wrong.
htab_free_prealloced_wq() is now unused as compiler says:
../kernel/bpf/hashtab.c:243:13: warning: =E2=80=98htab_free_prealloced_wq=
=E2=80=99
defined but not used [-Wunused-function]
  243 | static void htab_free_prealloced_wq(struct bpf_htab *htab)
      |             ^~~~~~~~~~~~~~~~~~~~~~~

and prealloced maps with wq leak wq-s.

pw-bot: cr

