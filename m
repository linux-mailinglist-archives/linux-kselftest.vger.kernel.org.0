Return-Path: <linux-kselftest+bounces-41198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90253B5216D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E703565167
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7B2DA77F;
	Wed, 10 Sep 2025 19:50:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15972BEC22;
	Wed, 10 Sep 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533813; cv=none; b=KOD11E1Ap034MS5CVD3QpZhAzwZFCJykLxkvBkqHuC8tSFNZQd8v1uT/346zh5wAXTslkPzbDOHXb3XE8Arf5eR7LTr/m0zlzZ3vn6/t2aqQq428aO5jP+v0W0JdALKBiit1rip8YOiPcb0PaksrXsro0Mt4CyJNLZe+jruGCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533813; c=relaxed/simple;
	bh=xIAY72bgHqedx7KpiGA2HRGFP6jRa8faDFGLEFK5InY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUadHWzMOklvdPU4PEDDpUm77KK2VEND8dyQNkY1Mlco9ZA8/b+H2mFOgxn/4guEzKVqcmEXidCN4o011AYBvbs4zBkqwQLiRovo7PZfaeg1d5RMPaciI6dYl94bW7FOXYECkCRTmGK6y2WXJKCcuRpx0aq0oh4APu8mZO9ZvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso9397023a12.2;
        Wed, 10 Sep 2025 12:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757533810; x=1758138610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3vKBqm7pcURd9tESfGhz9oqMQFvcRFDT4FLheRG4z8=;
        b=CLW5DP6WX5sVZl2JHZKt+KPdW+d0k2Twqzq/UVeXB1oITWX1YAI6P/e/yJf2W6u4sh
         jlouv2a3tTpqkgscEZgnBuwZiyE+zdv0ToTel51XY0rxU+4jiGqFsIGI87olJN4jKBZz
         1x+z+XvQA92MWrWps9tmNcCXxM2EXmoMwCGXtWijq1wf4VoEI60awnxNrdsg9TjRAw3Y
         2rzjNrlGp173ld/z0Kr0xLVp384fChp67BFiiEqNvYqGNwXWJ1bEsS7ya/oE3AhN8ZdR
         veEn5jLFPBliewPDmgIul+ahDPcIdM7E0vCWSIlzDWNDBhe2LSnFOq2QCUpMhSRYaQWk
         lKtA==
X-Forwarded-Encrypted: i=1; AJvYcCXF2k7x+sssxbvYayoDYJ6/XF3VhZlkhyacYVALYwtjQEH1dEGHUZ5QPr1qVXhN+eu2tmgzk3KR@vger.kernel.org, AJvYcCXlftT0DS2mFeLsNARy4B8oqy8uHOFVmBfC3EV2haKDOUi4aQcSbht+Cpq5OcENJnISf5Q9mMmj6lpexaNarqMF@vger.kernel.org, AJvYcCXvwMFkGgsKGdvf1qdUxTERRjmQIJTdmbbLM1pKA3j+kcFnfG6HxlIs4xu6Dpj9YWcn7O69qe4WqWvcQ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEaG5IkqTot7SuKju/Knt5aM72wcpvCXI1up9ef1a2bHcaUQT
	DBv9QPQ82HXB6NROgvxVS+POpg4bbLh+h81xvPO0oDbJjSMGkr652/yL
X-Gm-Gg: ASbGncu9YSgyimA+dKlVF1WP0Frl57MicJO2fpng5IRwp6zA0aHaC/OjLdiw59kEQB1
	dvcjvpBpYLKU6crnJxZ1a+oKzU8UyGtiFtXiH04YGgscERqq8IMvDPPghtoXSDoVsvCwNyXJaq8
	MLOkk+er79J1Cmy+UWdrS3l+JLAjBcRJjNtDLafEEG7nV9ToBDNisbiaJZnaV8SJfgKyBj7zJye
	f7PVkeiXBw2ceLqtnkpWosr69s6z0YfDqza0I7B8lxEoPCHcIuVXt5NKBENTYS+fBSDx3itm9hN
	Ho4CLl9XW7kuJwbT9ID1m6Y5iK9X4h9ngAygEJxMEvBJvK0DQD5rJ7g+WzKHrp1Gu5N055Gg1hQ
	634oIFoSqeowYVQ==
X-Google-Smtp-Source: AGHT+IGyd4L2N7RvfgT7mOfLY0LSrY8XFeQA34NCoewWsMqzDEFYmV/9i4JN4sTJTkdkS5Ypph5pwQ==
X-Received: by 2002:a17:907:7290:b0:b04:6338:c936 with SMTP id a640c23a62f3a-b04b1408070mr1729829666b.17.1757533809986;
        Wed, 10 Sep 2025 12:50:09 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830479a7sm225242366b.16.2025.09.10.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:50:09 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:50:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] netconsole: resume previously deactivated
 target
Message-ID: <jcvsmfivr27bchhk2t2lt2l35ixjs2adaos6hqwfydpulq7gxm@5aprxim4vvoa>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
 <20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com>

On Tue, Sep 09, 2025 at 10:12:15PM +0100, Andre Carvalho wrote:
> @@ -1460,6 +1493,10 @@ static int netconsole_netdev_event(struct notifier_block *this,
>  				stopped = true;
>  			}
>  		}
> +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP)  {
> +			if (!strncmp(nt->np.dev_name, dev->name, IFNAMSIZ))

Don't you need to check for dev_mac here as well?

> +				schedule_work(&nt->resume_wq);

I would prefer to have the enablement done inline here, instead of
scheduling a task.

It will be safer, given no one else is traversing the list and
accessing the element, given you have the target_list_lock in
netconsole_netdev_event, but, you don't have it in the resume_wq.

Given that we don't have a lock per target, target_list_lock is the
current lock protecting any simultaneous modification to the targets.

