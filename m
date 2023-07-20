Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6B75AC69
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGTKwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjGTKwo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 06:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A2173A;
        Thu, 20 Jul 2023 03:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CFA61A04;
        Thu, 20 Jul 2023 10:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053B3C433C8;
        Thu, 20 Jul 2023 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689850361;
        bh=PiRPsNTu3ZoxabFGwoYJ4bs4XlF9WqCHpONj7mkDnk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2kSefCsQUr6rv7Myphpg5jQl+JDzG9RNrwiQWlrGbNOWMqhge0LNb/s/yo4kA/d7
         vQl+7zWRcyUzfZzxlnUyCBmJGH+8QIO1K9H3S0gRUfSdtnxp1dpqHEXR4wksJbyCFG
         nUFlC8RsVGkMl1J7l/k6sa7PzQSH/ydMk42obYYYrs6Wbdxikzu186hE0wpsZjkZwX
         JG9HfU3rzvh7xVWJAFQYBtHMT8afV3bksmMojC7nF+QXMpA7HhOJRi+bwGysZjdVc3
         KDcQXIL1uPdd6ekjKDhNL8SY18kX1xMnHdGEpL7jaubKiOOOoBRdSX5KRddhNXendO
         KweixedEavBsQ==
Date:   Thu, 20 Jul 2023 11:52:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64/fpsimd: Ensure SME storage is allocated after
 SVE VL changes
Message-ID: <20230720105235.GD11034@willie-the-truck>
References: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
 <20230713-arm64-fix-sve-sme-vl-change-v1-1-129dd8611413@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713-arm64-fix-sve-sme-vl-change-v1-1-129dd8611413@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 13, 2023 at 09:06:04PM +0100, Mark Brown wrote:
> When we reconfigure the SVE vector length we discard the backing storage
> for the SVE vectors and then reallocate on next SVE use, leaving the SME
> specific state alone. This means that we do not enable SME traps if they
> were already disabled. That means that userspace code can enter streaming
> mode without trapping, putting the task in a state where if we try to save
> the state of the task we will fault.
> 
> Since the ABI does not specify that changing the SVE vector length disturbs
> SME state, and since SVE code may not be aware of SME code in the process,
> we shouldn't simply discard any ZA state. Instead immediately reallocate
> the storage for SVE if SME is active, and disable SME if we change the SVE
> vector length while there is no SME state active.

What is the advantage of keep the old behaviour in this case? In other
words, if it's acceptable to reallocate the state when SME is active, why
not just reallocate in all cases?

Will
