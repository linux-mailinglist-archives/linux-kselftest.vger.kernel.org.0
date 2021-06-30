Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8D3B89AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhF3UYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhF3UYk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 16:24:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C9C061756;
        Wed, 30 Jun 2021 13:22:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c11so5049231ljd.6;
        Wed, 30 Jun 2021 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=asiPWTg/9LdxIDMuM03tyPCc7XSGdVqNFdWPqsCB8Y4=;
        b=TZqkgdXmmTyR0b6OjQEVeOUjuaXgNAAoq96Q/gm8nNxGOWW0PhwtOUzAYnAX2BUpfa
         OFiBla7yFtrSwSyEH3liO1Fhzaxj6m1NBzxQvC0hfbvLhqbBxaFq1EcITTqJ2Vcl2LyD
         mEfS+sTGb6FqmSyWNbtnAPnDQ2Tx4E+/zGIfeJys5LOdazyALBixZqssnn2NEz0yAnEj
         Sn+t7x+drRE64ig/NHWbbycCUDXVV2iK9daURwdUZsuuIqN+88sWjPiA5zozm47CUlH5
         gpZKs3Ne5g+MsuHyXvqMpVLnV3TvWnhgd4yYGXeuA2FVA392TJC/q3xi0dM9GQ51Dwb0
         kYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=asiPWTg/9LdxIDMuM03tyPCc7XSGdVqNFdWPqsCB8Y4=;
        b=I0JPBENz9TPTZmf/IkY5/iu/xWBYTSIgpQxE/s3XGgb4mHJcYAThuW1hju4JaOEgDR
         Qd5JotT1Bwh0ijVB64QHXft/yE1xvXvUsuypBbotvKTESiiHolC61Qx76YITkRtpEVap
         AzFbrkV0LY40V0gxIJn0wRccgkWdkq7WD5oUeYtS6ya7nKtJ+ATE9I2BmPEHPqpCVjIO
         QsU3/QYgwi5lDXWELTNx/JWhiMv0zdXmB8bvWvFWqT7Z5lyWqvwO3zeHzukNp8s/QHrW
         aUktlKS3C4p4Qg3LYxoexUM8HAW3EkjOaE+uYMMNBbqhsLaR87fF3oMh4CkMayGhSDft
         paiw==
X-Gm-Message-State: AOAM532uTjr0PDH0gjLpjmhRuX0SNtragF+zE5gbOfmIOSN29EINOXRY
        0cYuoHiV+XEPimwIN9ShuN8=
X-Google-Smtp-Source: ABdhPJxsz4WexCal2555CfKKJjXEIfGhb9O5Owy3jWZ0R9LZNS6i8u6iWiEm3qc7l7HemyZD8UxUzg==
X-Received: by 2002:a2e:5848:: with SMTP id x8mr3618338ljd.191.1625084529507;
        Wed, 30 Jun 2021 13:22:09 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id l10sm306117ljg.81.2021.06.30.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 13:22:08 -0700 (PDT)
Date:   Thu, 1 Jul 2021 02:22:06 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH 0/1] add KSM selftests
Message-ID: <cover.1625083828.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As a part of the Outreachy internship project, add unit tests for Kernel
Samepage Merging. More tests to be added later; they would focus on
unmerging, handling zero pages and pages in different NUMA nodes.

Zhansaya Bagdauletkyzy (1):
  selftests: vm: add KSM tests

 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   1 +
 tools/testing/selftests/vm/ksm_tests.c    | 289 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  16 ++
 4 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/vm/ksm_tests.c

-- 
2.25.1

