Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8834429314
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhJKPZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 11:25:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42497 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhJKPZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 11:25:46 -0400
Received: (Authenticated sender: n@nfraprado.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 80593240005;
        Mon, 11 Oct 2021 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1633965825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sezK/FAtcCli+p2YnDeNIUcTto02XK4Nsqv33VCxO7E=;
        b=P9LVtYWqf/QKJcDJfkzgorULf9ZsoNS8YAKnA138ulq+BYkCr7blpOOuEkhFYD1Om9drKa
        zxxX9e1vN6kb6NpCfJIDO90woKiVt4tmk1FWTyzbl2PkVTdyWZvzA9OY62MDlnkwum11Q7
        7GRD5LViaHb0xDZoK1ix7tzbtOpHAxjrvcRVMFA5z26TJ4Re/wMtB8L+p570Xai3OJsP5F
        xsIyZp2+GLa0ctRGsNwQpeavEC6ESValcaHczL7NkUWvkPHF3Iy/UH2xe6ECx+w8eLOlp7
        d0U5EcNZrcfOCez4w+ZM0cM35jZQGctIVP9G4s8O50DuE1pL5JPo8yr1Ee8vDA==
Date:   Mon, 11 Oct 2021 10:23:33 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@riseup.net>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Pedro Sader Azevedo <pedro.saderazevedo@protonmail.com>,
        isinyaaa <isabellabdoamaral@gmail.com>,
        ~lkcamp/discussion@lists.sr.ht
Subject: DRM KUnit hackathon
Message-ID: <20211011152333.gm5jkaog6b6nbv5w@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

We belong to a student group, LKCAMP [1], which is focused on sharing kernel and
free software development knowledge and mentoring newcomers to become
contributors to these projects.

As part of our efforts, we'll be organizing a hackathon to convert the drm
selftests in drivers/gpu/drm/selftests/ (and possibly the ones in
drivers/dma-buf too) to the KUnit framework. It will take place on October 30.

So please expect to receive some patches from our mentees on that date. It
probably won't be a big volume (experience tells it'll be around half a dozen
patches). We'll also make sure to do an internal review beforehand to catch
common first-timer mistakes and teach the basics.

We're already working on making sure that the converted KUnit tests can still be
run by IGT.

Please let us know if there's any issue with this date. Otherwise we look
forward to helping a few newcomers get their patches in the kernel on the 30th
:).

Thanks!

[1] - https://lkcamp.dev/
