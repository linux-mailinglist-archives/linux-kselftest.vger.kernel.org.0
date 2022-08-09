Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8F58D3B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 08:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiHIGZz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHIGZy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 02:25:54 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9CBF4D;
        Mon,  8 Aug 2022 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660026352;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=t1d2KTH8m0XlbsxykujzGa28SCCTEDlVz3j05Smhax0=;
        b=DMoCJTzz+2A81Vf4MkQ7Abu+V9WlBnUHBxnsy2Etcenq8AluGUyTf2sxtAmx0ET0
        2hxnX6nQsr94P1KyQt8c+4nw3fHABx4PCAqz2ai8MwZLp9Vj5LZLwChZXiBZXr9NKU1
        JL1jMvljiOLV6r1USRRA7D40A244ti2KYnzTl+qo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660026352;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=t1d2KTH8m0XlbsxykujzGa28SCCTEDlVz3j05Smhax0=;
        b=SaBIgaJULQUvHcfrGUZvQ/IW1O4qXA5+7FcY9ybMAc+NdQvy0YFRc7WJ7iGSH6J8
        VXc25vcDh5krLYuFVLB+mIdoeaoucnMSd0hppI+A01zx57Rpl19U506SoEX1PJYYbus
        JZnTcRig85SIlfWN8BDZHRuwPYtMJwhvbQOIAJmo=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220809
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <010001828147f0da-d1512f2a-e1e4-4f51-892b-782aa8ba1e32-000000@email.amazonses.com>
Date:   Tue, 9 Aug 2022 06:25:51 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.09-54.240.48.37
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
* git commit: 6c8f479764ebe2848589de3249743ea552ed2495
* git describe: next-20220809
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220809

## Test Regressions (compared to next-20220808)
No test regressions found.

## Metric Regressions (compared to next-20220808)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220808)
No test fixes found.

## Metric Fixes (compared to next-20220808)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
