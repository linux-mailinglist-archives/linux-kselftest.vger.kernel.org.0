Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430047C8056
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjJMIdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjJMIdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 04:33:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B844A9;
        Fri, 13 Oct 2023 01:33:16 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d0f945893so15109906d6.1;
        Fri, 13 Oct 2023 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697185995; x=1697790795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB14EJe8gaSIsrChU+ryklBeoO0BpFobtwILGows1XY=;
        b=Ny0ydS34c3okbdjU+8YO+ebA+IEG6lo/0gGkOMQcfvMfwfBRzwk/Ca/4+WvpKRd64w
         5X5fqh6AZaqJZHZvKfI6AUKXcpi+GYvRIRXQoFoOJdTGLnfj5ok2gmHdq9e/1jmCTMU6
         uc2dv3YnZ8tekYf0cb2qQPBVAcoko3kYBJ/XIy3/d4pzqDHzcbeNDTHVeSn+SQiCppHu
         HFzVC2tIS/+QO15TLzHsucoQBo9nEYojdHYqjXnes2NTIyZaS44Y6cNi3HlR17lK4Ksg
         JippH/I6O/q15EzCyOo5N0zQaZN6nZqoCHJjFzJJcVO+Q2aCYK88Wp6V2Ivq14LbOjNW
         mcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697185995; x=1697790795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB14EJe8gaSIsrChU+ryklBeoO0BpFobtwILGows1XY=;
        b=KoObdpMeJCnB9HiyKu/9URLt5CqIomYpEYIXEHPsQbTmy7neQNLwfLSwZFMhtMJ15A
         0t+g+B57P3j3FmJxazbV/7sSSWE6WSbLiivL3DtqShehlcvMv6ICdtF2ETEHCVrCYlJQ
         L++6MyRsVg7/FbHfJZJCpLLICpccspbiiskjHoq1mlY76bLF69rnLvbF9Gw/eqm1tKqg
         ttgjniO7a4Ng4aOAouxji/nXje+g1b9AHTUJ6ZRst39JdCYcd1J4yACdAkcd8D3OD0Ok
         fz/Jkhvj8V2pMya7yNdZ17U59Z+J9q1uzPzp+8ea1zyz/2MLa1Vo0QQu7bqjEA9Pdi0X
         hkEw==
X-Gm-Message-State: AOJu0YzXdE6ebkJ7sdSh4GYxD1lzpx5sTsuNJY8UyTctS9vc/stkx7Ah
        Mj3EXAQfJLAJAy+seuiuPL68wjSi5Rmwdoy0zkQjrLIg7gYOLfe2
X-Google-Smtp-Source: AGHT+IE6W8lv3qmlq0fV4g9Q/NkdBL1ED8anuar1B71O4TG7gG/AueoWY+/HF/6Z/AZwJeRRAy0LUdgFSxhLHVzoBlE=
X-Received: by 2002:a05:6214:5197:b0:66d:12d1:351c with SMTP id
 kl23-20020a056214519700b0066d12d1351cmr6602735qvb.31.1697185995112; Fri, 13
 Oct 2023 01:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231013013536.2047-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231013013536.2047-1-zhujun2@cmss.chinamobile.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 13 Oct 2023 16:32:38 +0800
Message-ID: <CALOAHbBubM3Z9JTZ4hCvvWFw0m-1mFP3BthFHA_8Xyr80zyS7g@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: remove unused variables
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        andrii@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 9:35=E2=80=AFAM zhujun2 <zhujun2@cmss.chinamobile.c=
om> wrote:
>
> These variables are never referenced in the code, just remove them.

You can't remove them because they are really referenced in the CHECK() mar=
co.
Sending a patch without even testing a build is bad :(

>
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/atomic_bounds.c      | 1 -
>  tools/testing/selftests/bpf/prog_tests/kfree_skb.c          | 2 --
>  tools/testing/selftests/bpf/prog_tests/perf_branches.c      | 6 +-----
>  .../testing/selftests/bpf/prog_tests/probe_read_user_str.c  | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/test_overhead.c      | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c       | 1 -
>  6 files changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/too=
ls/testing/selftests/bpf/prog_tests/atomic_bounds.c
> index 69bd7853e..4715cde38 100644
> --- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> @@ -7,7 +7,6 @@
>  void test_atomic_bounds(void)
>  {
>         struct atomic_bounds *skel;
> -       __u32 duration =3D 0;
>
>         skel =3D atomic_bounds__open_and_load();
>         if (CHECK(!skel, "skel_load", "couldn't load program\n"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/t=
esting/selftests/bpf/prog_tests/kfree_skb.c
> index c07991544..b0992a9ed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
> @@ -20,7 +20,6 @@ static void on_sample(void *ctx, int cpu, void *data, _=
_u32 size)
>  {
>         struct meta *meta =3D (struct meta *)data;
>         struct ipv6_packet *pkt_v6 =3D data + sizeof(*meta);
> -       int duration =3D 0;
>
>         if (CHECK(size !=3D 72 + sizeof(*meta), "check_size", "size %u !=
=3D %zu\n",
>                   size, 72 + sizeof(*meta)))
> @@ -65,7 +64,6 @@ void serial_test_kfree_skb(void)
>         struct perf_buffer *pb =3D NULL;
>         int err, prog_fd;
>         bool passed =3D false;
> -       __u32 duration =3D 0;
>         const int zero =3D 0;
>         bool test_ok[2];
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
> index bc24f8333..0942b9891 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -13,7 +13,6 @@ static void check_good_sample(struct test_perf_branches=
 *skel)
>         int required_size =3D skel->bss->required_size_out;
>         int written_stack =3D skel->bss->written_stack_out;
>         int pbe_size =3D sizeof(struct perf_branch_entry);
> -       int duration =3D 0;
>
>         if (CHECK(!skel->bss->valid, "output not valid",
>                  "no valid sample from prog"))
> @@ -43,7 +42,6 @@ static void check_bad_sample(struct test_perf_branches =
*skel)
>         int written_global =3D skel->bss->written_global_out;
>         int required_size =3D skel->bss->required_size_out;
>         int written_stack =3D skel->bss->written_stack_out;
> -       int duration =3D 0;
>
>         if (CHECK(!skel->bss->valid, "output not valid",
>                  "no valid sample from prog"))
> @@ -61,7 +59,7 @@ static void test_perf_branches_common(int perf_fd,
>                                       void (*cb)(struct test_perf_branche=
s *))
>  {
>         struct test_perf_branches *skel;
> -       int err, i, duration =3D 0;
> +       int err, i;
>         bool detached =3D false;
>         struct bpf_link *link;
>         volatile int j =3D 0;
> @@ -102,7 +100,6 @@ static void test_perf_branches_common(int perf_fd,
>  static void test_perf_branches_hw(void)
>  {
>         struct perf_event_attr attr =3D {0};
> -       int duration =3D 0;
>         int pfd;
>
>         /* create perf event */
> @@ -143,7 +140,6 @@ static void test_perf_branches_hw(void)
>  static void test_perf_branches_no_hw(void)
>  {
>         struct perf_event_attr attr =3D {0};
> -       int duration =3D 0;
>         int pfd;
>
>         /* create perf event */
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c=
 b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> index e41929813..a7c6ad8d6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> @@ -9,7 +9,7 @@ static const char str3[] =3D "mestringblubblubblubblubblu=
b";
>  static int test_one_str(struct test_probe_read_user_str *skel, const cha=
r *str,
>                         size_t len)
>  {
> -       int err, duration =3D 0;
> +       int err;
>         char buf[256];
>
>         /* Ensure bytes after string are ones */
> @@ -44,7 +44,7 @@ static int test_one_str(struct test_probe_read_user_str=
 *skel, const char *str,
>  void test_probe_read_user_str(void)
>  {
>         struct test_probe_read_user_str *skel;
> -       int err, duration =3D 0;
> +       int err;
>
>         skel =3D test_probe_read_user_str__open_and_load();
>         if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/too=
ls/testing/selftests/bpf/prog_tests/test_overhead.c
> index f27013e38..6161009df 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
> @@ -17,7 +17,7 @@ static __u64 time_get_ns(void)
>
>  static int test_task_rename(const char *prog)
>  {
> -       int i, fd, duration =3D 0, err;
> +       int i, fd, err;
>         char buf[] =3D "test_overhead";
>         __u64 start_time;
>
> @@ -66,7 +66,7 @@ void test_test_overhead(void)
>         struct bpf_program *fentry_prog, *fexit_prog;
>         struct bpf_object *obj;
>         struct bpf_link *link;
> -       int err, duration =3D 0;
> +       int err;
>         char comm[16] =3D {};
>
>         if (CHECK_FAIL(prctl(PR_GET_NAME, comm, 0L, 0L, 0L)))
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_synproxy.c
> index 8b50a992d..5af434353 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
> @@ -40,7 +40,6 @@ static bool expect_str(char *buf, size_t size, const ch=
ar *str, const char *name
>  {
>         static char escbuf_expected[CMD_OUT_BUF_SIZE * 4];
>         static char escbuf_actual[CMD_OUT_BUF_SIZE * 4];
> -       static int duration =3D 0;
>         bool ok;
>
>         ok =3D size =3D=3D strlen(str) && !memcmp(buf, str, size);
> --
> 2.17.1
>
>
>
>


--=20
Regards
Yafang
