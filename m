Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74B72F6408
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 16:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbhANPO1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbhANPO1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 10:14:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41DC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:13:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so6122111wrm.11
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVLo5BPEqp+ye9g7cufxibCuaIAS/DGP9Yi79MJe9kY=;
        b=won0B5uHrjcqRlYjUBBkQbM3sbSz2hhH2cmVKpt4Ejx9JxdBRVg6pImH5f443q5HOh
         78JEtbonxLP52mtFifp+IFC3Tg6fLsmPrf2ENbLTvxWeydvjHc81pIIznh5QL8MyioVs
         esT8hqXtDMpc/g1jAwtv7aClyIwCN0yEgTyNO5K2a+4veWHrb61A0rq4AaUkLeWflNiT
         zPpdqqHPLGtVNFTw0s4I1HJJcV1178Z4Rcb6qlscDcLRu4XaiiLMzghdoKq54bH8Mcf9
         CCDsDzVdyyBCrfNofVJNVAJc4l8PXU6JPEjY/u032Sdsc6URYYQQvTMg5RZj464ZOOFp
         gJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVLo5BPEqp+ye9g7cufxibCuaIAS/DGP9Yi79MJe9kY=;
        b=XVGmlrutJg/ti9hzPMdSDIxfqZ8FAUWR9+pK0gE0hSMLLw2FTtxo94AjEjk1hytkki
         ymyutZwLZHdUg8SSLLr6jedqCDMoJ6si1U2iL6Iu/XGHyb/fWCe3MwbsmeDgBvlDlrG+
         +IfjmGAj2BAPs3XFq9eShQqrFnpn5d3sC3H0L21C5gNfHisdsEap+u9ZQztBqEp6XTUF
         fkkGEh2NgE9KNhxq1D58jGhrVKxseGAoTz5EdwxC4tYjc2wPxLau6dp6J3/BeI4QIAJp
         ouyBp+FFkQPXwggK/e2NCsGqRUlwrZalk5wi0FWMSJOAqjT3zB9gqgNx3dBXPrWdVaOp
         490g==
X-Gm-Message-State: AOAM531s+LeU3KGlI02mVzp9XBEYOL4zoAqyGNrg5UXjjn0O15bb3oq+
        gnIokW8hBxYMXQfSMPYCLkz+6N8YccUGEMzt/EO8dQ==
X-Google-Smtp-Source: ABdhPJxIkBqRfL1TF0JHl+rSbpZvhnN+YU5tGFaa2jlCW3niHYNg6rtHJ77oUw71r3ViG1agFniqfvEOa37mjrVCYbw=
X-Received: by 2002:adf:a388:: with SMTP id l8mr8389014wrb.354.1610637225415;
 Thu, 14 Jan 2021 07:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <20210107025731.226017-7-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-7-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 16:13:34 +0100
Message-ID: <CAMpxmJUv4mQXDVY6cVPTFTK02i9LTH-eiWTPMGTyrdAcNM3n4g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] selftests: gpio: port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 7, 2021 at 3:59 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add a port to the GPIO uAPI v2 interface and make it the default.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
