Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272AF6CADFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjC0SzY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjC0SzX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:55:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB019A9;
        Mon, 27 Mar 2023 11:55:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w9so40314950edc.3;
        Mon, 27 Mar 2023 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679943320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+nsytMysp1FODhWu2kvGCHUtSXEQamFOMFgO+AwSM0=;
        b=mRRfr2QQg4wrQsULbADTNA0f7sNdq9Yfzr4G3XTPm44vHYLshTgW9NdfLqPmVdbMHz
         GE267NY87l1ef3hndV8F3BrOwE8/Dg1g3pajN0wNXn3w6+pXf/Vv7BZUenBm/fqjn0rm
         EG9/Mr/UQsL91VQ4uxBm8nuctTWbNdpcaCGWGcAQLUeA3SH/1xRaXzegeYNCLx0RQo9q
         Edpd8tFzIuhzbKeUor/mh4ySV+bMYpmk1mIZBdHzI8bTjpgbFRYYePkbDJ0ngSE2pHZc
         bHeAz/gfxF028QgDa18tfafEV2k6KnPNaNAaxAmTkGfXrcGWVP0GYUl8HM9vP7Ogqp8i
         R1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+nsytMysp1FODhWu2kvGCHUtSXEQamFOMFgO+AwSM0=;
        b=GX9uXKEAtDjYfhm+tcmoNwJHv3rAOL/qdjUkPaTJJDdS3yLWI5yPScyG/H7dZA73J3
         L5kXx0PiKwf59nEjlVZGsyREzOnjl0r5RREgNGbumDmY5diLPD0Yc0B10ZLe3lOH2cS9
         PgLgA7M1tV6M+SxUjTHELnNka7q6IbtcCTmA7Fk+c4W2lCyp2KL3a4OVW04JAcZuTxxN
         bwzNgu1Is9N/vhjzQ+9Bj6Y4A8I/odnDRn04rAcEJoqyZYo8eVQrCioe+AXgoW1ePwoe
         4uTKwTYKcKOgIpgiSO1pQNKBJkdAkHfofn3mgZ56syniCX97hVJedxE4oGjXqyUKG4o3
         X4Jg==
X-Gm-Message-State: AAQBX9cscDPDzJ+wwvhLf19FhP8F/EUJgOWQj57LEbRHd3u52x4mi2l9
        ygw5G7B2kuXyGos0DSX2oUItOcirHxP3f5YO6/h/gBqc/4c=
X-Google-Smtp-Source: AKy350aY2aM4jwoQXFs5GSRWcG4jTb2IK4+pB+UMlbIKcJ0c9jiMF9bKuIZkegCiRSbYZUAZHEkGGdIFGRzJS6IwF2Y=
X-Received: by 2002:a17:906:af0d:b0:932:38d5:ff86 with SMTP id
 lx13-20020a170906af0d00b0093238d5ff86mr6690398ejb.5.1679943320202; Mon, 27
 Mar 2023 11:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230327153538.850440-1-xukuohai@huaweicloud.com>
 <CAEf4BzZuf=G0sEk5XqB0nAbvr81uRChLa96WDz0jCSG82=kofQ@mail.gmail.com> <a4e44814-3c92-ccab-2a14-7824dfd44488@huaweicloud.com>
In-Reply-To: <a4e44814-3c92-ccab-2a14-7824dfd44488@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 11:55:08 -0700
Message-ID: <CAEf4Bzb4JD89CC8yEmnD91pdCMyzhCT5YkU4cv2feLUj8Dcf6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove two infinite loop bound
 check cases
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 26, 2023 at 11:21=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> On 3/27/2023 11:20 AM, Andrii Nakryiko wrote:
> > On Sun, Mar 26, 2023 at 7:45=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >>
> >> From: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> The two infinite loop bound check cases added by commit
> >> 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit =
range")
> >> take a long time to execute but don't add much value.
> >>
> >> Remove them to reduce run time of test_verifier.
> >
> > Summary: 2042 PASSED, 0 SKIPPED, 1 FAILED
> >
> > real    0m4.780s
> > user    0m0.458s
> > sys     0m3.871s
> >
> >
> > 5 seconds isn't such a long time, especially when we compare it to
> > test_progs (even with parallelization).
> >
>
> Well, I actually don't know if it is "long time".
>
> This patch was sent to address Alexei's concern about the run time
> of test_verifier in mail [1].

  > These infinite loops don't add much value to the actual test.
  > Please rewrite them without infinite loops.

Alexei asked to improve the test, not to just remove it, if I
understand correctly. If the test is there, presumably it's useful. If
it can be implemented better, let's do that. Just removing the test
seems like a wrong move.

>
> [1] https://lore.kernel.org/bpf/20230322213056.2470-1-daniel@iogearbox.ne=
t/T/#mb3d6363a693ccd63d416d9d787db17f8fdcb8442
>
> >>
> >> Fixes: 1a3148fc171f ("selftests/bpf: Check when bounds are not in the =
32-bit range")
> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> ---
> >>   tools/testing/selftests/bpf/verifier/bounds.c | 50 -----------------=
--
> >>   1 file changed, 50 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/tes=
ting/selftests/bpf/verifier/bounds.c
> >> index 74b1917d4208..515a8222f08f 100644
> >> --- a/tools/testing/selftests/bpf/verifier/bounds.c
> >> +++ b/tools/testing/selftests/bpf/verifier/bounds.c
> >> @@ -777,31 +777,6 @@
> >>          .result =3D ACCEPT,
> >>          .prog_type =3D BPF_PROG_TYPE_XDP,
> >>   },
> >> -{
> >> -       "bound check with JMP_JSLT for crossing 64-bit signed boundary=
",
> >> -       .insns =3D {
> >> -       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_m=
d, data)),
> >> -       BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_m=
d, data_end)),
> >> -       BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
> >> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
> >> -       BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
> >> -
> >> -       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
> >> -       BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
> >> -       BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
> >> -
> >> -       BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
> >> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
> >> -       /* r1 signed range is [S64_MIN, S64_MAX] */
> >> -       BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
> >> -
> >> -       BPF_MOV64_IMM(BPF_REG_0, 0),
> >> -       BPF_EXIT_INSN(),
> >> -       },
> >> -       .errstr =3D "BPF program is too large",
> >> -       .result =3D REJECT,
> >> -       .prog_type =3D BPF_PROG_TYPE_XDP,
> >> -},
> >>   {
> >>          "bound check for loop upper bound greater than U32_MAX",
> >>          .insns =3D {
> >> @@ -849,28 +824,3 @@
> >>          .result =3D ACCEPT,
> >>          .prog_type =3D BPF_PROG_TYPE_XDP,
> >>   },
> >> -{
> >> -       "bound check with JMP32_JSLT for crossing 32-bit signed bounda=
ry",
> >> -       .insns =3D {
> >> -       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_m=
d, data)),
> >> -       BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_m=
d, data_end)),
> >> -       BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
> >> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
> >> -       BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
> >> -
> >> -       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
> >> -       BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
> >> -       BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
> >> -
> >> -       BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
> >> -       BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
> >> -       /* r1 signed range is [S32_MIN, S32_MAX] */
> >> -       BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
> >> -
> >> -       BPF_MOV64_IMM(BPF_REG_0, 0),
> >> -       BPF_EXIT_INSN(),
> >> -       },
> >> -       .errstr =3D "BPF program is too large",
> >> -       .result =3D REJECT,
> >> -       .prog_type =3D BPF_PROG_TYPE_XDP,
> >> -},
> >> --
> >> 2.30.2
> >>
> > .
>
