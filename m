Return-Path: <linux-kselftest+bounces-38422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E7B1CE78
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 23:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996F83AB710
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3325227E83;
	Wed,  6 Aug 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAmtLUI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1F220F57;
	Wed,  6 Aug 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515920; cv=none; b=BNSzzpBqHRp0VZUIP3JYHVa/VwaIOCPQnmcqckuiGJVJKUs4WpyYh02Jur056Q8zLOzEiWZFl2OjsWdMocs/NW+Y93w2ICw9boI9jrhiKfOZTg/MkD3oxKQCAxF55jqnsm72tniT5+IC9sE0wtWr+z2O0lLhvDV0gQIg2+JP06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515920; c=relaxed/simple;
	bh=/giIOQzx6K5sOID8U14r2OeiCF3tDg2h/q4DxXrWByo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqfR7L8hjK/zuVO8H8KzRGo/Hm2UOlZIQR6d/z0bnymX0e3u6LnJQllWtjEUnSlTuLF1TigdG1PrfF/EiHUFLDWprJHLV1qSCGi1ziuYSKiQVra2J+RrVcChgSikmH7aJkfSaKBeYeEvkmse9qtkCHnamedo9bLaFYl+YcVTJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAmtLUI3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so566691b3a.0;
        Wed, 06 Aug 2025 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754515919; x=1755120719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4QNupblGALoqqGlWBz1ZKrdzPYMUg1WIWZepG7Tblc=;
        b=QAmtLUI3OIUw9FLj/zImrHt2EXMOc7mzUDNJZKf8a1o8mwYX4w29uar83PIkZhxyd6
         kO22OIJ6vRocjvH5Atwmmo67KyDuKW1CTd4Ln3PyV6rhrRM9aeYI7R3oDlO7H17iiB/y
         f0I4NFGv+xqru/Fxbrp2oU/r41AHtYjyEicd6LGnVtR7UgMFyHOmA5PyL/ERtW//8LCq
         Ji0egi5hUVg5Z8FFkTGwjIQ/bij7nkBSvAIDn3cOumF0QAJho9cySdmC3vLJO+y7PtNC
         09IedxFusRUlXQ9x1/hJdnU95mYEKH80d9Hj8xpnR/x4BPHD6OMjAj7GAbccenNMpCyr
         mnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754515919; x=1755120719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4QNupblGALoqqGlWBz1ZKrdzPYMUg1WIWZepG7Tblc=;
        b=lOfX1kZ0Z2iGyC6oKJLwN8ZL3/mho5T9ggVvM+Lpq0TV9D046uE+eCVw/giK28Eka1
         SFNZ0mBUV+lW8F4bC/L27AYejCpFSAMxyrT3VEaOh23HDz0r6llDs+wwxBEwx68V0OB+
         MT2enqlcAyjR90K+Mz2wEMAhjZ+a43cbgn9s0LV9MqR4FDXBgmilApcjsgcGuv6O+TYa
         lOhOR3ppaHiOmChqiFVD66M9ly2gp/pJYJ2QQFnVkggAL5BhRSBm0QoAl3LZjZceYTdW
         WZdJizrjj7gjea8WWvo1grnoIgAo0QQgxYKNhtN1LCkGheGv0+f0vZwTTgBhukcB4oww
         gqZw==
X-Forwarded-Encrypted: i=1; AJvYcCUOycUnX1i2XXgdScGfWedDsftTOmb3+DJMtl8D/yTa4QOIAnML7fICqJ8ZIkZCLo4JrFQXK9kfCP6+1XPY@vger.kernel.org, AJvYcCVAeAvc41P++I6BZK8LEWLpAjwAOIKYTwPdjTENK2ksUqwh1cres9LgUL+irsXcWcmmXgf4c2Aj0SOjQ4+oK5VT@vger.kernel.org, AJvYcCWIrr7RZxNezxQvXNqGw8fLccB4YeKSrLukVCxpTEc/bv2HwLoMtnA6e7WBNAXCc1jxlBE+fSzDxkU5d30f@vger.kernel.org, AJvYcCX8cMNsgZCHKn9u+RNZZepLBsMdMTppzBMMcM9mgeLZgV3RqAq59G3qrvrSIp3o0fvhRjk=@vger.kernel.org, AJvYcCXiZrEN3MuzfA10dagetgL6rCG6Qs+NLABUmAsI/21cfM+Vu5gJVSxKsStYFSNh/IOBUjaiKgra@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCAPTvZrjnl9flUsKaLnqahvq5D3+7CDaF/Vh4+qakzuKG5Kz
	QooAgQYzgj4EVzYjv5UuHTuM9JuARB04oNWRqLguD5rjP+XCLCBrZBg8
X-Gm-Gg: ASbGncvh4t/B384jae2p68tKmBRr40ez0/HPOUnX4aEFaJJ6cIV89hY3iCT04t+8+pZ
	piQ37fXeRrElXGy5D1dGDryolBqPfrNXuqfg3iQbOwSGCdhWOesKPl8fcfWnrFwxOSh3+mnnq7X
	d1AwmfDOUsFSpsO/ZuEMo0JPCIBNUxHn+f6jpmyqssUOfOeO1KIVaaJC0bSaQAh0oKAgSq4rPxs
	jpou+y6jKgIIoXCOOW21Ddss2jjQWOsvlROyfeX12Hfr47i1kOY3lSXJrCD4YyyUYNbOg7UMi1i
	xDcCXoTi4W6iZd5fZmG/Rs3HuwaS/7Jf+iZ///1O3EQORNo4PV1/cpc1mGoZPg2W91VMO0cZng4
	vbQzsBnm+qScUpX/U6T6Wy8/9XaTGekLEZsq620w9
X-Google-Smtp-Source: AGHT+IGL6cjVW6DkJpKi2u1d7wydoW9gDvkjjcaUvStQY9bO2NaVBu2bNe7BKLheg0BV5EpYrTDCdg==
X-Received: by 2002:a05:6a20:7fa0:b0:232:b849:b906 with SMTP id adf61e73a8af0-240312526cfmr7106360637.11.1754515918621;
        Wed, 06 Aug 2025 14:31:58 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm9477788b3a.123.2025.08.06.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:31:58 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:31:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <aJPJy+s0yhvbJK08@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <aJJ/uWhqEu1TG1Kz@devvm6216.cco0.facebook.com>
 <20250806191348.GG61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806191348.GG61519@horms.kernel.org>

On Wed, Aug 06, 2025 at 08:13:48PM +0100, Simon Horman wrote:
> On Tue, Aug 05, 2025 at 03:03:37PM -0700, Bobby Eshleman wrote:
> > On Tue, Aug 05, 2025 at 02:49:08PM -0700, Bobby Eshleman wrote:

...

> 
> Ack. But net-next is currently closed for the merge-window.
> 
> So please don't post non-RFC patches for it until it reopens,
> around the 11th August.

Got it, thanks!

