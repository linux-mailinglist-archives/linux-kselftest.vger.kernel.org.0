Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24B6EE5CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjDYQcv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjDYQcu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 12:32:50 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C69CDC17A;
        Tue, 25 Apr 2023 09:32:49 -0700 (PDT)
Date:   Tue, 25 Apr 2023 18:32:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Kai Liu <kai.liu@suse.com>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: netfilter: fix a build error on openSUSE
Message-ID: <ZEgArba2jGAGy0/Z@calendula>
References: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
 <8cbf1231-0da5-c8a0-d66b-1488633d9895@linuxfoundation.org>
 <Yh+wulh/nIkFeFmz@salvia>
 <sr67066-o9or-1s32-pp7-s764r386n55q@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sr67066-o9or-1s32-pp7-s764r386n55q@vanv.qr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 25, 2023 at 11:14:55AM +0200, Jan Engelhardt wrote:
> 
> On Wednesday ** 2022-03-02 19:00 **, Pablo Neira Ayuso wrote:
> 
> 
> >On Wed, Mar 02, 2022 at 10:11:11AM -0700, Shuah Khan wrote:
> >> On 3/1/22 10:29 PM, Geliang Tang wrote:
> >> > This patch fixed the following build error on openSUSE Leap 15.3:
> >> >   nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or directory
> >> >    #include <libmnl/libmnl.h>
> >> > diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
> >> > index e4f845dd942b..8136c1fab7ab 100644
> >> > --- a/tools/testing/selftests/netfilter/Makefile
> >> > +++ b/tools/testing/selftests/netfilter/Makefile
> >> > @@ -8,6 +8,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
> >> >   	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
> >> >   	conntrack_vrf.sh nft_synproxy.sh
> >> > +CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
> >> >   LDLIBS = -lmnl
> >> >   TEST_GEN_FILES =  nf-queue
> >> 
> >> Adding Pablo to the thread.
> >> This looks good to me. I can take this through linux-kselftest tree.
> >> Or if it is going through netfilter tree:
> >> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> >
> >If this does not cause any issue when running tests in any other
> >distros, then it is fine with me.
> 
> Since a pkgconfig file exists, it ought to be used. That also means
> you need the same/similar incantation in LDLIBS, with
> `pkg-config --libs libmnl`.

Patch?
