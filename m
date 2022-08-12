Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A8590D65
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiHLI3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLI3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 04:29:16 -0400
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com [54.240.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC6C9DB62;
        Fri, 12 Aug 2022 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660292953;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=r44EBYFjiLern6mmi+Iw/wQKiMLYkPxbYBvZPQnjIQI=;
        b=t/5o0G729enCs93z6D88cd9utZXqDDhVFv5dB+c00yIyYwttNTeDsQkRK5O8Qkae
        gcezB3B3IF8wcARYPOjilWJg52OgmbyOoxUacEwax5ZQXMHBqLfxP5RJ/g+Z7x2HVyx
        KSS8ne2zRROrZHEPuYu+qI+SSoOCLS6KSPx/I52Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660292953;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=r44EBYFjiLern6mmi+Iw/wQKiMLYkPxbYBvZPQnjIQI=;
        b=Z1aNbyxVRp21uuvgtfWxtDPNt9if0RImSIe6hZxEVHwLh6i5aVuEbruzoVUBE7br
        dKUH9o8oK1WdJMgy5FrMG84Mv88fCMXyMfI32Lbq4WOOYgIOn5W+LnvNWJ0lgFjJz/X
        D7Lq1hgjMbO71dr+iTc/6iiS1MhJW0j2HGUwIaRM=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220812
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000182912bf652-2328ba75-250e-4917-8efc-9cd62383e63a-000000@email.amazonses.com>
Date:   Fri, 12 Aug 2022 08:29:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.12-54.240.8.73
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.19.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 7bb4fa8a025a1bd305a146022083f0287653ea12
* git describe: next-20220812
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220812

## Test Regressions (compared to next-20220811)
No test regressions found.

## Metric Regressions (compared to next-20220811)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220811)
No test fixes found.

## Metric Fixes (compared to next-20220811)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
