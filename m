Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42BBE8BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 01:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfIYXFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 19:05:06 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:41925 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfIYXFG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 19:05:06 -0400
Received: by mail-io1-f48.google.com with SMTP id r26so1309672ioh.8
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2019 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=579Tnc2tHWRxfBzI2AYOcygJW1YrE5JUA2yogVfQLuk=;
        b=ApdS52HZvPG4UPM6xBSrQ2S/UNXlmI8kFOmZudEilOG4y80P5HJRHlUnXKPfNJ+WKH
         au6AjE0kdrTM+IBnFeBGhuDDtnofOCiBS7i2bfyRqXibn7ujiFixczgXhQZkG/9SPJLP
         nWtV3tk8SZJqPR2uvC9inxGGtNfRDe6urfDEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=579Tnc2tHWRxfBzI2AYOcygJW1YrE5JUA2yogVfQLuk=;
        b=OaKYg4Se/8uL1fWrpr5AYpBgS3SqlQxTeN2npbfaeknrx8CHIOnBcMA0KO1u0bpLHr
         o/OcaL3kiepV2wVjK8/XIes54AxIoTwjx/8uIpWMHhfdpZVSPR6Fbf2lhLNek3ApvyNF
         dbXXbFcb14ynDDz3vJZ6HW3yjj9S/DKmIr/Tc6koqX+lE6vBQ5dZECenSCadjqoJR+yg
         DHgrPGffB4IxKofAeqoTftCzm6ZKfiFQNBw3S9cB/7NljebkvtOxS0Zp0UAB0ZYchEUL
         1vcKeWD5X5s3O1L5B5IUORpoXWkxx5UhTZOtaiFr1nsUtitFSVyzoBONBNg9+oP5GxYM
         qhkg==
X-Gm-Message-State: APjAAAW4yh8aHRkwt9qXzxVzwAb15L59L2Yr+nHksNSeqOvFuD8u3MrY
        Ho274q3mLJKiYNaJFMmDn3fsiw==
X-Google-Smtp-Source: APXvYqw3G8DNm3m995j68ySkBp40wb8S0xhIePya4oAlregS01zaifCXpCYtrJLA2UrcL7HqzDB3rg==
X-Received: by 2002:a02:a792:: with SMTP id e18mr803374jaj.125.1569452705565;
        Wed, 25 Sep 2019 16:05:05 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f23sm70767ioc.36.2019.09.25.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:05:04 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Simplify kselftest build and install use-cases
Date:   Wed, 25 Sep 2019 17:04:33 -0600
Message-Id: <cover.1569452305.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series simplifies kselftest use-cases and addresses requests
from developers and testers to add support for building and installing
from the main Makefile.

Shuah Khan (2):
  Makefile: Add kselftest_build target to build tests
  selftests: Add kselftest_install target to main Makefile

 Makefile                                     | 8 ++++++++
 tools/testing/selftests/Makefile             | 8 ++++++--
 tools/testing/selftests/kselftest_install.sh | 4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.20.1

