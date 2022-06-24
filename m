Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7127655A233
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiFXTtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiFXTtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 15:49:12 -0400
X-Greylist: delayed 1326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 12:49:11 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500647C52D;
        Fri, 24 Jun 2022 12:49:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D5FBD31A;
        Fri, 24 Jun 2022 19:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D5FBD31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656100151; bh=fmRtDd2s3FqA+hEt+9MtMv52kopzwDRnLvuqc2u2Goo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S2norobFpWeXKBDf/d2ZYcGUS6gQptPLRgXLlKiHIl/h81ly3etZzIbL0L4BmeUVL
         if34HBNrrYOptSxLNzM5+Uym6l6Kfsp0VTXgCX3A32K4wB5pBdH2u5H1IToMHt5VMG
         rXIDUSyqfG9m7/G2M0azdHZbfj7iHHF445ggjP35RhIBKWOQ7rIo4haU1UUqTVXmdv
         XKTq/sUQjU8O51KaPk6Gqhwecr6xXl33QlGIyiroeQzfdKUf0cbpV8mHBDBBsBdLso
         8Xq+V/Mcv6kh0+B2tPF872tA9Zs7FxwbUK9PkiONjARLr6DShWNBqxmbIAxaJdB36b
         hwx6JYCje62ug==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        bagasdotme@gmail.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/kselftest: add more guidelines for adding new
 tests
In-Reply-To: <0e8ea624-3cf0-7c63-9b24-8c4109096d3d@collabora.com>
References: <20220521073651.4191910-1-usama.anjum@collabora.com>
 <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
 <63fc263d-c06a-2974-298c-5da80322411a@linuxfoundation.org>
 <0e8ea624-3cf0-7c63-9b24-8c4109096d3d@collabora.com>
Date:   Fri, 24 Jun 2022 13:49:10 -0600
Message-ID: <87letl3kqx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:

> On 6/8/22 2:41 AM, Shuah Khan wrote:
>> 
>> The change looks good to me. I am catching up on patch backlog after the
>> merge window and vacation. I can take this through kselftest or if it
>> goes through doc tree - here is my
>> 
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> 
> This patch hasn't been accepted yet.

I've applied it now, thanks.

jon
