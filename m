Return-Path: <linux-kselftest+bounces-14587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FCF943903
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E40B1F230E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCF16D327;
	Wed, 31 Jul 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUcLFxJ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219945979;
	Wed, 31 Jul 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465124; cv=none; b=SU4WGkp7hxjO3Afpg3oaZmUinOfmtXS0LKEtlOdm3E5GpYPQdqmIRzI7PMVLVashKr7/eVRF//sWdf5qxScUj88ZAViQcEKwFTf3zXxt6+uwBd8TyY+hISKFVb3V7gb5KJP6Q5ZybjBc2Q1da0KTlfC9cNpq0vfg1WOStPCetOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465124; c=relaxed/simple;
	bh=uP9LI96oVM3iD2K8cCIwLRdFf7wlPafEj3mcPSGtkSY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FnRJiYs/WSvOv5PFuUUO/VBHMKtyb2dNSGg8MWCRQr/mRCzpBtAW4bkOEBjmiKiL/VPrnnt9Gzx3iBqqhQCiQKbDEWgz/grCzFNfjaABCp4yEe9iRNW7YaxMvCRAqArmWyxNLkHDcvq3moRC3yN3h7Bj8m1jbePSOBMxuudpwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUcLFxJ9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79ef72bb8c8so265803185a.2;
        Wed, 31 Jul 2024 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722465122; x=1723069922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqR1kcT2b0XyED9S/J1fSkTxPyTcsc23l+ZHHYJPirw=;
        b=CUcLFxJ9gwW2guJIHu1GIiptS7pSle+zvpBfV3EM3cfN3Sk5v17g9d/n5lPnmv08PO
         ARYx9mkYr8VSi+V56fpJSa0rbi2LnJ5N1rvW09pDXtIJyxCagGy260qWvHl+ja6RnrHV
         fiP++65PVYM0HC+7sXGQgycvaFRJjvv8z4onhpHb9CBEAI6qCZpqAvykB0w5w+tPe/W8
         n9iT3JJ50SgaNrdT5qIOPoiNPXvzBsm5zhbdH1sMV7jJkSCoRTbR+wA1Ki/0VTx5Eh6K
         m/Qg8ByVkog/vXwyWTYwpvvVpQbDkrdG1ZhHbxPSwF2B0hn4GTjpu5qJnO0gwUoBtaMQ
         HCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722465122; x=1723069922;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rqR1kcT2b0XyED9S/J1fSkTxPyTcsc23l+ZHHYJPirw=;
        b=dAbF8FHdBwSvXdefdiyEpF1nI/Z3bqpAJ5DGMOKLKG0CeMGa1e+LKmjFrTcyYzbOwM
         IGn5WPwEf7T0cPBS7lL4zOYyQ3UpJ7zKwtATBwCE3DHfyotyIjf7RhKcr95SzpqvGpXU
         tDVkg9Ahc/iPtwHkzp6S+HlPcyDDynyi648KwrdjloclE651eWZMfiQWKQwTpRalDIFp
         bjpxCcf73TNA9pDupa2ow4t1KvZ+Dk13VmU2wfrJXjsAZKGcDR7vNwKa/dotml5tE5F5
         qGFQENUGes4nsyQcWZt8dckYl4N2nzqalItpky2Hr18e39PhPoUXLhNMHCsg2VQk7iac
         ri5w==
X-Forwarded-Encrypted: i=1; AJvYcCU/mj8/zHv+EVN1a0DegyApCt0xnPN+E9nmaRFbBoWA7BoIV6gK9/rsA7aRN8aD/bX4L1fCiekNCjtq5QFcd14dfRltJaoSNI1xZ/1AaPqao0kfA+zX8xK+ouskXvw3BHpwundnUpxb
X-Gm-Message-State: AOJu0Yy/wmb/+Or65j3Pa50Rv4oFNzBln5jSmJCHJmqyL9o9mungAPul
	JwW0jlZ9q4PHkRZdh/p2FhzJhsWzeO4piYtELxwYHsCfZUFotubR
X-Google-Smtp-Source: AGHT+IEYZyQ/teFtK99yc8UGxhuf9GIllxFkws+ePMHnvNsZj9VTsBeLCOecySr0D1EvaWfjWkEnCA==
X-Received: by 2002:a05:620a:28d2:b0:79b:efe1:1222 with SMTP id af79cd13be357-7a30c6fd505mr54046685a.63.1722465121804;
        Wed, 31 Jul 2024 15:32:01 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1f247f17dsm395237785a.23.2024.07.31.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:32:01 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:32:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 almasrymina@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 axboe@kernel.dk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66aabb616714_21c08c29432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240730184120.4089835-4-zijianzhang@bytedance.com>
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
 <20240730184120.4089835-4-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v8 3/3] selftests: add MSG_ZEROCOPY msg_control
 notification test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,

Please make commit messages stand on their own. If someone does a git
blame, make the message self explanatory. Replace "the new mechanism"
with sendmsg SCM_ZC_NOTIFICATION.

In patch 2 or as a separate patch 4, also add a new short section on
this API in Documentation/networking/msg_zerocopy.rst. Probably with
the same contents as a good explanation of the feature in the commit
message of patch 2.

> cfg_notification_limit has the same semantics for both methods. Test
> results are as follows, we update skb_orphan_frags_rx to the same as
> skb_orphan_frags to support zerocopy in the localhost test.
> 
> cfg_notification_limit = 1, both method get notifications after 1 calling
> of sendmsg. In this case, the new method has around 17% cpu savings in TCP
> and 23% cpu savings in UDP.
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 7523    | 7706    | 7489    | 7304    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 8834    | 8993    | 9053    | 9228    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 117.42% | 116.70% | 120.88% | 126.34% |
> +---------------------+---------+---------+---------+---------+
> 
> cfg_notification_limit = 32, both get notifications after 32 calling of
> sendmsg, which means more chances to coalesce notifications, and less
> overhead of poll + recvmsg for the original method. In this case, the new
> method has around 7% cpu savings in TCP and slightly better cpu usage in
> UDP. In the env of selftest, notifications of TCP are more likely to be
> out of order than UDP, it's easier to coalesce more notifications in UDP.
> The original method can get one notification with range of 32 in a recvmsg
> most of the time. In TCP, most notifications' range is around 2, so the
> original method needs around 16 recvmsgs to get notified in one round.
> That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 8842    | 8735    | 10072   | 9380    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 9366    | 9477    | 10108   | 9385    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 106.00% | 108.28% | 100.31% | 100.01% |
> +---------------------+---------+---------+---------+---------+
> 
> In conclusion, when notification interval is small or notifications are
> hard to be coalesced, the new mechanism is highly recommended. Otherwise,
> the performance gain from the new mechanism is very limited.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

> -static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
> +static void add_zcopy_info(struct msghdr *msg)
> +{
> +	struct zc_info *zc_info;
> +	struct cmsghdr *cm;
> +
> +	if (!msg->msg_control)
> +		error(1, errno, "NULL user arg");

Don't add precondition checks for code entirely under your control.
This is not a user API.

> +	cm = (struct cmsghdr *)msg->msg_control;
> +	cm->cmsg_len = CMSG_LEN(ZC_INFO_SIZE);
> +	cm->cmsg_level = SOL_SOCKET;
> +	cm->cmsg_type = SCM_ZC_NOTIFICATION;
> +
> +	zc_info = (struct zc_info *)CMSG_DATA(cm);
> +	zc_info->size = ZC_NOTIFICATION_MAX;
> +
> +	added_zcopy_info = true;

Just initialize every time? Is this here to reuse the same msg_control
as long as metadata is returned?

> +}
> +
> +static bool do_sendmsg(int fd, struct msghdr *msg,
> +		       enum notification_type do_zerocopy, int domain)
>  {
>  	int ret, len, i, flags;
>  	static uint32_t cookie;
> @@ -200,6 +233,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>  			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
>  			msg->msg_control = (struct cmsghdr *)ckbuf;
>  			add_zcopy_cookie(msg, ++cookie);
> +		} else if (do_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
> +			   sends_since_notify + 1 >= cfg_notification_limit) {
> +			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
> +			msg->msg_controllen = CMSG_SPACE(ZC_INFO_SIZE);
> +			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
> +			add_zcopy_info(msg);
>  		}
>  	}
>  
> @@ -218,7 +257,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>  		if (do_zerocopy && ret)
>  			expected_completions++;
>  	}
> -	if (do_zerocopy && domain == PF_RDS) {
> +	if (msg->msg_control) {
>  		msg->msg_control = NULL;
>  		msg->msg_controllen = 0;
>  	}
> @@ -466,6 +505,44 @@ static void do_recv_completions(int fd, int domain)
>  	sends_since_notify = 0;
>  }
>  
> +static void do_recv_completions2(void)

functionname2 is very uninformative.

do_recv_completions_sendmsg or so.

> +{
> +	struct cmsghdr *cm = (struct cmsghdr *)zc_ckbuf;
> +	struct zc_info *zc_info;
> +	__u32 hi, lo, range;
> +	__u8 zerocopy;
> +	int i;
> +
> +	zc_info = (struct zc_info *)CMSG_DATA(cm);
> +	for (i = 0; i < zc_info->size; i++) {
> +		hi = zc_info->arr[i].hi;
> +		lo = zc_info->arr[i].lo;
> +		zerocopy = zc_info->arr[i].zerocopy;
> +		range = hi - lo + 1;
> +
> +		if (cfg_verbose && lo != next_completion)
> +			fprintf(stderr, "gap: %u..%u does not append to %u\n",
> +				lo, hi, next_completion);
> +		next_completion = hi + 1;
> +
> +		if (zerocopied == -1) {
> +			zerocopied = zerocopy;
> +		} else if (zerocopied != zerocopy) {
> +			fprintf(stderr, "serr: inconsistent\n");
> +			zerocopied = zerocopy;
> +		}
> +
> +		completions += range;
> +		sends_since_notify -= range;
> +
> +		if (cfg_verbose >= 2)
> +			fprintf(stderr, "completed: %u (h=%u l=%u)\n",
> +				range, hi, lo);
> +	}
> +
> +	added_zcopy_info = false;
> +}
> +
>  /* Wait for all remaining completions on the errqueue */
>  static void do_recv_remaining_completions(int fd, int domain)
>  {
> @@ -553,11 +630,16 @@ static void do_tx(int domain, int type, int protocol)
>  		else
>  			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>  
> -		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
> +		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE &&
> +		    sends_since_notify >= cfg_notification_limit)
>  			do_recv_completions(fd, domain);
>  
> +		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
> +		    added_zcopy_info)
> +			do_recv_completions2();
> +
>  		while (!do_poll(fd, POLLOUT)) {
> -			if (cfg_zerocopy)
> +			if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE)
>  				do_recv_completions(fd, domain);
>  		}
>  
> @@ -715,7 +797,7 @@ static void parse_opts(int argc, char **argv)
>  
>  	cfg_payload_len = max_payload_len;
>  
> -	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
> +	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
>  		switch (c) {
>  		case '4':
>  			if (cfg_family != PF_UNSPEC)
> @@ -749,6 +831,9 @@ static void parse_opts(int argc, char **argv)
>  		case 'm':
>  			cfg_cork_mixed = true;
>  			break;
> +		case 'n':
> +			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_SENDMSG;
> +			break;

How about -Z to make clear that this is still MSG_ZEROCOPY, just with
a different notification mechanism.

And perhaps add a testcase that exercises both this mechanism and
existing recvmsg MSG_ERRQUEUE. As they should work in parallel and
concurrently in a multithreaded environment.


