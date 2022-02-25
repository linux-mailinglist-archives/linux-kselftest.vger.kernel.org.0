Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19354C3EFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 08:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiBYH1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 02:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiBYH1Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 02:27:24 -0500
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B742ED7;
        Thu, 24 Feb 2022 23:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645774007;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=a/IVFR3inflT9Yw9us4KGNsp45d8WF5HkFPpJnegjG4=;
        b=RLhGwTQwOE/u21oc7hy8V0p99ePHlW2itgLqyZ+E6FmjjzOPukDl6zr8yTa8c5W2
        Th849+wk3Jx8UR8P+p+I9UBI9YXmXwGIqJ93hQlen2WSrcBPrCV4imdNJWshWL6RiP8
        7OfU6IZBAlRewRQuurUYymJze4/bqsYrAf8pzC/s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645774007;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=a/IVFR3inflT9Yw9us4KGNsp45d8WF5HkFPpJnegjG4=;
        b=cvUee8lndIxxVvn+I06GETpF1QaNDli8FRjO2lnol9emedwJtzn99HjRFdbc7fMa
        zY1fYKk+0lmyhlyhsLjkCR4a4AnEbMQ1Y/r9vyHCsqL9jVqiViOHUi8Au6QL/Na42SH
        dxrTqrIynKza6OZMF2OD5zxMDkrYXgHBbyUAvpOE=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220223
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f2fc669f1-46d24378-6aa6-46c3-a113-6d8569337c67-000000@email.amazonses.com>
Date:   Fri, 25 Feb 2022 07:26:46 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.25-54.240.48.37
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
* kernel: 5.17.0-rc5
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: [None, 'master']
* git commit: d4a0ae62a277377de396850ed4b709b6bd9b7326
* git describe: next-20220223
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220223

## Test Regressions (compared to next-20220216)
No test regressions found.

## Metric Regressions (compared to next-20220216)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220216)
No test fixes found.

## Metric Fixes (compared to next-20220216)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
