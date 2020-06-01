Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EAF1EAFCD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFATto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFATto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 15:49:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495EAC061A0E
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Jun 2020 12:49:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so302070pjs.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jun 2020 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CV7mubTvEBdNlKnhsE7VGPqdTkRnwn99m97ta59lmfk=;
        b=g6HEz2aBlNKZcFsotKI4pWut9t2Aah2dMfCm6GzqIN9apkiVUT5tnI7f3sDv6swxov
         mQyEuHW8GPOln+tF0OFqF3HLcdlMNPN+1dPq0bv+ETJqM5wQzZDI3SYpkc6/Ul+Rg1TA
         X74mV36Y8g3wrwU5DMJnT/Ql93eBuSKvycaiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CV7mubTvEBdNlKnhsE7VGPqdTkRnwn99m97ta59lmfk=;
        b=JTvenKNaFnGEZEqdxe7m9M1ALKgAGSINeakEsnWaZdT8xTqKwBRqKWkASZ429XY22N
         WpUv2tMoUHHpBbXVBXBpbLdiWw6WlhhRzWhDdY21ssjXZ0YlPiTJQzAVpeq3hDI3c4NH
         YRc1WFnRsShnc5b+eSNQ9+iq6AsnpsBD6AawKBl3zDJOPgpcNtFwvoXVI0CLfr4G8p6F
         AvLwAB6Pr2BRGnIMiucOU7IU1iOSBwBXx5mqNtEwvrdYukNuSI3oYLtahoO5h4zTzSme
         xKj3zDHuLiCFMXw0lAB0Gz50CcZKfnMwsbSoFMKgCC4SmXb4vRHo7BZvoe26w1+XfDVi
         3dmg==
X-Gm-Message-State: AOAM531Jsak9htpcsUlfC+YOujv/Hdaui+cPWJpo6cuqnLDF8g9qcfAG
        Cxzpk6MBMvFdji+JlZNTuPPxbQ==
X-Google-Smtp-Source: ABdhPJysKrG9WjCl3R8UKGAvcZbIaRgJHSv+b58jR0g7DDChW61bHTe3IuA4U+poaf1+x+tpj41lsw==
X-Received: by 2002:a17:90a:9e8:: with SMTP id 95mr1095838pjo.189.1591040983872;
        Mon, 01 Jun 2020 12:49:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm240437pjz.54.2020.06.01.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:49:43 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:49:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] selftests/seccomp: use 90s as timeout
Message-ID: <202006011249.3E72ABDDE3@keescook>
References: <20200601123202.1183526-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601123202.1183526-1-cascardo@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 01, 2020 at 09:32:02AM -0300, Thadeu Lima de Souza Cascardo wrote:
> As seccomp_benchmark tries to calibrate how many samples will take more
> than 5 seconds to execute, it may end up picking up a number of samples
> that take 10 (but up to 12) seconds. As the calibration will take double
> that time, it takes around 20 seconds. Then, it executes the whole thing
> again, and then once more, with some added overhead. So, the thing might
> take more than 40 seconds, which is too close to the 45s timeout.
> 
> That is very dependent on the system where it's executed, so may not be
> observed always, but it has been observed on x86 VMs. Using a 90s timeout
> seems safe enough.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Excellent point! Thanks, I've applied this (well, actually, your v2)
to for-next/seccomp.

-- 
Kees Cook
