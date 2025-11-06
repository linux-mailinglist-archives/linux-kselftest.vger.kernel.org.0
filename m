Return-Path: <linux-kselftest+bounces-44868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F42C38D53
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 03:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C199618837A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 02:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD41239E75;
	Thu,  6 Nov 2025 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NayA01pH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535322D4E9
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395256; cv=none; b=W5lg8qO/7S6Zrkeg5q/tmTaOXnp+Xd24v1TkmPJrpS8by5vCVNtJD/B6mcCi+Z5g/63ZMg6mbGPYr7pfBO07GGK3e3H+INjxk4YMPkFMc3vpWPtOt04Sfj+zGWzvhiVO+jd32oPe65NFDTHUmOe/vaPjyWmQ1+0UdcDkkg/QpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395256; c=relaxed/simple;
	bh=vZP6Olr5BkV89fHbnFl2sWgdkU0Nu6NEN5nDJ+HXmt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVJgkYNq1hWVM7a3+yOW2x3FacIU5caJW3WzeN18D0UU6gvlw+tRd/gOYLBxed8QYlqqLJ4dmkft1BPxYcUgZczgdaPt/4WjdVrX+7FhYK0SucylOWgsLjf2jJDlg5SYwoGquplGzCTqJoQdrA+/3JKQRig4W4MONlVX+cz2Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NayA01pH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563bcaacso3052335e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395253; x=1763000053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pID6uUnnVVZ9vUknZjr7R/tHvBIqPxx/hilxjQ4G/4I=;
        b=NayA01pH7J4QAApvV6oY6JB9WF6zyrc7iVR/2oNn9ntLYTClVYcxFDZqneiLVuoy6t
         pe3+Ws2RO7Tej5S8Ulx3RaMx8N2E2KO1odP4b5A929XWZNqrWbtix44axXqAIb6gPFkx
         GlpFkNg0KsxsITlLCUtmQPoy8skXOh0PnXpYK8pcmGsNckYAp/JhiRyYX6FGoV38FsRg
         3q4xJ+VkUxESZj26RO8rCVai7geBECTyJsEt0fF3jisSwvvWbqBI+RXyHSazb0EvuRix
         JYKuzNgjhJkkvxkSr1n4QZIxcPw9TpF0mnWfRZTtxwfGSoEfFm9V1ubNoe0iZN5CSk3J
         TpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395253; x=1763000053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pID6uUnnVVZ9vUknZjr7R/tHvBIqPxx/hilxjQ4G/4I=;
        b=kQkcXasPFs8x3Ac8M2GtsIykg+0A7R54jKLtsMVNSsuajg9I8nIV84Am4XPjzvA+rM
         hVyqhWV3v077CWejAjYqaoqU9faDeTl0e1LzEupMyeyzT1vc97FPUxwZ3TvSNpIvyFIN
         6C6jzj6y9cDSCJc7IxJR/5eLSAMdcm3obSoGDSNeLqSO5KcOdKiTHYg+YRtKsm95n0wa
         ip6CY3azx++L3b/bnU5ct8OG5meABAtKbxVttcRIk9mnwI0HKCCZ07Riq5FzDzhGU4/3
         SKqQoxm0l94wcmuHrngtA6z0SSGN+HLCfyG69o3YaED8jBG06rpRdn5U2wa8wzU3wxGH
         uhFw==
X-Forwarded-Encrypted: i=1; AJvYcCXyLKArllQFUlZQWKHiVDuz1nDVg85fzCvZTZ6TC8ZkTh89QfBqWckBMillr7fMip5DFWVJ/5uLLABwdweUEy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZx+MxldFniEn6cU3jZr7pDjHPB0VaNnYHbdWuLGw6DNg+7Uv
	8Y0Y2oriW+JaMAgjrFQjSyNJ9bK6is+kE27lMO0XgNkFZ8slHtNzR44A4Bd+upa0H4vShU10J8G
	COJVSlUa4JhGzYcG6E5G/2N1OulcwMoE=
X-Gm-Gg: ASbGncuPsKEqLEKmOawFYq5781fAHF8tTI5HX5i+KwtKwkAC8AI5lecn3gjnZbHkjjh
	b1L6PA/UZTci173x8G2mxrapn2YmrQZrlS8K+G51tUgAA6DZEJ4J+kLiBiI7HXFYm5Anx1flBaV
	zgyFiwFTyTXkLTfoTS8mp3uE8mA2ApC7j5akSBrWgju1fDIE36wfpOOv6d9JP+WzCOqCjVnR7J5
	kVNl+UWVmPmHSZPAdpUaumguPjE/uILRKsY5rzTyg8L/74JFYJJYkd0a0DflGus+4A18xmxlaTj
	WAlb+WN8h+xiZqT17KGg0iZ6ADRr
X-Google-Smtp-Source: AGHT+IHNnfInoqONg+HdDsdA3ANtxnE3sVDgNmGAhLj4s+3clgxi2RV1/L4viLoDYukFGUUERUQj1xR+74oc6GYdLj4=
X-Received: by 2002:a05:600c:621b:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-4775ce7dfcfmr67517835e9.34.1762395252988; Wed, 05 Nov 2025
 18:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
 <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
 <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org> <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
 <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
In-Reply-To: <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:14:02 -0800
X-Gm-Features: AWmQ_bkDFU4rnwNyySArAEKJqcvgmyxv0uWO4gd3WyExlNwj1KcULnAVkj1_8jg
Message-ID: <CAADnVQL7cLYPKEQOLWi1DjTZjhE_Fy4zWLrWG+=NSeN821SyMw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Quentin Monnet <qmo@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:05=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2025-11-05 17:29 UTC-0800 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > On Wed, Nov 5, 2025 at 1:38=E2=80=AFAM Quentin Monnet <qmo@kernel.org> =
wrote:
> >>
> >> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com>
> >>> On Sat, Nov 1, 2025 at 12:34=E2=80=AFPM Harshit Mogalapalli
> >>> <harshit.m.mogalapalli@oracle.com> wrote:
> >>>>
> >>>> It is useful to print map ID on successful creation.
> >>>>
> >>>> JSON case:
> >>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 valu=
e 8 entries 128 name map4
> >>>> {"id":12}
> >>>>
> >>>> Generic case:
> >>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value =
8 entries 128 name map5
> >>>> Map successfully created with ID: 15
> >>>>
> >>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> >>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> >>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com=
>
> >>>> ---
> >>>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quent=
in]
> >>>> ---
> >>>>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
> >>>>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> >>>> index c9de44a45778..f32ae5476d76 100644
> >>>> --- a/tools/bpf/bpftool/map.c
> >>>> +++ b/tools/bpf/bpftool/map.c
> >>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
> >>>>         LIBBPF_OPTS(bpf_map_create_opts, attr);
> >>>>         enum bpf_map_type map_type =3D BPF_MAP_TYPE_UNSPEC;
> >>>>         __u32 key_size =3D 0, value_size =3D 0, max_entries =3D 0;
> >>>> +       struct bpf_map_info map_info =3D {};
> >>>> +       __u32 map_info_len =3D sizeof(map_info);
> >>>>         const char *map_name =3D NULL;
> >>>>         const char *pinfile;
> >>>>         int err =3D -1, fd;
> >>>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
> >>>>         }
> >>>>
> >>>>         err =3D do_pin_fd(fd, pinfile);
> >>>> -       close(fd);
> >>>>         if (err)
> >>>> -               goto exit;
> >>>> +               goto close_fd;
> >>>>
> >>>> -       if (json_output)
> >>>> -               jsonw_null(json_wtr);
> >>>> +       err =3D bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len)=
;
> >>>> +       if (err) {
> >>>> +               p_err("Failed to fetch map info: %s", strerror(errno=
));
> >>>> +               goto close_fd;
> >>>> +       }
> >>>>
> >>>> +       if (json_output) {
> >>>> +               jsonw_start_object(json_wtr);
> >>>> +               jsonw_int_field(json_wtr, "id", map_info.id);
> >>>> +               jsonw_end_object(json_wtr);
> >>>> +       } else {
> >>>> +               printf("Map successfully created with ID: %u\n", map=
_info.id);
> >>>> +       }
> >>>
> >>> bpftool doesn't print it today and some scripts may depend on that.
> >>
> >>
> >> Hi Alexei, are you sure we can't add any input at all? I'm concerned
> >> that users won't ever find the IDs for created maps they might want to
> >> use, if they never see it in the plain output.
> >>
> >>
> >>> Let's drop this 'printf'. Json can do it unconditionally, since
> >>> json parsing scripts should filter things they care about.
> >>
> >> I'd say the risk is the same. Scripts should filter things, but in
> >> practise they might just as well be comparing to "null" today, given
> >> that we didn't have any other output for the command so far. Conversel=
y,
> >> what scripts should not do is rely on plain output, we've always
> >> recommended using bpftool's JSON for automation (or the exit code, in
> >> the case of map creation). So I'm not convinced it's justified to
> >> introduce a difference between plain and JSON in the current case.
> >
> > tbh the "map create" feature suppose to create and pin and if both
> > are successful then the map will be there and bpftool will
> > exit with success.
> > Now you're arguing that there could be a race with another
> > bpftool/something that pins a different map in the same location
> > and success of bpftool doesn't mean that exact that map is there.
> > Other tool could have unpinned/deleted map, pinned another one, etc.
> > Sure, such races are possible, but returning map id still
> > looks pointless. It doesn't solve any race.
> > So the whole 'lets print id' doesn't quite make sense to me.
>
> OK "solving races" is not accurate, but returning the ID gives a unique
> handle to work with the map, if a user runs a follow-up invocation to
> update entries using the ID they can be sure they're working with the
> same map - whatever happened with the bpffs. Or they can have the update
> fail if you really want that particular map but, for example, it's been
> recreated in the meantime. At the moment there's no way to uniquely
> identify the map we've created with bpftool, and that seems weird to me.

ID is not unique. If somebody rm -rf bpffs. That ID will not point anywhere=
.
Also it's 31-bit space and folks in the past demonstrated an attack
to recycle the same ID.
So the users cannot be sure what ID is this.

