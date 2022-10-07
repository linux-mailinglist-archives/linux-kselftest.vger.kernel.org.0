Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121235F7773
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Oct 2022 13:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJGLcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Oct 2022 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJGLcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Oct 2022 07:32:07 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B0CF1AE;
        Fri,  7 Oct 2022 04:32:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MkQwj1SLfz9xHwF;
        Fri,  7 Oct 2022 19:25:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHQ14XDkBjSF+mAA--.6552S2;
        Fri, 07 Oct 2022 12:31:45 +0100 (CET)
Message-ID: <903481c1933ba25f5b97d378b7344502cd56f209.camel@huaweicloud.com>
Subject: Re: [PATCH v2 0/6] Add _opts variant for bpf_*_get_fd_by_id()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 07 Oct 2022 13:31:32 +0200
In-Reply-To: <Y0AGhW4USeB4sHU3@krava>
References: <20221006110736.84253-1-roberto.sassu@huaweicloud.com>
         <Y0AGhW4USeB4sHU3@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHQ14XDkBjSF+mAA--.6552S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47CF1kCw4fKrW3WFyDZFb_yoW5GrWUpa
        95Ga4Ykr4FqryI9F9xtFZYvFn5tFWxX34UGa4xJr13Ary0qFs8Z34xWr43ur9I934kGw4D
        Zw4Yyry5Gw1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBF1jj3-zDAABsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-10-07 at 12:59 +0200, Jiri Olsa wrote:
> On Thu, Oct 06, 2022 at 01:07:30PM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the _opts variant for bpf_*_get_fd_by_id() functions, to be
> > able to
> > pass to the kernel more options, when requesting a fd of an eBPF
> > object.
> > 
> > Pass the options through a newly introduced structure,
> > bpf_get_fd_by_id_opts, which currently contains open_flags (the
> > other two
> > members are for compatibility and for padding).
> > 
> > open_flags allows the caller to request specific permissions to
> > access a
> > map (e.g. read-only). This is useful for example in the situation
> > where a
> > map is write-protected.
> > 
> > Besides patches 2-6, which introduce the new variants and the data
> > structure, patch 1 fixes the LIBBPF_1.0.0 declaration in
> > libbpf.map.
> > 
> > Changelog
> > 
> > v1:
> >  - Don't CC stable kernel mailing list for patch 1 (suggested by
> > Andrii)
> >  - Rename bpf_get_fd_opts struct to bpf_get_fd_by_id_opts
> > (suggested by
> >    Andrii)
> >  - Move declaration of _opts variants after non-opts variants
> > (suggested by
> >    Andrii)
> >  - Correctly initialize bpf_map_info, fix style issues, use map
> > from
> >    skeleton, check valid fd in the test (suggested by Andrii)
> >  - Rename libbpf_get_fd_opts test to libbpf_get_fd_by_id_opts
> > 
> > Roberto Sassu (6):
> >   libbpf: Fix LIBBPF_1.0.0 declaration in libbpf.map
> >   libbpf: Introduce bpf_get_fd_by_id_opts and
> >     bpf_map_get_fd_by_id_opts()
> >   libbpf: Introduce bpf_prog_get_fd_by_id_opts()
> >   libbpf: Introduce bpf_btf_get_fd_by_id_opts()
> >   libbpf: Introduce bpf_link_get_fd_by_id_opts()
> >   selftests/bpf: Add tests for _opts variants of
> > bpf_*_get_fd_by_id()
> 
> it's not marked, but I'm assuming this goes to bpf-next, right?

At the next possible chance would be perfect.

> anyway, lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks

Roberto

> thanks,
> jirka
> 
> >  tools/lib/bpf/bpf.c                           | 48 +++++++++-
> >  tools/lib/bpf/bpf.h                           | 16 ++++
> >  tools/lib/bpf/libbpf.map                      |  6 +-
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> >  .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c | 87
> > +++++++++++++++++++
> >  .../bpf/progs/test_libbpf_get_fd_by_id_opts.c | 36 ++++++++
> >  6 files changed, 189 insertions(+), 5 deletions(-)
> >  create mode 100644
> > tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> >  create mode 100644
> > tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
> > 
> > -- 
> > 2.25.1
> > 

