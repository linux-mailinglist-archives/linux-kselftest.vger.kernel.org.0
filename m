Return-Path: <linux-kselftest+bounces-34185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED9BACBDA1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7552F3A401D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E92036FA;
	Mon,  2 Jun 2025 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfw3+feS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7D1FF1A6
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905728; cv=none; b=SK7jjzn7TzKEgH+s5ZO8+Dec153kEDRQMT8izfHbTtkSTsQ5eVba6k2+2ikTmzy1n7bM7Zl3Skbw+SHkYEw+yVwUkqFLg1Rz5zAp8IZmDyzzOzqpSH9K3HUP5qmqfutv9FAzNNzngxKG7asbhvAeWg3CX9J7AtCQqVvtNzRNBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905728; c=relaxed/simple;
	bh=y7CK+CHQ4DIFwaUvhwVJaZwpnA7dYLCzJMncn8f3CIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2rFbH4G6QFwkIO/36XoRXw6lx3Bewr5yQBxwBoTiolNDWhPmGQiV86iCLwKPMnCuWObAuNW0LzaoNsTnn8kIorUufALUd7yu/pzMWOzy5KmjLyDq8tQ8dhBXBvDox6WAXFvmF7r1h4SXqxTNHdyfBQQ+erBsg1buuUHB1DIVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfw3+feS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748905725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iW7eQbhNtrqZPgemUDJnWAZIpC6bLn6AnaOnx0AQ+H8=;
	b=dfw3+feSP85+zyng+xBHX0mT+vzNjVsw90HqWOzVBw587VlmmDsi+0q14MtiSS+dM+sS2U
	H0D9TzqDtYD1qyfpSWcl+wp/T5X0qZK717HwyNNBmHVIgj9Mxpgqm0DDha9Pf1zDjeldlb
	ec6KNwGbjLCDdPJiBMmDKhtS7x7s4eI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-Igg9FjHOM1CHxYgL-Fs9iw-1; Mon, 02 Jun 2025 19:08:44 -0400
X-MC-Unique: Igg9FjHOM1CHxYgL-Fs9iw-1
X-Mimecast-MFC-AGG-ID: Igg9FjHOM1CHxYgL-Fs9iw_1748905724
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cf7803786so25048439f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 16:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748905723; x=1749510523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iW7eQbhNtrqZPgemUDJnWAZIpC6bLn6AnaOnx0AQ+H8=;
        b=XbdgBTV0sC0+7403kQ9LhZ4Xw6UDaT7Z7ehn+jtPBnsnXmr3yLWDBR7dK8jYmiiR7c
         HZ5TdSSQex7V+Ry4yZ0nB8WxXqToLUH2egK8eXuzi6gkw3QzN+Gar7SBu6SsE2prKCo4
         6T/Bw7lk4wwFphymaTFhQciUQJ2UENbCb+QCRBIy9HitHCjd2ri6huI/++gQ8Xl8AAn+
         X2/ZN45OB/D7gMJ3EXaoYuI8No7snz0AgtC1Uv4gubJgvQUzEUhds2Oo3ESDnxWpemIb
         e9l0US71sqAmAq5s8xB0FVnkTQLnQzzVWvkuCpDYuT/9PlIf67QLuk2gsxAIXFK3vL4G
         ncdg==
X-Forwarded-Encrypted: i=1; AJvYcCW+hNRP/zNQiz4oYKSzTQfUPZXZSzVz/AlXbJiIG9vfZyxflnnpsq0UhRqLyLc0ID+z3PNQOJIhPK32bo/MQFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMyrTebHuyZ4CT6ds3HXpmJAQmX6FgnMUSPosjcdnL+SDUG1+
	i4msHwSAgApjxGdKlobpC52s8cXQspPT+SRGTiJQjCuNWZS90a+RRWtnyniLxc95gqpktM2A9ui
	vOB4KRzGRLSA4LL1LRDa2Nn+kWlXkvOU2K9oFArUxBiaMqjZ2pxSyw3cjU0jA5PNJlwJOuQ==
X-Gm-Gg: ASbGncuj4xBERZiv60HdUBMktnpzwetPADilP3L7zKwk21DrL/8CNxRZ6S3hqtaCab6
	tsn5CNxA4vKbYk7909v/WYtQQap13fz0qKsARgAuWYrFVT+CF5/SmZuoZxLxKArLToDwynhRh6N
	32617qGHXh/okniYxaXb7VGbBvRQtRPVyYum03ReVZcNjaLl+W1859KqBKqdj+qIKu25xmjGjyo
	0mC0XXtweHOjfhSTmEIkf8WMuZlEaHIjybA23bj13/NFAn/l0fd0u3d0Ln1jLvcuAoYCB7BgXcx
	L+YOubbk0mjDwoE=
X-Received: by 2002:a05:6e02:104e:b0:3dd:b4b5:5c8a with SMTP id e9e14a558f8ab-3ddb4b55d51mr8685985ab.6.1748905723647;
        Mon, 02 Jun 2025 16:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGvUb6ER8Q4QD7RqCJtOiVCn3ySFqrXy3Hx1BKfIFFt0szxNE8YsrkqbCvLqmMnmnDTAvuqw==
X-Received: by 2002:a05:6e02:104e:b0:3dd:b4b5:5c8a with SMTP id e9e14a558f8ab-3ddb4b55d51mr8685645ab.6.1748905723308;
        Mon, 02 Jun 2025 16:08:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935a7aa4sm24182885ab.71.2025.06.02.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 16:08:41 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:08:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, Sean
 Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger
 <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, Jason Gunthorpe
 <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma
 <vipinsh@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 04/33] vfio: selftests: Test basic VFIO and IOMMUFD
 integration
Message-ID: <20250602170839.4fe2a914.alex.williamson@redhat.com>
In-Reply-To: <20250523233018.1702151-5-dmatlack@google.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
	<20250523233018.1702151-5-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 23:29:49 +0000
David Matlack <dmatlack@google.com> wrote:
> +int main(int argc, char *argv[])
> +{
> +	char *bdf;
> +
> +	if (argc != 2) {
> +		printf("Usage: %s bus:device:function\n", argv[0]);

segment:bus:device.function?

> +		return 1;

1 or KSFT_FAIL?  Thanks,

Alex

> +	}
> +
> +	bdf = argv[1];
> +	set_cdev_path(bdf);
> +	printf("Using cdev device %s\n", cdev_path);
> +
> +	return test_harness_run(1, argv);
> +}


