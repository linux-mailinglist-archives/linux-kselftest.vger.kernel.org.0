Return-Path: <linux-kselftest+bounces-14674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED7194529C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1027284147
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39392146A7C;
	Thu,  1 Aug 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wf5lxz57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F273A8F7
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536117; cv=none; b=l9GHWoZBsn9vRzVFfUG/TwpgVlYh1JIjVmKlXwgi2NuVorZqjX10r1Ck5/sc5iZrZsmCR0vy133W+tQ3gGLgqLlTJNGZ3YSNdxko3Xe6KLnoTx4MR5K9M4sn8va7KEsouYYJpxLW1BNBEdP0MUj3ch/rP7izqymZ4VILUBK+tE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536117; c=relaxed/simple;
	bh=mDQmscKzC6FkcvJ1nMQ62JAgSYrDQbginlWf3DXeVug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImdzutSiMZUxpacntAi2416QHMJqPeb3dxQ5ub8luwaIPzgWP1IN9WYqbcDvzgdKMkcGts8Hk6ZrMpdhBPBNsz2HvlnkMYlky+7FAZUoU/2rU2PEIoPFCutgqf72XHLktkSevM1/FNTwwSlMo7K/J28Gp/7rpokajI2g+u9Ap7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wf5lxz57; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44ff6f3c427so34565611cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722536114; x=1723140914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJmj+uQzxUGHDFeUr2mlYe7UZLaWUNwaH2yLxAFxVq4=;
        b=Wf5lxz57TGKqV/+tCnAzMC61wbF4yeXaOE1Re5c2PshnMIjIHUsEBTp+8QKey6GR4I
         HQ9HIF5BBw273drs1FI3QdOdoOCH8KypZnCOBk+0pf1c1UqrtssO2I7/uDmjvEC1uwp5
         rjN/A+8gw5YcFAB8P1NZ7DfBbn++Rp/92qiv/OmU34AAAZTO9R//MEB+FWIElqHnDkmJ
         udG8eYQuGG67m9NWTAJs0d91omfG25JxuDKMUUYPGAoDP20qnHovXRvYAYzGYnPB0biQ
         aVMNiu7VWyvXbLEFMAH99QXkoL+5XW5iUXPiPjZEhMMJ1IFo7EooYqTfuNMlkhWbxImt
         VydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536114; x=1723140914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJmj+uQzxUGHDFeUr2mlYe7UZLaWUNwaH2yLxAFxVq4=;
        b=Of8Hb48uKGYHfjFL+GY0YCZwNvnDXMuIYkqL8mOG9KXi5zExxpwITr4qntKIBrdW0x
         qf7kjOSjS2pxQGQNVifRJJP8H1hdoHlINRF4i+2ZzL1HRckDs/CFLTZPBnKSkCWAuL9s
         keyjdgzdMtjlxiN1fz6gw17TkrK2+PFOy3A5YCF9ij/neI2IqpAWdL4aLlJkpAA4ftuW
         K6WYQtEDUCZ31rARHzCN1wKq3S4v8PDi7gOGE2ydX+5FgVr1I2GFGKrXRDTezUNdqxPe
         lnRm2DJ+eXUyvb4DqFXJShgM3wRloAJjFclYyqvlp7Uz76OTfff5TkSrQizId95A12O1
         zg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbqnj2RS1RRyVGzbc1BuELi0ZYOkd25JSxjW5JgJgw2Hxr06WhYRqqoAdXsDx0S/yh/dK/yJ5F6lGan8wuGEQJta3ddfj+k2Tynrh8aJWT
X-Gm-Message-State: AOJu0YzNA2smowNH9vBNG4Zbo8PWK1hl91QSRa5Sxi1H6nx+QJYGClTy
	blArsDHDp9bm1LxgTXzd0bWZOxuk/4UGWTYUAJQYQWVRDyqGflzUTeUL08+QvHs=
X-Google-Smtp-Source: AGHT+IH0Ox8LkCy/m2cu9OtkuK3U3PR6Sh/KINpo+GPnGvySb1ILchFJUlHIJbqbWernh826B9k3Dg==
X-Received: by 2002:a05:6214:4341:b0:6b5:e190:435 with SMTP id 6a1803df08f44-6bb984a6783mr14380676d6.50.1722536114469;
        Thu, 01 Aug 2024 11:15:14 -0700 (PDT)
Received: from [10.5.114.153] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb99a22195sm1159676d6.45.2024.08.01.11.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 11:15:14 -0700 (PDT)
Message-ID: <bd81277b-a443-461d-9bad-5688c7d8565d@bytedance.com>
Date: Thu, 1 Aug 2024 11:15:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/3] selftests: add MSG_ZEROCOPY msg_control
 notification test
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org,
 almasrymina@google.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, axboe@kernel.dk,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
 <20240730184120.4089835-4-zijianzhang@bytedance.com>
 <66aabb616714_21c08c29432@willemb.c.googlers.com.notmuch>
 <570fe8a0-4b93-4f3d-a4d7-34a3a61167e4@bytedance.com>
 <CAF=yD-Jt6XWSCLfZE1C+9=vcXyG-XcC2q-7Ai-HHSUt=1OrWsg@mail.gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <CAF=yD-Jt6XWSCLfZE1C+9=vcXyG-XcC2q-7Ai-HHSUt=1OrWsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 10:36 AM, Willem de Bruijn wrote:
> On Thu, Aug 1, 2024 at 1:30 PM Zijian Zhang <zijianzhang@bytedance.com> wrote:
>>>
>>>> -static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>>>> +static void add_zcopy_info(struct msghdr *msg)
>>>> +{
>>>> +    struct zc_info *zc_info;
>>>> +    struct cmsghdr *cm;
>>>> +
>>>> +    if (!msg->msg_control)
>>>> +            error(1, errno, "NULL user arg");
>>>
>>> Don't add precondition checks for code entirely under your control.
>>> This is not a user API.
>>>
>>
>> Ack.
>>
>>>> +    cm = (struct cmsghdr *)msg->msg_control;
>>>> +    cm->cmsg_len = CMSG_LEN(ZC_INFO_SIZE);
>>>> +    cm->cmsg_level = SOL_SOCKET;
>>>> +    cm->cmsg_type = SCM_ZC_NOTIFICATION;
>>>> +
>>>> +    zc_info = (struct zc_info *)CMSG_DATA(cm);
>>>> +    zc_info->size = ZC_NOTIFICATION_MAX;
>>>> +
>>>> +    added_zcopy_info = true;
>>>
>>> Just initialize every time? Is this here to reuse the same msg_control
>>> as long as metadata is returned?
>>>
>>
>> Yes, the same msg_control will be reused.
>>
>> The overall paradiagm is,
>> start:
>>     sendmsg(..)
>>     sendmsg(..)
>>     ...          sends_since_notify sendmsgs in total
>>
>>     add_zcopy_info(..)
>>     sendmsg(.., msg_control)
>>     do_recv_completions_sendmsg(..)
>>     goto start;
>>
>> if (sends_since_notify + 1 >= cfg_notification_limit), add_zcopy_info
>> will be invoked, and the right next sendmsg will have the msg_control
>> passed in.
>>
>> If (added_zcopy_info), do_recv_completions_sendmsg will be invoked,
>> and added_zcopy_info will be set to false in it.
> 
> This does not seem like it would need a global variable?
> 

Agreed, maybe I can use sends_since_notify to check whether we
need to do_recv_completions_sendmsg, then we get rid of
added_zcopy_info.


>> Btw, before I put some efforts to solve the current issues, I think
>> I should wait for comments about api change from linux-api@vger.kernel.org?
> 
> I'm not sure whether anyone on that list will give feedback.
> 
> I would continue with revisions at a normal schedule, as long as that
> stays in the Cc.

Got it, thanks

