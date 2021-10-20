Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EAC434395
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 04:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTCnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 22:43:13 -0400
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:57569 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTCnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 22:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634697658;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=ELFhLELQRMDGjK2JlDJeI+5CxAxQWHdE5kGtW8rwdpg=;
        b=b/VC54+QvnyaArqCtutkjwF57j4HhINIjTSj11ZSdX2oYtW7m57RpGLm05EAERw5
        HYm/XsYHL1cPCYN4mIoT9kBCfgGj69sBm+/ChDWICGnGSkSwpJcvoUFSABVxrFoWr0O
        EWRnm6n7UyTa3KY8Yft1NhiZ0ZQTkVDu8OGN0HAU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634697658;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=ELFhLELQRMDGjK2JlDJeI+5CxAxQWHdE5kGtW8rwdpg=;
        b=PWFhDn2bWIAnFvxXA7LtABHjg7NcHHP2O0FYIOQF+OMVmxZjBj+lV+TDMs8xTbIp
        r8PBhL/2weQ1Gyts/Cz+y6GBhMdsOC6sRyR1Gn2R5iEFHruMRJp6n0kWgOvlCYULpks
        tfrauLFq6an7wWT4uaa7VSOSO3F5NqtkkLUIrr0I=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: lkft kselftest for next-20211019
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c9b92bfaa-8f0e8330-b6f4-41d9-82b6-8ad06e80d5eb-000000@email.amazonses.com>
Date:   Wed, 20 Oct 2021 02:40:58 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.20-54.240.8.29
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc6
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 5b27c149257d83558d9a7fae927be822673be230
* git describe: next-20211019
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211019

## Regressions (compared to next-20211015)
No regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211015)
No fixes found.

## Test result summary
total: 0, pass: 0, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary

--
Linaro LKFT
https://lkft.linaro.org
