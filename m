Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071D7C7B93
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjJMCZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjJMCZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:25:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AB95;
        Thu, 12 Oct 2023 19:25:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so2360259a12.0;
        Thu, 12 Oct 2023 19:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697163946; x=1697768746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfucaFtMygn+o6ygSaKBL+1oTA+kLVzBXGrUlL7E3ws=;
        b=QNReD1WEoCP5SO8nc6lGawnOlt8ZqVQtcy4QRoJ0J8bcJnMGHeSwDlHRYywkDA1y3+
         NZ+RzYpzfAqJ1mcJ8rLyfRSuI2HhegNOyH71XctXkCuCeFf5jN8wgkYDXHk0pNEyEiYT
         ukabfqkCOA2UuqtA8ougKXxbAO7ZWV7VLdqkIy4etQ7kXrPqocI0O77vH1cbZ0J5o0nX
         rnWS7xV22IDEOxhFc3Iz3IDUl0xh5gw0hiZtpLZEnaF8QLO7quRF5+S5ryRKPx2ffcva
         h1eptEPweBqdieEEBPOsqaOsPOxzAt+et/VrS5B0PpXYqZNMS4MFvDgrv5YaW4mrgKav
         3G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697163946; x=1697768746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfucaFtMygn+o6ygSaKBL+1oTA+kLVzBXGrUlL7E3ws=;
        b=YOE0grijcuoo2tFKVTtsYmTRwLetCMYJ/KQTK+n0+UIxtHhnPQONaoNygQalwvfbkm
         Dz36O/bMlB2nsoQONenLHHE7K8n6BIpU82T4G1kx2YFk2wt8MEb9VNmI+t+pL2Y+JiqL
         oJcnqbFJ+SC3Fpy/Jov8mVEM/wVNGMNde7oNCYTy6SFMzh5iIia/gg+ve11Rk5HTaHvl
         lC1UOfz2A7hs/dLmVGd0IsyHFRFKA6titIzVUrRYFAKEG/cwZLikyHY/kdVqHrrrWDHG
         7vsRGCVgOKYy38n3+e50LMejwWpkDu5Prq3dLCYjzTBqQ6sj7YDNFURwTuucBYt9wW4u
         ksOQ==
X-Gm-Message-State: AOJu0YzS8oh2JeBQq5Dn+fvv+XqLCcjr+mtc6WpUQUEWovbgPuKXIaPX
        WsIQbolkB+ocqfTa67eW43YBg4ojqsjRu/b7wf1X97pQ2Zc=
X-Google-Smtp-Source: AGHT+IGfKKqTIbSVTOh52xqnpR+OlWaleG0kq0XcH8t6hx7zfyC0t1UjxReyCGYOyF7baEXemAgzpmeiJEGLoTxoxIE=
X-Received: by 2002:a05:6402:b0f:b0:536:aead:3486 with SMTP id
 bm15-20020a0564020b0f00b00536aead3486mr18332831edb.40.1697163945415; Thu, 12
 Oct 2023 19:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231013013536.2047-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231013013536.2047-1-zhujun2@cmss.chinamobile.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Oct 2023 19:25:34 -0700
Message-ID: <CAEf4BzbPMWy4Zxg6Tc-qcWjncW6qK+G=i0wC+nd0MLXiSMiBig@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: remove unused variables
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        andrii@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 12, 2023 at 6:35=E2=80=AFPM zhujun2 <zhujun2@cmss.chinamobile.c=
om> wrote:
>
> These variables are never referenced in the code, just remove them.
>
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---

  Why do you stubbornly keep submitting the same untested and broken
patch, ignoring the feedback ([0])? Your changes don't even compile
successfully ([1]).

  [0] https://lore.kernel.org/bpf/2e4c17ac-9a61-4901-8f98-c783242eec28@ioge=
arbox.net/
  [1] https://github.com/kernel-patches/bpf/actions/runs/6502998724/job/176=
62867681

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
