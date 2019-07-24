Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E622873DC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403800AbfGXUTv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 16:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391140AbfGXUTv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 16:19:51 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D529220693;
        Wed, 24 Jul 2019 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563999590;
        bh=NR2+6PT7l3YN8pNusq+j1LBpWGnRCt7/+N+k65V7US8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DDV+DcxKuXsVa3MSEGmOwt0irQqsM00CrbJnW+Qe2d5OgU2BICykVYzDALIOtGv4e
         9bDdAX5uFLWUBsQ/FALahWsA0uxuVLKpaEVyHWdEymDHl+VkJ8Af4TgVGpjoFwDv4v
         qLemdY/dw02HOtJijYY8fMp/Z7SEoQA10XJAK8w4=
Subject: Re: [PATCH v4] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>
References: <e450e2ec-b683-f712-c8d5-ef1c2e2dee7c@kernel.org>
 <20190724200558.6412-1-joe.lawrence@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <92c4941a-e1cc-4933-9cc0-610f9ec349c5@kernel.org>
Date:   Wed, 24 Jul 2019 14:19:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724200558.6412-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/24/19 2:05 PM, Joe Lawrence wrote:
> Add a skip() message function that stops the test, logs an explanation,
> and sets the "skip" return code (4).
> 
> Before loading a livepatch self-test kernel module, first verify that
> we've built and installed it by running a 'modprobe --dry-run'.  This
> should catch a few environment issues, including !CONFIG_LIVEPATCH and
> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
> skip() function.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
> 
> v4: s/unable load/unable to load/ in user visible skip message. [shuah]
> 

Thanks. Applied to linux-ksefktest fixes for 5.3-rc2 with Petr's Ack

thanks,
-- Shuah
