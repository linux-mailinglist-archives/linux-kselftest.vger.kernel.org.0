Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7307464D0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGCV0G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGCV0G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 17:26:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58392E62;
        Mon,  3 Jul 2023 14:26:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66872d4a141so2911439b3a.1;
        Mon, 03 Jul 2023 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688419562; x=1691011562;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bmKZ8Y/bfL0lMK2TktVUvKgxAR9Wdg/glmHijui0lE=;
        b=X0JQ3sIwqpDsvmjbL/qFyefRXGKaTd5daOZPNF2QsYjbFKpMdoOlyCTdiGdXZLLbmn
         TE9h280nCAXRyMRPToBUNcG8wns2Rneev2GL7FvLyhBReWy/YoYZwD9SoVreW50lHhuo
         03VjIVhjvpbWh8t1UJeByciP0JY0fABpW917T7Fp7e/0UHwU3Ii09aT7mNPqV2TLCWIN
         ZdJUuDkmCx/m/6EqLMdKHHYdpLRnGMHHW3DqQSjbxegGW+/JXhrLyHByrIle4ovAchPk
         j3Fbs+aCtoc2liyztfxUtZA7msaF0e2rgyrcMKlvu267D/wBq3sT9TgluWPFBu20ujC+
         xghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419562; x=1691011562;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4bmKZ8Y/bfL0lMK2TktVUvKgxAR9Wdg/glmHijui0lE=;
        b=CgcVbXXve6/xLpMsGicf6Ox+bz/FRsu4CxVy6dy2cnFpU02gOYXEztTTxjyhkpOaoi
         Ia6psj4GUa3rL1oYCtzXFXiuUsQFfJxiYV45wWqQGxJzeBLyb1sgYI/MrEV8CdypmMym
         h6DwHySc4h1ht/LjX84FyJPs+sOj7Hv8JT9uQGJapVXGJWC4traaO3YYY8EEPhbOERC6
         4vwW1YadZ6ESpjsL1GrijOPD+HdxnajtR/ZjIleY+8gtlhqDQ0Bnmuo670SxVkWHjUSW
         LIz8EfT8XIj0x45qIak6SZGZlLsHKe9Ex/7bhxGHLWw8PC4BfFdE5Eju9S0srIjL5CcD
         jXKw==
X-Gm-Message-State: AC+VfDx5Ndkdv32CBzhZc0x6GH/GQiG//iyGWI3h6KxOEyvQrxZqqQDG
        iwtsU4UFSN+ReQAt85g6Unc=
X-Google-Smtp-Source: ACHHUZ67vfjG9TOTuz6vIg9/gI1HAJ/DfD0VsFRyLGeO9oxaqDjP6MJNysppVbEjM9Xymhho6qmNdw==
X-Received: by 2002:a05:6a20:8f16:b0:12d:3d9e:2934 with SMTP id b22-20020a056a208f1600b0012d3d9e2934mr9111623pzk.44.1688419561631;
        Mon, 03 Jul 2023 14:26:01 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027d8d00b001acae9734c0sm15690664plm.266.2023.07.03.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:26:01 -0700 (PDT)
Date:   Mon, 03 Jul 2023 14:25:59 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <64a33ce7b50d2_6520520875@john.notmuch>
In-Reply-To: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
References: <20230703175048.151683-1-jthinz@mailbox.tu-berlin.de>
Subject: RE: [PATCH 0/2] bpf, net: Allow setting SO_TIMESTAMPING* from BPF
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

J=C3=B6rn-Thorben Hinz wrote:
> BPF applications, e.g., a TCP congestion control, might benefit from
> precise packet timestamps. These timestamps are already available in
> __sk_buff and bpf_sock_ops, but could not be requested: A BPF program
> was not allowed to set SO_TIMESTAMPING* on a socket. This change enable=
s
> BPF programs to actively request the generation of timestamps from a
> stream socket.
> =

> To reuse the setget_sockopt BPF prog test for
> bpf_{get,set}sockopt(SO_TIMESTAMPING_NEW), also implement the missing
> getsockopt(SO_TIMESTAMPING_NEW) in the network stack.
> =

> I reckon the way I added getsockopt(SO_TIMESTAMPING_NEW) causes an API
> change: For existing users that set SO_TIMESTAMPING_NEW but queried
> SO_TIMESTAMPING_OLD afterwards, it would now look as if no timestamping=

> flags have been set. Is this an acceptable change? If not, I=E2=80=99m =
happy to
> change getsockopt() to only be strict about the newly-implemented
> getsockopt(SO_TIMESTAMPING_NEW), or not distinguish between
> SO_TIMESTAMPING_NEW and SO_TIMESTAMPING_OLD at all.

Yeah, I think it would be best if we keep the old behavior and let
SO_TIMESTAMPING_OLD return timestamps for both new/old. It looks
like it should be relatively easy to implement?

Otherwise the series lgtm.

> =

> J=C3=B6rn-Thorben Hinz (2):
>   net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
>   bpf: Allow setting SO_TIMESTAMPING* with bpf_setsockopt()
> =

>  include/uapi/linux/bpf.h                            | 3 ++-
>  net/core/filter.c                                   | 2 ++
>  net/core/sock.c                                     | 9 +++++++--
>  tools/include/uapi/linux/bpf.h                      | 3 ++-
>  tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
>  tools/testing/selftests/bpf/progs/setget_sockopt.c  | 4 ++++
>  6 files changed, 19 insertions(+), 4 deletions(-)
> =

> -- =

> 2.39.2
> =

> =
