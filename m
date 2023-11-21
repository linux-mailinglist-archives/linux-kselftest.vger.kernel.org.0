Return-Path: <linux-kselftest+bounces-366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D27F26A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 08:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3032282A0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 07:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39636B0F;
	Tue, 21 Nov 2023 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoEXrYmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C83116
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 23:47:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso19967495e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 23:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700552868; x=1701157668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1Y57R3L0HcMhbg8KOSSlooP9Ta78IZFzYPPiGoMQM8=;
        b=WoEXrYmTOCuaf6fQP2MS3rLn0xC8In8RcUy376BoNX7OoJhhha/gq397UppnvXY0DW
         8gjGzKsQvoc21JTUEL3triPQ0dt96FVsbYewRHdmR5mi/z+YEPp1aASWh2C0j497BM8T
         N5pDB9ag9sbyLX5Ei7niXFl7zrHjbLUn8mOq6IaY471PdhbxYScWwFLiQmSYK+CmWmiF
         8PCsyhFr0t40mB2q77I3mktwROXOGCiQPnKlSpLtz6eMG8/w46vcw9oOvFwRs7+YeBJn
         Rol/DyzLpwGlArxk7VJ+VzjFZWsziqSUnlPuXaIsVdflpRI9T1nghlDyPBYxtznVUgfL
         P1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552868; x=1701157668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1Y57R3L0HcMhbg8KOSSlooP9Ta78IZFzYPPiGoMQM8=;
        b=e+fnqUwl/TMZqMiMnQaQ4k4OpEDVpQ7d8V7xfwvWjeqtzqU2KdTzQR0AsdE3OljuMX
         OuQR2ZeWI1Ts1Dg/inE0Xb7ua4j8uGclH3t8pxd0b6W7qUd+exT1mZvSXUeb68W4+jOH
         xbHnLC/jlhyxy6SeAoMFZwGQtrqaSw3REv4zJLdwHP7vWOal3pVywpFsHCDvAMQjFPP7
         VGyaioI0qqFYl32zRBsKjzYMP0r2HzIIT5k5KwW+g2J54fx6hbyf6H+//buKXVfadcB1
         IuANU9LJs911IE9s3599e8q5lGYXQDAYKkEiHQmXC1i3m9sSK92N0zANrKuS3WPoYfwy
         cxCQ==
X-Gm-Message-State: AOJu0Yz5L7jY72vBO9z8iB8Fm4xcbaBIbDn2Lgdrl0ys15fXQFjHMQQa
	oALvrXlRCigm11fLq22pDIhoYA==
X-Google-Smtp-Source: AGHT+IH4wwV1/n3G3r43AoKA8JC1M2MY5Nd1HmsDJfGHfBNRI/Jxb2nv4O1DIdpdiedpMdwWvkGfcg==
X-Received: by 2002:a05:600c:4f55:b0:402:f55c:faee with SMTP id m21-20020a05600c4f5500b00402f55cfaeemr7478517wmq.26.1700552868351;
        Mon, 20 Nov 2023 23:47:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003fbe4cecc3bsm19975709wmk.16.2023.11.20.23.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:47:48 -0800 (PST)
Date: Tue, 21 Nov 2023 02:47:44 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: kernel-janitors@vger.kernel.org, mathieu.desnoyers@efficios.com,
	ivan.orlov0322@gmail.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] selftests/media_tests: fix a resource leak
Message-ID: <71465605-7179-4281-8ec8-80f741e78038@suswa.mountain>
References: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
 <20231121025918.2570-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121025918.2570-1-zhujun2@cmss.chinamobile.com>

On Mon, Nov 20, 2023 at 06:59:18PM -0800, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/media_tests/media_device_open.c | 3 +++
>  tools/testing/selftests/media_tests/media_device_test.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
> index 93183a37b133..2dfb2a11b148 100644
> --- a/tools/testing/selftests/media_tests/media_device_open.c
> +++ b/tools/testing/selftests/media_tests/media_device_open.c
> @@ -70,6 +70,7 @@ int main(int argc, char **argv)
>  	fd = open(media_device, O_RDWR);
>  	if (fd == -1) {
>  		printf("Media Device open errno %s\n", strerror(errno));
> +		close(fd);

Open failed so there is nothing to close.

>  		exit(-1);

When we exit() then all the resources are automatically reclaimed by the
operating system so we really don't worry about leaks at all in short
running programs.  It's different for an operating system or a web
server which is expected to have a long uptime.  But these programs are
going to run quickly and then exit so resource leaks are not an issue.

regards,
dan carpenter


