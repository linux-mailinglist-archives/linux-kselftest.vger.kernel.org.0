Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0B49FA29
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 13:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiA1M56 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 07:57:58 -0500
Received: from foss.arm.com ([217.140.110.172]:42482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbiA1M56 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 07:57:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55A411D4;
        Fri, 28 Jan 2022 04:57:57 -0800 (PST)
Received: from [10.57.12.200] (unknown [10.57.12.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007163F766;
        Fri, 28 Jan 2022 04:57:56 -0800 (PST)
Subject: Re: [PATCH v2] kselftest: Fix vdso_test_abi return status
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220128122744.17248-1-vincenzo.frascino@arm.com>
 <20220128125525.GB5776@e120937-lin>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <27f85ba0-7a4b-4f86-e1ab-e75f38e4bc12@arm.com>
Date:   Fri, 28 Jan 2022 12:58:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220128125525.GB5776@e120937-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Cristian,

On 1/28/22 12:55 PM, Cristian Marussi wrote:
> I gave it a go on JUNO, got a segfault as you can see below.
> 
> I think it is simply that now you are accounting properly for the
> FAIL/SKIP/PASS like in:

I tried it on a different board, let me give it a go on Juno.
Thanks for reporting this.

-- 
Regards,
Vincenzo
