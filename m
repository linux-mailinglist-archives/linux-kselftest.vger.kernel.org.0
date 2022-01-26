Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3149CE24
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiAZP0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:26:14 -0500
Received: from foss.arm.com ([217.140.110.172]:47228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbiAZP0N (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:26:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C611FB;
        Wed, 26 Jan 2022 07:26:13 -0800 (PST)
Received: from [10.57.14.15] (unknown [10.57.14.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9802C3F793;
        Wed, 26 Jan 2022 07:26:12 -0800 (PST)
Subject: Re: [PATCH 2/5] kselftest: Fix vdso_test_time to pass on skips
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-3-cristian.marussi@arm.com>
 <8d513be7-a99d-2b7f-6767-a378742ef3fa@arm.com>
 <20220126123418.GH6113@e120937-lin>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <116c3c77-f6b6-66f8-e687-9ecea7327252@arm.com>
Date:   Wed, 26 Jan 2022 15:26:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220126123418.GH6113@e120937-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Cristian,

On 1/26/22 12:34 PM, Cristian Marussi wrote:
> Sure, I was indeed not sure my solution was what you wanted.
> 

Not a problem and more then anything thank you for reporting the issue.

>> If it does feel free to fold it in the next version of your series with your
>> "Tested-by:" otherwise let me know.
> Sure, I'll do and keep you on CC.

Thanks!

-- 
Regards,
Vincenzo
