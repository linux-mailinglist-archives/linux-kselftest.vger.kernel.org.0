Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512D592BB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiHOJWX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiHOJWA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 05:22:00 -0400
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com [54.240.8.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873C2A7;
        Mon, 15 Aug 2022 02:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660555316;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=xFqraFA6lGmUu0wYMye/OBvTkGaFcGmFu9hbEp/wo44=;
        b=Gncdjke6xFirgu+vxM5ciR105bzITV0i01UzWOa2vTwjMiLSAVIlpd8alPGE0mH+
        LswfP8SJWiXEcIhL9Y+nzrQ8P7dL8dVVyxKevnusDHUNGejDzJhLeTNTRHeDCMzUTZi
        zF+NpaP8CFnKCGLBWmwV1YNlt2zWk4Fl3ADyKu90=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660555316;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=xFqraFA6lGmUu0wYMye/OBvTkGaFcGmFu9hbEp/wo44=;
        b=Uvfz+oldhTD9PkJn3Bxry/aRBMLXlfO7xVy6WeqxQOq0b8F0vKPJB0nCDGLqFsIj
        WLB0jx4OWxBFzT9Bwkq4yVIORLPxWuKVGAdUGImP3MxQEKkTcy+Yl9SWv9E6hAxeSbz
        jwkvA1bhzEgvAcrnTzFx1yVurBQBcF51i6l6TWAo=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220815
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000182a0cf4b92-f1608483-7e1c-4b32-93c9-5c1dfe12c9c2-000000@email.amazonses.com>
Date:   Mon, 15 Aug 2022 09:21:56 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.15-54.240.8.35
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
* git commit: fa96acf505e0e5f4774e273d97cee65fffcf53e6
* git describe: next-20220815
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220815

## Test Regressions (compared to next-20220812)
No test regressions found.

## Metric Regressions (compared to next-20220812)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220812)
No test fixes found.

## Metric Fixes (compared to next-20220812)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
