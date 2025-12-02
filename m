Return-Path: <linux-kselftest+bounces-46913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F5C9CF33
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 21:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 510354E3DE5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2A2F746C;
	Tue,  2 Dec 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuoYd4Yj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVhKjiNp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177882DC79E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708449; cv=none; b=LE7/U8f4mSqJ7cMCZ3vR88C6rq5OFxtzoL42bwmjaum7zyLSVNdv3rFyypd/jDL3hhk+4/QxOjU6d+KSrn3updSq/DszFh1LrQv4NI0Vmj8A0TgNFVBmkWXFNw1J3e6hLVvfr4piyVM+lEVYTsZbzcMB1u+NE5jZjhHtcL0KzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708449; c=relaxed/simple;
	bh=UM18VZ97rudmnPHbViAf5T/QAoYaIPRYtTn8w10RmJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAIX6gut3lCeFo93v9gMm25dsnPokIXkKE3AyMZtOEvtS4S/Orj4vUbrVizqHH8eDvRKl49wIyw4YhGmDQbFkf3ulA1Lshv8/pA6kWeoStE9wFnjSvqjOPpbSmDhb2BUDaVBUfBdl1ycuvphePpTH9UBxd1n07q2SmEk0MVbHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuoYd4Yj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVhKjiNp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764708447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93E6zWcOFHYDryuio97v2YbtHjZdnUdD9zTGmSSfbUU=;
	b=QuoYd4Yj6Lw4ODkFVPGAstJzq6XOlRf75aNJD84lK8Kd+KEGHq0XMU027Tvi+KFts2IShU
	Zu1u7J0JrRtFtUPzDrR9Sq1T1Jp0dKg6m8SlbLNyaDUX8YdIYNzIEYkVx2zxAQlmfWOFZx
	dO2m9AzS5gjF/eA/8BTsnhfwRFFP22k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-lJ0AIqlCMG6aPki2dlrZ5Q-1; Tue, 02 Dec 2025 15:47:23 -0500
X-MC-Unique: lJ0AIqlCMG6aPki2dlrZ5Q-1
X-Mimecast-MFC-AGG-ID: lJ0AIqlCMG6aPki2dlrZ5Q_1764708442
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477964c22e0so1348595e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 12:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764708442; x=1765313242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93E6zWcOFHYDryuio97v2YbtHjZdnUdD9zTGmSSfbUU=;
        b=aVhKjiNpcNVENSUPVrQNNZ1Ue/iQhIGTiBek9sS6yJYEqJCCkUrRrIqKcKIh+fm+ag
         2/jK+rl+4e/psvGyEVkQ4V3VbEkwASukpZLraRcaRabgpvVFmPL4DlUAVrjroQncpHFO
         wdk1p40p/JkVjrST4xp74VLVKSIDJOPvEb+H/f90A4H4gYJhXOw2xnLhIZWXGkiAQQha
         uBziC3LsRd7Bdtl4xtBuH0fhDl1Iac0/Hv9+u4jJc3P2csK8wdw9QNypHRIEYKPx/U3r
         6sLY7DApznGIgrY9sSg0xwUScDocIc7///oPEzB/fqTuBrERTFf5Fb1NknFcMlk4xEPR
         +DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708442; x=1765313242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93E6zWcOFHYDryuio97v2YbtHjZdnUdD9zTGmSSfbUU=;
        b=PYAn0HTCD+OVI8B7wZxPopNRimZRLlKQEWuoCFddwnwDCmbHFA2bpyJCPJKWLmn2zY
         c8+Fr+gjaFTMLMJKyPpRBbXLAdcxCSIgzW+lCYsbP1we9T6q99zSgSn2sdhu4hwvWPip
         W+5o+0Y3CHjH+8Iz84cOs3fkdZWQtMqLBKP+rNCk7zhwMD6GD4/AwD3GMMZnU6m9zYNf
         GSWPgkwy1pwmimlLraw4xF+9INgU2ICYb+yh4pDx7MQghusQQ9adUJ3qG1YWaDkJFFq7
         Tq9i4mm62e68Ul0BwAW5j1uhZU6H/M/XYp3LU9UvvR9W88yrvk8HWnzXqiSdzu9/Iopl
         ChQw==
X-Forwarded-Encrypted: i=1; AJvYcCUUknuSmhX7tdY2jLzJNq2jt06GnS2xKQe6yMWJz6p0mQxs44m4sjxjlAy66RthejTdaerVJ7jOcMaSrn29LmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjP9617WfjFivUwrSLWfnWcV4QrliO1zYEd7YeQGNn8bg7jeRr
	k8N4Td7936OI5jZEwRkmIi1D35CwaP0xM100tDqY+o6Ba2LxpkWjqooRXxQcYywDFdVnUQfjX5G
	qjjDvzwDyNXTYn7NK8bjUpQ043ZkHjD/yWCMeQwOEaioOk3x5e8yAoEzAogyL/9cKD5CgzA==
X-Gm-Gg: ASbGncvKe2EeTLhTr3pZ42XlXWGlbeW//+SUYjpoUg+uDdqWjld7q8EP14i9236z2u7
	FLI11O2iE8aHDDgki8ECkSpSOG6h/NT+sHVKxeG0dSHEAUzeLQyuQBr2kkvqv7BwBEO5TzoKiPW
	iO8Bp1brG6OqroM9yMnDmmoJ6YKQPGDmQmEj8uZgG0ZL8difqQMgNCfckyxGHeFTSGQARqgjCUp
	fuhefq3U5J4K9QUjir3m5ak2yv/ku0WijpNIHfQ+q6DHO1mCRX6v9RY8AyQioDGJnSEwuBI9VHw
	DvIFo05SIhhv7okef8jQ1EHI6IaZAEmYiYMerZaV3EZxwpEjIF73yFxMfaxYiqmp8nHK7259Kq7
	HTPssD0ejq3Cqew==
X-Received: by 2002:a05:600c:4507:b0:479:2a78:4a2e with SMTP id 5b1f17b1804b1-4792aeefe08mr67265e9.7.1764708442363;
        Tue, 02 Dec 2025 12:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtz/lzVuD567rALCwx3x7VkFHPvswA+h4sGnpysQXizUNAK/zCsPREdKaY3F5ZICBkIIzs/w==
X-Received: by 2002:a05:600c:4507:b0:479:2a78:4a2e with SMTP id 5b1f17b1804b1-4792aeefe08mr66825e9.7.1764708441897;
        Tue, 02 Dec 2025 12:47:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a7971c7sm8502095e9.2.2025.12.02.12.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 12:47:21 -0800 (PST)
Message-ID: <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
Date: Tue, 2 Dec 2025 21:47:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
>> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
>>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>>>  		goto out;
>>>  	}
>>>  
>>> +	net = current->nsproxy->net_ns;
>>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>>> +
>>> +	/* Store the mode of the namespace at the time of creation. If this
>>> +	 * namespace later changes from "global" to "local", we want this vsock
>>> +	 * to continue operating normally and not suddenly break. For that
>>> +	 * reason, we save the mode here and later use it when performing
>>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
>>> +	 */
>>> +	vsock->net_mode = vsock_net_mode(net);
>>
>> I'm sorry for the very late feedback. I think that at very least the
>> user-space needs a way to query if the given transport is in local or
>> global mode, as AFAICS there is no way to tell that when socket creation
>> races with mode change.
> 
> Are you thinking something along the lines of sockopt?

I'd like to see a way for the user-space to query the socket 'namespace
mode'.

sockopt could be an option; a possibly better one could be sock_diag. Or
you could do both using dumping the info with a shared helper invoked by
both code paths, alike what TCP is doing.
>> Also I'm a bit uneasy with the model implemented here, as 'local' socket
>> may cross netns boundaris and connect to 'local' socket in other netns
>> (if I read correctly patch 2/12). That in turns AFAICS break the netns
>> isolation.
> 
> Local mode sockets are unable to communicate with local mode (and global
> mode too) sockets that are in other namespaces. The key piece of code
> for that is vsock_net_check_mode(), where if either modes is local the
> namespaces must be the same.

Sorry, I likely misread the large comment in patch 2:

https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/

>> Have you considered instead a slightly different model, where the
>> local/global model is set in stone at netns creation time - alike what
>> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
>> inter-netns connectivity is explicitly granted by the admin (I guess
>> you will need new transport operations for that)?
>>
>> /P
>>
>> [1] tcp allows using per-netns established socket lookup tables - as
>> opposed to the default global lookup table (even if match always takes
>> in account the netns obviously). The mentioned sysctl specify such
>> configuration for the children namespaces, if any.
> 
> I'll save this discussion if the above doesn't resolve your concerns.
I still have some concern WRT the dynamic mode change after netns
creation. I fear some 'unsolvable' (or very hard to solve) race I can't
see now. A tcp_child_ehash_entries-like model will avoid completely the
issue, but I understand it would be a significant change over the
current status.

"Luckily" the merge window is on us and we have some time to discuss. Do
you have a specific use-case for the ability to change the netns mode
after creation?

/P


