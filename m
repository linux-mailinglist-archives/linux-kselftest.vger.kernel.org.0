Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EA5A9C47
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiIAPx2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiIAPx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 11:53:27 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C918E4DC
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 08:53:25 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MJQYw2VD3zMqD8X;
        Thu,  1 Sep 2022 17:53:24 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MJQYv5dt5zlh8Tx;
        Thu,  1 Sep 2022 17:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662047604;
        bh=/5UiAwQl0oR6WvEdzMPklN5nYUCp04mQ1pozhObj1j4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NfnfAuYXhdbSSCloKVNxHWkn9G8NVTe1fkWsXj0CHpYQk70XZC3smJA/DIBaZSZSZ
         WyyzvXD6D9rSOG+dEboLoYAwMTGRHnb/vy5sDcKlG1M8qNcbZg3gbVcsu2k/MidJNd
         1SdAzTFhu6YkVPSfsnFBg7aPCJuLxP6OJNqNhAmQ=
Message-ID: <7ed45656-f28b-5aaa-8a5b-84f566eb3bfb@digikod.net>
Date:   Thu, 1 Sep 2022 17:53:23 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC PATCH v1] checkpatch: Handle FILE pointer type
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20220901145948.1456353-1-mic@digikod.net>
 <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 01/09/2022 17:49, Joe Perches wrote:
> On Thu, 2022-09-01 at 16:59 +0200, Mickaël Salaün wrote:

[...]

>> +# our $typeKselftestHarnessTypedefs = qr{(?x:
>> +# 	FIXTURE_(?:DATA|VARIANT)\($Ident\)
>> +# )};
> 
> But not this.  Random userspace typedefs should likely
> be kept in some local version of checkpatch.
> 
> Or maybe add a command line option like --additional_typedefs=<file>.

This is part of the kselftest harness API. Could we take this into 
account for files under tools/testing/selftests ?

> 
>>   our $typeTypedefs = qr{(?x:
>>   	$typeC99Typedefs\b|
>>   	$typeOtherOSTypedefs\b|
>> -	$typeKernelTypedefs\b
>> +	$typeKernelTypedefs\b|
>> +	$typeStdioTypedefs\b
>>   )};
> 
