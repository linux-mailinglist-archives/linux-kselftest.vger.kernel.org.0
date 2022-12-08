Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A56473F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLHQNk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 11:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLHQNi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 11:13:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E184B68
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 08:13:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso5156843pjt.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEF5Kdoxdu+cKfk6R3ZwPWFH59dyZr5XNLc+TP4k1ZU=;
        b=M9dPq43pCEesdG1Pr73JFi78Hptyiq5VZqWgnsSr3kI1jPoUdQ4zxjiAhyNFqpFmZg
         njyxgcdxqgN0KzGHxmez3cz91qutsMd43bfVz+BmUEiqosyY0DbvL3iHrFX0td8dUCSY
         MTh3j9pe6XZs6CcLquyZVVbjRBXWFW2xIvWp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEF5Kdoxdu+cKfk6R3ZwPWFH59dyZr5XNLc+TP4k1ZU=;
        b=V7NAPBg94ARIiRYNDPawp0e062+uBDlZP+iQyRBjgxVqgY4DJvySWepDdn2Q4dn+ne
         /COUmw9vbZgOtSsZfb6HV4NjBPfnfbvl3MnqzbRMO23OX7u6hToaDhPt2qycT9wYDxgb
         SE9CGJpMug5SKgIxUzjBUoxUrHXtG9P6tyRlLPcfcNupcY1fmnK7Xy2tCyzYi60efj2r
         J7/panPgfgCBBFVRsAxO6CbMDlTwwhQKUZXkzeiysKCxwRB9945KS2K7BbTs06iPBGK0
         LvjnuCSY+WRrIGDKuy04c0D8bcWobVnzX1J3c4XXIQ0z1jHtJ5phKuz9txP7GTFVXnj7
         mkcA==
X-Gm-Message-State: ANoB5pmdx3v1ly9KTdLdUq832ThEv02gHpsMGcgxD+Qi/JVKzfiS5wM1
        3uPpvBuq0nUf+nApNgQg/aZaVQ==
X-Google-Smtp-Source: AA0mqf54Uql+4I53tb1lC4yydY21faKQwOpWl2+BYX9Ds95kNuRBabF3SZQkBl8QR9ooQXG7EPr8Eg==
X-Received: by 2002:a17:903:22c2:b0:189:c47b:af22 with SMTP id y2-20020a17090322c200b00189c47baf22mr24668561plg.23.1670516016394;
        Thu, 08 Dec 2022 08:13:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik25-20020a170902ab1900b001869b988d93sm16661571plb.187.2022.12.08.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:13:35 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:13:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212080809.687CC8BC23@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-1-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:33PM +0000, jeffxu@chromium.org wrote:
> This is V6 version of patch: see [4] [5] [6] [7] for previous versions.

When sending a new version, can you include an overview of what changed
between this version and the prior version? This helps reviewers who are
following along, so it's easier to focus our attention on the
differences. Also, it's helpful to version the links:

> [4] https://lwn.net/Articles/890096/
> [5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
> [6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> [7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/

e.g.:

v6:
- moved foo to bar
- improve comments for baz
v5: https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
v3: https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
v2: ...etc

-Kees

-- 
Kees Cook
