Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7981166A8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 23:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgBTWvY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 17:51:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44186 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgBTWvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 17:51:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so2116806plo.11
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2020 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xUODmT3izmnK2/3rXHfMIJC5LaJlKPGnGXA3PxU3bIs=;
        b=JGlzm0vCBpE/kCib0dY+jJB1ACPbGboIdU9+eh3bWp96p37rDdYVpx0OTA1BjYBIg2
         zYaNJ0gyebRhAzCrFtYzeKIn7mTgU3VPRQmHNQKxTNmFnYMAlHoG9Yn8vXRA2aeNGg/F
         zOY9iSo7lLSNuPU3hdJgKCzok3fWfRS64h5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUODmT3izmnK2/3rXHfMIJC5LaJlKPGnGXA3PxU3bIs=;
        b=LBeZwKpw84DjYPGtNw1cv+j2NIaLbl4EamMuQT0FNiT/ywPq46lJbtlbiRgWtBIVEg
         cvBrTQTs7tq/1ovVaUYsPKEuQed/wCjqgqSoLVyv5/ImIhDyhywIa54IGLGlNHN+3bBR
         WzaFiIj/YICdc2nTgkHIhUINpjng1u3plIlms4yjuy3AnWRRShJ+b2BlEbCPY+VRsxzl
         kaui+FZF1UdsJ45zvl9cRxEOThykR3xoWIofGpmjKA1zmVk5JjgPbYOLOhP2SjcFpOGm
         WMBwayXs0ugVB/kzo+0kjDHmS6Qhsikx4aUha90Oqh9WGSrrwa3NF2DhGFybDeo6FTs1
         Ef5w==
X-Gm-Message-State: APjAAAUhTV1KNCqgZWPr6goN9SmDaStK6ZqghIVJb9evZOGVwmmCKBwA
        lPARbbFI+jlXHcnqr554ZKO36Q==
X-Google-Smtp-Source: APXvYqwIsRyk6knJ6cpQX+pqL+SFKQ58ujoDFJuEcMgob+s0hLlXXQmC7R3/ABnLUxkvI+4/NJTQYQ==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr30684494plo.98.1582239083274;
        Thu, 20 Feb 2020 14:51:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm630218pfz.25.2020.02.20.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:51:22 -0800 (PST)
Date:   Thu, 20 Feb 2020 14:51:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
Message-ID: <202002201450.A4BB99421@keescook>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220044241.2878-1-mpe@ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test") added a 45 second timeout for tests, and also added
> a way for tests to customise the timeout via a settings file.
> 
> For example the ftrace tests take multiple minutes to run, so they
> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
> timeout setting").
> 
> This works when the tests are run from the source tree. However if the
> tests are installed with "make -C tools/testing/selftests install",
> the settings files are not copied into the install directory. When the
> tests are then run from the install directory the longer timeouts are
> not applied and the tests timeout incorrectly.

Eek, yes, nice catch.

> So add the settings files to TEST_FILES of the appropriate Makefiles
> to cause the settings files to be installed using the existing install
> logic.

Instead, shouldn't lib.mk "notice" the settings file and automatically
include it in TEST_FILES instead of having to do this in each separate
Makefile?

-Kees

-- 
Kees Cook
