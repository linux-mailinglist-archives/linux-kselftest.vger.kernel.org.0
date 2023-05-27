Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E11B713171
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjE0BWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE0BWE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 21:22:04 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00529BC;
        Fri, 26 May 2023 18:22:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 14D0E3200495;
        Fri, 26 May 2023 21:22:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 May 2023 21:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685150521; x=1685236921; bh=np
        +SdouGYtmY64V5pK+hyAwy83SCQcDxynb0nhR32BA=; b=XUlKda0YE4GJZGIw4V
        QeHdSYVjCMQxPt+BmZZZNP+5nwUdoxIOkUVkSns8u5vgrDVufiRvRNwGsFsTR1L8
        hOn6waYa56qddxfsVI6QhhoGBNH99EV3ILN/M5a2efq+ja28TcGSPXRvzsnAxV5K
        XNoNdxJnL7N5/rSMiCUj5VSI647WWWde9zX0ReknfpYxzP1GwIkKp3u0nc/QrkQ2
        RWVOOrD/0g7d3DB9yyChgvw+O6zOTV6YqqhSXt9/kaHIT8Y2wxDv/sa34XhiXZyV
        GAR8g17ctwW6Z8TD/AjEiOQZwIdoqPXXSlFcit+03R1hzWXQGNn27789mWn3XV7u
        OJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685150521; x=1685236921; bh=np+SdouGYtmY6
        4V5pK+hyAwy83SCQcDxynb0nhR32BA=; b=bRdR7BVjOnjLE3mtJ6d9WlqQvF4If
        LWE2OiY44OCNPNJGcMVKQYJKhlRt0z6tDwIUo122qnDrivXhM6rlCEILiBZh904b
        UDkj+prLG7kMkNpA7EUEnEKRk8iz8eOqiZvZS25c0ltlq185PZN4kfMaRlTFCodm
        Gam73veVcTZlhV8wLyS6Syw2+SGvobWI0CFyLQlZC6nrwEHtGARgewFmj2YajCGG
        GM92x//YyDbqQmpZWj7XePJ9EbZ3AjzWuh291yGTeDYR4kAPnOSBiJLE1NpsNk8A
        iUUhuMdrZVPFeJ+dl8C131vRgu2VQXnG97Mvm1ovrTQOqgI/srkE38hiw==
X-ME-Sender: <xms:OVtxZLcGvom7qMmaPPFsuAFe3kUZwTOc1BTbvHtC3TZxhWwkDBXWxQ>
    <xme:OVtxZBNim4rekYYnCLRmEwLFd2f0dP768sKPaUjwxta-l3hX4UBYOG2pvCgfnXAwJ
    YQHk5366yW_5aej5rQ>
X-ME-Received: <xmr:OVtxZEgsKnmCNcSB4nYmkyqOaUN6MvOs8wckEwh_0B31fNs82lFbn-Z4loE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeektddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdehvddttdfhfefhtdfgleehfeeggfdujeeuveekudevkedvgeejtddtfefgleei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghoug
    gvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:OVtxZM_2AALTXv7jRoLET7t5ck_Vpzkv4ymkusqttk6bOpVXXGjO6A>
    <xmx:OVtxZHvUPv1SWWXBlscpY4i6DNXfPD3WUS9SfIeXlViYT0F4c50DJg>
    <xmx:OVtxZLGW8VLhtHKjtVmC2RHQSLJFJl_xkB6jYSkElaBkcSVmBlPDAA>
    <xmx:OVtxZNXelmlU_vWpBZiKOIo-34Ef91OmQObcFsgCHJt-LdciPzqd1A>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 21:22:00 -0400 (EDT)
Date:   Fri, 26 May 2023 20:21:59 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, shuah@kernel.org, jeffxu@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        niyelchu@linux.microsoft.com
Subject: Re: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown
 type name build failure
Message-ID: <ZHFbN7lVu7gdwCcE@sequoia>
References: <20230526232136.255244-1-hargar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526232136.255244-1-hargar@linux.microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-26 16:21:36, Hardik Garg wrote:
> Partially backport v6.3 commit 11f75a01448f ("selftests/memfd: add
> tests for MFD_NOEXEC_SEAL MFD_EXEC") to fix an unknown type name 
> build error.
> In some systems, the __u64 typedef is not present due to differences
> in system headers, causing compilation errors like this one:
> 
> fuse_test.c:64:8: error: unknown type name '__u64'
>    64 | static __u64 mfd_assert_get_seals(int fd)
> 
> This header includes the  __u64 typedef which increases the
> likelihood of successful compilation on a wider variety of systems.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>

Reviewed-by: Tyler Hicks (Microsoft) <code@tyhicks.com>

Tyler

> ---
>  tools/testing/selftests/memfd/fuse_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
> index be675002f918..93798c8c5d54 100644
> --- a/tools/testing/selftests/memfd/fuse_test.c
> +++ b/tools/testing/selftests/memfd/fuse_test.c
> @@ -22,6 +22,7 @@
>  #include <linux/falloc.h>
>  #include <fcntl.h>
>  #include <linux/memfd.h>
> +#include <linux/types.h>
>  #include <sched.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> -- 
> 2.25.1
> 
