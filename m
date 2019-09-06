Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120DAABCFC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfIFPv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 11:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbfIFPv5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 11:51:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED86207FC;
        Fri,  6 Sep 2019 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567785116;
        bh=olq8KpdU2v3Ls1VC1ZH3usO+fBe5ugYbV7wB0pi1OIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1xdml3Gsyy3q/j7FTCJbHUz4yUZX/SH6snWYY7sqhzkaljmRd3+G0ZZgM+LR6DOoH
         br/s0BrkxHY1m6dhKYaVDPESnYjHutAjWsgthb6JXc2MRCgla6GRGJxJdVJvYZb83N
         JefFJkiuJUget12PjYQqEVIMrk9KSSFmo5ZEkQxc=
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     SeongJae Park <sj38.park@gmail.com>, brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <1567771541-7690-1-git-send-email-sj38.park@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3531717b-fa9d-ac94-57ec-0eb501d1ad3b@kernel.org>
Date:   Fri, 6 Sep 2019 09:51:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567771541-7690-1-git-send-email-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/6/19 6:05 AM, SeongJae Park wrote:
> kunit fails to run with '--build_dir' option because the option is not
> properly sent to kernel running procedure.  This commit fixes the
> problem.

Can you please include the failure you are seeing in the commit log

thanks,
-- Shuah


