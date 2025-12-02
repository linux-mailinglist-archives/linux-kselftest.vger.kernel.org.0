Return-Path: <linux-kselftest+bounces-46871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A9C9B184
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A53A3A76A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EF3126C2;
	Tue,  2 Dec 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8DXUFcj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWqlNVfz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85119311C35
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670723; cv=none; b=GUF3FDJYj84hDZhyTaic9nGG7Wp51TN8/rzsFMRdg1Iy4I3L6QnNOo9pZnCiItrR80Dm2TutEB8BlAtZYiRKGAti4YEWE8VoZ+BwM026WS4bV1Z7ZXa3lD8DTqDGrJBYTbjCEm/volqT1DMaY8sxyaS/jOo9v3o1rmdrKKcHQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670723; c=relaxed/simple;
	bh=C4AsMPURAFZJ6fstRBG4Qg4vpP3aNkGXJBTFj94MTzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BODtWSc06LQNpkbxLclTQ/P3duT+f6peGWO1WyG8EHmSvk0l481TsuaS5uJRgq0PYKTFxG7t/KBcgNc3LOR06XXtdX7Yy6pn1as5Y2gsugzDFtD61HB6ThzvodDfyARyn8Fic3rs1sNfPRb7VgeJ+otN3mj1ZmDQU3Xar9OINno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8DXUFcj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWqlNVfz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764670720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
	b=c8DXUFcjDI27lQGB03rZ0NKoY76cnA/5QGvFtuyLXyfs8I5ykR+sgapbNB6jHV5h460yHi
	ZkXVVy0YPeISJrALJIpk/nw2xGVMMR+q8ugR/3eCnXaIDsL9wAVydGv+4/L77Z0gvXbPxm
	dsoDwFcVC6p1Bl0lVeEQbdzrYEYGoKU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-6Jna1bt1M6OT3lQSEva8tg-1; Tue, 02 Dec 2025 05:18:21 -0500
X-MC-Unique: 6Jna1bt1M6OT3lQSEva8tg-1
X-Mimecast-MFC-AGG-ID: 6Jna1bt1M6OT3lQSEva8tg_1764670701
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64203afd866so10120293d50.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764670701; x=1765275501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
        b=YWqlNVfzJ2B+5RypcZGlhYXrKy4RwJ1V7YRi9LFlH/uQgPuttuE4q21nihPcAL1d3y
         NxMsMNM0xcm/Xr7+nveTr+KUeRKozzOgI2IygnagWoH/N1afXmuzp+ENv8S0glgh07vO
         2pUxvV0Z+X5vvKpKwYglz6G42mmbo9qcc6kAdeQ7WhH7dIZfpv1DAd5DXvcny5x3G7+A
         HZse3ajvAWzv6CDjYbkSR1VLF4TFxxBIeAPOtNKLLinyjNUwEoHsfE5P9VALj24dGov8
         8ZanDs0UXrGroviMEKexh6fV5rUyz+eNC+zFQsm7CKyPj79wlPQci4SNmL22NlpGZ8zf
         0EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764670701; x=1765275501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
        b=BN+G2fWLDe0BTVtEkTxz9KMvSDaayYGGdSUK9Zfd0w1q7IlDoLQ2/8PdoPO819KhIz
         YXttD4sGuM5vqGSDhDM1gwac9DYWaOmE0fG3SmEl+j30w7gN1hF0Nqu24m3GvH/qGqHS
         xjA+wf0SEZpLhZ3qIHm8zzHOZBk6nH+1XlvjKZKaoEY+8QqRSUf2+0gJbbezE7n8uXGI
         gy1ICDyMftjlaks78wkWgHqqPIXo4kCH3rW8/GuOGpS1j2QgQ7HDKBEKikglk5l7h7S0
         eFO5adTx21HOW/vQE7/tXqPmjLXkAeKyo1LH63lK2oC4naklNNsofrsRTsho/vzdwlIn
         wiUA==
X-Forwarded-Encrypted: i=1; AJvYcCViIqxtc8KnQ6MgZf7EpgPO3D/D1SJex3JHaA8EZjc+bOMn2f8XoROxkiQhJV2LlIGaMdLamt4n5bkkOP5qfPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1N92rPuZ+kJ86ALgw0YAAH43vAS4ChseHcKaj7AIaCwGvtpN2
	UlbGbElbgafokKXHhavdnxFRGMNBEkqHBqHwfC4onKlxUHSQHJpMzJTIEi/WGCNZHPzBHDlf6lO
	URjkxBLsM/UiFf6TPwjYhqnY/iMUbUGZSZ+lwQvc2qrfks4S1DZf7aEz/Gj8W4gn7hzbl0g==
X-Gm-Gg: ASbGncuEN8WVVGUCgTWL2yKCGDVxxKpDgKEu6NMTSTMrC9FeVb0D9/U+YPUvXXW0t8a
	ay2m4hJOIbXFK7NHlKJkPwoGo//KMlH+1GudyTn5XhKmHfDN4tHKWPhSpZ0vb31Q9UXJFDx8hBG
	yBbxJdPvGM1lamu4/pdh9ZzhrM0vVfl36pvGg5ZP2cnsZiXOLLkw48CrbI3/tM75GyVKqYULzja
	XrWjVhWrehYNz1jegarhnZq4j6aY7kBZ1TTrR1AJCK7dusBCjZkNpasuB5CH5g7/sLnRpsMWyxn
	RaL6Lr22M5BhMpzXv0EKpokHt15wP2tLETXEXjjdriYKJh+obPNN2syH1/5qlG12il9hNFfK9CK
	HrMggwFJsrpxI8g==
X-Received: by 2002:a05:690e:d03:b0:641:f5bc:6959 with SMTP id 956f58d0204a3-6442f18c515mr1347944d50.42.1764670701038;
        Tue, 02 Dec 2025 02:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Y2QIm+VTnIL7mAD4ACmwgT3wSBe6KSOZFrHyLZqmktUrNUAn/hV1QCPy5jYE4S4xdld0TA==
X-Received: by 2002:a05:690e:d03:b0:641:f5bc:6959 with SMTP id 956f58d0204a3-6442f18c515mr1347929d50.42.1764670700596;
        Tue, 02 Dec 2025 02:18:20 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c089431sm6041059d50.10.2025.12.02.02.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:18:20 -0800 (PST)
Message-ID: <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
Date: Tue, 2 Dec 2025 11:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
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
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  		goto out;
>  	}
>  
> +	net = current->nsproxy->net_ns;
> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> +
> +	/* Store the mode of the namespace at the time of creation. If this
> +	 * namespace later changes from "global" to "local", we want this vsock
> +	 * to continue operating normally and not suddenly break. For that
> +	 * reason, we save the mode here and later use it when performing
> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> +	 */
> +	vsock->net_mode = vsock_net_mode(net);

I'm sorry for the very late feedback. I think that at very least the
user-space needs a way to query if the given transport is in local or
global mode, as AFAICS there is no way to tell that when socket creation
races with mode change.

Also I'm a bit uneasy with the model implemented here, as 'local' socket
may cross netns boundaris and connect to 'local' socket in other netns
(if I read correctly patch 2/12). That in turns AFAICS break the netns
isolation.

Have you considered instead a slightly different model, where the
local/global model is set in stone at netns creation time - alike what
/proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and inter-netns
connectivity is explicitly granted by the admin (I guess you will need
new transport operations for that)?

/P

[1] tcp allows using per-netns established socket lookup tables - as
opposed to the default global lookup table (even if match always takes
in account the netns obviously). The mentioned sysctl specify such
configuration for the children namespaces, if any.


