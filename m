Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE853A4064
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFKKud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 06:50:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKKud (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 06:50:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9E4151F44523
Subject: Re: [PATCH v3 0/1] lib: Convert UUID runtime test to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
References: <20210610163959.71634-1-andrealmeid@collabora.com>
 <YMMzDUVOlJcw63lf@smile.fi.intel.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <7ad34395-2b62-58fb-8a63-7b4899460290@collabora.com>
Date:   Fri, 11 Jun 2021 07:48:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMMzDUVOlJcw63lf@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andy,

Às 06:55 de 11/06/21, Andy Shevchenko escreveu:
> On Thu, Jun 10, 2021 at 01:39:58PM -0300, André Almeida wrote:
>> Hi,
>>
>> This patch converts existing UUID runtime test to use KUnit framework.
>>
>> Below, there's a comparison between the old output format and the new
>> one. Keep in mind that even if KUnit seems very verbose, this is the
>> corner case where _every_ test has failed.
> 
> Btw, do we have test coverage statistics?
> 
> I mean since we reduced 18 test cases to 12, do we still have the same / better
> test coverage?
> 
I don't think we have automated statistics, but I can assure you that
the coverage it's exactly the same. We are testing two correlated
functions with the same input, in a single test case, instead of having
a single case for each one, so that's why the number of cases is reduced.

For example, instead of:

	total_tests++;
	if (guid_parse(data->uuid, &le))


	total_tests++;
	if (!guid_equal(&data->le, &le))

We now have:

	KUNIT_ASSERT_EQ(guid_parse(data->guid, &le), 0)
	KUNIT_EXPECT_TRUE(guid_equal(&data->le, &le))

That will count as a single test.
