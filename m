Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27170753FD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjGNQ2K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNQ2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:28:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC2852722;
        Fri, 14 Jul 2023 09:28:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87C11570;
        Fri, 14 Jul 2023 09:28:50 -0700 (PDT)
Received: from [10.57.76.27] (unknown [10.57.76.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2CA83F740;
        Fri, 14 Jul 2023 09:28:06 -0700 (PDT)
Message-ID: <5336c2a4-aaf7-4bc0-46ec-dd1ae15bbf85@arm.com>
Date:   Fri, 14 Jul 2023 17:28:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/9] selftests/mm: Give scripts execute permission
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20230713173237.66285-1-sj@kernel.org>
 <7935c31a-6c47-95c8-d6bd-176b81046699@arm.com>
 <20230714092600.5cdf5844098a2de728a1750b@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230714092600.5cdf5844098a2de728a1750b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/07/2023 17:26, Andrew Morton wrote:
> On Fri, 14 Jul 2023 10:44:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Thanks for the detailed explanation. Are you effectively saying this patch will
>> turn into a no-op once its been munged through the various patch management
>> tools? That's disappointing because it's a pain to have to invoke everything
>> though bash explicitly. Many other scripts manage to have the correct execute
>> permission set (see everything in ./scripts for example).
> 
> Such patches need delicate handling :(
> 
> I queued this as a standalone thing, for 6.5-rcx.

That's great - thanks Andrew! Do I'll drop this patch for my v2 of the series
(hopefully Monday).

