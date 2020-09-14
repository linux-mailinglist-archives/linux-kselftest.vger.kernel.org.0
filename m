Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B312693BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINRmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 13:42:04 -0400
Received: from foss.arm.com ([217.140.110.172]:35746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgINMX2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 08:23:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA35B106F;
        Mon, 14 Sep 2020 05:21:41 -0700 (PDT)
Received: from [10.37.12.80] (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1D903F68F;
        Mon, 14 Sep 2020 05:21:39 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] kselftests/arm64: add PAuth tests
To:     Will Deacon <will@kernel.org>,
        Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, boian4o1@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
 <20200911181558.GA21319@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <626cb564-22e1-4f2d-47c7-f38439c5fb29@arm.com>
Date:   Mon, 14 Sep 2020 13:24:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911181558.GA21319@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Will,

On 9/11/20 7:15 PM, Will Deacon wrote:
> On Mon, Aug 31, 2020 at 12:04:46PM +0100, Boyan Karatotev wrote:
>> Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
>> It introduces instructions to sign addresses and later check for potential
>> corruption using a second modifier value and one of a set of keys. The
>> signature, in the form of the Pointer Authentication Code (PAC), is stored
>> in some of the top unused bits of the virtual address (e.g. [54: 49] if
>> TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
>> controls are present to enable/disable groups of instructions (which use
>> certain keys) for compatibility with libraries that do not utilize the
>> feature. PAuth is used to verify the integrity of return addresses on the
>> stack with less memory than the stack canary.
> 
> Any chance of a v3 addressing the couple of small comments from Dave on
> the third patch, please? Then I can pick up the whole lot for 5.10.
> 

Boyan is on it. Thank you.

> Cheers,
> 
> Will
> 

-- 
Regards,
Vincenzo
