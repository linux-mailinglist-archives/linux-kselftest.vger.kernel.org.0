Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ABA4C9E7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 08:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiCBHj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 02:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiCBHj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 02:39:27 -0500
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com [54.240.8.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0737A39;
        Tue,  1 Mar 2022 23:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1646206722;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=cbcL4el6kk1bLK+yqEUc6ji5Azmi0oPW5Z+ZLBD1oJE=;
        b=hI+AixeFxnx/i2bIyz6YSXZ7doyawoTAy/qQvjXF0zaI4E7PAlPR7GV0DGkCBvVm
        XszZigopglvLkG3ylfBXyCY8CGoTojia/vlnpva2IN0xrijITk4vDHqCnUeMIg+J0OU
        WnBHWUTfXr1YpwBggU8M5vyYO6QgCCklybL43h9U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1646206722;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=cbcL4el6kk1bLK+yqEUc6ji5Azmi0oPW5Z+ZLBD1oJE=;
        b=JMEin0iZo4NfqhBC53y0GAEDRTad2cnDDD1FNR/OoSU0CvvaFTOmZmplVG5FFIPf
        sC/l4TmRiCssaVTUzlIy0aVpdI03UUPPl59C773TlnuyWIIN3EbCGHgfB+S1V22tRsM
        y5Iw5pjwDWZql8xibPDvBNg0phyuR5WNZG+Us+0o=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220301
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f499121ef-166acd25-c6f4-4b7d-936b-edfcf4855048-000000@email.amazonses.com>
Date:   Wed, 2 Mar 2022 07:38:42 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.02-54.240.8.97
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
* kernel: 5.17.0-rc6
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: [None, 'master']
* git commit: e6ada6df471f847da3b09b357e246c62335bc0bb
* git describe: next-20220301
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220301

## Test Regressions (compared to next-20220225)
No test regressions found.

## Metric Regressions (compared to next-20220225)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220225)
No test fixes found.

## Metric Fixes (compared to next-20220225)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
