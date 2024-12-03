Return-Path: <linux-kselftest+bounces-22766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39489E29D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1EE165626
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85E1FBE88;
	Tue,  3 Dec 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/fTAeIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AD1F8AD2
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248011; cv=none; b=D0YUmy8v7qSvZYBGdBiAI9d2PiCVrT47uw4faq5YgCO0Pp6zDZUDocjnIKfDsCRsLBxG0Gj7tGWZ+bx0PkRxxMAxtcsYVt31hvKZqlXKnuTkxdp8geMUKIla3kk1k5jz+kLAG6YpTL2E17Tm7W3QVlXbWUpVq3GVZh6yj1rqih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248011; c=relaxed/simple;
	bh=50YYxZWRrgFvV7RWzGZagJmm/MIRxY3i13DlmK0l2CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctDvgibSr431LuriShOZmEIkESC989KQM+uKPzlrkdCFPYCRkrvjv6MwCTz9M5kxzLewQYzbtq7fHwGedzx5NBWJfu3iAWSE2NVJ72XHte3VN1oHY6QGObOnQXHH3a6bv2CeuMKtX9NfDORcbfHDAjRaxXP5kFH0Xuqc11wN2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/fTAeIu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733248008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSpS4mkww3n7ZfxdPyPAe92ZnrZDWXRdAxdhxgPhie0=;
	b=F/fTAeIu9y15Fvw+vZZe/j2+i3YH8I6hivYSqIVbIz6kUZrH6w5zyTsf80EH+zfccMFGgD
	0rMTomLkrtXjvUC4S/OZ8GX/5iLjEQTiM3f874zAgDZpHRMZinVT870KVb0709x9eHyJd0
	tOO5X/xhJNcINH8yKhHzUGITr7fsLv8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ZjrHsph-PH660Am54NZFkw-1; Tue, 03 Dec 2024 12:46:47 -0500
X-MC-Unique: ZjrHsph-PH660Am54NZFkw-1
X-Mimecast-MFC-AGG-ID: ZjrHsph-PH660Am54NZFkw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a0d30c06so99685e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 09:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733248006; x=1733852806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSpS4mkww3n7ZfxdPyPAe92ZnrZDWXRdAxdhxgPhie0=;
        b=RWKqbRuxhxLsj7SHVAj5SNhiXCACWJG4J0UWA6uwI3OpRIADjCRWL4gaWWCNiv7exK
         X2kVtziFIawy+xfRKEcWzU41BANtksfzqxKiqxiox7m4C3GQgl0cSqXx1JZd17j1cYYT
         OpJJ80BaldINTty9HmtDIscerMPRzYXY+54NPb78a/UN3rzZaZzniwmkcxvziXLLeUEx
         vZo8vnvw61QbCaKDU5eQ4uK7gwrzn9mgEw3qTc1tz6fJrZLsLNAeXaPUl2Wk0HpVK9yC
         here3L0uvOkFdOKsgZK+KwnQjf9tuNhP5IjtGvLiZE7wItAlCF+JV2MEIwk15ROSQnDL
         LRnw==
X-Forwarded-Encrypted: i=1; AJvYcCUyww09xzyZAHDloik5EspJnUSk6/mRD6r9aYbgYc7XsuwgOU7JMcvxn0xP17JNMvFj3pFhj0fvtNSqyC8wz20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+32+sJkL/6BNcZHQmjZ/QSIJPnTAVUhXz1hfKEfFFO1LvaLb+
	Tff7dX+vVhFRVGxTaMnAW25rU7KjWa+j+PYaG5aiLpwSMVhbnGY2cB9Y2xo98yF2bU3arrV17w2
	EraDL/oEL9bOpRto8jGlL+2SVgiGLcquOXA4S3vIkArax4B2yh4CzvHdc3rrhYs4msA==
X-Gm-Gg: ASbGncv4MYlapwU8aJRtx8KEcymV2MPrASLs0OgTzrhbgTIKnib0gfBverk+xgQ1D43
	W50usUyKyp0wzhDboUdSnHjliKu5Bl+O/hO62qfvyXFUlArHHpcjS2p2BA0C9LnlSZP4kvivEGO
	GX0jfQN0QFXSmizw+ZJeMWttDg93H7W8AgqfSOehcqGJJGF92xwjyOStgeoSzetZMciKjTVBYUJ
	NPjIq2aZdPA9CD6mjOv+o/VXRI4xjMwOF13ApGYygYAGvA5WOBGy48LBsQG6/8d3OT1ycWdbsnn
X-Received: by 2002:a05:600c:4e86:b0:434:9f90:2583 with SMTP id 5b1f17b1804b1-434afc1d39amr204882535e9.11.1733248006249;
        Tue, 03 Dec 2024 09:46:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETgA2pFZtAPaTKpdbTBMQYjJVZRs89hmZMU86qmFTgXb6S51/atTKr2YYGr045N/IDGnqPBA==
X-Received: by 2002:a05:600c:4e86:b0:434:9f90:2583 with SMTP id 5b1f17b1804b1-434afc1d39amr204882335e9.11.1733248005853;
        Tue, 03 Dec 2024 09:46:45 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e19104a0sm11552257f8f.32.2024.12.03.09.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 09:46:45 -0800 (PST)
Message-ID: <c6ec324f-dcfe-46c0-8bfb-1af77c03cb59@redhat.com>
Date: Tue, 3 Dec 2024 18:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-17-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-17-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
> +/**
> + * ovpn_nl_peer_modify - modify the peer attributes according to the incoming msg
> + * @peer: the peer to modify
> + * @info: generic netlink info from the user request
> + * @attrs: the attributes from the user request
> + *
> + * Return: a negative error code in case of failure, 0 on success or 1 on
> + *	   success and the VPN IPs have been modified (requires rehashing in MP
> + *	   mode)
> + */
> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
> +			       struct nlattr **attrs)
> +{
> +	struct sockaddr_storage ss = {};
> +	u32 sockfd, interv, timeout;
> +	struct socket *sock = NULL;
> +	u8 *local_ip = NULL;
> +	bool rehash = false;
> +	int ret;
> +
> +	if (attrs[OVPN_A_PEER_SOCKET]) {
> +		if (peer->sock) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "peer socket can't be modified");
> +			return -EINVAL;
> +		}
> +
> +		/* lookup the fd in the kernel table and extract the socket
> +		 * object
> +		 */
> +		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
> +		/* sockfd_lookup() increases sock's refcounter */
> +		sock = sockfd_lookup(sockfd, &ret);
> +		if (!sock) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "cannot lookup peer socket (fd=%u): %d",
> +					       sockfd, ret);
> +			return -ENOTSOCK;
> +		}
> +
> +		/* Only when using UDP as transport protocol the remote endpoint
> +		 * can be configured so that ovpn knows where to send packets
> +		 * to.
> +		 *
> +		 * In case of TCP, the socket is connected to the peer and ovpn
> +		 * will just send bytes over it, without the need to specify a
> +		 * destination.
> +		 */
> +		if (sock->sk->sk_protocol != IPPROTO_UDP &&
> +		    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
> +		     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "unexpected remote IP address for non UDP socket");
> +			sockfd_put(sock);
> +			return -EINVAL;
> +		}
> +
> +		peer->sock = ovpn_socket_new(sock, peer);
> +		if (IS_ERR(peer->sock)) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "cannot encapsulate socket: %ld",
> +					       PTR_ERR(peer->sock));
> +			sockfd_put(sock);
> +			peer->sock = NULL;

This looks race-prone. If any other CPU can do concurrent read access to
peer->sock it could observe an invalid pointer
Even if such race does not exist, it would be cleaner store
ovpn_socket_new() return value in a local variable and set peer->sock
only on successful creation.

/P


