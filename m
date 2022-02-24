Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C704C3633
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 20:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiBXTxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 14:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiBXTxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 14:53:06 -0500
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com [54.240.8.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332891BD05A;
        Thu, 24 Feb 2022 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645732352;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=4A3yDHf8lGozheIIAlfQ3IfX4oaAt+aQPAe49n1gYLs=;
        b=OMDwXedbokieyVaQTdSFaTMDzzCUPGzB6pvFqpWMWxuh4FB6XSATavktXVgDaOyT
        4Gl5wU2MXFteGWKQYK5bVAJs4ZHQ2myQY07rQTNLR0Jy65SJhnI6uSoWI29loG/wUmW
        wqU9gFz56F0xARyBhbul39SsK0xLcc/SBlIuxGTo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645732352;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=4A3yDHf8lGozheIIAlfQ3IfX4oaAt+aQPAe49n1gYLs=;
        b=V7/TWMkmAtwpbhOL6xd9UdE98n6gDBfYbE/0xRjYRy35/0Vow9oaODtiwuYvSyyA
        xkmIZiW5As+PfNYZfMHCVm2dELJLV8vo9OmFm0c7mWsk0k23iEtgW2hdVAavO2Xjt2c
        kMpBiE2ZPSzncziX+dUfcWoD0YTqMcwwLxmqfgiQ=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220217
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f2d4acf38-885ae32e-78f3-4d89-8ff8-4307eb126764-000000@email.amazonses.com>
Date:   Thu, 24 Feb 2022 19:52:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.24-54.240.8.35
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 3c30cf91b5ecc7272b3d2942ae0505dd8320b81c
* git describe: next-20220217
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220217

## Test Regressions (compared to next-20220124)
No test regressions found.

## Metric Regressions (compared to next-20220124)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220124)
No test fixes found.

## Metric Fixes (compared to next-20220124)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
