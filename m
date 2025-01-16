Return-Path: <linux-kselftest+bounces-24637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41EA1369B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62871680FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9661D7E4F;
	Thu, 16 Jan 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d2sSU/zx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314326AF6
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019792; cv=none; b=PGdp+cBA72uvxZY6di6yQ0wezW+J7zFJkci25XHrpn681jaCUqs3H+bHDmtyquZmtXMT8bb1k2Ia+JKFOeGHx5rGMJ34eenQXsAJEKAA0pJ2hM6bs2xaevzkAWuCU4+kRtziPHi3Jjv7Lkdm5Pgh8dkY7hd5vklVtC5k46Vg3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019792; c=relaxed/simple;
	bh=ndOQe7iYVdafaQgYnE+41A58i1xptE9OdOrBo0S9x6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLmCOSikPvYv6otm1KafwLYvuMx70XcyE2l3e93MG2AXA/PEXStatzBdirZigM7xO4NkSDANZjPlWlisTavJPcQPX9j3Ex9qIYEfVT4YKH9e5hV5TyA415JSkSosId/V3whjj14YxAhpow+UZeM8KSuCxiQ33q1By+OsufySt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d2sSU/zx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so384324f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737019788; x=1737624588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndOQe7iYVdafaQgYnE+41A58i1xptE9OdOrBo0S9x6g=;
        b=d2sSU/zxhFB2TfWL9bcoZSLRQEz/Aw0/6tN3R03Lawd03W93fgwNIRTuk9i9qF7knj
         hXUWoB2gfFsMPgaiHqXGy+EuLbEpRQJEeY/jg6GV+83zruJM4IrbPFudgS/A/BqmNmIn
         qmdYlOcY4QJpVXhcPmtcIKYTcVfPsMpX5ZqlYlMBl3NICi8lbM5JV1R3B3H1lKAYumvv
         DuTwY6tF+uoTb0qfTtIOpq/nj7GtsjZGXogL7mEM44+yTvCVZS+QzCe+GSCXfSb/U8HP
         I25lRwF50lxRrs9IJs5QH4Sx6/dIA8EEulNwPeqfeRawTycbRxQJU2/6hkm6/gtcll2N
         q+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019788; x=1737624588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndOQe7iYVdafaQgYnE+41A58i1xptE9OdOrBo0S9x6g=;
        b=XX2jHcyWBZTOB5sws9arXSxuSHdjy8wUEztF4/+aIqedLEXHmAeoKySaP43i3g6EtJ
         pFbEUjNwkHO/v5ECgl+tu999mAlOzZhzhZ9O8D0XzM746S7WTZ9L/vBE4DMH7DEGUPl7
         FTPMuXgEE98m+9W2hevFr42QhHycoQ/zohmlvywa7FJX4MlTpOJ3DjaWdffkigSXclzL
         WQDhmpDZd/H/KAtORL3KpnAuccYRmumIPrCqc35utetsvEJWMTSo/mYPj3V0M+DZID1V
         jByIRjfVlHhFlUmkxqoYEisntwNeS9DkdPf1a0RWE5eHkikC8G7mw5RGMPtslRX0QD5O
         rn8w==
X-Forwarded-Encrypted: i=1; AJvYcCXCI4EWC+OelosADD7ZWdmThUtxdRik/hLa10zo50FU7mZQ/yU7lMoSjtEsFPJtAFWy6qxf13IH/I5lDl0IdC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEizZZrqEBF6lE2yrXtSO+kXLwFwKumGVtKE24A4pfg9Elcje
	na1p6U7DKpNgyz3mOCwfySp/61CxOpIsmGbyLAdlQWEt7ZCFk2BRchPsHE4qLV4=
X-Gm-Gg: ASbGncvq60ATDpKqGfFLs8KbZfmw+AS4qj8sBOQT55IcT//1I8u+OTYbeBMDtr3VN7H
	kWH2RZ/+viGI9T42CtlMjbUZmi6sosaiNisBHsSCqQWfntve10ABIkfgPQSRaEaEYUs05MH2nZ2
	RsvJBMcvhpUS8NRmwwcEgjrJYrM3gskhaZJHplKt7LYysPn/tKmzch6kFX82sj+0VhPI/m7DVWC
	J9U8J+l6LMcQ/dLAyS0PiQq+s9lXtfOmfY0eWOAVz9GvI4vL626EiyZhA==
X-Google-Smtp-Source: AGHT+IH5nuIBbL7/hc99gmUbXnHjV1QmVgQbVuzI8DIlS9I/l5k+cT/NveGuMhqp+ADX/0RVXMkBfA==
X-Received: by 2002:a05:6000:4011:b0:385:f47b:1501 with SMTP id ffacd0b85a97d-38a87312d58mr26829937f8f.32.1737019788570;
        Thu, 16 Jan 2025 01:29:48 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c73e370fsm53343725e9.0.2025.01.16.01.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:29:48 -0800 (PST)
Date: Thu, 16 Jan 2025 10:29:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	shuah@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
Message-ID: <Z4jRisgTXOR5-gmv@pathway.suse.cz>
References: <20250114143144.164250-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114143144.164250-1-maddy@linux.ibm.com>

On Tue 2025-01-14 20:01:44, Madhavan Srinivasan wrote:
> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER, which
> adds the caller id as part of the dmesg. Due to this, even though
> the expected vs observed are same, end testcase results are failed.

CONFIG_PRINTK_CALLER is not the only culprit. We (SUSE) have it enabled
as well and the selftests pass without this patch.

The difference might be in dmesg. It shows the caller only when
the messages are read via the syslog syscall (-S) option. It should
not show the caller when the messages are read via /dev/kmsg
which should be the default.

I wonder if you define an alias to dmesg which adds the "-S" option
or if /dev/kmsg is not usable from some reason.

That said, I am fine with the patch. But I would like to better
understand and document why you need it. Also it would be nice
to update the filter format as suggested by Joe.

Best Regards,
Petr

