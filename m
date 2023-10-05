Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53057BA890
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjJESAe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjJESA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 14:00:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E698
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 11:00:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533df112914so2207948a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Oct 2023 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696528826; x=1697133626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soC/hI6qoVGb1EBSelNwhFg1ZrYnyxzAE+/e29uwgT4=;
        b=22QnwidH5T8m0rE1qmnLt5HKBH53ChSY2UjyhuUrECXA4zPkPQVv66mhNptLztf2sk
         mMguaiogQpVZBMqEtWvp4bSymATUAvvaORmfKpH4Rg270CNBuijTKfAJzrB629kKaLOO
         pSbxbzk73QSNvp/0JsBkmC//eW+EaqR3H8Ic7EgZ5dQCMmg9wGIb8+uDckMgjFMJlQ4g
         ggme4kxJDhLdpTLffXxy8v41oI9XzaviNKmJIigD1jnZcPSfhIMbpawzbMRDQuBniWlE
         JmULgWkkDicR7UcNxdhjVDjcLl+IoAushx00kkqcQMc2rdzuje+wWqKpPTUTa9ipOjdU
         bjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528826; x=1697133626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soC/hI6qoVGb1EBSelNwhFg1ZrYnyxzAE+/e29uwgT4=;
        b=t96hW4VUZA+tzUfibvgGGzSDVYKPIjhuU01lsoJfFBpbXWI9JKsVP1RSFQvtX1W0fm
         t2QKJUM5RS7QVSo5Wauxu6uDraXxbu5PW42vyPg7jFTqIvcDAsVy212Ah3i6jcffON3f
         XC1X9gZLMAk4TIexi0qbRl4YeEO1EIrSc5AWKpCnJSx10WMCnqYJdDAS9vLKzp0WmpY1
         vI9p/BqnQ1M02pBtK0tpm+0yvXYS9ZTyBO3gonUlqtTWIg0mBJxhIM3a9pRCeAEiQx8a
         qGxiBr/K/lh5D16jG2r5RyggeMZhosD8EmCS7Nw9DW1RqnVptND0c+xnvC4xPCSke49i
         0w0w==
X-Gm-Message-State: AOJu0YzBdWwrxOKm/WbimO1/RP7LfZIuth+xM/UGfNrBMMfaLmKs2Y77
        VAR32s3lcqzG621+OBnlEvOXhWTShCp8xn2kqpowoQ==
X-Google-Smtp-Source: AGHT+IGxbmrYGV4xHeUYWGp7FnCMXrpxOrueGBjqdlU6Zozm6OO34o5rxIoT+s90O/UZXNHJlVnMazAF5XJouq7eXCU=
X-Received: by 2002:aa7:dd0e:0:b0:533:1832:f2b4 with SMTP id
 i14-20020aa7dd0e000000b005331832f2b4mr5295009edv.13.1696528826582; Thu, 05
 Oct 2023 11:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 5 Oct 2023 11:00:12 -0700
Message-ID: <CAFhGd8pKbznU5Atj6vEhjTQc0e3G8wKEBPa5gMteyFAvua=nZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] selftests/hid: assorted fixes
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 5, 2023 at 8:55=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> And this is the last(?) revision of this series which should now compile
> with or without CONFIG_HID_BPF set.
>
> I had to do changes because [1] was failing
>
> Nick, I kept your Tested-by, even if I made small changes in 1/3. Feel
> free to shout if you don't want me to keep it.
>
> Eduard, You helped us a lot in the review of v1 but never sent your
> Reviewed-by or Acked-by. Do you want me to add one?
>
> Cheers,
> Benjamin
>
> [1] https://gitlab.freedesktop.org/bentiss/hid/-/jobs/49754306
>
> For reference, the v2 cover letter:
>
> | Hi, I am sending this series on behalf of myself and Benjamin Tissoires=
. There
> | existed an initial n=3D3 patch series which was later expanded to n=3D4=
 and
> | is now back to n=3D3 with some fixes added in and rebased against
> | mainline.
> |
> | This patch series aims to ensure that the hid/bpf selftests can be buil=
t
> | without errors.
> |
> | Here's Benjamin's initial cover letter for context:
> | |  These fixes have been triggered by [0]:
> | |  basically, if you do not recompile the kernel first, and are
> | |  running on an old kernel, vmlinux.h doesn't have the required
> | |  symbols and the compilation fails.
> | |
> | |  The tests will fail if you run them on that very same machine,
> | |  of course, but the binary should compile.
> | |
> | |  And while I was sorting out why it was failing, I realized I
> | |  could do a couple of improvements on the Makefile.
> | |
> | |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1=
c153dcb2@redhat.com/T/#t
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Changes in v3:
> - Also overwrite all of the enum symbols in patch 1/3
> - Link to v2: https://lore.kernel.org/r/20230908-kselftest-09-08-v2-0-0de=
f978a4c1b@google.com
>
> Changes in v2:
> - roll Justin's fix into patch 1/3
> - add __attribute__((preserve_access_index)) (thanks Eduard)
> - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> - Link to v1: https://lore.kernel.org/r/20230825-wip-selftests-v1-0-c8627=
69020a8@kernel.org
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/6=
1
>
> ---
> Benjamin Tissoires (3):
>       selftests/hid: ensure we can compile the tests on kernels pre-6.3
>       selftests/hid: do not manually call headers_install
>       selftests/hid: force using our compiled libbpf headers
>
>  tools/testing/selftests/hid/Makefile               | 10 ++-
>  tools/testing/selftests/hid/progs/hid.c            |  3 -
>  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 77 ++++++++++++++++=
++++++
>  3 files changed, 81 insertions(+), 9 deletions(-)
> ---
> base-commit: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
> change-id: 20230825-wip-selftests-9a7502b56542
>
> Best regards,
> --
> Benjamin Tissoires <bentiss@kernel.org>
>

Tested entire series.

 I can now build the tests using this command:

$ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 -j128
ARCH=3Dx86_64 -C tools/testing/selftests TARGETS=3Dhid


Tested-by:  Justin Stitt <justinstitt@google.com>
