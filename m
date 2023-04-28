Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630386F122E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjD1HPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345425AbjD1HPO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 03:15:14 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10412F;
        Fri, 28 Apr 2023 00:15:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q73WF4TkTz9y4yj;
        Fri, 28 Apr 2023 15:04:25 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHFFtrcktk859eAg--.10972S2;
        Fri, 28 Apr 2023 08:14:58 +0100 (CET)
Message-ID: <f35ea79ac13f1f7ccf189f527d3e7f4d7133cdcd.camel@huaweicloud.com>
Subject: Re: [PATCH v1] selftests/bpf: Do not use sign-file as testcase
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Date:   Fri, 28 Apr 2023 09:14:44 +0200
In-Reply-To: <ZEq+u0CWs8eO2ED/@google.com>
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
         <ZEq+u0CWs8eO2ED/@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBHFFtrcktk859eAg--.10972S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15Xr13CFW3Gw1kKw4DJwb_yoW8AFWUpa
        48Ja4YkryfXF1Ut3W0k3y2qF4rKFs7Xr4rW3WUtry3ZrnrJFykXr4fKFWYk3ZxGrWFgws8
        Aa4IgF93ua1UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj4yaPAAAsf
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-04-27 at 11:28 -0700, Stanislav Fomichev wrote:
> On 04/27, Alexey Gladkov wrote:
> > The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
> > but the utility should not be called as a test. Executing this utility
> > produces the following error:
> > 
> > selftests: /linux/tools/testing/selftests/bpf: urandom_read
> > ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read
> > 
> > selftests: /linux/tools/testing/selftests/bpf: sign-file
> > not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2
> > 
> > Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> > ---
> >  tools/testing/selftests/bpf/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index b677dcd0b77a..fd214d1526d4 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >  	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
> >  	xdp_features
> >  
> > -TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
> > -TEST_GEN_FILES += liburandom_read.so
> > +TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
> >  
> >  # Emit succinct information message describing current building step
> >  # $1 - generic step name (e.g., CC, LINK, etc);
> > -- 
> > 2.33.7
> > 

