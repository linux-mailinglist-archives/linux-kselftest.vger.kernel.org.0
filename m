Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64D4EED82
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiDAMzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbiDAMzi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 08:55:38 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C161929C;
        Fri,  1 Apr 2022 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648817627;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=iokU4kBOR+TI7Jykw2i5Geg1hj+lfuyD52h/QVnbuPk=;
        b=B3UGAxSM0tjYr8KW5BTGb3+/w9OzVAibCYouo16pb67LMkUjf0RLB3WkBassAojS
        saRhAglrVtoHW2c725pn/4wqC78ncB1jSg5J0T+YIvKoIMrfLeLP/KZh8Vz91IrpU+c
        WiFnrSQU6J8z5dxF9RXlO1KaFWut1VgOl30dlGwY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648817627;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=iokU4kBOR+TI7Jykw2i5Geg1hj+lfuyD52h/QVnbuPk=;
        b=EwXmhVGm3usO6gMcUz4bdfgq55MntxiqRKGomiewV87aiyG03/tYgjvD6vo/9kQm
        /5Cy62tWUN2qcx3RKMw9bPWBU4WTNaW3gF+p1FmadF+29dRDW29zfhFRe22f+OM9mMN
        r9VBw49D8zDJaV19Fm7DdydKDslV+5q3fwqhm26k=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220401
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017fe5306059-bb781818-2f36-486c-9e70-0b9813487747-000000@email.amazonses.com>
Date:   Fri, 1 Apr 2022 12:53:47 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.01-54.240.48.37
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: e5071887cd2296a7704dbcd10c1cedf0f11cdbd5
* git describe: next-20220401
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220401

## Test Regressions (compared to next-20220302)
No test regressions found.

## Metric Regressions (compared to next-20220302)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220302)
No test fixes found.

## Metric Fixes (compared to next-20220302)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
