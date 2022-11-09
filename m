Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7062297D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 12:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKILEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 06:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKILEc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 06:04:32 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 909B7644C;
        Wed,  9 Nov 2022 03:04:30 -0800 (PST)
Received: from pwmachine.localnet (85-170-25-210.rev.numericable.fr [85.170.25.210])
        by linux.microsoft.com (Postfix) with ESMTPSA id E10EA20B929F;
        Wed,  9 Nov 2022 03:04:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E10EA20B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667991870;
        bh=xjS3RSgFinUTnn09YzQPAUOcc5Q2nF9iD2L4KzdBxww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gf/R1SCtcGFF4CgzLlMsIc28oU4/5u8K8PB3INvwTTeVUNeluS7YQDzb7WkVZBGXM
         aTE3sOLwkcICATx7N4IcHvqtFxt3hZH5a9ZuqjcrhWmR/tnPzX5NnDMaAnbb243Fdt
         a+TEzsT3R21bijzQv3l8DC5BsrleqV8rqMp/comQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] maccess: fix writing offset in case of fault in strncpy_from_kernel_nofault()
Date:   Wed, 09 Nov 2022 12:04:24 +0100
Message-ID: <2655397.mvXUDI8C0e@pwmachine>
In-Reply-To: <20221108130551.85ad67b402582e3855418294@linux-foundation.org>
References: <20221108195211.214025-1-flaniel@linux.microsoft.com> <20221108195211.214025-2-flaniel@linux.microsoft.com> <20221108130551.85ad67b402582e3855418294@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi.

Le mardi 8 novembre 2022, 22:05:51 CET Andrew Morton a =E9crit :
> On Tue,  8 Nov 2022 20:52:06 +0100 Francis Laniel=20
<flaniel@linux.microsoft.com> wrote:
> > From: Alban Crequy <albancrequy@microsoft.com>
> >=20
> > If a page fault occurs while copying the first byte, this function rese=
ts
> > one byte before dst.
> > As a consequence, an address could be modified and leaded to kernel
> > crashes if case the modified address was accessed later.
> >=20
> > Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
> > Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
>=20
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>=20
> Please merge via the bpf tree.
>=20
> This looks potentially nasty.  Fortunately only tracing code uses it,
> but I'm thinking it should have cc:stable and a Fixes:?

Thank you for the review!
Sorry, I thought to add stable list but forgot to add it when sending the=20
series...
I will sent a v2 with your review and without rfc tag to, among others,=20
stable.


