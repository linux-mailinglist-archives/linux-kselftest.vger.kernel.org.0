Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FAA4B35E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Feb 2022 16:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiBLPsB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Feb 2022 10:48:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiBLPsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Feb 2022 10:48:00 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 07:47:55 PST
Received: from e2i927.smtp2go.com (e2i927.smtp2go.com [103.2.143.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83081240AC
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Feb 2022 07:47:55 -0800 (PST)
Received: from mail43 (103.2.143.243) by e2i927.smtp2go.com id h0vbai2t12op for <linux-kselftest@vger.kernel.org>; Sat, 12 Feb 2022 15:32:50 +0000 (envelope-from <kdqet8lb30=7sif5rd4pgu2=e7wl3a22kk@em541630.edechamps.fr>)
Received: from [10.5.151.70] (helo=[10.10.172.1])
        by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_SECP256R1__AES_128_GCM:128)
        (Exim 4.94.2-S2G)
        (envelope-from <etienne@edechamps.fr>)
        id 1nIuO6-rlZE30-1k; Sat, 12 Feb 2022 15:32:38 +0000
Message-ID: <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
Date:   Sat, 12 Feb 2022 15:32:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 0/6] RLIMIT_NPROC in ucounts fixups
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
From:   Etienne Dechamps <etienne@edechamps.fr>
In-Reply-To: <20220207121800.5079-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 541630m:541630axyZg6b:541630st7E7OQXF4
X-smtpcorp-track: 1nmIO6r_ZE301k.UwuWD5CoI_y-H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1644679970; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=VmIVvA1W8OMJXTdtkXF/hvAHVH9rtN3Tcn5DrWq08IY=;
 b=jsToiyKG9NOxmxZRwHfWfIRKy/o9tYXHKMBZfi1YEMBAF/z0nKR4GLv0c6YZeL+006cdY
 9HytmQDE6Owwac1Lfdx92cPt9Shx086QJyGmLmnbjUVp5Y0Gzcpzc7nAJZr4pvuJP2tCJFX
 FiB9PfIYwKzOItXcRR8ZKNdNQFkYm6nyeDu8h/Ofw1wHJPd/U6B7CzwRN4f/5rNe51RwmbB
 LJ+B6xLj+c4pOPheYHDg/7PH/dfAqttFjnAwcrvysqrONM98Y9yuQglbbjhxzudV6mcimGx
 KgQsdGLbjm6J3H1JLquiHpGs5Wn2a+Zdomt7MzR/LV77KZg6PrzKpkmg+NfA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello there,

On 07/02/2022 12:17, Michal Koutný wrote:
> This series is a result of looking deeper into breakage of
> tools/testing/selftests/rlimits/rlimits-per-userns.c after
> https://lore.kernel.org/r/20220204181144.24462-1-mkoutny@suse.com/
> is applied.

Pardon the intrusion, but I thought you might be interested to know that 
as a humble user I noticed actual user-visible breakage from 59ec715 
"ucounts: Fix rlimit max values check": 
https://bugzilla.kernel.org/show_bug.cgi?id=215596

I'm not sure I understand everything that's going on in this thread but 
it does seem very relevant. You guys might want to double-check the 
behavior in the particular scenario described there. I'm mostly sending 
this to make sure everything is cross-linked.
