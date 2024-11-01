Return-Path: <linux-kselftest+bounces-21326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F139B9A76
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526F41C21AA7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A31E47BC;
	Fri,  1 Nov 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5b0sI9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE51E32BD;
	Fri,  1 Nov 2024 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497895; cv=none; b=glPOmRfnaTgTiOmJtxUgcR8FTfsETgm7vwj2nE7nbAnHaaEDN1QvL5KNM1P4MAeCCfwcCnz/EGZ2bX9YsIb7CUj0lKJDwPI8Rl9LQfr1FxYk/du6dkG6OMSF3cCL5bVWU+ORg60aVxYDXruCE1yofQ3Cvzf/aVp4evGYMQc1vvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497895; c=relaxed/simple;
	bh=2MYIZiXSfLL6vxUEZZdUkiQvueBlK/GaJ4xtn7dtCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyPdDwPg/dytExmB+nB9S3pToRmT/bPgYm+HFSJVeFXikPZs/xImbttYWpYf2Ql54IvK9sLo9gM0DbnSyoIrE64T70JIUlekvDV5aYxtpOLbQ+kxoT3uubAr7QnYgdBxPerprikQWIXPa26n30NfmXFPuGOyqSvOL0ZIjifkaiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5b0sI9f; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c767a9c50so24713515ad.1;
        Fri, 01 Nov 2024 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730497894; x=1731102694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqOSQvizINBYla+O3k1bEzctQxHc9qL4AnI65iFZnfY=;
        b=Q5b0sI9fo1HyOnccZwhMOUVghOY0ocmQNOBQr5beAxpA2JQhGLGmjp6WCXosPNsdwp
         dVrKADxSs2gKE1AS7A2EC+M/gw+piuIgZzXchDX705tJEZrGU1RyutyNLNcWyHz8p7sN
         R0Wie1xyiZxY/Wq5TOPbzDpuXOUDvjFb1sjAz8mT7RHVo4bt6P/oJLNf03rSY/dAjNz2
         DRn5lE0PjX5tdsPQTaa8GeqirVtsfj8lKaCCXMVdIB/g+3Qg3EBHk3kOP2aeUvoxnH7j
         FVNSyKcmhSW8VsH1O4UkY95ZXV13i7VMh0yQ4CzYmtNfPXxvREQ00ftmXZ3fRObPkqWI
         cCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497894; x=1731102694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqOSQvizINBYla+O3k1bEzctQxHc9qL4AnI65iFZnfY=;
        b=iyk+ZwYSqbOG7ep8dCj6SHS0Z2cKL8khNpHjpbWiMmWUZgYieDLjz2n0pfQXEy57uh
         zchYLwnhyqKLxF7xr4EKiJxY0LkGunGIpa6td15yVcKuGmwH8J6eh8B6uS9Adjihn/a7
         dNjgIaQqH3rj51HbSC/a37BdPMY9DR5qirkshzQRc5R1HTqVNKORTapEKNfMi+zQliAe
         JpATLAFWx4krKwUj6500nsN1owwvP1jQn9SoyEYrC5ek6K9BGQ+kbE8R1X262jfYE5uz
         vNjqf3h7SX9dsUSTuImrL6bYVCfHzVxdJG9sN1XleuhgriMz3ZiyQMVdf3CCsUBVcoIt
         TEfg==
X-Forwarded-Encrypted: i=1; AJvYcCWtLPqSbo3ACFe7Sidc4DVOhI9Ubu/5+caPLHd4dci6B21Y+YBQqWAFXRD+d4H1k5mIcSbGt5BAFPeZjDyvLTc6@vger.kernel.org, AJvYcCXshLHEscTZO43OLtKJgH3CWkoWsjWr0SWu0yxNtKbcEyJRqojuTU0ZTJYKjAle1W24N1NO4ZUoBjgRFH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZ1AFAgIDoLCVSbGUFbB+CIhZgfuYhww9nxhBCLd+KdGf1kHE
	Oltp3SdUVOSAVyL+5KDhapy4j+xxhx8JRoEKpw5nIggVmo7yPSrE
X-Google-Smtp-Source: AGHT+IELqqb+P4HgQGBysM8Mc88nov1zQGX/2aqpM0HFXz0rK167Reeprdax+9M/6TVaKHOE+Y5WEQ==
X-Received: by 2002:a17:902:d486:b0:20c:5d05:69b4 with SMTP id d9443c01a7336-2111af5a0a6mr65686245ad.26.1730497893646;
        Fri, 01 Nov 2024 14:51:33 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:be2e:c8e6:bba5:abcd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d9750sm25415905ad.280.2024.11.01.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:51:33 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:51:32 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/tc-testing: add tests for
 qdisc_tree_reduce_backlog
Message-ID: <ZyVNZFnZO79iQlSr@pop-os.localdomain>
References: <20241101143148.1218890-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101143148.1218890-1-pctammela@mojatatu.com>

On Fri, Nov 01, 2024 at 11:31:48AM -0300, Pedro Tammela wrote:
> Add 3 tests to check for the expected behaviour of
> qdisc_tree_reduce_backlog in special scenarios.
> 
> - The first test checks if the qdisc class is notified of deletion for
> major handle 'ffff:'.
> - The second test checks the same as the first test but with 'ffff:' as the root
> qdisc.
> - The third test checks if everything works if ingress is active.
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Cong Wang <cong.wang@bytedance.com>

Thanks for more tests!

