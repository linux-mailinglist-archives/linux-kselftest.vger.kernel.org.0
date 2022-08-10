Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359DC58F00B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiHJQEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 12:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiHJQEs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 12:04:48 -0400
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com [54.240.8.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DA6580A;
        Wed, 10 Aug 2022 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660147486;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=Rf/m8B9+Cw9kdwKV2esMY+p2eyZV4+cvATIOg1VdNaU=;
        b=ZNKeqUuyPFnsBIYLgUVkumxYZuX0ToAf1GD5Cy2fClf7mNeZ3uFj9wPzmoBAykfW
        lC4SjdlQkFxNLqAt1wHHEomlOn5fsCAiyS9id1F+lieKJK2sDZX8ZWO2mFfg9VcrpNN
        z1WSFkNF5HldG6mmylwfU9xl3kmZgSWwTzkEz3GE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660147486;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=Rf/m8B9+Cw9kdwKV2esMY+p2eyZV4+cvATIOg1VdNaU=;
        b=iW64heRAM2lkal7BQGT0XnrCagUS4AvmnTUZagcErXY+SW1MGiEwHY6aenQ7GX2j
        ms/v+d3Re5GYHapOmT09NusuPpBEZCf2ZDobLCgufZDkBVwIgO15LUGz2wnKyJQpgT0
        zN1nchxq9ySVGqkpitgKbG4VOhcz9iM1bGgzZrhI=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220810
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100018288804c9f-f631e70f-fc11-44d5-b66b-b8556d71639f-000000@email.amazonses.com>
Date:   Wed, 10 Aug 2022 16:04:45 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.10-54.240.8.97
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
* git commit: bc6c6584ffb27b62e19ea89553b22b4cad1abaca
* git describe: next-20220810
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220810

## Test Regressions (compared to next-20220809)
No test regressions found.

## Metric Regressions (compared to next-20220809)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220809)
No test fixes found.

## Metric Fixes (compared to next-20220809)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
