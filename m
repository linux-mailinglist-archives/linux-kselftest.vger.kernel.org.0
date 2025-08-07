Return-Path: <linux-kselftest+bounces-38527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DAB1DE46
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B76AA00608
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B03FE7;
	Thu,  7 Aug 2025 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF42lLdF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BA273D8F;
	Thu,  7 Aug 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598280; cv=none; b=k1GRMSurH2vEx5N0qesjA88iT5RzmEHK4IN82Iodf0a5bG7rMCb40qSFUcN/U9BP9wm2GfMVl49IlxDm8LPRELJysxlotQgXtL9a740THT1DMYuQ39vxJzus2MBOE/fLh7zqUkglSdpDdmHB8mqkHJIFFt6s2zDAKv3VkDZqxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598280; c=relaxed/simple;
	bh=B5dHpd9/2CVBm2hMcIJ9Lj/mYxIYk3/xJor8Q45KyBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Jtbjpw3htle9yY4Us2A91efKrLa9uMtj8KZrUhDDb+Pbo+MctI3puYQgqmZsObZsJblLo8GXW9o8gIQMB1TWR7xgnYLEmb+rBc6WG5BiNpvn2Ceg411rMp+CGg89Te5H3pw0lrGlfej1nAhIT0a9z419fYXW0Z/PyIUJ7JLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF42lLdF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so942765a12.1;
        Thu, 07 Aug 2025 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754598277; x=1755203077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3RlVskhZ/9tPsfsfYQZQqqA9goXX/0nRbKP1avcqUY=;
        b=WF42lLdFFXBnMOmrIx83598mH1dTuKqr1JVcrbP/gzUIXcmcPClFeaA5SFVUfY8fXq
         Qloiw4wadDKlk74kqI9+YLmQIua/7Qfeg8EORNSVElRrp4I4uwUhdp6JMlm4XYTJWn8a
         zx+vRXpO0hpMGfVZ/+ZTC6AUOzdMOxn80uzA1j1P6fyeRKCVwJzID/Jyyc5Dbj6+6Q1C
         LMUm4zzPgOD5fhOizynvu6Aj9jeMPeXyGvgzsMJhOG1o1/UDvGg1NlPnsnDmWS1P+em2
         SFofl9rflhPUCNb5K4wSyV8qfg36qJ3ZJ6l/vkctT3YJSUtiqMiCt6rfwsdUgteRQmam
         a1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754598277; x=1755203077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3RlVskhZ/9tPsfsfYQZQqqA9goXX/0nRbKP1avcqUY=;
        b=A5MLMpKea300OZFQrRO8JuBdLEyGrOJIfNCgTX7aU4YJb0Wl0SoplwoYzUyOg+j6IT
         I7vDR9Z4tK8+AzyyTU4DbCD4A7hj4JabSJqW4uOkYJlPIfJ3bOfzTaQEayvDj0mroYsY
         jDcpaB1zlsa//u04hZwwfk7tJn3rGo8deGlP1DWtF7ORZdIAEkuHCVXGGBmk0qZJ/eGz
         HZKzdF0DwXCAAzU3Wi7PJVZdREzPsjXtcshwVVhDKkASERNm0EB+hnHJWwlxqoEN25qi
         DmpfA0znArE8wagOnNlgG/hp0mKrcmQpgoS5ozLajLyIFNkPlbQbNk/Aw0idsBJHvPqC
         8Ddg==
X-Forwarded-Encrypted: i=1; AJvYcCUxZM2CmgsYqWpdwLSSqnAJ2LSHKdVUVnG5PJjTo/W7fly+xmIGNjH8qrXKN55kHYDVcTw=@vger.kernel.org, AJvYcCVSL9+0/mht/fNRPeKhHDP2Q3+4mntIgV2rrjuKGLzFfIj23dAaVhfHLmdwrEN5eIclvaZO/ngmP+kb2Vvb@vger.kernel.org, AJvYcCVeolL8Fl4bLfWt1KbZKNS93r6LjVDi55hr7cy3iYurOuYJGFsCf9YvDM5pExF2ljp+rFszuAgn/ioIayAG@vger.kernel.org, AJvYcCXSyVUc1/qSWQhRzHGENifxnrrR+Q3+sHFw3/PcJTdLktjXwDHQm+3sH7uZPxolL0XH1uE1knWBy4yJgVd26VHF@vger.kernel.org, AJvYcCXnhr6tvpKDM9ZYTWcerptT7eHKZY9l0pnigy1a8TjgZAD5d0Qwmolm2OlGzz7fg0vk4EEYEmOz@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNC+2N7qi9S3x6oYj0Hjw0CbKLllpTzTFhR79ztTEASfyXcW8
	wgqe71f+CqUu6ktD/cXI13BD1JAd/HIrH9+4AS7oOUxU3ym8uIxwO4b9
X-Gm-Gg: ASbGncupTcu4ezwob0fPi5VB20lamIjrZC92LTqS8V1gTyDkl8gTWzjfsHk6Bu0gE3s
	B+hKiecugP5LypGQBW0hg9s+Ag5h4scxthnfNuRrsjQt8twg9K4y9IWT2XXSA3yEmmynLEK7yEU
	ZCEWNHV/Iay6daR1FDRgzmDx80ndzevNqvXAr1ixXLxp/9VV5WXOQH8MEdzREH5+BQq3B1yN76D
	gNdt6+dvKQ0TVMg63ltvr+Z2kBjTBUsGmHsKors3r/onN4Wqm1/oAxcVXMWA5VR7yrXX5tjnBje
	iEVR05YuDzK8bJ6o9iZIgnN8yy6vapNm7cz3BjWotRqhB5WBJG8LfRWq3O5sMqyGwbEyhAyq1qS
	l8RbSADFD0b8yGvb00due9rQyDSiEgarTWHoe8Lv2+HU=
X-Google-Smtp-Source: AGHT+IF/VWh5TM2qquaqzYZqHo8a91a/584HOmbew0G6ouHaU7Evm8NtOh9ULhmHs70qMUCw7xImDg==
X-Received: by 2002:a17:903:2310:b0:234:d431:ec6e with SMTP id d9443c01a7336-242c1ffcf60mr4675265ad.3.1754598276994;
        Thu, 07 Aug 2025 13:24:36 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaadadsm193768745ad.156.2025.08.07.13.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 13:24:36 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:24:34 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <aJULgjM8r+d+bKpM@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <27a6zuc6wwuixgozhkxxd2bmpiegiat4bkwghvjz6y3wugtjqm@az7j7et7hzpq>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a6zuc6wwuixgozhkxxd2bmpiegiat4bkwghvjz6y3wugtjqm@az7j7et7hzpq>

On Thu, Aug 07, 2025 at 10:06:35AM +0200, Stefano Garzarella wrote:
> Hi Bobby,
> 

...

> 
> Thanks for your work!
> 
> As I mentioned to you, I'll be off for the next 2 weeks, so I'll take a look
> when I'm back, but feel free to send new versions if you receive enough
> comments on this.
> 
> Thanks,
> Stefano
> 

Thanks Stefano, enjoy your time off!

Best,
Bobby

