Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3576D4FF7CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiDMNkv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiDMNku (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 09:40:50 -0400
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com [54.240.8.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD0E5F266;
        Wed, 13 Apr 2022 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649857107;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=1XNYhsrNPf8+D/nYnPncl80qSnYcKNrwGxgG2fxn7uQ=;
        b=WJEmAo0REaRKESwg1E/05uX/c8pnGiGpvluutC76yA/J1ui9z2LobjRPZW4p041I
        ovQ3NAIyjxb8GtQobybLDU3KDHcF2cn/2P8ICFWF+kkrP14Xdyg4jGhjJs1gQ5F/pZ4
        gyslhepJY93nOkB8xZAI2kdJGe0ImVMwmzy65eWM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649857107;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=1XNYhsrNPf8+D/nYnPncl80qSnYcKNrwGxgG2fxn7uQ=;
        b=AjceYrBOha8fh25bb+BRO5BwB0DYQj9szdo8RUonmIaCs0I/qpJuOY2VI8CvdVWf
        bPJaRrQjZaMmvahQrlClzlSIjexzJdnYn71NrTn1vXNj4LvbxkAD8Eo9lUMUZNTtJhE
        jeq39zmZpCimV8wCzG0pabFY9qpTtyokQK9yM670=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220411
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180232596b5-0242d2d1-06be-4ed4-9e37-26c371e8ff7f-000000@email.amazonses.com>
Date:   Wed, 13 Apr 2022 13:38:27 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.13-54.240.8.35
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
* git commit: d12d7e1cfe38e0c36d28c7a9fbbc436ad0d17c14
* git describe: next-20220411
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220411

## Test Regressions (compared to next-20220408)
No test regressions found.

## Metric Regressions (compared to next-20220408)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220408)
No test fixes found.

## Metric Fixes (compared to next-20220408)
No metric fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
