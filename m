Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E070F4B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjEXLEC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjEXLEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 07:04:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C287BC5
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 04:03:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96652cb7673so115134666b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684926238; x=1687518238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8ZhOJCOuX0oHb6wu+kiLfwd2A/qY3eT2+7FskM6ENc=;
        b=g5x23xsNJHGi+3qQBqDfXNJD4T/JZBtNTbGbreq3L36vlyxtSdqqzF2Mwfn1kQIUFW
         mE7CfSzmenr8M3undMw4osWM3aex2oF3OtUfjPix7uwAVXZKoDa+m27eTTdZqp5k0NDL
         tqWFBHdHFnrjv0cd5HimeWlCRpeoDxVjage8ud/MDZ+ByaLoyWOAhNuoH7/ZkuKEP3kw
         pLn6LQY/0th6kZ8mkqQFYQit3ljZLIV5eSfFYAq74BbtaLESRPc7/auxbHmHlFUnv6N3
         wKvHam12zXukwJS4axfzZFG9t6svthEL4rmlxRjJpnbx5lwGztyU0gxCi+/yVDHYni5t
         Hu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684926238; x=1687518238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8ZhOJCOuX0oHb6wu+kiLfwd2A/qY3eT2+7FskM6ENc=;
        b=lD5wvbSJTPuGCTkekURc3AvISGPZ6zOphaGz8npLdUIxDHq+ybhvBf6NYsV+dBms0E
         YinlGQYBgns4bOL4PuIIvSiCMEG2ZEz37F2R6+MisApnq9xKKap+pGHbiyJ7c0R2clSG
         tL6U4vUrwhbJiX/aXt9KhEj50MJa52JT1aX91CfhisEXqmano7Z66Iu5i8OQNPs/rKLd
         SrWOzif7gPks/E95Y13oSANcpz76SNbA3unvYexdBLOWz/51aed1hGEqI/nxrD9xdKTa
         87mvaZYkzPBSbL1jTIcXM8Mu8orYGwtevSPSDmo6eiLxzWpo5sQH25SGIj4ci5Ikt3bi
         MM+w==
X-Gm-Message-State: AC+VfDwVwKLI23FY4eWCsRaZsztzT78a0o3WYoSuSr52RAIwGTFam6ln
        S6dMd5E93YhIQOFa6xYPu6+VQciHFWcVZ0QJJ6qa0g==
X-Google-Smtp-Source: ACHHUZ4vN/yMybFjWHdgNNUUP82Fl2/+r7Hr/l+By9pTJ+miaajy760HKj6zhMUf70v8MYLFC9JeDYQm9fIlH8ov0M0=
X-Received: by 2002:a17:907:36c3:b0:966:a691:55ed with SMTP id
 bj3-20020a17090736c300b00966a69155edmr16606110ejc.70.1684926238208; Wed, 24
 May 2023 04:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com> <2023041100-oblong-enamel-5893@gregkh>
In-Reply-To: <2023041100-oblong-enamel-5893@gregkh>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 24 May 2023 12:03:43 +0100
Message-ID: <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 4:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> I didn't see anything to do here.
>
> And selftests should NOT be broken on stable releases, if so, something
> is wrong as no other subsystem has that happen.

Sorry for the long delay in replying, I update the kernels we use for
CI only infrequently. Here is an example of the build failure I'm
seeing, from kernel.org 5.10 LTS:

In file included from
/work/build/5.10.180/tools/testing/selftests/bpf/verifier/tests.h:59,
                 from test_verifier.c:355:
/work/build/5.10.180/tools/testing/selftests/bpf/verifier/ref_tracking.c:93=
5:3:
error: 'struct bpf_test' has no member named 'fixup_map_ringbuf'; did
you mean 'fixup_map_in_map'?
  935 |  .fixup_map_ringbuf =3D { 11 },
      |   ^~~~~~~~~~~~~~~~~
      |   fixup_map_in_map

This is just doing make -C tools/testing/selftests/bpf after compiling a ke=
rnel.

Best
Lorenz
