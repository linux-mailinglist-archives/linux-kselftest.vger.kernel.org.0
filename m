Return-Path: <linux-kselftest+bounces-40628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8CB40AF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7BF1B6023B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9F8335BC6;
	Tue,  2 Sep 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPosayci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C731AF2E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831652; cv=none; b=i5Zaomcu0GCPtj/sQAjHnry3SGtPwuPnhGJX7YUChrTJ1bdIZLN+AKYEeYjTVQSDJP5cw0ACX+ucz5K68QCbbXXju2/7X5WLLtAVtlJYuEPdHNvjoxVnI9QnaE2rwDzJ9EFATkvZjp8IgPnsISnjnQhLNHv8WWCF5ftGdSdoo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831652; c=relaxed/simple;
	bh=vJdN4aFngzTskRPWi73VuFR0pt7F21ZL6WABtIpqI8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUEhdIL1R5g45mBQCvvzdR/+jy/CCT5NnOiQn4grZDK8hUbj5w6FcUsFXedvadnvRHmxfytMtbMCua7C1ILw9AAfWhNL7fhOnlP3VzVFZ0gnj5HupRNiz642AOMnuHBEUf+LoTt2QW4uHsUdv+06uBfMcD0QvXsBrX4eR5p3J5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPosayci; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24936b6f29bso2865ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756831650; x=1757436450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7wbahk73cKnPK3dR5KuGsOmOcYX7wfKMEr43Kl+X2c=;
        b=kPosaycidl0hIQWgN1U4VQM5n7JP7YHRRJTnEIothb/QO2UVTnKj4CqEyY2ge52VLD
         yBlAnJpZodMnhNeD4QB2VDRFq1V7bBxa94LdeRP3fo98RjZnv+qz4sjgMIYm5SPFAX5O
         pYTzy8Y+8DBtVLXbuKGgBjp9aDbkRhqRI2PY9MhSaRivznmqtkPMKhnUgwMsWRqMByXe
         gLTUGp7usNusEKjLaXENQFAsdSd1gFMacfmd/qVLGE7n3HUic1PRuq0L++dIwhH3v9dV
         JS7nr8Vpab/vg8B+TnZe9IyjAJbJpstQemCfl5jLlHx/o4npJgbgrxioOSxMUXgyA1pO
         JZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831650; x=1757436450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7wbahk73cKnPK3dR5KuGsOmOcYX7wfKMEr43Kl+X2c=;
        b=Sf8Z5NHByEGN7O4b+mVkhy02CCQ43WZJT/EOg6WnhocuDIDGKafUn9AH4qLL8uTVFX
         St29+zaAYeI307HFLJUUatu7sux23kiIFtC6U7hJnHJmqLzvl5TsZDSJtUzBK3RNKzfE
         DetRWnCOkTJuCPh7JzXx8KQqB2PClqgJzGKnXlkAq4L4DM2P6Wl1rqaFPnD6+HMoc1O8
         Mjghtdvni/5Pn/dOct9VbUOMRcVm9hRRu/jIgoH/JRRHxd2IZTu4goRm9NTcGIhHtnjC
         w2BLvc3NlAgA9LvXWHdXEqAXPa7il2h/1/nmi8RU9LvbyO3XJLG/e6KRvobBeNhjHysh
         JUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4CmcZ7Q2QWyzemzkkvLPj80wr7sQ/Vjr+YWWF2XQlqtMRwoFQEi9X/cY9pqcvsKPhcsy8oLvgknPCSXeRWZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7E0AnfC3qVEcORJfMyfEGp6c1/l0dcuU1wyPNUfGaNZEOSco
	ZcCAewYOgmDel8qLYUbnDQM6nlreAhvI5tFg+Eam+sms/MQGnXg0yd/WQDRbQRe14jNcWrrJ9BL
	itGnXHR64sjnZXokuaRasrQ4q9XZiMHATnMFT5ju2
X-Gm-Gg: ASbGnctw+9bPzAKWdBUQwzttXkY9qHo+kCJoF1aDXV7NP+PbKvy7DTKz81r/B13hYFi
	l7rhY4/i3FeSbgZRnLmYAA1jVl/haS4aJxwEuS9Bw1uR/0UdasDzxGTLjeFs+YJHlsaaLN0l9a/
	i6LjA23IStIOmGeQ7eSxYKQytnPrHgUYbJgA1Wyl++nSl9GHHzIdfixiLcK+55vjRzGPL9FwvAC
	uHP8WUVFMmcU0sZk+ny8sA6IBBVRUZBwYdH5oR+8qJaGEKFMvdj
X-Google-Smtp-Source: AGHT+IFlWytMNRpJ+W5etnxGnSMVwTu3Roq4RhqpxRJvK82mRn8zbyCoD8S1hd4xaod7fMolCZT5mFJ/kAZFSnXeBk8=
X-Received: by 2002:a17:902:f689:b0:248:a039:b6e3 with SMTP id
 d9443c01a7336-2493e9af74bmr10462235ad.10.1756831649858; Tue, 02 Sep 2025
 09:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com>
 <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
 <CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com>
 <466d45ae-ce97-4256-9444-9f25f3328c51@linux.dev> <aLVR0-CUGgwHvFpF@google.com>
 <CAP-5=fX8pw91DQCW0sva_U4A2UGXynNApOHcb3SVT8eRZ=DtyA@mail.gmail.com>
In-Reply-To: <CAP-5=fX8pw91DQCW0sva_U4A2UGXynNApOHcb3SVT8eRZ=DtyA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Sep 2025 09:47:18 -0700
X-Gm-Features: Ac12FXznmz5gusdkym-cgOyI9DnEm1bOqgsHdHcQ-zfBZqouH499cLFWhANzSIE
Message-ID: <CAP-5=fWPSHVGBcqBC0x0VXOzYPRfOLiZ_dZsNxfEMhMBRs6=ZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Namhyung Kim <namhyung@kernel.org>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>, jolsa@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Blake Jones <blakejones@google.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, mykolal@fb.com, shuah@kernel.org, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:04=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Sep 1, 2025 at 12:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Sun, Aug 31, 2025 at 09:17:34PM -0700, Yonghong Song wrote:
> > >
> > >
> > > On 8/29/25 10:19 PM, Ian Rogers wrote:
> > > > On Thu, Jun 5, 2025 at 2:00=E2=80=AFPM <patchwork-bot+netdevbpf@ker=
nel.org> wrote:
> > > > > Hello:
> > > > >
> > > > > This series was applied to bpf/bpf-next.git (master)
> > > > > by Andrii Nakryiko <andrii@kernel.org>:
> > > > >
> > > > > On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
> > > > > > The BTF dumper code currently displays arrays of characters as =
just that -
> > > > > > arrays, with each character formatted individually. Sometimes t=
his is what
> > > > > > makes sense, but it's nice to be able to treat that array as a =
string.
> > > > > >
> > > > > > This change adds a special case to the btf_dump functionality t=
o allow
> > > > > > 0-terminated arrays of single-byte integer values to be printed=
 as
> > > > > > character strings. Characters for which isprint() returns false=
 are
> > > > > > printed as hex-escaped values. This is enabled when the new ".e=
mit_strings"
> > > > > > is set to 1 in the btf_dump_type_data_opts structure.
> > > > > >
> > > > > > [...]
> > > > > Here is the summary with links:
> > > > >    - [v3,1/2] libbpf: add support for printing BTF character arra=
ys as strings
> > > > >      https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
> > > > >    - [v3,2/2] Tests for the ".emit_strings" functionality in the =
BTF dumper.
> > > > >      https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1
> > > > >
> > > > > You are awesome, thank you!
> > > > I believe this patch is responsible for segvs occurring in v6.17 in
> > > > various perf tests when the perf tests run in parallel. There's lot=
s
> > >
> > > Could you share the command line to reproduce this failure?
> > > This will help debugging. Thanks!
> >
> > My reproducer is below:
> >
> > terminal 1: run perf trace in a loop.
> >
> >   $ while true; do sudo ./perf trace true; done
> >
> > terminal 2: run perf record in a loop until hit the segfault.
> >
> >   $ while true; do sudo ./perf record true || break; done
> >   ...
> >   perf: Segmentation fault
> >       #0 0x560b2db790e4 in dump_stack debug.c:366
> >       #1 0x560b2db7915a in sighandler_dump_stack debug.c:378
> >       #2 0x560b2d973b1b in sigsegv_handler builtin-record.c:722
> >       #3 0x7f975f249df0 in __restore_rt libc_sigaction.c:0
> >       #4 0x560b2dca1ee6 in snprintf_hex bpf-event.c:39
> >       #5 0x560b2dca2306 in synthesize_bpf_prog_name bpf-event.c:144
> >       #6 0x560b2dca2d92 in bpf_metadata_create bpf-event.c:401
> >       #7 0x560b2dca3838 in perf_event__synthesize_one_bpf_prog bpf-even=
t.c:673
> >       #8 0x560b2dca3dd5 in perf_event__synthesize_bpf_events bpf-event.=
c:798
> >       #9 0x560b2d977ef5 in record__synthesize builtin-record.c:2131
> >       #10 0x560b2d9797c1 in __cmd_record builtin-record.c:2581
> >       #11 0x560b2d97db30 in cmd_record builtin-record.c:4376
> >       #12 0x560b2da0672e in run_builtin perf.c:349
> >       #13 0x560b2da069c6 in handle_internal_command perf.c:401
> >       #14 0x560b2da06b1f in run_argv perf.c:448
> >       #15 0x560b2da06e68 in main perf.c:555
> >       #16 0x7f975f233ca8 in __libc_start_call_main libc_start_call_main=
.h:74
> >       #17 0x7f975f233d65 in __libc_start_main_alias_2 libc-start.c:128
> >       #18 0x560b2d959b11 in _start perf[4cb11]
> >
> >
> > I manually ran it with gdb to get some more hints.
> >
> >   Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
> >   0x00005555558e8ee6 in snprintf_hex (buf=3D0x5555562c1d79 "", size=3D5=
03, data=3D0x40 <error: Cannot access memory at address 0x40>, len=3D8)
> >       at util/bpf-event.c:39
> >   39                    ret +=3D snprintf(buf + ret, size - ret, "%02x"=
, data[i]);
> >
> > The data is bpf_prog_info->prog_tags and it's called from
> > synthesize_bpf_prog_name().
> >
> >   (gdb) bt
> >   #0  0x00005555558e8ee6 in snprintf_hex (buf=3D0x5555562c1d79 "", size=
=3D503, data=3D0x40 <error: Cannot access memory at address 0x40>,
> >       len=3D8) at util/bpf-event.c:39
> >   #1  0x00005555558e9306 in synthesize_bpf_prog_name (buf=3D0x5555562c1=
d70 "bpf_prog_", size=3D512, info=3D0x55555665e400, btf=3D0x5555562c5630,
> >       sub_id=3D0) at util/bpf-event.c:144
> >   #2  0x00005555558e9db5 in bpf_metadata_create (info=3D0x55555665e400)=
 at util/bpf-event.c:403
> >   #3  0x00005555558ea85b in perf_event__synthesize_one_bpf_prog (sessio=
n=3D0x555556178510,
> >       process=3D0x5555555ba7ab <process_synthesized_event>, machine=3D0=
x555556178728, fd=3D25, event=3D0x5555561b73a0,
> >       opts=3D0x5555560d33a8 <record+328>) at util/bpf-event.c:674
> >   #4  0x00005555558eadf8 in perf_event__synthesize_bpf_events (session=
=3D0x555556178510,
> >       process=3D0x5555555ba7ab <process_synthesized_event>, machine=3D0=
x555556178728, opts=3D0x5555560d33a8 <record+328>)
> >       at util/bpf-event.c:799
> >   #5  0x00005555555beef5 in record__synthesize (rec=3D0x5555560d3260 <r=
ecord>, tail=3Dfalse) at builtin-record.c:2131
> >   #6  0x00005555555c07c1 in __cmd_record (rec=3D0x5555560d3260 <record>=
, argc=3D1, argv=3D0x7fffffffe2e0) at builtin-record.c:2581
> >   #7  0x00005555555c4b30 in cmd_record (argc=3D1, argv=3D0x7fffffffe2e0=
) at builtin-record.c:4376
> >   #8  0x000055555564d72e in run_builtin (p=3D0x5555560d63c0 <commands+2=
88>, argc=3D6, argv=3D0x7fffffffe2e0) at perf.c:349
> >   #9  0x000055555564d9c6 in handle_internal_command (argc=3D6, argv=3D0=
x7fffffffe2e0) at perf.c:401
> >   #10 0x000055555564db1f in run_argv (argcp=3D0x7fffffffe0dc, argv=3D0x=
7fffffffe0d0) at perf.c:445
> >   #11 0x000055555564de68 in main (argc=3D6, argv=3D0x7fffffffe2e0) at p=
erf.c:553
> >
> > I seems bpf_prog_info is broken for some reason.
> >
> >   (gdb) up
> >   #1  0x00005555558e9306 in synthesize_bpf_prog_name (buf=3D0x555556330=
5b0 "bpf_prog_", size=3D512, info=3D0x55555664e1d0, btf=3D0x55555637ad40,
> >       sub_id=3D0) at util/bpf-event.c:144
> >   144           name_len +=3D snprintf_hex(buf + name_len, size - name_=
len,
> >
> >   (gdb) p *info
> >   $1 =3D {type =3D 68, id =3D 80, tag =3D "\\\000\000\000\214\000\000",=
 jited_prog_len =3D 152, xlated_prog_len =3D 164,
> >     jited_prog_insns =3D 824633721012, xlated_prog_insns =3D 1185410973=
912, load_time =3D 1305670058276, created_by_uid =3D 352,
> >     nr_map_ids =3D 364, map_ids =3D 1975684956608, name =3D "\330\001\0=
00\000\350\001\000\000$\002\000\0004\002\000", ifindex =3D 576,
> >     gpl_compatible =3D 0, netns_dev =3D 2697239462496, netns_ino =3D 28=
34678416000, nr_jited_ksyms =3D 756, nr_jited_func_lens =3D 768,
> >     jited_ksyms =3D 3418793968396, jited_func_lens =3D 3573412791092, b=
tf_id =3D 844, func_info_rec_size =3D 880, func_info =3D 3934190044028,
> >     nr_func_info =3D 928, nr_line_info =3D 952, line_info =3D 429496729=
6988, jited_line_info =3D 4449586119680, nr_jited_line_info =3D 1060,
> >     line_info_rec_size =3D 1076, jited_line_info_rec_size =3D 1092, nr_=
prog_tags =3D 1108, prog_tags =3D 4861902980192,
> >     run_time_ns =3D 5085241279632, run_cnt =3D 5257039971512, recursion=
_misses =3D 5360119186644, verified_insns =3D 1264,
> >     attach_btf_obj_id =3D 1288, attach_btf_id =3D 1312}
>
> Thanks Namhyung!
>
> So it looks like my "fix" was breaking the tools/perf build feature
> test for btf_dump_type_data_opts opts.emit_strings and that was
> avoiding this code.
>
> Having terminal 1 run perf trace is going to be loading/unloading a
> BPF program for system call augmentation. This must be creating the
> race condition that is causing perf record to segv when it is
> inspecting the bpf_prog_info.
>
> The cast in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/util/bpf-event.c#n135
> ```
> static int synthesize_bpf_prog_name(char *buf, int size,
>     struct bpf_prog_info *info,
>     struct btf *btf,
>     u32 sub_id)
> {
> u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(uintptr_t)(info->prog_tags);
> ```
> looks concerning given the bad address comes from:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/util/bpf-event.c#n144
> ```
> name_len +=3D snprintf_hex(buf + name_len, size - name_len,
> prog_tags[sub_id], BPF_TAG_SIZE);
> ```
> Checking git blame this code has existed since 2019, commit
> 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF
> programs"):
> http://lkml.kernel.org/r/20190117161521.1341602-8-songliubraving@fb.com
> it was refactored in 2019 to a single memory allocation commit
> ("a742258af131 perf bpf: Synthesize bpf events with
> bpf_program__get_prog_info_linear()")
> http://lkml.kernel.org/r/20190312053051.2690567-5-songliubraving@fb.com
>
> There seems like a potential race here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/util/bpf-utils.c#n123
> ```
> /* step 1: get array dimensions */
> err =3D bpf_obj_get_info_by_fd(fd, &info, &info_len);
> ```
> and later:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/util/bpf-utils.c#n185
> ```
> /* step 5: call syscall again to get required arrays */
> err =3D bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
> ```
> There's a verification step that looks to cover issues with the race.
> I thought making those warnings fatal may help, but no:
> ```
> --- a/tools/perf/util/bpf-utils.c
> +++ b/tools/perf/util/bpf-utils.c
> @@ -202,14 +202,20 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
>                 v1 =3D bpf_prog_info_read_offset_u32(&info, desc->count_o=
ffset);
>                 v2 =3D bpf_prog_info_read_offset_u32(&info_linear->info,
>                                                    desc->count_offset);
> -               if (v1 !=3D v2)
> +               if (v1 !=3D v2) {
>                         pr_warning("%s: mismatch in element count\n", __f=
unc__);
> +                       free(info_linear);
> +                       return ERR_PTR(-EFAULT);
> +               }
>
>                 v1 =3D bpf_prog_info_read_offset_u32(&info, desc->size_of=
fset);
>                 v2 =3D bpf_prog_info_read_offset_u32(&info_linear->info,
>                                                    desc->size_offset);
> -               if (v1 !=3D v2)
> +               if (v1 !=3D v2) {
>                         pr_warning("%s: mismatch in rec size\n", __func__=
);
> +                       free(info_linear);
> +                       return ERR_PTR(-EFAULT);
> +               }
>         }
>
>         /* step 7: update info_len and data_len */
> ```
>
> Fwiw, the address of "data=3D0x40" in the stack trace makes it looks
> like an offset has been applied to NULL. 0x40 is 64 which corresponds
> with "name" info a bpf_prog_info by way of pahole:
> ```
> struct bpf_prog_info {
>         __u32                      type;                 /*     0     4 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
> ...
>         char                       name[16];             /*    64    16 *=
/
> ```
>
> I feel we're relatively close to discovering a proper fix for the
> issue, if others could lend a hand as I'm not overly familiar with the
> BPF code. I'm wondering if the second bpf_obj_get_info_by_fd could be
> filling in offsets relative to NULL rather than returning an error,
> but this would be (I believe) a kernel issue :-(

It's a use-after-free perf bug:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/bpf-event.c?h=3Dperf-tools-next#n660
```
/* save bpf_prog_info to env */
info_node =3D malloc(sizeof(struct bpf_prog_info_node));
if (!info_node) {
err =3D -1;
goto out;
}

info_node->info_linear =3D info_linear;
info_node->metadata =3D NULL;
if (!perf_env__insert_bpf_prog_info(env, info_node)) {
free(info_linear);
free(info_node);
}
info_linear =3D NULL;
...
/* Synthesize PERF_RECORD_BPF_METADATA */
metadata =3D bpf_metadata_create(info);
```
The insert can fail due to a duplicated BPF program (the sideband data
thread is racing with the synthesizing thread in perf) leading to
info_linear to be freed which the info points into. The later use of
the freed memory leads to the crash.

I hope that's all it is and I'll work on a fix.

Thanks,
Ian

