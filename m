Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067F4FA5FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiDIIcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Apr 2022 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiDIIco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Apr 2022 04:32:44 -0400
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com [54.240.8.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DDB7EA;
        Sat,  9 Apr 2022 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649493035;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=VKgZZKhpLzOES/8MDo6ThnaqOSsUk5I0EWd2dp2V45w=;
        b=KkyGBsbyr0q6gtBgXhRGWdts83Y6JRSxQiWCfbJhWYptm/zOQ2LaxyZ8Qnxu342F
        ObkX6fR0P9deEY/EXtsWVK5LNlcWv827CTiioLcVxF3AP4Eph0PuIhDwFo+SYvwUnOM
        D13Uau8AAtzRmMgHyhzXF8aeUdbAGupFsbOHCD9w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649493035;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=VKgZZKhpLzOES/8MDo6ThnaqOSsUk5I0EWd2dp2V45w=;
        b=gwWvilhhiNgvKLsvBiz7YSfyQ40Q4E+eyGHU79Zm25NkfxWex/6WsYhkQgEjFcJk
        IC+Z0OnT7eEk1VgJFcnarfGsa07mdBVLNGR0mTudg3/2bUefEKUWYeneObPKplbXJg2
        Y+cFMfdSVYq76SXlF3DyhXLYMQH6RD5drjwnddi8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220408
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <010001800d7249d1-e7ed44ab-a1a5-46ff-be98-02360be0965d-000000@email.amazonses.com>
Date:   Sat, 9 Apr 2022 08:30:35 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.09-54.240.8.35
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.18.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: ff511c1c68a5a35ab0b3efb3c306fd80b10d74be
* git describe: next-20220408
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220408

## Test Regressions (compared to next-20220401)
No test regressions found.

## Metric Regressions (compared to next-20220401)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220401)
No test fixes found.

## Metric Fixes (compared to next-20220401)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
