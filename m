Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4B75ABFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGTKbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGTKbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C810F1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 03:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A25B61A08
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 10:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8535C433C7;
        Thu, 20 Jul 2023 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689849078;
        bh=J75VgyCyMOY4uCVubQ02MoxyKNXvNaiEKCHSA0oocXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYhuewxIOIozhxLyaQzjLN74pujj/a3exBH06uQTom5IvOVid8aDiTflLeZzm5uHg
         08243Z/whH+358t36ORt45RWh+c+Y51XBopl47o8zMbzsIeH/g13QUYcMNSbZMNu8E
         BUgHDYOh6e8F7lRGY3GkYdw6KCsCg0TfKVbO1ZMwNsgWWeR7hBD+Nn+/lKcN0sQlMW
         mK9heIEdJxoKkG7YdmJD+nWaNPg0QhK5Q+nvFJl5xqgTWk2aadpt5/MkH1TPndrUbr
         m/MtFlVmajFkz7AXXLeo+FveOvVRJq9gRfsldq+wK0HNdrpVrsfDlQuc+epFPxoOc0
         BzRPPehhzfDPw==
Date:   Thu, 20 Jul 2023 11:31:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/arm64: Exit streaming mode after collecting
 signal context
Message-ID: <20230720103113.GA11034@willie-the-truck>
References: <20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org>
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

Hi Mark,

On Wed, Jul 12, 2023 at 12:02:30PM +0100, Mark Brown wrote:
> When we collect a signal context with one of the SME modes enabled we will
> have enabled that mode behind the compiler and libc's back so they may
> issue some instructions not valid in streaming mode, causing spurious
> failures.
> 
> For the code prior to issuing the BRK to trigger signal handling we need to
> stay in streaming mode if we were already there since that's a part of the
> signal context the caller is trying to collect. Unfortunately this code
> includes a memset() which is likely to be heavily optimised and is likely
> to use FP instructions incompatible with streaming mode. We can avoid this
> happening by open coding the memset(), inserting a volatile assembly
> statement to avoid the compiler recognising what's being done and doing
> something in optimisation. This code is not performance critical so the
> inefficiency should not be an issue.
> 
> After collecting the context we can simply exit streaming mode, avoiding
> these issues. Use a full SMSTOP for safety to prevent any issues appearing
> with ZA.

Thanks for looking at this. Comments inline.

> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
> index 222093f51b67..db28409fd44b 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
> @@ -60,13 +60,28 @@ static __always_inline bool get_current_context(struct tdescr *td,
>  						size_t dest_sz)
>  {
>  	static volatile bool seen_already;
> +	int i;
> +	char *uc = (char *)dest_uc;
>  
>  	assert(td && dest_uc);
>  	/* it's a genuine invocation..reinit */
>  	seen_already = 0;
>  	td->live_uc_valid = 0;
>  	td->live_sz = dest_sz;
> -	memset(dest_uc, 0x00, td->live_sz);
> +
> +	/*
> +	 * This is a memset() but we don't want the compiler to
> +	 * optimise it into either instructions or a library call
> +	 * which might be incompatible with streaming mode.
> +	 */
> +	for (i = 0; i < td->live_sz; i++) {
> +		asm volatile("nop"
> +			     : "+m" (*dest_uc)
> +			     :
> +			     : "memory");

I don't think it's save to use "+m" here, since the compiler can assume
that the address is used exactly once in the asm. If a post-indexed
addressing mode is generated, then you can end up with register corruption.

Stepping back, why not use either barrier() or OPTIMIZER_HIDE_VAR()
instead?

The most robust fix would be to write all of the streaming mode code in
asm, but I can appreciate that's a tonne of work for a testcase.

Will
