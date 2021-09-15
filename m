Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7440CEC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 23:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhIOV3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 17:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhIOV3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 17:29:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A20C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n128so5366433iod.5
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDA4AbD60SFQgHVVfmZC7gzxpvrFiSmOOYbTULWaLEg=;
        b=Qjzr/Msnp4BvPg/qNnrI0V1bBRyfDQKd5QFJi4DBTQ5AhuP2EdO4J2mlMt6YLgC0QI
         MRPmRnmVkIodrj9Qy5xs0GHL/Lcfs38Gjqdn+Bhq1Yy3qXebQxzmtSB1YHgovlkTfjJK
         sr93BTNkDWmEB76iRgnmV4JYn31QbCTDCi7nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDA4AbD60SFQgHVVfmZC7gzxpvrFiSmOOYbTULWaLEg=;
        b=3NO/ItdOAs5DNyDZFVxaZ8XlztqiNtPPaN/AibfOxCQex/IWh3CdTQ3Gi0JBpwTwmM
         xAK0lYSI0/AqgMOPpH1hZ9xOJyD/BalInV+S/4gbhacNUWRZqZZeDFR1O10yJUV6OsAN
         S6p86w5Y/n2ZNMSJIbd1M5tha0HTAc3aBy+r+hnnSkFW7r7k7nWmnmXwkW+IXku9UvG2
         RogS4BG/Tj7DPIc9wAiV/i/RNrRjxHTBVLitvJpoPdTyeEZ0TcgnleD0VQjX8R5aywWi
         Oy94OZHU4jyVVDFv4iah0RCRUOWWX3yfpWcJQBCEEK4EAf35As1W5QpmVroFiM9oBpEg
         0nmg==
X-Gm-Message-State: AOAM532QhtIkGwpbhaXDP96nGaQKeJQ6tNiXQytsb264BIMGRFR4HAu0
        N5++Css/14HPJ/Ytp/tCcgajeQ==
X-Google-Smtp-Source: ABdhPJw7MApHWV4jaw0J0zFKmXPFTdcnTqBXPZ1RmVMFUrAhVKKMFiD7J9ZQNHlpVEP9I8Sc5YDgMA==
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr1766871jas.25.1631741291173;
        Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f2sm622884ioz.14.2021.09.15.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:28:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups 
Date:   Wed, 15 Sep 2021 15:28:05 -0600
Message-Id: <cover.1631737524.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series fixes fscanf() ignoring return value warnings.
Consolidates get_run_delay() duplicate defines moving it to
common library.

Shuah Khan (4):
  selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
  selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
    warn
  selftests: kvm: move get_run_delay() into lib/test_util
  selftests: kvm: fix get_run_delay() ignoring fscanf() return warn

 .../testing/selftests/kvm/include/test_util.h |  3 +++
 tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
 tools/testing/selftests/kvm/steal_time.c      | 16 --------------
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
 5 files changed, 26 insertions(+), 33 deletions(-)

-- 
2.30.2

