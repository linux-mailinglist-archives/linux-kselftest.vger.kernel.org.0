Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189417BA9B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 21:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjJETGN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjJESOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 14:14:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FEDE;
        Thu,  5 Oct 2023 11:14:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so14522121fa.3;
        Thu, 05 Oct 2023 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696529647; x=1697134447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mkmrZ85KDPvgtxyxwHlcxR2FwXeKHeY2CWLRj7V6mQ=;
        b=Xry8hv/YKZalo97emr9Rpz4cm+C2Q9juXc/5mXfj2c/vu9erJ1rWc/+p8WLOljt9S9
         JfX9SYVTxEQG3FkG5zhDHc8yoMynohoT7maO7eaxJlSAIB8NCBhLUS4tB6leXKRPp05W
         3wzcGw3DXYjZO9sXLyPfDk3oltIQlxYLMUbzHqR7VGRJMG39h2XM+XesYm7CiImw5+2N
         8ZtJwS/MQkalgJ71k7cGI1KB+KfhRLr3Bbe8B3EUoI8pCvRAmbFfg9MoDZiWlSY7Aavw
         0mB0jhakyMZ+ibrxQuCm0r0J8TAv4N3asbosNd4RYLUxVHJhZSEqffylC6VT+HYxZiLA
         jB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529647; x=1697134447;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mkmrZ85KDPvgtxyxwHlcxR2FwXeKHeY2CWLRj7V6mQ=;
        b=IjEv6IM5m7ahtLC5JZsb+Y0ljSf42WowXPBpv1+spEgyUYO/CEt+DHnoONxxlZV8u8
         BZGy8xQJzRLJeydOIKe1afJr8JA+q9pC8fXSoWH19ZQT9tBclzvkbjiE7Y143Cf88QGT
         GW4bDWqpWZggOAlQhkJkK9rM5QomIk4MGcre/8uAzCNFm+Nj1xrfu/EuExBsVzuJqnVg
         bKOUF7Sxp5hT52Dh+4G/9n/7yduaRfcoFuSAcLMyF5+8Pfz/Rb28jAeWALmnP9iwMolS
         oG8CqNHyooneoK0OuKNEODgyGiflJrma1YnljThxkrI3HZV1By95f64c1bnJ+a5HRQr/
         0lmg==
X-Gm-Message-State: AOJu0YxxDX5NrS33zfnripPO5GgtvWHLKsJPjnMQ4MHWN8OulrLhVykk
        OQzF3fyp1u8fwiwa1ECsMfw=
X-Google-Smtp-Source: AGHT+IHGLAsSutIacUOwL8sK0JmdEvfw4ceipZby+beeO7d1Vfy6hKGZN5cCfh8lGxBm0rDxTQYCaA==
X-Received: by 2002:a05:651c:1059:b0:2c0:bc5:5ff1 with SMTP id x25-20020a05651c105900b002c00bc55ff1mr5785854ljm.22.1696529647195;
        Thu, 05 Oct 2023 11:14:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a2e8542000000b002c0d9d83f71sm381811ljj.62.2023.10.05.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:14:06 -0700 (PDT)
Message-ID: <1e64c550b3ce044c1ab045ec74946d1b361f364e.camel@gmail.com>
Subject: Re: [PATCH v3 0/3] selftests/hid: assorted fixes
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Date:   Thu, 05 Oct 2023 21:14:05 +0300
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-10-05 at 17:55 +0200, Benjamin Tissoires wrote:
> > And this is the last(?) revision of this series which should now compil=
e
> > with or without CONFIG_HID_BPF set.
> >=20
> > I had to do changes because [1] was failing
> >=20
> > Nick, I kept your Tested-by, even if I made small changes in 1/3. Feel
> > free to shout if you don't want me to keep it.
> >=20
> > Eduard, You helped us a lot in the review of v1 but never sent your
> > Reviewed-by or Acked-by. Do you want me to add one?

Hi Benjamin,

I think there is no need, I just took part in the discussion and that's all=
.
Feel free to ping me if there is anything BPF related that needs clarificat=
ion.

Thanks,
Eduard

> >=20
> > Cheers,
> > Benjamin
> >=20
> > [1] https://gitlab.freedesktop.org/bentiss/hid/-/jobs/49754306
> >=20
> > For reference, the v2 cover letter:
> >=20
> > > > Hi, I am sending this series on behalf of myself and Benjamin Tisso=
ires. There
> > > > existed an initial n=3D3 patch series which was later expanded to n=
=3D4 and
> > > > is now back to n=3D3 with some fixes added in and rebased against
> > > > mainline.
> > > >=20
> > > > This patch series aims to ensure that the hid/bpf selftests can be =
built
> > > > without errors.
> > > >=20
> > > > Here's Benjamin's initial cover letter for context:
> > > > > >  These fixes have been triggered by [0]:
> > > > > >  basically, if you do not recompile the kernel first, and are
> > > > > >  running on an old kernel, vmlinux.h doesn't have the required
> > > > > >  symbols and the compilation fails.
> > > > > >=20
> > > > > >  The tests will fail if you run them on that very same machine,
> > > > > >  of course, but the binary should compile.
> > > > > >=20
> > > > > >  And while I was sorting out why it was failing, I realized I
> > > > > >  could do a couple of improvements on the Makefile.
> > > > > >=20
> > > > > >  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d49=
8-0ca1c153dcb2@redhat.com/T/#t
> >=20
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> > Changes in v3:
> > - Also overwrite all of the enum symbols in patch 1/3
> > - Link to v2: https://lore.kernel.org/r/20230908-kselftest-09-08-v2-0-0=
def978a4c1b@google.com
> >=20
> > Changes in v2:
> > - roll Justin's fix into patch 1/3
> > - add __attribute__((preserve_access_index)) (thanks Eduard)
> > - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> > - Link to v1: https://lore.kernel.org/r/20230825-wip-selftests-v1-0-c86=
2769020a8@kernel.org
> >=20
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues=
/61
> >=20
> > ---
> > Benjamin Tissoires (3):
> >       selftests/hid: ensure we can compile the tests on kernels pre-6.3
> >       selftests/hid: do not manually call headers_install
> >       selftests/hid: force using our compiled libbpf headers
> >=20
> >  tools/testing/selftests/hid/Makefile               | 10 ++-
> >  tools/testing/selftests/hid/progs/hid.c            |  3 -
> >  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 77 ++++++++++++++=
++++++++
> >  3 files changed, 81 insertions(+), 9 deletions(-)
> > ---
> > base-commit: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
> > change-id: 20230825-wip-selftests-9a7502b56542
> >=20
> > Best regards,

