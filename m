Return-Path: <linux-kselftest+bounces-40491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E77B3ECEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED23A9B18
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489AA30E831;
	Mon,  1 Sep 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHQxuqkq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483730649C
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746316; cv=none; b=pndXU/xopKvLzAHzXzup1BTDwD+d4hftzIEhW0ifgMKwI2gcyft0ID3eV5VIeECdowr5aLuMqfcstJyxsC4ddXbLVf0+SI1j1P/VRzIxTKf06ou6eaFCAqNYuCZylaPp7CW6rKc6x9qsrUSg1A5MyMlhkuuaRkPV31g0/FVZVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746316; c=relaxed/simple;
	bh=llCRiK3lXe/yiSxV/HR1Xc5Qrk4yyd3AIXRrlGnoLu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQXsDMMIf9Rz9fsTdtkX5tbK27kM/Ie1enkRxoZuULea655UK0+AFpvQ2SafeeRgu8CDe/EvmP47lU3jsTnJnJthopZKvAGKlt2SwR8dsGltAldS/CVsyyhXsgC74SSxMli337fbno3DMEs37suVB3aZ53f88OUr/7HQX6OaihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHQxuqkq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248f08d31dcso374615ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756746314; x=1757351114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QoLjwxK8LzjBpJjG48ipDPj+TT/xUD3SQc2FJAfA6g=;
        b=GHQxuqkq7UpcFCQk2+7PCcwS9ZjxjtnLztju6nRNSEp/XiMMTL1fh1saAVAZt/AhCn
         WVJ7j47gb5V6/c2DU5AfSWG6VuXqKJGdD3+CoB6ZCrbpVrAP3GUQamIaXqrQD2RY+3WY
         N4f8MweTrukQq87h6mTDrvu3s45somixyJysFDGBfsoAm6aH+Zw5I/aUufGOEo7cyphn
         ldjr3MyxY7YAlsWCDers6QAUP/Gcw6svKIR8VdH6MjVUxbglOPDQULQUEvK87C9Iy7Um
         lYrB4hYFElSMjftcr/PtDNo4g5iljaWmM0mDduulaVptwCHAmhNo6jANFuYZVCNigvLp
         x8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746314; x=1757351114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QoLjwxK8LzjBpJjG48ipDPj+TT/xUD3SQc2FJAfA6g=;
        b=lBXHhQlNfNqZMqi0GxFDRtBpZrM+fAjFeNyNJF3pe6JV7bfdbttG+C8Tiozxwt1JkH
         XQnqRaqzX01m5VIFZxlxkA9V+tiV3RqKzYEXU8v1EOTIBFKCiP5eI/OQqNty15z/hU8d
         sVhgaPwJbuGSBVpKv5mYT4aSHGjxkYhww1O2WotCaOh0Nh+1V6+dX6kt+oXYUtmQY+YS
         SN7vMHg+V7TuHrNKVyD+It50iTK7MxheCMzu6hIsa4K9xuNOqCWfsg5DHPQ+eax/efQ8
         C+vH2AuSdn41KUiD7n8WKbG/mCs95hlHiyi/HUFqbPjmlTBfGYP83PRE7UMj/V0lef6w
         NFKw==
X-Forwarded-Encrypted: i=1; AJvYcCUPUCEFyDJjjKADSZG3mlLXKezMnaOwc2iI+fkY3ZNqDResGQOTU9j3g2WFsOMjPCS4cK/CFad7114uAxalyoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKFtt3VcL0urw7HO64peHTouyXiuG/eIUBbMvq5jkggMxfypE
	2Q6v5aYWW7jh/9sFbVKYzDbZTrUjqkfvqSQomsM1cs9IZD9NL8JLais5I6FSuT22Njhbb1kZZpn
	YnGT2eDSX8HZUmiER5Fyc1blnEdf7EE4IXfBMCmFC
X-Gm-Gg: ASbGncsew5RThWv1j37BnqdgJvr/5oAHXsGI8A3HYWLBUahvJcLJOUiTxtrQSDfgNAZ
	QgvRspNk1DwCvTuC19tkqMvl2E/DctgC5HZ3sw7hxCOLfooHxkO982PSH+EGm7fnvRRh5MbgFHb
	EabayuAeh221Q52RGMuwJYIkRHfJ9e/vlOpZk6I+HRMjQioQxOqc8bX2CBBkjiYWdbEkrW4ScZl
	g75X80w5KHKyo4UIUP2qX2gEg==
X-Google-Smtp-Source: AGHT+IGxr2n1ICZCkOCSejEisAdttrmgKp3a/giGaeEq1JSBg/w2iNQL7nhul/1i1Mogs/tTZxLItOvyD2WkTxvPHbU=
X-Received: by 2002:a17:902:b713:b0:248:aa0d:f826 with SMTP id
 d9443c01a7336-2493e8fb30bmr4947575ad.6.1756746313082; Mon, 01 Sep 2025
 10:05:13 -0700 (PDT)
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
In-Reply-To: <aLVR0-CUGgwHvFpF@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 1 Sep 2025 10:04:58 -0700
X-Gm-Features: Ac12FXzgZcMksbwkyCOaS4g_EKgW3lTS0HlcliQGDdMfcvQaA-H39vJcWvqvrqI
Message-ID: <CAP-5=fX8pw91DQCW0sva_U4A2UGXynNApOHcb3SVT8eRZ=DtyA@mail.gmail.com>
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

On Mon, Sep 1, 2025 at 12:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Aug 31, 2025 at 09:17:34PM -0700, Yonghong Song wrote:
> >
> >
> > On 8/29/25 10:19 PM, Ian Rogers wrote:
> > > On Thu, Jun 5, 2025 at 2:00=E2=80=AFPM <patchwork-bot+netdevbpf@kerne=
l.org> wrote:
> > > > Hello:
> > > >
> > > > This series was applied to bpf/bpf-next.git (master)
> > > > by Andrii Nakryiko <andrii@kernel.org>:
> > > >
> > > > On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
> > > > > The BTF dumper code currently displays arrays of characters as ju=
st that -
> > > > > arrays, with each character formatted individually. Sometimes thi=
s is what
> > > > > makes sense, but it's nice to be able to treat that array as a st=
ring.
> > > > >
> > > > > This change adds a special case to the btf_dump functionality to =
allow
> > > > > 0-terminated arrays of single-byte integer values to be printed a=
s
> > > > > character strings. Characters for which isprint() returns false a=
re
> > > > > printed as hex-escaped values. This is enabled when the new ".emi=
t_strings"
> > > > > is set to 1 in the btf_dump_type_data_opts structure.
> > > > >
> > > > > [...]
> > > > Here is the summary with links:
> > > >    - [v3,1/2] libbpf: add support for printing BTF character arrays=
 as strings
> > > >      https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
> > > >    - [v3,2/2] Tests for the ".emit_strings" functionality in the BT=
F dumper.
> > > >      https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1
> > > >
> > > > You are awesome, thank you!
> > > I believe this patch is responsible for segvs occurring in v6.17 in
> > > various perf tests when the perf tests run in parallel. There's lots
> >
> > Could you share the command line to reproduce this failure?
> > This will help debugging. Thanks!
>
> My reproducer is below:
>
> terminal 1: run perf trace in a loop.
>
>   $ while true; do sudo ./perf trace true; done
>
> terminal 2: run perf record in a loop until hit the segfault.
>
>   $ while true; do sudo ./perf record true || break; done
>   ...
>   perf: Segmentation fault
>       #0 0x560b2db790e4 in dump_stack debug.c:366
>       #1 0x560b2db7915a in sighandler_dump_stack debug.c:378
>       #2 0x560b2d973b1b in sigsegv_handler builtin-record.c:722
>       #3 0x7f975f249df0 in __restore_rt libc_sigaction.c:0
>       #4 0x560b2dca1ee6 in snprintf_hex bpf-event.c:39
>       #5 0x560b2dca2306 in synthesize_bpf_prog_name bpf-event.c:144
>       #6 0x560b2dca2d92 in bpf_metadata_create bpf-event.c:401
>       #7 0x560b2dca3838 in perf_event__synthesize_one_bpf_prog bpf-event.=
c:673
>       #8 0x560b2dca3dd5 in perf_event__synthesize_bpf_events bpf-event.c:=
798
>       #9 0x560b2d977ef5 in record__synthesize builtin-record.c:2131
>       #10 0x560b2d9797c1 in __cmd_record builtin-record.c:2581
>       #11 0x560b2d97db30 in cmd_record builtin-record.c:4376
>       #12 0x560b2da0672e in run_builtin perf.c:349
>       #13 0x560b2da069c6 in handle_internal_command perf.c:401
>       #14 0x560b2da06b1f in run_argv perf.c:448
>       #15 0x560b2da06e68 in main perf.c:555
>       #16 0x7f975f233ca8 in __libc_start_call_main libc_start_call_main.h=
:74
>       #17 0x7f975f233d65 in __libc_start_main_alias_2 libc-start.c:128
>       #18 0x560b2d959b11 in _start perf[4cb11]
>
>
> I manually ran it with gdb to get some more hints.
>
>   Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
>   0x00005555558e8ee6 in snprintf_hex (buf=3D0x5555562c1d79 "", size=3D503=
, data=3D0x40 <error: Cannot access memory at address 0x40>, len=3D8)
>       at util/bpf-event.c:39
>   39                    ret +=3D snprintf(buf + ret, size - ret, "%02x", =
data[i]);
>
> The data is bpf_prog_info->prog_tags and it's called from
> synthesize_bpf_prog_name().
>
>   (gdb) bt
>   #0  0x00005555558e8ee6 in snprintf_hex (buf=3D0x5555562c1d79 "", size=
=3D503, data=3D0x40 <error: Cannot access memory at address 0x40>,
>       len=3D8) at util/bpf-event.c:39
>   #1  0x00005555558e9306 in synthesize_bpf_prog_name (buf=3D0x5555562c1d7=
0 "bpf_prog_", size=3D512, info=3D0x55555665e400, btf=3D0x5555562c5630,
>       sub_id=3D0) at util/bpf-event.c:144
>   #2  0x00005555558e9db5 in bpf_metadata_create (info=3D0x55555665e400) a=
t util/bpf-event.c:403
>   #3  0x00005555558ea85b in perf_event__synthesize_one_bpf_prog (session=
=3D0x555556178510,
>       process=3D0x5555555ba7ab <process_synthesized_event>, machine=3D0x5=
55556178728, fd=3D25, event=3D0x5555561b73a0,
>       opts=3D0x5555560d33a8 <record+328>) at util/bpf-event.c:674
>   #4  0x00005555558eadf8 in perf_event__synthesize_bpf_events (session=3D=
0x555556178510,
>       process=3D0x5555555ba7ab <process_synthesized_event>, machine=3D0x5=
55556178728, opts=3D0x5555560d33a8 <record+328>)
>       at util/bpf-event.c:799
>   #5  0x00005555555beef5 in record__synthesize (rec=3D0x5555560d3260 <rec=
ord>, tail=3Dfalse) at builtin-record.c:2131
>   #6  0x00005555555c07c1 in __cmd_record (rec=3D0x5555560d3260 <record>, =
argc=3D1, argv=3D0x7fffffffe2e0) at builtin-record.c:2581
>   #7  0x00005555555c4b30 in cmd_record (argc=3D1, argv=3D0x7fffffffe2e0) =
at builtin-record.c:4376
>   #8  0x000055555564d72e in run_builtin (p=3D0x5555560d63c0 <commands+288=
>, argc=3D6, argv=3D0x7fffffffe2e0) at perf.c:349
>   #9  0x000055555564d9c6 in handle_internal_command (argc=3D6, argv=3D0x7=
fffffffe2e0) at perf.c:401
>   #10 0x000055555564db1f in run_argv (argcp=3D0x7fffffffe0dc, argv=3D0x7f=
ffffffe0d0) at perf.c:445
>   #11 0x000055555564de68 in main (argc=3D6, argv=3D0x7fffffffe2e0) at per=
f.c:553
>
> I seems bpf_prog_info is broken for some reason.
>
>   (gdb) up
>   #1  0x00005555558e9306 in synthesize_bpf_prog_name (buf=3D0x5555563305b=
0 "bpf_prog_", size=3D512, info=3D0x55555664e1d0, btf=3D0x55555637ad40,
>       sub_id=3D0) at util/bpf-event.c:144
>   144           name_len +=3D snprintf_hex(buf + name_len, size - name_le=
n,
>
>   (gdb) p *info
>   $1 =3D {type =3D 68, id =3D 80, tag =3D "\\\000\000\000\214\000\000", j=
ited_prog_len =3D 152, xlated_prog_len =3D 164,
>     jited_prog_insns =3D 824633721012, xlated_prog_insns =3D 118541097391=
2, load_time =3D 1305670058276, created_by_uid =3D 352,
>     nr_map_ids =3D 364, map_ids =3D 1975684956608, name =3D "\330\001\000=
\000\350\001\000\000$\002\000\0004\002\000", ifindex =3D 576,
>     gpl_compatible =3D 0, netns_dev =3D 2697239462496, netns_ino =3D 2834=
678416000, nr_jited_ksyms =3D 756, nr_jited_func_lens =3D 768,
>     jited_ksyms =3D 3418793968396, jited_func_lens =3D 3573412791092, btf=
_id =3D 844, func_info_rec_size =3D 880, func_info =3D 3934190044028,
>     nr_func_info =3D 928, nr_line_info =3D 952, line_info =3D 42949672969=
88, jited_line_info =3D 4449586119680, nr_jited_line_info =3D 1060,
>     line_info_rec_size =3D 1076, jited_line_info_rec_size =3D 1092, nr_pr=
og_tags =3D 1108, prog_tags =3D 4861902980192,
>     run_time_ns =3D 5085241279632, run_cnt =3D 5257039971512, recursion_m=
isses =3D 5360119186644, verified_insns =3D 1264,
>     attach_btf_obj_id =3D 1288, attach_btf_id =3D 1312}

Thanks Namhyung!

So it looks like my "fix" was breaking the tools/perf build feature
test for btf_dump_type_data_opts opts.emit_strings and that was
avoiding this code.

Having terminal 1 run perf trace is going to be loading/unloading a
BPF program for system call augmentation. This must be creating the
race condition that is causing perf record to segv when it is
inspecting the bpf_prog_info.

The cast in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/bpf-event.c#n135
```
static int synthesize_bpf_prog_name(char *buf, int size,
    struct bpf_prog_info *info,
    struct btf *btf,
    u32 sub_id)
{
u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(uintptr_t)(info->prog_tags);
```
looks concerning given the bad address comes from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/bpf-event.c#n144
```
name_len +=3D snprintf_hex(buf + name_len, size - name_len,
prog_tags[sub_id], BPF_TAG_SIZE);
```
Checking git blame this code has existed since 2019, commit
7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF
programs"):
http://lkml.kernel.org/r/20190117161521.1341602-8-songliubraving@fb.com
it was refactored in 2019 to a single memory allocation commit
("a742258af131 perf bpf: Synthesize bpf events with
bpf_program__get_prog_info_linear()")
http://lkml.kernel.org/r/20190312053051.2690567-5-songliubraving@fb.com

There seems like a potential race here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/bpf-utils.c#n123
```
/* step 1: get array dimensions */
err =3D bpf_obj_get_info_by_fd(fd, &info, &info_len);
```
and later:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/bpf-utils.c#n185
```
/* step 5: call syscall again to get required arrays */
err =3D bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
```
There's a verification step that looks to cover issues with the race.
I thought making those warnings fatal may help, but no:
```
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -202,14 +202,20 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
                v1 =3D bpf_prog_info_read_offset_u32(&info, desc->count_off=
set);
                v2 =3D bpf_prog_info_read_offset_u32(&info_linear->info,
                                                   desc->count_offset);
-               if (v1 !=3D v2)
+               if (v1 !=3D v2) {
                        pr_warning("%s: mismatch in element count\n", __fun=
c__);
+                       free(info_linear);
+                       return ERR_PTR(-EFAULT);
+               }

                v1 =3D bpf_prog_info_read_offset_u32(&info, desc->size_offs=
et);
                v2 =3D bpf_prog_info_read_offset_u32(&info_linear->info,
                                                   desc->size_offset);
-               if (v1 !=3D v2)
+               if (v1 !=3D v2) {
                        pr_warning("%s: mismatch in rec size\n", __func__);
+                       free(info_linear);
+                       return ERR_PTR(-EFAULT);
+               }
        }

        /* step 7: update info_len and data_len */
```

Fwiw, the address of "data=3D0x40" in the stack trace makes it looks
like an offset has been applied to NULL. 0x40 is 64 which corresponds
with "name" info a bpf_prog_info by way of pahole:
```
struct bpf_prog_info {
        __u32                      type;                 /*     0     4 */
        /* --- cacheline 1 boundary (64 bytes) --- */
...
        char                       name[16];             /*    64    16 */
```

I feel we're relatively close to discovering a proper fix for the
issue, if others could lend a hand as I'm not overly familiar with the
BPF code. I'm wondering if the second bpf_obj_get_info_by_fd could be
filling in offsets relative to NULL rather than returning an error,
but this would be (I believe) a kernel issue :-(

Thanks,
Ian

