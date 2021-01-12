Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455B42F3276
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jan 2021 15:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbhALOCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 09:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbhALOCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE72C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 06:01:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c7so2411873edv.6
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 06:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiuFHB0WsN+gRbC8OTVe9py28UNmf6FiXJPro5M6bjE=;
        b=qFIiKr5oesh+IVtPeybtrNvfu6BP7U879JZvvxTT1RrVIhAQ2lsHckogDBFKa+UAwv
         dMyp6yk9roNcBA186JR0pLuDyUxP3rGxCvqTyJRDjvp1zj8e2WoAY+A9qE9OX0pXSCzn
         GnVbnXALtp9I+P5C9StGAezoOXhMuIy3SOki5JMuf9CF2lR4ek9ADQJlvVs72EOOPpka
         hNKUyyZcX0pO1aDQpLxocqoCCmbphp0ncrewGQmtaNrbgfmMKt44770GuewpiaSSi7a8
         JC/iqhra1AIJqlCb83XqUjmeEO1+1ZC0TzjfCWl7NxXavxz4zn/IN/VqlwwmNQtcdywr
         nSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiuFHB0WsN+gRbC8OTVe9py28UNmf6FiXJPro5M6bjE=;
        b=FmyY8FdDgo0penJevu+F+BCe1NwFBFlIZ8OdC4KreUvwzSQMLFTzS7fxK46nFFByU2
         5ApezrfU/03HZnZaSB20Wyg8Zq/zLtdJJdFLhjo2JRaQdcsT9wCJN2yv0x5irZabRbFe
         09qhEscYNJ3+q/RGzJA0/a1YbUCglJiKZCbADLZfEpBfjvzGjMuYRZArAOzVM7srMDHv
         mrGhQAetjBZb4XP93AARyZENYwTdJO9qW1iEdZkP307fS8/YHRqTMt5CbMpwyUdggmsr
         6blSZE97z0/phPXb3uo2jF9GxqVj+s/yD/eaYon6G6QnzDRhSQ3LWD4Cq0TApRKn4u7O
         5PXw==
X-Gm-Message-State: AOAM530+J99uBA0Fl8L7yu2QUMiqOML9CeumFC7XzwzMfNTCqKm1M5wY
        E9ikofxWgDHC38vUVex6eoXoKw==
X-Google-Smtp-Source: ABdhPJxE8DxYmMrrRn9w4FKuoXGyJg1ojDZecw1ZcMFlHVMXoJnleDguzRfx4oKMjSuQW3ko5F2aLw==
X-Received: by 2002:aa7:dacf:: with SMTP id x15mr3479477eds.134.1610460085481;
        Tue, 12 Jan 2021 06:01:25 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:24 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 0/5] selftests/bpf: Some build fixes
Date:   Tue, 12 Jan 2021 14:59:55 +0100
Message-Id: <20210112135959.649075-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following the build fixes for bpftool [1], here are a few fixes for
cross-building the sefltests out of tree. This will enable wider
automated testing on various Arm hardware.

[1] https://lore.kernel.org/bpf/20201110164310.2600671-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (5):
  selftests/bpf: Enable cross-building
  selftests/bpf: Fix out-of-tree build
  selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
  selftests/bpf: Fix installation of urandom_read
  selftests/bpf: Install btf_dump test cases

 tools/testing/selftests/bpf/Makefile | 61 +++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

-- 
2.30.0

