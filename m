Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57AE596C04
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiHQJ1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiHQJ1U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 05:27:20 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C25AC60;
        Wed, 17 Aug 2022 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660728437;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=f5lcVFI/ID9ncrhLvlh7H+e+AzV1rO8p9fQyoibhIKE=;
        b=YrMFD25nDWscTM1au2oZumg1+4jR0rC1xpO6jwY+3YRVN5ch99b2EqpK5cFhVV2Q
        IH2nXBbjsDY/f7Fos4yMbAjuDqyeaNoPGJMMZ/70uynlcf/DfADYIYvvgUqdBQRnKio
        6znzTjJeMX4EBDiz4ETJM66nrtxLCfh+UQPfkJZw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660728437;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=f5lcVFI/ID9ncrhLvlh7H+e+AzV1rO8p9fQyoibhIKE=;
        b=QxaEMaAAXFlh2GJmM8pmj+hJeYPuFNg4EFr8x1VqDEzKOMNXlDGouDG08H7rDtpw
        7TUAuBL/VGKcSmJCe1bfk0UrIFKpaOvm80ZMM3rJ0k2YI8N8uOVcPHmCPS8aupwOPIi
        VIZ0hxUeRHH+eP2Ar0mQYPdg8Fr2pXLzwB4pgkC8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220817
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000182ab20eb3a-7b68d1d6-880f-417d-8d12-6c85bf28874e-000000@email.amazonses.com>
Date:   Wed, 17 Aug 2022 09:27:17 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.17-54.240.48.37
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 6.0.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 95d10484d66e54d5c01e36389e9318221fb8f60b
* git describe: next-20220817
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220817

## Test Regressions (compared to next-20220816)
No test regressions found.

## Metric Regressions (compared to next-20220816)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220816)
No test fixes found.

## Metric Fixes (compared to next-20220816)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
