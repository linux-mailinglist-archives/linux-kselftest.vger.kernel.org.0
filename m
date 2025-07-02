Return-Path: <linux-kselftest+bounces-36343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94CAF5D69
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949683AC649
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DE267B01;
	Wed,  2 Jul 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfcI01hy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEC247DEA;
	Wed,  2 Jul 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470645; cv=none; b=LdnegEsNdgYdT6/5Z9m17g8y7o9ZmAKjrXiyXqEQOjba62V1+Xl2nqVauce3iv+nNuZvys3UujBN6mZxRm/06l3Ag2WPGQAvyYUsh67Re2pc2zkFLlDELE/Lhb4yG9Rfxbi5LlWJ+stxepwa9Q2pOBOoFbXiwi+HrIjCchnuerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470645; c=relaxed/simple;
	bh=KqBbYF70pADCZTcZ9n7TYX38VHU8oPpGL3jXh3Bfv10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+bzjDZI1QuLlgWc45/1FZ5a/+Y8yUcGsK0l5kAU1JGh6vQyiP24dMYo9SaA6BLZUC128SVLmnSYXEq7f5rCBTTHp/8NcMWqIb6dtaKLsGdXJclFbaXOhLuIIJ44T3TRopkZp6Cy/2tNwjxEnJc6lFweF1u0xoWVJ99qXaUxFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfcI01hy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4352926b3a.0;
        Wed, 02 Jul 2025 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751470643; x=1752075443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq+72EChW4TGsnXMZtcbgAkpZEN2d4v3ljqTh4TkPYA=;
        b=QfcI01hyBYlcXeAtwcqw1OTFWcfte5Lc0EpEnLCo6bkmWo7ZWjUAedNprIog6/DFaF
         BM9ezXO+DOjudIADrgV6aulKgoZ+g80m7c/hgYSR+uxz/M/BKEP7AOUFYZhR+MfR37Sj
         xPcQBwHEi15M6IzpLJOmAwIPkH69iT1QFcQs/ySJSV7IfhyTYtg4JuZjdhCZ78GBBeIh
         YPZ7V2FuaSP+jkXG/VHli6SRvwZAO7cwknrs5B0hB4bvQYXOYt85Pj45Bq6KkV1luIQV
         rQJkhPm6wNoqrvFgufZM41X/BoY8h/qeMp+LxRh+rF0VwLDD7Hd1N7/J01fPQv/QspKY
         XEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470643; x=1752075443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq+72EChW4TGsnXMZtcbgAkpZEN2d4v3ljqTh4TkPYA=;
        b=BwZ5bKU/gbNYVWOaXuYrEvl+TgJrLNSkVfMoAb9V15GLq+pDlt7lDd4lFfstwFYHwE
         voxA14+xOX6aXKpoVZoQ49THjE68sVAfVeAxElmrSRRxbgEPiGZ7An/qDbgII9SYy89M
         J+ZcQUA23Lm0aJkvHms8oB4XzST4Cr/QvsMl4k04NJken+vKjoFzLZ+JmTph4yugbyMU
         XtClJnB1FUGaca+bRC66xgi6IeQZhqaFSZlk+n0LtzYD/ZkDZYVJYcIoFT5FyO70My6p
         FmO6cTlvim9N+GITG+AiISco5oonVrZTUKyQtotT462WE7lLLBl62Rla+5f/s7+1e1SF
         n69w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8EOv2RZ4RQHkis6H4OXKE9lmC3/CJFRU8QQIh7hRpBnRmsYNz+GtOv2PS66aCD7rsKxjYKGO@vger.kernel.org, AJvYcCVFWVBRLsB0mZJrh8uYLFWDumOEkp4v9G9F3AsVl/7Bd645G77KZPkXuWnkOJZMIS0yKyJBb0VKqTiZANgex+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaF5RIpIXoxk6gk5CwtUF4XT1ssbAhbaLkSithE2Toy9JGItQr
	LfQ0vdunXUbdfdl5XsFXSoWyeX8yQNWmYOVO2HW/fkj3GUAhl4UBRew=
X-Gm-Gg: ASbGncudMWdFbGAyYo6urtGLy0civi9qMwk82GITMRfdIME0Ovb0sbmi+aTP7Nvt/UF
	2b7qCT4nQWJI19JTwndqVNBsI6Hy5lRxBQehcY3aCzbZVXp+Aw3OuF0iPULQ+964QcB/s5QUHVD
	8LvcSwJlARTlEjMhfdOe6sQcnwrWfQYjmQX0GYJNAQK8SOSIB97hHXfEVitY165FjtG35AI7qlR
	zmBHmR/LK4P429PEAFTiUNToxBPwNt6btsfLUvLTW+18MFqlpaMVgMyhTVH+ZnU3xkvVr6OsE5U
	6SxOuyBFRiaTB1Wph0lHXboOUUbWExtS7VILiQhhJVHWnO7EJV+6GQoH9T9Ci9UtEpqvjO8ErHV
	rJ5KtbEZnsslbgcAjUVIAfNs=
X-Google-Smtp-Source: AGHT+IHHV80yXsD4jvrFAc3o+b9jkfGIDEIL/egK/G7tj43ZY01HcCiZBk2tZtaK82tHKRUTsoGFvw==
X-Received: by 2002:a05:6a21:6009:b0:21f:54f0:3b84 with SMTP id adf61e73a8af0-222d7f1d4c7mr6552855637.35.1751470642888;
        Wed, 02 Jul 2025 08:37:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af56e8b00sm14769309b3a.143.2025.07.02.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:37:22 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:37:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, jdamato@fastly.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
Message-ID: <aGVSMYsoMvlBPtC4@mini-arch>
References: <20250702104249.1665034-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702104249.1665034-1-ap420073@gmail.com>

On 07/02, Taehee Yoo wrote:
> The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> change it automatically.
> Therefore, make configure_headersplit() sets hds-thresh value to 0.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>  - Do not implement configure_hds_thresh().
>  - Make configure_headersplit() sets hds-thresh to 0.
> 
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index cc9b40d9c5d5..52b72de11e3b 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -331,6 +331,12 @@ static int configure_headersplit(bool on)
>  	ret = ethtool_rings_set(ys, req);
>  	if (ret < 0)
>  		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> +	if (on) {
> +		ethtool_rings_set_req_set_hds_thresh(req, 0);
> +		ret = ethtool_rings_set(ys, req);

Why call ethtool_rings_set again here? Can we move ethtool_rings_set_req_set_hds_thresh
to be after ethtool_rings_set_req_set_tcp_data_split ?

