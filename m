Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7E3ABD16
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFQTtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 15:49:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60932 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhFQTtT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 15:49:19 -0400
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1ltxxw-0008TN-27
        for linux-kselftest@vger.kernel.org; Thu, 17 Jun 2021 19:47:08 +0000
Received: by mail-oo1-f72.google.com with SMTP id r12-20020a4ae5cc0000b029024ada3391fdso4550334oov.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 12:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bs/gsnaGt8DZvKt+QmmiZ2Y19wSylDXIdnNyHPHUNxU=;
        b=PzmM/MF5b0fA9a9e+Lf77pwcYXWtLqbvaEIummWqGyMVnqksoM0dc6/q+TVmn1jz7A
         GhdZiqqX3p8jEBhMxFcrh3bREZA+4e0vfjRPczPjvF4j0JhiHjScaLYctcEI9ICo/qd9
         GHfZAx8JhdZ2l+MAQjKME8FqSYffEgU1FqmaZNeDEAdKP+6Gs43JWM0m+0pRMVmOwIoD
         puFsncIZwKo7fd7fEsyV6Qq+/ezenMrN6ffTmByUP62sLAS27dIN9cFfz8oAHl96/D6K
         BH7aODqYYk+En8qRsDjLufLUACtX+B3gfp1QkWf80r39L2HCj1JrrwHq65VxQ2ro/6Vf
         i74Q==
X-Gm-Message-State: AOAM532TIgJynkCgz2OyMImPYOp9YWLHn0dWJAGBcOiHf5U/jX8BcVww
        plp2fJEjSesA9xvAk9MkqPH9wp/rSP1BHbWRyFw2WSt4mC+foqDyHFT/JdG/f60Zsiv/528yHCO
        bltxLKCSGB6ZqmmHYX5SUiBU1osFHcghsV83y84otXmEPSg==
X-Received: by 2002:a05:6808:605:: with SMTP id y5mr8933282oih.74.1623959175076;
        Thu, 17 Jun 2021 12:46:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiP21iWn4El3hnU5S9Mst1ROIZ+laQzMC834FbKNoOdkpYiJ4mIeEMESS702mUxAG9SAtLDA==
X-Received: by 2002:a05:6808:605:: with SMTP id y5mr8933259oih.74.1623959174737;
        Thu, 17 Jun 2021 12:46:14 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:1522:24c0:88d7:e850])
        by smtp.gmail.com with ESMTPSA id v1sm1530726ota.22.2021.06.17.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:46:12 -0700 (PDT)
Date:   Thu, 17 Jun 2021 14:46:11 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Pooja Trivedi <pooja.trivedi@stackpath.com>,
        Mallesham Jatharkonda <mallesham.jatharkonda@oneconvergence.com>,
        Josh Tway <josh.tway@stackpath.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Hangs during tls multi_chunk_sendfile selftest
Message-ID: <YMumgy19CXCk5rZD@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I've observed that the tls multi_chunk_sendfile selftest hangs during
recv() and ultimately times out, and it seems to have done so even when
the test was first introduced. Reading through the commit message when
it was added (0e6fbe39bdf7 "net/tls(TLS_SW): Add selftest for 'chunked'
sendfile test") I get the impression that the test is meant to
demonstrate a problem with ktls, but there's no indication that the
problem has been fixed.

Am I right that the expectation is that this test will fail? If that's
the case, shouldn't this test be removed until the problem is fixed?

Thanks,
Seth
