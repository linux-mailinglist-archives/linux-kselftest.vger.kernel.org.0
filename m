Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672E85F8C18
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Oct 2022 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJIPpz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Oct 2022 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJIPpy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Oct 2022 11:45:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4592408B;
        Sun,  9 Oct 2022 08:45:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so7184335wme.5;
        Sun, 09 Oct 2022 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nRMSkb+ml96yYY9w8KKx8b1cTDJi6bovEKWdF0d+9Y=;
        b=JmbKkz1Jw/pgnvrZOmgP0Zo9MWwwLNmpJN3+e+pwC16qEybYFCiblKveHxpz26pSr+
         Phc9sspbhuEayA2+LLZn8C4hvexpN7Qa2isk4KwF3GS4ED+F/vTTkLFvYy0FbTiSY91g
         H0rVInXMz1wyaxjwPhimc1mGKPgRGpHoogueQLf09MhLlFAz8G1MRzy3BhGcTGyqAlZS
         5X3Efit43XbkAGKayC+SNPPmgLmgIy3eXe7yzWy/qX+3Fm3yN9P/ILlrP8oaE33v3m3y
         MVu0LPGV/qh9rN/sYl/aCmhPRx962Ca5esEOVTTPLc9IuBbO0g030lVviamMDXaIGqpU
         Vr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nRMSkb+ml96yYY9w8KKx8b1cTDJi6bovEKWdF0d+9Y=;
        b=oQ5QbJnpXLaBcLFOL+90cp90B0xxJ6L3+z+fTtyetRiDl/S1ND+wUzADEdfPEqOFu1
         /iu4kNyJYkgKP7WqyX+pkcuIxA5bvtx7OwvqCbimcPQHXhXD369t2GzegZCRhfxceRx9
         s+zcZoIz6TNXtT4HKpJWu6QJZ5Isp7kOWyL6zl+KOTDV44VYUY2cAVpZ5qauWBn4YJLS
         WIm0yWGi6dqPU1CR06Q/VE0kzXS+tEi/xvACW83V88oZs871I3OTNaJJQieQ2ZicBnMY
         YxdNfH9kt2euLkBS92zsC16KsbGh/crCz0qQD5kl2zIsfslHxAmsjyp4xCzs84JxROfT
         yb7w==
X-Gm-Message-State: ACrzQf1usqlsqNH+gokWf5ssrPkWx5pDg2VQsFeqmsXeTshm7P0B1xnA
        0buShlBunO4zTUTsUwZGwA==
X-Google-Smtp-Source: AMsMyM5nP+6EqILdWCc6sT8s+AghPUti03O0i9dwrZeR+eVOpjGG8ZUOIxy6j14O27uc3GNzkTAyjg==
X-Received: by 2002:a05:600c:b47:b0:3b4:8604:410c with SMTP id k7-20020a05600c0b4700b003b48604410cmr9919564wmr.51.1665330351733;
        Sun, 09 Oct 2022 08:45:51 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.37])
        by smtp.gmail.com with ESMTPSA id q8-20020adffec8000000b0022afce9ea93sm6797658wrs.40.2022.10.09.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 08:45:51 -0700 (PDT)
Date:   Sun, 9 Oct 2022 18:45:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     lkp@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: tools/nolibc: fix missing strlen() definition and infinite loop
 with gcc-12
Message-ID: <Y0LsreRGq3nbe2xC@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy Tarreau wrote:
> +#if defined(__GNUC__) && (__GNUC__ >= 12)
> +__attribute__((optimize("no-tree-loop-distribute-patterns")))
> +#endif
>  static __attribute__((unused))
> -size_t nolibc_strlen(const char *str

I'd suggest to use asm("") in the loop body. It worked in the past
to prevent folding division loop back into division instruction.

Or switch to 

	size_t f(const char *s)
	{
		const char *s0 = s;
		while (*s++)
			;
		return s - s0 - 1;
	}

which compiles to 1 branch, not 2.

But of course they could recognise this pattern too.
