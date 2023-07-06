Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2A74A362
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjGFRqb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGFRqb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 13:46:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259610F5
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Jul 2023 10:46:29 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b890ca6718so10535685ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jul 2023 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688665589; x=1691257589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYwswXlV1/1qc1QMb8XdbUm0VHdqMuEGHLDmXeCI7tw=;
        b=JADhELCXVgoD7i7cWTwhQRh73F5YhFYDBv94oM/8VxQQoeG0PhxyPIPeAt5smzYLDQ
         2VFXs6FDTv58B0PombJgnTJb6SyHVgNKljVNLKJw3EBZa3IM+rDpks3+Z8C/xYtcpoxb
         LbU/vFpSAvnQ+5Dl4V1lvy11cPRh6gO9C/KaYNRuo5YkMRA5ChZ+B6QR3eNwDAJNHhEv
         28/VzsSQuyF3hQ7p9xa/+eE3S/Swa0foXq4eOKi4DtfGVPSsoyFlkW+OKOkQEV9Hjwha
         r2lQN4ScFg+aAQmNbKsoXLuiVXMfbKyZj9wiemASlejBWpa5SFm0+xS1wTFJAhLizRvw
         VrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665589; x=1691257589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYwswXlV1/1qc1QMb8XdbUm0VHdqMuEGHLDmXeCI7tw=;
        b=LvuFuYxHchpM3NzEblPzC5vfy3YLUxUBbYwC6XxLzMRfo1oalJoMfoFmqrCK601Rka
         ANwACQFyoMPeH7ycsYg/FXtyi1vDvaFDEibqpNmnjAN4iZsV0NqzhsAaRGC9Nnv7lAbD
         CO1gD6ZUIKV9TzgVJXC+NAPEzzbdJD/TLEQvSqi/SCbzsil+rQh3cdUBIrqlW/oQOsRM
         WbKuctQm2W04C2+FABOWW/7/kxgEEzfVWID9Yc2/vwcepiZ2Ix1ttF3f5WFqAK0x8aFf
         4lvgME0nm0GHWdyfu1c+lzN9VRtaq7WFYnzKkoUXP39qJlpsv4fSKxlTL/Jg4eD0B+Os
         S5xQ==
X-Gm-Message-State: ABy/qLaobflD831oVs+fcE35mM88FpG3hdmIZSiNrzxCKyzhqpqS1vnq
        jVJI3Jo9hS24EQW/SxcI7/bYXGU=
X-Google-Smtp-Source: APBJJlFpjvWRD+oH7cEr3v6mp6VT3nmUJ2yl68awyDOvDt3JNKrMgENCDlaLreMNh3hWPwDXBQWJuWE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:7085:b0:1b7:eecd:9dae with SMTP id
 z5-20020a170902708500b001b7eecd9daemr1936538plk.9.1688665589079; Thu, 06 Jul
 2023 10:46:29 -0700 (PDT)
Date:   Thu, 6 Jul 2023 10:46:27 -0700
In-Reply-To: <20230706142228.1128452-1-bjorn@kernel.org>
Mime-Version: 1.0
References: <20230706142228.1128452-1-bjorn@kernel.org>
Message-ID: <ZKb986L59CTFITjP@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump and validate MAX_SYMS
From:   Stanislav Fomichev <sdf@google.com>
To:     "=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        "=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/06, Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>=20
> BPF tests that load /proc/kallsyms, e.g. bpf_cookie, will perform a
> buffer overrun if the number of syms on the system is larger than
> MAX_SYMS.
>=20
> Bump the MAX_SYMS to 400000, and add a runtime check that bails out if
> the maximum is reached.
>=20
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

OTOH, should be easy to convert this to malloc/realloc? That should fix
it once and for all and avoid future need to bump the limit?

> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 9b070cdf44ac..f83d9f65c65b 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,7 +18,7 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
> =20
> -#define MAX_SYMS 300000
> +#define MAX_SYMS 400000
>  static struct ksym syms[MAX_SYMS];
>  static int sym_cnt;
> =20
> @@ -46,6 +46,9 @@ int load_kallsyms_refresh(void)
>  			break;
>  		if (!addr)
>  			continue;
> +		if (i >=3D MAX_SYMS)
> +			return -EFBIG;
> +
>  		syms[i].addr =3D (long) addr;
>  		syms[i].name =3D strdup(func);
>  		i++;
>=20
> base-commit: fd283ab196a867f8f65f36913e0fadd031fcb823
> --=20
> 2.39.2
>=20
