Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437366F147A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjD1JrO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjD1JrN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 05:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2049D2;
        Fri, 28 Apr 2023 02:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E4C64248;
        Fri, 28 Apr 2023 09:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6C0C433D2;
        Fri, 28 Apr 2023 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682675228;
        bh=JY4RqeLhcsKS/+d4c0z8n74XUBX98HyxyCgXD4SQ+zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RI4az/7y3FU0cpPuOx218plOYNz/v6s/4ABGMC5YpAktNDlcNLcn5qIdgn3IQs9ic
         nmxACokFS6SsbCAEihulCaGEj+ZYkFGQiN+tG+xIJI+BB873twmvt8wWJpBXDJ1rLB
         yl9UTuSgzUKgfGzuBhnji18Wj/eVj/9uKdUgkjW6JPNjXj2m0n37qKwHF8ROu8nBLO
         MRPFtS7dURfB+UEDlGRo2jmjFPrROL4HErHjOZ8lvbPXmUI8gPLBVYxy4VflkCYxAL
         OIOpMM2mQNuNtu4i/QV431pKjIF4j77cOGnEp/4scGtfr6xUxY6yLztRaQN2Vt+u9z
         +Duj2CTD3lPcQ==
Date:   Fri, 28 Apr 2023 11:47:02 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v1] selftests/bpf: Do not use sign-file as testcase
Message-ID: <ZEuWFk3QyML9y5QQ@example.org>
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
 <ZEq+u0CWs8eO2ED/@google.com>
 <66b8d805-06db-a0ca-9a69-b715d03d4f5e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b8d805-06db-a0ca-9a69-b715d03d4f5e@iogearbox.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 27, 2023 at 10:38:50PM +0200, Daniel Borkmann wrote:
> On 4/27/23 8:28 PM, Stanislav Fomichev wrote:
> > On 04/27, Alexey Gladkov wrote:
> >> The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
> >> but the utility should not be called as a test. Executing this utility
> >> produces the following error:
> >>
> >> selftests: /linux/tools/testing/selftests/bpf: urandom_read
> >> ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read
> >>
> >> selftests: /linux/tools/testing/selftests/bpf: sign-file
> >> not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2
> >>
> >> Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
> >> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > 
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> > 
> >>   tools/testing/selftests/bpf/Makefile | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >> index b677dcd0b77a..fd214d1526d4 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >>   	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
> >>   	xdp_features
> >>   
> >> -TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
> >> -TEST_GEN_FILES += liburandom_read.so
> >> +TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
> 
> Given you move over both of them, the commit msg should be adapted accordingly
> since it mainly talks about sign-file, less so about urandom_read.

I mentioned urandom_read only in the example of output because this
utility is less critical. Although it is mistakenly used as a test, it
does not lead to an error.

First I found sign-file and only then I noticed that urandom_read is not a
test either.

> Also now that you remove the TEST_CUSTOM_PROGS, we should probably also remove
> the other two instances:
> 
> tools/testing/selftests/bpf/Makefile:91:TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file

My patch just changed it.

> tools/testing/selftests/bpf/Makefile:156:        $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
> tools/testing/selftests/bpf/Makefile:674:EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) \

I thought about it.

According to the documentation TEST_CUSTOM_PROGS should be used by tests
that require custom build rule and common prevent build rule use.

These rules provide a custom build of utilities. Therefore, I left it
unchanged in case such tests actually appear.

> >>   # Emit succinct information message describing current building step
> >>   # $1 - generic step name (e.g., CC, LINK, etc);
> >> -- 
> >> 2.33.7
> >>
> 

-- 
Rgrds, legion

