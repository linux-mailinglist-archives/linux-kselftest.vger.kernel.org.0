Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B66A3A53
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 06:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjB0F0J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 00:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0F0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 00:26:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6AE392;
        Sun, 26 Feb 2023 21:26:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PQ89S1gvyz4x4r;
        Mon, 27 Feb 2023 16:26:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677475564;
        bh=T6QIytn9L33Q7Aw+6A+7icMEI0DxJnhlJO8jCmkh/j8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=KVFEitcLJPxiyFCpSP6KfUPWvu9FUwNV/+hoYvvH1l2j1vvswhMgzA4Fqa/YfLTu2
         Ofo9OjPay9EK8L/di6xhIHfBhIxu+h0rprf7TfkFD57UP+ZJ3V86Zdast9cO2SswEE
         AQJlSBZGI8R3iRBn7/A3aqpaWzP9FN9z5tFdibRmszJGAEOuftArf2n08X0z9MBQXH
         Ql7h2eDNEttzDilSjOkRpgj1jT1/rQxwNYBsdcIFiDBoOfqOMB31dphjVVGn9IV6Le
         RdtvpmZVPedj75L9CXYrnP+gqR+7u3fEu+OmYwTFmVL9nKwKp7N/yWt9AXSasBqCGJ
         kcUPNThXs1dyg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Binderman <dcb314@hotmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug in
 linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
In-Reply-To: <DB6P189MB0568CF002762C6C43AF6DF169CA89@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
References: <DB6P189MB0568CF002762C6C43AF6DF169CA89@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Date:   Mon, 27 Feb 2023 16:26:01 +1100
Message-ID: <87ttz7vfva.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Binderman <dcb314@hotmail.com> writes:
> Hello there,
>
> I ran the static analyser cppcheck over the linux-6.2 source code and got this:
>
> linux-6.2/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c:68:10: style: Same expression '0x3' found multiple times in chain of '&' operators. [duplicateExpression]

Thanks.

> Source code is
>
>     FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample & 0x3) !=
>             get_mmcra_sample_mode(get_reg_value(intr_regs, "MMCRA"), 4));
>
> but
>
> #define EV_CODE_EXTRACT(x, y)   \
>     ((x >> ev_shift_##y) & ev_mask_##y)
>
>
> Given the token pasting, I very much doubt an expression like "sample & 0x3"
> will work correctly. Same thing on the line above 
>
>     FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample >> 2) !=
>             get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4));
>
> "sample >> 2" doesn't look like a valid token to me.

It expands to:

 if ((((event.attr.config >> ev_shift_sample >> 2) & ev_mask_sample >> 2) != get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4))) 

Which AFAICS is valid, and does compile.

Whether it's what the author actually intended is less clear.

And the other example with & 0x3 seems obviously wrong, it expands to:

  if ((((event.attr.config >> ev_shift_sample & 0x3) & ev_mask_sample & 0x3) != get_mmcra_sample_mode(get_reg_value(intr_regs, "MMCRA"), 4)))

The shift is 24, so bitwise anding it with 0x3 gets 0 which doesn't seem
likely to be what was intended.

cheers
