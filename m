Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174A8132E14
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGSOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 13:14:05 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:46154 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 13:14:05 -0500
Received: by mail-pl1-f174.google.com with SMTP id y8so23085pll.13
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MbmHl/HAEk5QyP68fJ+BdPXjU9dluSXGSo4pwY99ybM=;
        b=bV/kCWH+Wcqm1c0W45EgP+rKSgo2a8anbTuKwaVxfR5qKXH1p3x8SXZ5ZZ49Xbv7H1
         MFKWkHtng2XuLjtbgDLnhtaRoaQ2OdilV5L4prPEuYFlGsFXe7AiHbn9/PxSuGCIF9u5
         Erlin9U5Fuymd9zfln8Lw7Gp3Hape2YXskFXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MbmHl/HAEk5QyP68fJ+BdPXjU9dluSXGSo4pwY99ybM=;
        b=P00+JOqTJAdQ7T1H1cNu+lrdm/AvmJHhnrbNCBydnl+GAgtxv4Twp59W23ermmPN2d
         bFRG9Xc9gD+wKmFR9HivQE6LGUeJArMQANMVyzuVW6GChghNdMoncibp1CbNMMwZIw1l
         RfM08dAczZGtBGCD2X/ng0qzH9bD6k+Ci7rgV1t0akxgwg1twpg1zlEb9RBLKMM8oGYK
         zOxyl+EfuVeWEdMejNqf1zRonBdzId1szYGnHKKPL2aMkoVK644PXx/K9dx8GLhhQYuR
         hXBxrr6ur3So0Abmsm2Q/hcs+t40HwqCbs/l1t/hnuxi9LHScy6Eg8AIpOsx8iVUqHKg
         9eyw==
X-Gm-Message-State: APjAAAXmZajvKwyI1Zss30DBdqO6qTZt9/tIz8aDrQp3jqpYXSb7pxn2
        oS7sj0OQ8EYp5X3ZjyrOIWce4b581tg=
X-Google-Smtp-Source: APXvYqwWCUV5XcuTp7ZRGcYmLyqWZufsPYJQYDroFA+eMe3mZojfs82ssm9FHgsEzV5ZyvbHZTb3LQ==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr975780pls.129.1578420844546;
        Tue, 07 Jan 2020 10:14:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm193137pfe.168.2020.01.07.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:14:03 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:14:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [bug report] selftests/tls: add a test for fragmented messages
Message-ID: <202001071013.1AE709474@keescook>
References: <20200107140106.ejj4zgeiu4fauatn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107140106.ejj4zgeiu4fauatn@kili.mountain>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 07, 2020 at 05:01:06PM +0300, Dan Carpenter wrote:
>    621  } while (0); OPTIONAL_HANDLER(_assert)
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The problem is the OPTIONAL_HANDLER().  Smatch thinks it should be
> included inside the do {} while(0) loop.

It looks weird, but it is intentional. :)

-- 
Kees Cook
