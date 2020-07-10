Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13ED21C03D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jul 2020 01:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGJXBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgGJXBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14107C08C5DC
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so3163560pgk.4
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTTJAkMi8Urf+RzgAFeYH3KuT0KGRsyTs9jUZmrlJzI=;
        b=mMIVw11GqwV00VvK2cnOudPuaUD3ot4X9puGq/kk9mDU/tjVUWuIMp1XOAzCqjQCRW
         e7kbu9n0uviGBe1xiVsrxefVtKvgF/ydYZYvQ6KW5Vvvt38gE9+i+Ss9qnUtSsUPUfdh
         xOR3JmXAOdwNnHObxww7MJ84QXv8+p/KmkgQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTTJAkMi8Urf+RzgAFeYH3KuT0KGRsyTs9jUZmrlJzI=;
        b=l0VePdwzkuoYbKT33UavjKP++458hfB+JoTIjCbHy34+ALZ4fAjglJvQ9ICyS6t1P1
         84ikghYmJ7ypUgDWTyef0UL49UGxPk2FrJrxgAFtx1ilQ+PT4EsqZEmFtFx4J+2U0IWr
         Zda0wQ3waKnbsfBnlyxZyOc5VZi2scgG+uw/SsSz72mIobKMvAH1oZqpEt8IPGz3XixR
         uAQU8t5HThy268P2C6EPD5iN/8mPxlX5YXurzJTukVOb/jWiag0n/JG9LxDKX7fKnwOz
         3dbkyyaGezis53w1Tdft0HDsV8GUtlDUIunQ8RETSfBTbtAYiztgAJS8f0VFwPz6koRD
         Ikuw==
X-Gm-Message-State: AOAM532xmz6QmMuzBNiesawyeBwtqg1UZEQzDXxbFHqHPcaGAtsEjAgi
        oTyEgHOB7rqwp6XpP5s9cDxlwA==
X-Google-Smtp-Source: ABdhPJwBNyJti+HGPgdEM34452meOElIcXjnX0dfuzNLSi3KpdPIkAL+jBlsKN4oMsrp+pRQIf2uxA==
X-Received: by 2002:aa7:9ec2:: with SMTP id r2mr65599649pfq.265.1594422070813;
        Fri, 10 Jul 2020 16:01:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o128sm6926634pfg.127.2020.07.10.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:01:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp v2 0/2] selftests/seccomp: SKIP tests requiring root
Date:   Fri, 10 Jul 2020 16:01:05 -0700
Message-Id: <20200710230107.2528890-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2:
- check for CONFIG_USER_NS
- add review
- fix Cc list
v1: https://lore.kernel.org/lkml/20200710185156.2437687-1-keescook@chromium.org

Hi,

This fixes the seccomp selftests to pass (with SKIPs) for regular users.

I intend to put this in my for-next/seccomp tree (to avoid further conflicts
with the kselftest tree).

(and for those following along, this is effectively based on the -next tree)

-Kees

Kees Cook (2):
  selftests/seccomp: Add SKIPs for failed unshare()
  selftests/seccomp: Set NNP for TSYNC ESRCH flag test

 tools/testing/selftests/seccomp/config        |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.25.1

