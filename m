Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC35632D4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKUTvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 14:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiKUTvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 14:51:03 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B5D539E;
        Mon, 21 Nov 2022 11:51:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n21so30927926ejb.9;
        Mon, 21 Nov 2022 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWLdJJDPEqVULc2oQdrml30Pa4z33QzeUxbdXRKXWHo=;
        b=G5hsHwuInQCfQ+JbnGoJ7f7lcIqikXLI78JMoJiw7+DCPUUSZmW8c8MQxyke9z515B
         ywBlAWDW+YMrzizHnZEX17JVIJiGu1qJ3a9u377dwuEhxdXtQP1y30awITZcqz7bxq1o
         WKFrNIIjbGjRpjZckSoEayAlh08d3AwvNlZI+yTUzCMUt1G9O9w+9G+sqIDuBhat2t3g
         mfM5HcpaXeqASYwtUlG2goN6ZOV6zQ26DI/pF12jzKSp8K4vjjP+9qq+26fxfKpp8T9L
         L8gCwFrzYQG8dNAv+WgTeYFTuhcriZM2oWADtPxDeY+Tc3JygdHIt5S0eMDnQu9R7wW8
         6/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWLdJJDPEqVULc2oQdrml30Pa4z33QzeUxbdXRKXWHo=;
        b=gXzLkeolycCFbkyJ98NARrHMboLZ1qFGzNPLC8MzuD1WU3ir1fXlByhZJFlxdP6Yqb
         RXLTQdwyCrqQz29iFzI0WK3mdmZKPJvuJyQv1RfobN9XZ4C58VK5wmtPvSKMN53mJMv8
         +4aAeYmHncQ4Qeo0APRd/+W+azsnZNH0PBLjwSriM6xZEWW54MTXWTFO4vwHwISlFrNA
         B1rigHtNkmcC7OglWNHjQkCh3Ce/0nLy3xrce7pkzbqzAIM92BH+nMHB88xZMAy3Ay1w
         6sT6q3GjrXcwo7vSaa3A1pimFy9PPXQaljbKjRT/Xi4zcdk8C7C7KatU5TlVCJPcUJ5Z
         nHvA==
X-Gm-Message-State: ANoB5pkmPXLZAbfQimB6Dv20kmOalXVBhcExEZ6IZ+K7UGr7H/LpelQx
        /B1PTF/3ocg+Ki3oKlnsoCd2EQW3NV541vu12LU=
X-Google-Smtp-Source: AA0mqf41qRpt1ALnZuh6h0zWQOQgAPiWwxZj1dr74tBklG//+TkizWoGq+Dz8s7s59i6bkCTYNu1zQEdi4xwDXDKzFk=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr5700043eje.94.1669060260708; Mon, 21 Nov
 2022 11:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114134720.1057939-1-xukuohai@huawei.com> <20221114134720.1057939-2-xukuohai@huawei.com>
 <CAADnVQLEzrqjuF+qYh2kJz0Q=9G8PySJ6ZwXD2EGoZsBUdwsog@mail.gmail.com>
 <fd1e6d2d-f7a2-21d2-f0ff-3e3d8b2ba9eb@huawei.com> <a6f8b4a4-2c37-740b-af87-c61af51eaab5@huaweicloud.com>
In-Reply-To: <a6f8b4a4-2c37-740b-af87-c61af51eaab5@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Nov 2022 11:50:49 -0800
Message-ID: <CAADnVQLnCeMu7yukHta8GHVPKwdqA=yjPr7DBgmLSU56pVifew@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Do not copy spin lock field from user in bpf_selem_alloc
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 21, 2022 at 3:30 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>
> On 11/16/2022 4:07 PM, Xu Kuohai wrote:
> > On 11/16/2022 1:27 PM, Alexei Starovoitov wrote:
> >> On Mon, Nov 14, 2022 at 5:31 AM Xu Kuohai <xukuohai@huawei.com> wrote:
> >>>
> >>> bpf_selem_alloc function is used by inode_storage, sk_storage and
> >>> task_storage maps to set map value, for these map types, there may
> >>> be a spin lock in the map value, so if we use memcpy to copy the whole
> >>> map value from user, the spin lock field may be initialized incorrectly.
> >>>
> >>> Since the spin lock field is zeroed by kzalloc, call copy_map_value
> >>> instead of memcpy to skip copying the spin lock field to fix it.
> >>>
> >>> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> >>
> >> The tag is wrong. When local storage was introduced it was not
> >> possible to use spin_locks there.
> >> Pls resubmit.
> >> .
> >
> > No, spin_lock was introduced by d83525ca62cf ("bpf: introduce bpf_spin_lock"),
> > before 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage").
> >
> > To confirm this, I built a kernel image on comit 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> > and run test case posted in patch 2, a softlockup was triggered. Then I picked
> > this patch and tried again, nothing failed.
>
> Hello, am I right? Or could you please give the correct fix-tag? Thanks.

I see. I was under the impression that bpf_spin_lock was enabled
in the local storage later.
Ok. Applied as-is.
