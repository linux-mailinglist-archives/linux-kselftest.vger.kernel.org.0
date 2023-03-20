Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495746C0ADC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 07:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCTGsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 02:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCTGsG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 02:48:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F7EB6E92;
        Sun, 19 Mar 2023 23:48:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B921AFEC;
        Sun, 19 Mar 2023 23:48:47 -0700 (PDT)
Received: from [10.162.40.143] (a077209.arm.com [10.162.40.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043ED3F885;
        Sun, 19 Mar 2023 23:48:01 -0700 (PDT)
Message-ID: <b68705c8-df85-6b45-091b-3975a89b796e@arm.com>
Date:   Mon, 20 Mar 2023 12:17:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] selftests: Set overcommit_policy as OVERCOMMIT_ALWAYS
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
 <20230314042351.13134-4-chaitanyas.prakash@arm.com>
 <8fe0d91b-2209-1c66-2788-f18055c9d213@redhat.com>
Content-Language: en-US
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
In-Reply-To: <8fe0d91b-2209-1c66-2788-f18055c9d213@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/16/23 21:01, David Hildenbrand wrote:
> On 14.03.23 05:23, Chaitanya S Prakash wrote:
>> The kernel's default behaviour is to obstruct the allocation of high
>> virtual address as it handles memory overcommit in a heuristic manner.
>> Setting the parameter as OVERCOMMIT_ALWAYS, ensures kernel isn't
>> susceptible to the availability of a platform's physical memory when
>> denying a memory allocation request.
> 
> Which tests in particular require that?

This is applicable to the virtual address range selftest.

> 
> Subjects should start with "selftests/mm" instead of more generic 
> "selftests:"

I'll make the necessary changes.
> 
