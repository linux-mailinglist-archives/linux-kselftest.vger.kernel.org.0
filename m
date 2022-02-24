Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0115E4C39ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 00:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiBXXz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 18:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBXXz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 18:55:29 -0500
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com [54.240.48.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FFE278CBF;
        Thu, 24 Feb 2022 15:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645746897;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=QbI2yvl+jpyU2l//9Q47e7edmEF4FJqN+ntTcUTUoL0=;
        b=opI9fRRu1Pby81RTufGQRKboy3uVjc9cuwBKQ/cvvk4ENz4xHnWvl6bOuAfHEIf4
        CxByWGD7wO44p3TOYUfNNJzfot2cu8hUjg+eWlX9KAWr900hW8pJb84kimhZA22EfZ3
        qyLyCJYukw6asfm7magJO0kDIcFQw6O/T1TiUkTQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645746897;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=QbI2yvl+jpyU2l//9Q47e7edmEF4FJqN+ntTcUTUoL0=;
        b=FYaLIikwTzcqUj+WC6EU6vGK+kk6C0EWLMudrEGdNoOowzWI6RqGPp8EkcVsVsSY
        wK8hS9VPPjzMqKn4Xf0robZaqII+tDFqNCphYSugj5p7JCOdquCLXrhzUWtwOpmGrzB
        85q/rpVYKR6a6IHGvztJ2265ovbhGByzJwyWvuEw=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220222
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f2e28c195-73f296bc-57d1-4189-8035-176832d77450-000000@email.amazonses.com>
Date:   Thu, 24 Feb 2022 23:54:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.24-54.240.48.34
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
* git commit: 196d330d7fb1e7cc0d85641c89ce4602cb36f12e
* git describe: next-20220222
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220222

## Test Regressions (compared to next-20220214)
No test regressions found.

## Metric Regressions (compared to next-20220214)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220214)
No test fixes found.

## Metric Fixes (compared to next-20220214)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
