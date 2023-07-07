Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF574B56E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGGQyh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjGGQyf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 12:54:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAA272B
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 09:54:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b806d07935so25953265ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688748852; x=1691340852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYmBa1F2BX8uWvMbkaR1fGi0rnov9XOpVr3batef4e0=;
        b=LlhKSI0iiNDqU+nBR49VWVVHL5UYlaTDihcgAZUSMvC+r7NXlp88s+ieWkOa+6iHTJ
         IEzRJgHbrGJy2ocm9pXJcl1A6wPNs8JK8gwoNbhVobbqxNdqYYfGsTUMI6vspI4OSXH8
         9j2+Vdm0MRw6Y42e9KYC4Mz/Q7ed/FE89+V7cfxxohweG7UbFvs+EhtxnFkYOZHz9+7H
         WG+6hG0gEbt8li/c4naCJ0uo7UvIkxr+DA9xUwxnEN0IL7+5Mze+YIn8DdzWK8ejHsdw
         Xo+gf+F7DrNLlUxAcWcD4AsoP1N5VPM6VbYOKhRNA0gzjBTqwMz8kwV3GOPit7NwIEKm
         DgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748852; x=1691340852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYmBa1F2BX8uWvMbkaR1fGi0rnov9XOpVr3batef4e0=;
        b=bahlktWNxCQpZS1fS8Oginp0e/QTXeMWuNfse4qIjVdT7YONsxGuC1tsoPdIuGT8qj
         6PlhICIdg54yStWskJ/YNF4Ee8UAX75yr0XiFBWOO10Ggfrah7WnW6NVtFTZijXbv4F2
         JzByDs/YyCWZVar0PB4U23yr0Op2IIL+EhVu97QtR5nrDGT1Ayl21AJ5sVlcN7D5upho
         XcE5XAY6Aw23u24HQ+Ng1SCOnOFag4T8/Tc/oAvBsUDd3RsrqKR9uNvFk4XWS55mrVNW
         gOuTGExt9yJazsx/UHenRXek5zEaVtmxUhl8FA+5uhwivAj9+soIJ0QZ9jHTyaFW3OUZ
         L59Q==
X-Gm-Message-State: ABy/qLaiEM4RH9M9py4Ac/0sGHTOkrDu331iHmATOxW6YaOhk/0GzEk5
        OU884eanpLfOGImei0MwkQZ6V0U=
X-Google-Smtp-Source: APBJJlEVJjri9XISZQJZlgb4aeeseqypovFXtIuHn7VbDLYBBsX51T1ZKVFL/sdG77g39zWrmfGlal8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:9a87:b0:1b8:80c9:a98e with SMTP id
 w7-20020a1709029a8700b001b880c9a98emr4881183plp.13.1688748852376; Fri, 07 Jul
 2023 09:54:12 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:54:11 -0700
In-Reply-To: <b438d804-f73e-a5e4-0473-f21fa22a4486@huawei.com>
Mime-Version: 1.0
References: <20230707081253.34638-1-luhongfei@vivo.com> <b438d804-f73e-a5e4-0473-f21fa22a4486@huawei.com>
Message-ID: <ZKhDMxVpu+w4Wb+t@google.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Corrected two typos
From:   Stanislav Fomichev <sdf@google.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Lu Hongfei <luhongfei@vivo.com>, opensource.kernel@vivo.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anton Protopopov <aspsk@isovalent.com>,
        Wang Yufen <wangyufen@huawei.com>,
        YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/07, Hou Tao wrote:
> 
> 
> On 7/7/2023 4:12 PM, Lu Hongfei wrote:
> > When wrapping code, use ';' better than using ',' which is more
> > in line with the coding habits of most engineers.
> >
> > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > ---
> > Compared to the previous version, the modifications made are:
> > 1. Modified the subject to make it clearer and more accurate
> > 2. Newly optimized typo in tcp_hdr_options.c
> >
> >  tools/testing/selftests/bpf/benchs/bench_ringbufs.c      | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Hou Tao <houtao1@huawei.com>

Acked-by: Stanislav Fomichev <sdf@google.com>
