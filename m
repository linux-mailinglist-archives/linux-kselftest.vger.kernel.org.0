Return-Path: <linux-kselftest+bounces-14669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2294517D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B55284A65
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B61A57EF;
	Thu,  1 Aug 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JAN3W923"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5911EB491
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533424; cv=none; b=reBJ2/4EWwkbqOsX9yqAifu3XqQAz3DQLFtlrBySrUf89Gv0/YHHKweU1wv3G6ThfPpbVNXDIWDkPcUw5jtvjrHhSZWpWKijraLieooOSugV8XqvsBcLVkn2fPmhoTy1c0YYFs6MRmmdKycD+fbrRnLA28hgupMgOQUNOGeE9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533424; c=relaxed/simple;
	bh=ryHDJE/zMk6NhN1Q2QnZtKviMQz9p19mlbn8j5vmlFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCP6jQFjRiJjmZHLOAbCjCcTDYclge+shl6JERpTgd5Rw82aZtGinAfFynkY/dY+wZjVNPyeey1GO5HZGabZ2yacVMwEPDtG6SoNZmlxpKlPs705xoxEY9L90S56L93Ar+XypM9plWHyvelu7tVpM+TSM59cqpCxsGZk6JbalLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JAN3W923; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093efbade6so4886356a34.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722533421; x=1723138221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cud5ON6Z+wdn9ucRa2pxh+eaG5b3fjZThpRwLwlfbc0=;
        b=JAN3W923vZFTFyaC7C9F2mGHPE/QOqEqGRcZBxEsBTrdQ2AeHBX7QztLVKa+37psIC
         SMC6Eoauv4fEye3jjWTTJ8KdyTaIWUOBOxZT48ihPdvgF4UT6AVXNmNxwHmKx0TqLYmH
         s+EIHEf+5eOvttJqkUXspeDLKjWkhpapZ6gd5/Hi8HR0JbqHnYQi7eKt6LE88Kb62pky
         mJl0eZ27l84v0unv3um70tIPO8M7WSeEQQNH3UKTy/qEplmDoP5KSfbzkNpLPtwkdEfL
         9Ot+G8onrQdSM8MfA4Moluq9REYiEeh/kPTfpzjbMkWOg7fZiTYHoWX0O6sCpJrrH7QF
         NnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533421; x=1723138221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cud5ON6Z+wdn9ucRa2pxh+eaG5b3fjZThpRwLwlfbc0=;
        b=lB1kUO31f7aDxuc3C0C78pghL5KVszuwvwJ8PY9dTORC5iJ0mFtCDEd0EcxneZuPtI
         i3qZgYCjDprHm8N6abtWn7YUGXh+1kx6z7MXcuUEhBjyxGXRyHPcqHHWlv+tsTMvuR3F
         l0Thf8dLsmx7gw1KScbklqD2MCFiePfIyS5/EsEKDky+MATTRdSJvOnN4zknZ2jkgpGY
         8BAAWjJID84TSuo2pKAVkdALQ+RRMOcXao2+AbJ6Az7fePKij3HB9TeLdDFeZu8cFr2Q
         4xde+Yv2RlQZnI4y2H/YcL1pYJqF/ALFgFYxC/qoXys39ju+3grhnLALc1NJRbASOjd1
         b9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUJKa+mnmBQ8dDe7aA98lgD2G1DMVT3E1hZQ16gBq/cBtsaneV2nJekN2DjbkvctqOJkzlnmdQp7XAGZHG/tPxHxD2N9S0Dy9vmpEVtbJUG
X-Gm-Message-State: AOJu0Yzgp5puyYUTIdIsB59mFp7EHcfsCQYDfjpiQb1v3brZDieC7ddT
	PWjrUsjcmrvSG6h64o7AGi1ywvXQV/QHn2NE74P93lgsyW6iN/PmyJk25kZYThddZ0zPQVl+etl
	Z
X-Google-Smtp-Source: AGHT+IF15SdrLT5oyL0W3ugfNAE5Tnob/mFQ95c6hqh4IrcQ5l85Cs0j1vRJZx5kruc+6a94OprNLg==
X-Received: by 2002:a05:6358:7201:b0:1aa:c49e:587d with SMTP id e5c5f4694b2df-1af3ba8abfbmr84090555d.18.1722533420887;
        Thu, 01 Aug 2024 10:30:20 -0700 (PDT)
Received: from [10.5.114.153] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb99b5c964sm689666d6.120.2024.08.01.10.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:30:20 -0700 (PDT)
Message-ID: <570fe8a0-4b93-4f3d-a4d7-34a3a61167e4@bytedance.com>
Date: Thu, 1 Aug 2024 10:30:16 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/3] selftests: add MSG_ZEROCOPY msg_control
 notification test
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 axboe@kernel.dk, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
 <20240730184120.4089835-4-zijianzhang@bytedance.com>
 <66aabb616714_21c08c29432@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <66aabb616714_21c08c29432@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 3:32 PM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,

First of all, thanks for the detailed suggestions!

> 
> Please make commit messages stand on their own. If someone does a git
> blame, make the message self explanatory. Replace "the new mechanism"
> with sendmsg SCM_ZC_NOTIFICATION.
> 
> In patch 2 or as a separate patch 4, also add a new short section on
> this API in Documentation/networking/msg_zerocopy.rst. Probably with
> the same contents as a good explanation of the feature in the commit
> message of patch 2.
> 

Agreed.

>> cfg_notification_limit has the same semantics for both methods. Test
>> results are as follows, we update skb_orphan_frags_rx to the same as
>> skb_orphan_frags to support zerocopy in the localhost test.
>>
>> cfg_notification_limit = 1, both method get notifications after 1 calling
>> of sendmsg. In this case, the new method has around 17% cpu savings in TCP
>> and 23% cpu savings in UDP.
>> +---------------------+---------+---------+---------+---------+
>> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
>> +---------------------+---------+---------+---------+---------+
>> | ZCopy (MB)          | 7523    | 7706    | 7489    | 7304    |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy (MB)      | 8834    | 8993    | 9053    | 9228    |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy / ZCopy   | 117.42% | 116.70% | 120.88% | 126.34% |
>> +---------------------+---------+---------+---------+---------+
>>
>> cfg_notification_limit = 32, both get notifications after 32 calling of
>> sendmsg, which means more chances to coalesce notifications, and less
>> overhead of poll + recvmsg for the original method. In this case, the new
>> method has around 7% cpu savings in TCP and slightly better cpu usage in
>> UDP. In the env of selftest, notifications of TCP are more likely to be
>> out of order than UDP, it's easier to coalesce more notifications in UDP.
>> The original method can get one notification with range of 32 in a recvmsg
>> most of the time. In TCP, most notifications' range is around 2, so the
>> original method needs around 16 recvmsgs to get notified in one round.
>> That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
>> +---------------------+---------+---------+---------+---------+
>> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
>> +---------------------+---------+---------+---------+---------+
>> | ZCopy (MB)          | 8842    | 8735    | 10072   | 9380    |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy (MB)      | 9366    | 9477    | 10108   | 9385    |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy / ZCopy   | 106.00% | 108.28% | 100.31% | 100.01% |
>> +---------------------+---------+---------+---------+---------+
>>
>> In conclusion, when notification interval is small or notifications are
>> hard to be coalesced, the new mechanism is highly recommended. Otherwise,
>> the performance gain from the new mechanism is very limited.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> 
>> -static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>> +static void add_zcopy_info(struct msghdr *msg)
>> +{
>> +	struct zc_info *zc_info;
>> +	struct cmsghdr *cm;
>> +
>> +	if (!msg->msg_control)
>> +		error(1, errno, "NULL user arg");
> 
> Don't add precondition checks for code entirely under your control.
> This is not a user API.
> 

Ack.

>> +	cm = (struct cmsghdr *)msg->msg_control;
>> +	cm->cmsg_len = CMSG_LEN(ZC_INFO_SIZE);
>> +	cm->cmsg_level = SOL_SOCKET;
>> +	cm->cmsg_type = SCM_ZC_NOTIFICATION;
>> +
>> +	zc_info = (struct zc_info *)CMSG_DATA(cm);
>> +	zc_info->size = ZC_NOTIFICATION_MAX;
>> +
>> +	added_zcopy_info = true;
> 
> Just initialize every time? Is this here to reuse the same msg_control
> as long as metadata is returned?
>

Yes, the same msg_control will be reused.

The overall paradiagm is,
start:
   sendmsg(..)
   sendmsg(..)
   ...          sends_since_notify sendmsgs in total

   add_zcopy_info(..)
   sendmsg(.., msg_control)
   do_recv_completions_sendmsg(..)
   goto start;

if (sends_since_notify + 1 >= cfg_notification_limit), add_zcopy_info
will be invoked, and the right next sendmsg will have the msg_control
passed in.

If (added_zcopy_info), do_recv_completions_sendmsg will be invoked,
and added_zcopy_info will be set to false in it.

>> +}
>> +
>> +static bool do_sendmsg(int fd, struct msghdr *msg,
>> +		       enum notification_type do_zerocopy, int domain)
>>   {
>>   	int ret, len, i, flags;
>>   	static uint32_t cookie;
>> @@ -200,6 +233,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>>   			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
>>   			msg->msg_control = (struct cmsghdr *)ckbuf;
>>   			add_zcopy_cookie(msg, ++cookie);
>> +		} else if (do_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
>> +			   sends_since_notify + 1 >= cfg_notification_limit) {
>> +			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
>> +			msg->msg_controllen = CMSG_SPACE(ZC_INFO_SIZE);
>> +			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
>> +			add_zcopy_info(msg);
>>   		}
>>   	}
>>   
>> @@ -218,7 +257,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>>   		if (do_zerocopy && ret)
>>   			expected_completions++;
>>   	}
>> -	if (do_zerocopy && domain == PF_RDS) {
>> +	if (msg->msg_control) {
>>   		msg->msg_control = NULL;
>>   		msg->msg_controllen = 0;
>>   	}
>> @@ -466,6 +505,44 @@ static void do_recv_completions(int fd, int domain)
>>   	sends_since_notify = 0;
>>   }
>>   
>> +static void do_recv_completions2(void)
> 
> functionname2 is very uninformative.
> 
> do_recv_completions_sendmsg or so.
> 

Ack.

>> +{
>> +	struct cmsghdr *cm = (struct cmsghdr *)zc_ckbuf;
>> +	struct zc_info *zc_info;
>> +	__u32 hi, lo, range;
>> +	__u8 zerocopy;
>> +	int i;
>> +
>> +	zc_info = (struct zc_info *)CMSG_DATA(cm);
>> +	for (i = 0; i < zc_info->size; i++) {
>> +		hi = zc_info->arr[i].hi;
>> +		lo = zc_info->arr[i].lo;
>> +		zerocopy = zc_info->arr[i].zerocopy;
>> +		range = hi - lo + 1;
>> +
>> +		if (cfg_verbose && lo != next_completion)
>> +			fprintf(stderr, "gap: %u..%u does not append to %u\n",
>> +				lo, hi, next_completion);
>> +		next_completion = hi + 1;
>> +
>> +		if (zerocopied == -1) {
>> +			zerocopied = zerocopy;
>> +		} else if (zerocopied != zerocopy) {
>> +			fprintf(stderr, "serr: inconsistent\n");
>> +			zerocopied = zerocopy;
>> +		}
>> +
>> +		completions += range;
>> +		sends_since_notify -= range;
>> +
>> +		if (cfg_verbose >= 2)
>> +			fprintf(stderr, "completed: %u (h=%u l=%u)\n",
>> +				range, hi, lo);
>> +	}
>> +
>> +	added_zcopy_info = false;
>> +}
>> +
>>   /* Wait for all remaining completions on the errqueue */
>>   static void do_recv_remaining_completions(int fd, int domain)
>>   {
>> @@ -553,11 +630,16 @@ static void do_tx(int domain, int type, int protocol)
>>   		else
>>   			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>>   
>> -		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
>> +		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE &&
>> +		    sends_since_notify >= cfg_notification_limit)
>>   			do_recv_completions(fd, domain);
>>   
>> +		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
>> +		    added_zcopy_info)
>> +			do_recv_completions2();
>> +
>>   		while (!do_poll(fd, POLLOUT)) {
>> -			if (cfg_zerocopy)
>> +			if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE)
>>   				do_recv_completions(fd, domain);
>>   		}
>>   
>> @@ -715,7 +797,7 @@ static void parse_opts(int argc, char **argv)
>>   
>>   	cfg_payload_len = max_payload_len;
>>   
>> -	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
>> +	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
>>   		switch (c) {
>>   		case '4':
>>   			if (cfg_family != PF_UNSPEC)
>> @@ -749,6 +831,9 @@ static void parse_opts(int argc, char **argv)
>>   		case 'm':
>>   			cfg_cork_mixed = true;
>>   			break;
>> +		case 'n':
>> +			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_SENDMSG;
>> +			break;
> 
> How about -Z to make clear that this is still MSG_ZEROCOPY, just with
> a different notification mechanism.
> 
> And perhaps add a testcase that exercises both this mechanism and
> existing recvmsg MSG_ERRQUEUE. As they should work in parallel and
> concurrently in a multithreaded environment.
> 

-Z is more clear, and the hybrid testcase will be helpful.

Btw, before I put some efforts to solve the current issues, I think
I should wait for comments about api change from linux-api@vger.kernel.org?

