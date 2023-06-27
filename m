Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7130E7403B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjF0TBL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjF0TBK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 15:01:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550119A9;
        Tue, 27 Jun 2023 12:01:09 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E48DF6607155;
        Tue, 27 Jun 2023 20:01:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687892468;
        bh=/9PrOHnvrybO+vm7KEMCWRQ/zQkS6KYWvsrScJjK7KY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=NQstSq2G2pKMTArKMF7wiQZ7161dBYh0/WOHI7OckZnQpgxDo34ElDUL2Oylrgltp
         vdngVF4HMSH88fluxuIMFYAEicAWMv0WsQe3xYy7eJvw6/ae8wG0zC5km2sJ63IiVE
         b0EBEI1lTPVwb8T3nvrtQ4rtRlKaFP1iCTGpQE1vX8F++tjNCYEKNaN6E9nNYTf/zf
         HkFbMmOVQ5lA4kqs3Up0TECHJ3bFIfY0gN7sVboYUtKyBe/0m3U/tbKtxmC29Zbj2u
         tJd4hKGzFZrg2gT+QewrnyT18B18Efqudvb7FhCpmpB2UAJG1K6q1Y1YMtHysgESej
         SGe2PH4arzLvQ==
Message-ID: <758f6c94-ac29-5e9c-f5c1-68210c2427ab@collabora.com>
Date:   Wed, 28 Jun 2023 00:01:01 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
References: <20230607153600.15816-1-osmtendev@gmail.com>
 <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/23 2:43 AM, Shuah Khan wrote:
> On 6/7/23 09:36, Osama Muhammad wrote:
>> This patch will add the new test, which covers the prctl call
>> PR_SET_NAME command. The test tries to give a name using the PR_SET_NAME
>> call and then confirm it that it changed correctly by using  PR_GET_NAME.
>> It also tries to rename it with empty name.In the test PR_GET_NAME is
>> tested by passing null pointer to it and check its behaviour.
>>
>> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
>>
>> ---
>> changes since v1:
>>     -Used TASK_COMM_LEN instead of using numerical value 16.
> 
> Please add linux/sched.h here as an include to pull this.
> It is good to add an explicit include as opposed taking
> a chance on it being included from another include.
TASK_COMM_LEN is defined in include/linux/sched.h. It is only to be used by
the kernel.

If we look at include/uapi/linux/sched.h, TASK_COMM_LEN isn't defined. So
this test looks good to me.

> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum
