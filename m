Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46D2608163
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 00:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJUWSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 18:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJUWS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554542AB114
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 15:18:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l127so3461656iof.12
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkcAxJz5UaV/gOoKQ5YqYMglqfBBTV2T6cx36FG5wQc=;
        b=Sz88s7fjekFj/AV26xOLEymhM3uxOHkIsuexheI2cWmJmITgqMJnr6heCXWUiUcafn
         Ye40LPs16A7SZaXogZy8xm3jQrBbJ7luV2Gwgkb+sU69uFDtQ9J+RRd24pBz5vUFkRM8
         G+NDC+UTbDtvoKMqcdLyT9Y8VfzY9cVRIaWYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkcAxJz5UaV/gOoKQ5YqYMglqfBBTV2T6cx36FG5wQc=;
        b=2ASOx7j8u8UKfJzZy1P01Fx0uINzvBSa5IzPvF/T6ABq+yNUXRFlxpK+e1KRSA4M7H
         7nsrDeR+ICNeD9uY6orY3NfjJBTpuWiKm3z8nogywt+4Q3Lk9KOqiUciYgaYGrOImysg
         pL/1rZXXHhk4Dy6LYvERo13A53EDLOJ6+IMi88IYIAODOTGNaewIaQIRGH7bQMfaCuQ4
         /a14hcZJWnPOXM4YhX9F6A00ioJ5amMHWYlsPaX+Dnk+a1Xx0mEC9MefVCz2bNaw/soJ
         yvd21B4BhG26Pu5mZXB+r0ALgJ/CC9ZDnkQBiKclsbvxJhbujqZR2Ne488fariq0YTlC
         4CfA==
X-Gm-Message-State: ACrzQf3T5DLFbt48SfD4q9kTburn4TSOUDTL3x1WSlIZ5KkVzDu3APh2
        y2Y6ycHMc7Ib41KKQRiICZPiWw==
X-Google-Smtp-Source: AMsMyM6eMy/U/vUFn+jdgCTz9ehgGzteVfkAgj4cBxe9txPKSPslSBTaqNbPVq3i/pS9NEnlFqxmDw==
X-Received: by 2002:a6b:671e:0:b0:6bb:f05a:fb11 with SMTP id b30-20020a6b671e000000b006bbf05afb11mr14278642ioc.74.1666390704312;
        Fri, 21 Oct 2022 15:18:24 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests/watchdog: print watchdog_info option strings
Date:   Fri, 21 Oct 2022 16:18:18 -0600
Message-Id: <2fb04f40e3d3a35fd2b30896202931cf5b9a1311.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666390362.git.skhan@linuxfoundation.org>
References: <cover.1666390362.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Change show watchdog_info output to print option strings instead
of hex values to make it user friendly and human readable.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index e6af6e327eb3..03103eaa946c 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -6,7 +6,6 @@
 * - Could be tested against softdog driver on systems that
 *   don't have watchdog hadrware.
 * - TODO:
-* - Enhance coverage of ioctl return values - flags and status.
 * - Enhance test to add coverage for WDIOC_GETTEMP.
 *
 * Reference: Documentation/watchdog/watchdog-api.rst
@@ -314,7 +313,7 @@ int main(int argc, char *argv[])
 			printf(" identity:\t\t%s\n", info.identity);
 			printf(" firmware_version:\t%u\n",
 			       info.firmware_version);
-			printf(" options:\t\t%08x\n", info.options);
+			print_status(info.options);
 			break;
 
 		default:
-- 
2.34.1

