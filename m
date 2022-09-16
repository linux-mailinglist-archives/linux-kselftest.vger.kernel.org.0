Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8D5BACE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Sep 2022 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIPMBk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Sep 2022 08:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPMBj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Sep 2022 08:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819327F
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Sep 2022 05:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6348862B41
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Sep 2022 12:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3983FC433C1;
        Fri, 16 Sep 2022 12:01:35 +0000 (UTC)
Date:   Fri, 16 Sep 2022 13:01:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Message-ID: <YyRlm/koy30sze9Z@arm.com>
References: <20220829154921.837871-1-broonie@kernel.org>
 <20220829154921.837871-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829154921.837871-4-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 29, 2022 at 04:49:20PM +0100, Mark Brown wrote:
> @@ -1392,7 +1407,7 @@ static const struct user_regset aarch64_regsets[] = {
>  	},
>  	[REGSET_TLS] = {
>  		.core_note_type = NT_ARM_TLS,
> -		.n = 1,
> +		.n = 2,
>  		.size = sizeof(void *),
>  		.align = sizeof(void *),
>  		.regset_get = tls_get,

Does this change confuse user-space? I presume an updated gdb would
check the iov.len to figure out whether a new register is available but
would existing debuggers complain of the new size of this regset?

-- 
Catalin
