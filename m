Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC705AA654
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 05:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiIBD1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 23:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiIBD1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 23:27:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874E2A0622;
        Thu,  1 Sep 2022 20:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5636B829B7;
        Fri,  2 Sep 2022 03:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1416CC433C1;
        Fri,  2 Sep 2022 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662089252;
        bh=qSAS0T0MuBmaWeT8uG5lNnET4yd1Q33sgQdS6DbDcJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qvnk9aGn58J554jGx93rrg65XFeihTphkgWxYKbWYj+w8dYmNgGUwSWflA4AdmhUg
         AbVqcYUucbQnz/XNnCf9toUpbL1FvSoz5iThdvfUBVbT9xcgJ7y930xmQ81edGrzb0
         TP/dJuUwCZxQ3SgFlCQSOFNt8bP5c4mjOkrAp9p5u5iZsq3hcIeIjziNHJ1a8PY3SX
         g64TdCOTQ43CVy3z1fs/wpko3HvbEZC/wUG8rZ+GiiC958/B7ga4p01wl+tPNWovoR
         EaDg0ltOoemE0r+kTJdaEGn4BFVQ9Bd6d766ultH2RxUxLLnALCVt273hjYLNJ78eQ
         gRXrdlGXfJXmA==
Date:   Fri, 2 Sep 2022 06:27:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        David Howells <dhowells@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v14 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and set KEY_LOOKUP_FLAGS_ALL
Message-ID: <YxF4H9MTDj+PnJ+V@kernel.org>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
 <20220830161716.754078-6-roberto.sassu@huaweicloud.com>
 <Yw7NKJfhyJqIWUcx@kernel.org>
 <Yw7o43Ivfo3jRwQg@kernel.org>
 <cad9a20cadc074cf15dcd0d8eb63b43c98a2f13d.camel@huaweicloud.com>
 <CAADnVQLCyts0JZ7_=rTp8vP67ET4PjVsZ0Cis0XKUpeCdC13LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLCyts0JZ7_=rTp8vP67ET4PjVsZ0Cis0XKUpeCdC13LA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 08:33:38AM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 31, 2022 at 2:24 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > > > >
> > > > > +#define KEY_LOOKUP_CREATE        0x01
> > > > > +#define KEY_LOOKUP_PARTIAL       0x02
> > > > > +#define KEY_LOOKUP_FLAGS_ALL     (KEY_LOOKUP_CREATE |
> > > > > KEY_LOOKUP_PARTIAL)
> > > >
> > > > IMHO this could be just KEY_LOOKUP_ALL.
> 
> Since this is supposed to be kernel internal flags
> please make them enum, so that bpf progs can auto-adjust
> (with the help of CORE) to changes in this enum.
> With #define there is no way for bpf prog to know
> when #define changed in the future kernels.

Isn't enum also Rust compatibility requirement, or do I remember
incorrectly? Anyway, good suggestion.

BR, Jarkko
