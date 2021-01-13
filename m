Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764F42F5016
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbhAMQfc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbhAMQfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 11:35:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BC5C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:52 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d17so3935046ejy.9
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vk0czB5fF0aB6nd/h40en79pLBBtFj9eodoYDBiXDAU=;
        b=WEtPRWKe9Uj7QzJ4cVmdQFMSqEbwCeAOl9nAb42BQC28kiPXzigZBsn5zdHCitm07Q
         Qh2LqIZ3zQ1mxKSfj4VgpiaHFFeUvDZBwlSrK5dIIPAoOib3c0k+zFLvwxH/GIEjDYeW
         cgOGViSNs1ikmv/+U3EkS3Q7L1fCi9g09m4J53cFyUzMOSjTtBn2n7mWS3d0W/YPClaC
         zIGT7R7rfV+cGOGeFwRSp41kXye7WUXynl2kPJcbeoHvp82iUMuH/7sGddBeamUYJT8z
         KDhiHG9zKtpo+/mzQFdXNZKv787fGTumVsy3XQYmquW0qt07OiwQhOIZobRRWhGKNOO/
         0vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vk0czB5fF0aB6nd/h40en79pLBBtFj9eodoYDBiXDAU=;
        b=Xe9s0wdOONSibm/fe6/toYZxMjPL6ypXyn0JPExvaIS4/SVGXTFdyoU9+KWNBAzvnf
         j6idDnz7T0q+KSgJKU6Jm1JZQlfkhwxg33qWUC5y25k6j5yPWit60qk4nbDJ2pBEtaus
         EC6X1iIq9PBnuiFAfthaix9s9haVEpBmrm0MOQ69i1X2B42V7+BNl9vLEIAtDxRb6gOc
         zeOHRjNY2d45u6oKXzekesMDEY7EUpTaitr07Er+Upd7ekQD+3E+Gu83cyR77jB8An3S
         y6AxHC6gSWD2C2Jh3/8aROl8AzwHmkuT1RLIMvsjsTjFB6QT+lYiKY3Eb0OYm+JZKP6H
         okZw==
X-Gm-Message-State: AOAM532L63QqPs0Q344teHbNkwIsj4KOpAT2bB9GFo/uRoPd4QZNqro1
        qH1HKC630Dyn8EP7TeTCNKEvhg==
X-Google-Smtp-Source: ABdhPJxpH/hWxv0jQcdwu5UOjAudNzu6DdzryR6pfeS0p69At5FoN1LBoIjEg4nbx4Qmzse3p/vAgQ==
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr2234196ejb.523.1610555690828;
        Wed, 13 Jan 2021 08:34:50 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:49 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 0/5] selftests/bpf: Some build fixes
Date:   Wed, 13 Jan 2021 17:33:15 +0100
Message-Id: <20210113163319.1516382-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few fixes for cross-building the sefltests out of tree. This will
enable wider automated testing on various Arm hardware.

Changes since v1 [1]:
* Use wildcard in patch 5
* Move the MAKE_DIRS declaration in patch 1

[1] https://lore.kernel.org/bpf/20210112135959.649075-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (5):
  selftests/bpf: Enable cross-building
  selftests/bpf: Fix out-of-tree build
  selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
  selftests/bpf: Fix installation of urandom_read
  selftests/bpf: Install btf_dump test cases

 tools/testing/selftests/bpf/Makefile | 58 ++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 17 deletions(-)

-- 
2.30.0

