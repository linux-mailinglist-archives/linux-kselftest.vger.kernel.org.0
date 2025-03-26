Return-Path: <linux-kselftest+bounces-29845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC432A726DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 00:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902B53B716D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0829253F00;
	Wed, 26 Mar 2025 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S+CytnhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72323FC4B
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030503; cv=none; b=rVO8UZAFiF+ah6/McQphw1tg420ib61AeoIvd6IZfkMigsqu+oGawIGolbqVmjJ7UVMJAGISOwW9YSpHEC4u0mjEr68oLItj7o19CEPr+92cXraCcwEqdNOsWLzXcKUz9qmHPSf0Fv5XoeEV9JgQVrIonlC1iw8p7Sw72uhKKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030503; c=relaxed/simple;
	bh=UIucPY8Hw6s1pIjj0T40L+yyxKLaVSlySiCPpLn2cd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZaxbWpH3cB1/KATEK+TP/O9bIcHmt2UJdX3GlSWDzF9VFHbHXorJ4oCSFy1hsonbPFCiu3xUZjLIXjqY8p6a0W9NiRW1PjfzZgjnd1XKM/NaV08TRjpUh/V+AQWpxZ/9r1AsjFoNip51s2KoB0YeOs3ldFDIC4t5/ziXPzfHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S+CytnhC; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-2c72cb91e9cso904336fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743030501; x=1743635301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rVT5gyP0OGTon/Wq3WnQYduId/TZ40NupCn3Es6UaA=;
        b=S+CytnhCujIqDOAGDu6jJWVwbefFUYR5QQE+QDd86pIuWCDioun9cgd9ZiHBxLEvmK
         9QG3drlbcLV6Ce94OMqta6qurINg8+hLrlu+E9+j9Kysi07LevrA3aUwVRPbL5jc8/Jp
         qPDoPa+bC9dwblkw/thRI11KCLH84Jvw7SdOrdvsRo88uD7w003kqNNHFvMEZoiDzImu
         YFD3LZJTrIDJcfBPq8sIFf9vAwRmSbDnzCcVNOVceBnNxny1JWpJZr1J2JaeNRjxw/3f
         jU7SH/Kd2nR8bbPSUwl0cuvZVjIQ8XyDosUPYl2/fDPOO4VOaJEondV5GCn/1ZS3zapb
         9Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743030501; x=1743635301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rVT5gyP0OGTon/Wq3WnQYduId/TZ40NupCn3Es6UaA=;
        b=o5EFyqFfzsMRQE+Rf3/GwHIMVmCIYz28EI8phUZ7mTiSLU3Unl19r6Vohsv1dD0IBN
         wuGg2qqM0jCriL19y65t7UKCRYlLFATKEahfQGogQbKIMXAm4r4HuTUMZl0xDyCAim2x
         9p3UvH9lvv7mYb7DITV4n3noUOPfD9eHCjzUN/d++wFh8f16Xa6uNjuSWM1RkaSOY1Cd
         8qEIouDnPQCoPgyKWySRm2KL0xOlVGYqy9/I7OOGmzTSK1Ae1XgaKKusG6tcOMiXPfWH
         6I86wV1lLAxZ6sC3arQc/mNepk0nOMO1D/SWrZ8j0YYzeLnhx9ai2YS4Qbgd/MzRlD+x
         irqw==
X-Forwarded-Encrypted: i=1; AJvYcCXMh95JXcPSC3LX+/rXE3xTLgy5AHHwC2Pvw4Vgau3SyjkOTo1uGHHSa6CyPG33dOVP8gqxw4wJ4uYLlZZk5H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHpvkoIJFx9npPbDLdQZDe2baTY1JFHlbS4bGQBMY9d9yEAI0
	U2RrL0nNwe6tCnxbzO/XMBs3dZFpbsG0pWGRTgI3RRhe+4RaGZnPJxU8c3xRii/1n3/WVNxlhTb
	Ma7XJNQmIWaE7JFVCJIQEhePAZNCeL9sd
X-Gm-Gg: ASbGncsLE0oqNgXHFfyyr2MN8NnwpY+ItgHiaQ6shTaaH3V+ErCD0W5xuZsJJ1V42OV
	GAQGNJUxDRi0OJSizFAPbL5Bysn8blHEj4bIimR/TmJG+WTHx9EuiwnNr3skv3A9WOcmAI7LpYo
	rn9sMlj4lee6BFeASU/q7PWBfAjj6lAKHCfeV/KF30IJrLBmyH/yYxBLV1UEJuwqU5jfASYZH3t
	bhK/IOE1/Z535KDxPBa8eyD32P+rifEoxqPPG07xFqYBUEx2Qa4JAaRKaIaJAGOMEZZAWKbsdqE
	ASdnfsiRczsaN1+j8xF550BEYWsqSgYwfwk8eAbGDYdaDfBy7Q==
X-Google-Smtp-Source: AGHT+IEPeX5QO7+np0lHt1JqQH6URXpDSCirYyHJkWTJBvVF0t+eQSx2Y6evgmmZSMAjZEj8DhgivwD6H6cm
X-Received: by 2002:a05:6870:2a45:b0:2c1:d516:66c1 with SMTP id 586e51a60fabf-2c826ccb975mr3678918fac.12.1743030500879;
        Wed, 26 Mar 2025 16:08:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c77f0ab523sm496151fac.37.2025.03.26.16.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 16:08:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 25C4C340199;
	Wed, 26 Mar 2025 17:08:19 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 153F7E40310; Wed, 26 Mar 2025 17:08:19 -0600 (MDT)
Date: Wed, 26 Mar 2025 17:08:19 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+SI4x+0J52rCJpN@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
 <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>

On Wed, Mar 26, 2025 at 12:56:56PM -0600, Uday Shankar wrote:
> On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > > ublk_abort_requests() should be called only in case of queue dying,
> > > since ublk server may open & close the char device multiple times.
> > 
> > Sure that is technically possible, however is any real ublk server doing
> > this? Seems like a strange thing to do, and seems reasonable for the
> > driver to transition the device to the nosrv state (dead or recovery,
> > depending on flags) when the char device is closed, since in this case,
> > no one can be handling I/O anymore.
> 
> I see ublksrv itself is doing this :(
> 
> /* Wait until ublk device is setup by udev */
> static void ublksrv_check_dev(const struct ublksrv_ctrl_dev_info *info)
> {
> 	unsigned int max_time = 1000000, wait = 0;
> 	char buf[64];
> 
> 	snprintf(buf, 64, "%s%d", "/dev/ublkc", info->dev_id);
> 
> 	while (wait < max_time) {
> 		int fd = open(buf, O_RDWR);
> 
> 		if (fd > 0) {
> 			close(fd);
> 			break;
> 		}
> 
> 		usleep(100000);
> 		wait += 100000;
> 	}
> }
> 
> This seems related to some failures in ublksrv tests

Actually this is the only issue I'm seeing - after patching this up in
ublksrv, make T=generic test appears to pass - I don't see any logs
indicating failures, and no kernel panics.

So the question is, does this patch break existing ublk servers? It does
break ublksrv as shown above, but I think one could argue that the above
code is just testing for file existence, and it's a bit weird to do that
by opening and closing the file (especially given that it's a device
special file). It can be patched to just use access or something
instead.


