Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC97AE6C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjIZH1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjIZH1F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 03:27:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B513A
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 00:26:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9936b3d0286so1010469966b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695713216; x=1696318016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL9jzjX9Dj4vINipwZ1Fop5IYAbBFu+z+Vj4h2wF/5E=;
        b=o09YdU0mmxxsksjNEi04O/LiJIVtHroN558/hfqDMu37IqW2kmIKmpqYJqj5rk9h3D
         +RU/q2AkDJTYvIPH5kxKcss9HnDthvlShxpzLIBZwwnBuHww7cSbbGPCbHMt59OHB/zq
         NCl7IiLsIGJa5uZLtk+LsowqKWhyfIkvW4IFhHJTYOg5AztA7m2iGolyUd1xzvCyYAfz
         nReqoMK4KFdySkmsrBcBqbg5HZ2SkgVK4sCaj6hLz4ziWrBO7703AH/1Pt4sn2r+aC7e
         6+s3flZx7nD0IFE/qFn51mOLd5MNX74z+yVa4GaD6Ue77mFwz/gP2xNCJyDJhqZf3wJg
         7dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695713216; x=1696318016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL9jzjX9Dj4vINipwZ1Fop5IYAbBFu+z+Vj4h2wF/5E=;
        b=D3AtVODlcLYSXfHrdow1cQx854DEybTHx5J9pypnODqxJV+QcUAnffLRrs3XozTAXJ
         wFlKCbKAo7fv5swgSqmZ8NyJzy634YI0eUyQGHtKJXijHh5X1PMXSPqWT4FUnlATbwvz
         iZDkVOWdtHbS24ztPRuTigiNqHsr6GuSWyeaSSkxF1vXAJjPLON/92JwpVBY4tbdutXw
         mieMaqNH0T4/BnUrjdOFJzs5+H7TIIALf+/7uEtBYoqgXBfsmiF0C91oy2F4bI7ibG4Z
         87SjCe/g51dsfqutWKCGTFfSExKZF+Xqx6trJ0fS2BuepY5HmRQ72i1roI7ChKrAQ2oi
         A8eA==
X-Gm-Message-State: AOJu0Yx9fNTU7vPeaWprBtvTZzNihxn6wfpvFx/pJGmYj1SOHXZRyoSB
        2AAoY6RYbNetdBMMKAB1M2aAaE1NCgwn1lRlVuThalXzbQ/aF1EEJYJvmw==
X-Google-Smtp-Source: AGHT+IFD2+LPuamDwfHmqmOw1Eb5LDk2z4fOwwV3qDU7j4eyB/9B7AGlGQS6QABciR6k3DepbtJwkJ2DH3H9480eta8=
X-Received: by 2002:a17:906:1d5:b0:9a5:da6c:6539 with SMTP id
 21-20020a17090601d500b009a5da6c6539mr8145437ejj.75.1695713216164; Tue, 26 Sep
 2023 00:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 26 Sep 2023 16:26:45 +0900
Message-ID: <CAFhGd8pEv32zp4RDsj_jeBjzP5hcsf4dP4Knueiw_UM8ZsqcKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selftests/hid: fix building for older kernels
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey all,

Gentle ping on this patch. Looking to get this patch and [1] slated
for 6.7 wherein we can start getting cleaner kselftests builds.

I do not think I am able to successfully run the hid/bpf selftests due
to my kernel version being too low (and an inability to upgrade it as
I'm on a corp rolling release). I'd appreciate some insight on how to
get the tests running or if someone could actually build+run the tests
with this patch applied.

On Sat, Sep 9, 2023 at 7:22=E2=80=AFAM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Hi, I am sending this series on behalf of myself and Benjamin Tissoires. =
There
> existed an initial n=3D3 patch series which was later expanded to n=3D4 a=
nd
> is now back to n=3D3 with some fixes added in and rebased against
> mainline.
>
> This patch series aims to ensure that the hid/bpf selftests can be built
> without errors.
>
> Here's Benjamin's initial cover letter for context:
> |  These fixes have been triggered by [0]:
> |  basically, if you do not recompile the kernel first, and are
> |  running on an old kernel, vmlinux.h doesn't have the required
> |  symbols and the compilation fails.
> |
> |  The tests will fail if you run them on that very same machine,
> |  of course, but the binary should compile.
> |
> |  And while I was sorting out why it was failing, I realized I
> |  could do a couple of improvements on the Makefile.
> |
> |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c1=
53dcb2@redhat.com/T/#t
>
> Changes from v1 -> v2:
> - roll Justin's fix into patch 1/3
> - add __attribute__((preserve_access_index)) (thanks Eduard)
> - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> - Link to v1: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c86=
2769020a8@kernel.org/
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/6=
1
> ---
> Benjamin Tissoires (3):
>       selftests/hid: ensure we can compile the tests on kernels pre-6.3
>       selftests/hid: do not manually call headers_install
>       selftests/hid: force using our compiled libbpf headers
>
>  tools/testing/selftests/hid/Makefile               | 10 ++---
>  tools/testing/selftests/hid/progs/hid.c            |  3 --
>  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++=
++++++
>  3 files changed, 53 insertions(+), 9 deletions(-)
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230908-kselftest-09-08-56d7f4a8d5c4
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/all/20230912-kselftest-param_test-c-v1-1-80a6c=
ffc7374@google.com/

Thanks
Justin
