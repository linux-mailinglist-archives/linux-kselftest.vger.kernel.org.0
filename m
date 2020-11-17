Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932DD2B70FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKQVfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQVfa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:35:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A400C0617A6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 13:35:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u2so10985885pls.10
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSJAJ0syJ78ceQy1Qt69nKgwbCK+98QEcAmwRhmUS6I=;
        b=Fw8CVPuv3WSulGgeIvke7FvfGyv4j7XsSyRpRrl0+o6ooEZ5zQKMLSzwMCEOKUmxfV
         vs8ey5SnHNEIUg/bjL6fuop2b0t++d76z7dKOaPsO/LXF1p03AXVP+dCkslM6RmIIu+U
         1Owu941fcpsgxcmT4PCrI2svnGrrTl22XAYuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSJAJ0syJ78ceQy1Qt69nKgwbCK+98QEcAmwRhmUS6I=;
        b=Uh3oOj7rDxvceMSRIe+jmkN0dsisJDuyobNS1BwNB4l1SALvxBPF/tArc18EDYky2e
         3Zn/ZktMTvPpd45jXUh+rBoXccsiduBBH+ghXNme8gEqReCW3RWbsrnUufworMrjEQas
         OBpSK3Sar9ocIt9kH+3I/cd8ENrStfJjfCdWIBNJRN9jRlR8Fmnd3O7YM39/EYi8XnOz
         NA4/MNss71NKmGEBfHP/bdQuR5/YQq11qm7N8c7coEEneeDczzww+PQY5u8rbebS9vGW
         VPXG2RGnSbxo42rLfFZcX87OUMMHvPUxO2VRJgunT4KdpzGXSgwL33QbQhzHcWc5a2uL
         M7Wg==
X-Gm-Message-State: AOAM533QtUIxI5G0x3ryd4YLnaA5+TY72RDN1zrynYbactw93UHyKwdB
        CxFVh25x7N1zqRZW+vLjcJFFdA==
X-Google-Smtp-Source: ABdhPJzMbIdMxFceKu6lEVYMeH3xn+oN79t5xAiO7CYbUlREKo0ytHl7RiuOiEsNoLoPWPKMfurq2g==
X-Received: by 2002:a17:902:6803:b029:d6:cf9d:2cfb with SMTP id h3-20020a1709026803b02900d6cf9d2cfbmr1396513plk.55.1605648929916;
        Tue, 17 Nov 2020 13:35:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v19sm19389732pgi.2.2020.11.17.13.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:35:29 -0800 (PST)
Date:   Tue, 17 Nov 2020 13:35:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: sh: Fix register names
Message-ID: <202011171334.3F1BDC484@keescook>
References: <20201117205656.1000223-1-keescook@chromium.org>
 <921a7e36-8b58-4a59-029a-066f5a05859e@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921a7e36-8b58-4a59-029a-066f5a05859e@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 10:08:13PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Kees!
> 
> On 11/17/20 9:56 PM, Kees Cook wrote:
> > It looks like the seccomp selftests were never actually built for sh.
> > This fixes it, though I don't have an environment to do a runtime test
> > of it yet.
> 
> We were testing libsecomp itself but I think we might have forgotten the
> self-test. Not sure how these are run.

If you're building natively, you can just build and run:

cd tools/testing/selftests/seccomp
make
./seccomp_bpf

-- 
Kees Cook
