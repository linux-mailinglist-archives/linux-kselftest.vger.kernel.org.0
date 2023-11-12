Return-Path: <linux-kselftest+bounces-39-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C87E92D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 22:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440A4280AAC
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F521A58D;
	Sun, 12 Nov 2023 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIpAVrGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5431A287;
	Sun, 12 Nov 2023 21:11:10 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437F1BFB;
	Sun, 12 Nov 2023 13:11:09 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77a277eb084so258435985a.2;
        Sun, 12 Nov 2023 13:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699823468; x=1700428268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jD91m5sH04Im6nPSCMOzYWxSpBLesOJumIlAWBGHFmk=;
        b=gIpAVrGiTSxF8SiYXYELq0eH2L8WPT48bz0alvdg6S6PtjE9x3nCE5OLfaOLGIDZMx
         wgJPJ5n0pGUFzsVoLJwEnjsA5e+ZQaEBKDYVGyqLDpGXaHywXc83Zawwa/op7ReCdvip
         gZ0idY7Z6W/7uyTfut9src+tk7/XEVnMMQyz/RMbrqCvOS7KPIbkGgzNRSdWHftF1hxH
         XuB4f40ZH8112x3SqDol3Q7wMqofGx6s9F0Tud3wwkQRpNpIKmLeqO4aUoS/JnGgs6Xk
         lXPuvkZRVWCJTFV7QNapUzY2CaG/1FzF2u1e+az+kF8TN3gTWkqLW0rMa6tBwor+gO/7
         GaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699823468; x=1700428268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD91m5sH04Im6nPSCMOzYWxSpBLesOJumIlAWBGHFmk=;
        b=fxDvOX7hPsggF37uW8B13gJwbYb7hKd25hwIonpz0iwXR32ay1qp02nuNw1oAWIfeu
         o6bCj6MPvXtHmxsZSnccqO4KoVdGIB0qI8jlNiFKswh4NCZDZih6iMTKMuT0d8rWOLmy
         ZS4h7+Vd41HUNzVXO6U09WbHjddGH64csnL/+ogL5cGz8v/vBwrafXveQlDu8BGOZSS3
         cOqn56qqPWZtU+2lC1ieL4oaQkprPYMaNXrnVuwoKvNT3qr05VFi8crAiSpIGpkPB1BM
         mzvU6DguY4YMOh6ck15/DwWkwkfa4JDYCyYu9VyNadBiDd3v2dK6iFICwC4UcWUSCO6H
         LWWw==
X-Gm-Message-State: AOJu0YxaSoqqasxpDZ6NYK51gU7xC9uZZHfthBMZ7NqQMg+ttRwnKJA1
	bNFRZnzJGL50RvFm1r7Rrmg=
X-Google-Smtp-Source: AGHT+IHyDp+xYbcN+zjeD/gqHd99HWevyqCMUqBZTteDnxLZATKZX59Azkd7EOlvm/3V3TLxm/PuJA==
X-Received: by 2002:a05:620a:2801:b0:773:ea6e:e8a4 with SMTP id f1-20020a05620a280100b00773ea6ee8a4mr5627654qkp.44.1699823468434;
        Sun, 12 Nov 2023 13:11:08 -0800 (PST)
Received: from localhost ([164.86.0.75])
        by smtp.gmail.com with ESMTPSA id y6-20020a37e306000000b00770f3e5618esm1389386qki.101.2023.11.12.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 13:11:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Nov 2023 15:10:59 -0600
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 0/4] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Message-ID: <ZVE_YwujdpcFDbGy@mtj.duckdns.org>
References: <20231025182555.4155614-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025182555.4155614-1-longman@redhat.com>

On Wed, Oct 25, 2023 at 02:25:51PM -0400, Waiman Long wrote:
> v2:
>  - Add 2 read-only workqueue sysfs files to expose the user requested
>    cpumask as well as the isolated CPUs to be excluded from
>    wq_unbound_cpumask.
>  - Ensure that caller of the new workqueue_unbound_exclude_cpumask()
>    hold cpus_read_lock.
>  - Update the cpuset code to make sure the cpus_read_lock is held
>    whenever workqueue_unbound_exclude_cpumask() may be called.

Applied to cgroup/for-6.8 with patch description for the third patch updated
to reflect the dropping of __DEBUG__ prefix.

Thanks.

-- 
tejun

