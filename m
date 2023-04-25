Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8E6EEA49
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 00:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjDYWVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 18:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDYWV3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 18:21:29 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1CC148;
        Tue, 25 Apr 2023 15:21:27 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 6B6455872CC11; Wed, 26 Apr 2023 00:21:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6AD9760C41016;
        Wed, 26 Apr 2023 00:21:26 +0200 (CEST)
Date:   Wed, 26 Apr 2023 00:21:26 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Kai Liu <kai.liu@suse.com>, linux-kselftest@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] selftests: netfilter: fix libmnl pkg-config usage
In-Reply-To: <20230425211139.518381-1-jeremy@azazel.net>
Message-ID: <6qpp4r21-8p95-8nso-4424-4pr28037qq98@vanv.qr>
References: <ZEgArba2jGAGy0/Z@calendula> <20230425211139.518381-1-jeremy@azazel.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Tuesday 2023-04-25 23:11, Jeremy Sowden wrote:

>1. Don't hard-code pkg-config
>2. Remove distro-specific default for CFLAGS
>3. Use pkg-config for LDLIBS


>+CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
>+LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)

Ah yes, this looks better and looks modeled upon selftests/bpf/Makefile.
Speaking of which, there's a space missing over there.

tools/testing/selftests/bpf/Makefile:HOSTPKG_CONFIG := pkg-config
tools/testing/selftests/bpf/Makefile:   $(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
tools/testing/selftests/bpf/Makefile:             $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
