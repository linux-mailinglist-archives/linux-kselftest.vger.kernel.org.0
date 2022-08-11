Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223B358F91A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 10:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiHKIbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiHKIbI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 04:31:08 -0400
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com [54.240.48.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71C74DE3;
        Thu, 11 Aug 2022 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660206664;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=1ecbtmwYNhTpR5BwTVj/XJ6U/D9GrPTeuWA82MNxTMc=;
        b=NOcCi8aZg7beWst2DuR8v3Upio7ErBxGG9AGiFOmSkLhH5q41mk4LLBXuUY9jI8b
        ll6f+NERCNDu5LzGFBR9Twn/Qymixm2jMS/II9tulJofY7aT+wYC8xxvKmjz6KkqsBl
        B0clDlDGOsL6K/nm+OPHG7sUGbmzQUAQygIKs/cY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660206664;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=1ecbtmwYNhTpR5BwTVj/XJ6U/D9GrPTeuWA82MNxTMc=;
        b=FSnnf3TCIycEhuq3o3EA0NgXIn7kHvWJN+FhJ8Jp7RNWnSl3d9yqqMSKOdiIFmvT
        Ma3FAM71l6rIUrVxd9EKH/4HoBOpWLX6hGHa1UgF4qoU6QdKgx/I94mbzx+yCvjAKR0
        /t6vU3vv1Ld+6XYy7Y/JUvrE+2DrO1JwDrv4GyII=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220811
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <010001828c074880-71c6c45b-bbbf-45c1-838c-e4810427afe8-000000@email.amazonses.com>
Date:   Thu, 11 Aug 2022 08:31:03 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.11-54.240.48.34
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
* git commit: 40d43a7507e1547dd45cb02af2e40d897c591870
* git describe: next-20220811
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220811

## Test Regressions (compared to next-20220810)
No test regressions found.

## Metric Regressions (compared to next-20220810)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220810)
No test fixes found.

## Metric Fixes (compared to next-20220810)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
