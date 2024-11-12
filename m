Return-Path: <linux-kselftest+bounces-21852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECB9C57B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBABB256A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAA2141D9;
	Tue, 12 Nov 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5j1qAz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CF207A14;
	Tue, 12 Nov 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409827; cv=none; b=juTZCaWQKmQIqmbvSN9KiwZiFqNrQKLwEhBP273RhbRZr/dzzq2q5rMta1JQZ9gYXWteyE3m9LsjaOU2T+shMcfDt7byEKAYkH/c5mApl4DeEP9qwQawYWOSDTpk55sp4exQ68dFIFvadfL5r5PvuGLH+yX6JKF0P4FFVQov4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409827; c=relaxed/simple;
	bh=o8LZzyAO/xN+J7whax3nwX9FC+5PPxdMxkeJ5j8tX94=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tXRdooX25gOMhdLrmwudQoA7iZfG9x+wH43G+L7x0cuNhfoiy/3sHGqIQ1+zHo43kKxs1aZJDovQ3Qzb5ufyQv7ZKF7bq6fdYuYECk9GEDF7oRwaF7WqTb4ji0eMdd2TMzlwFY0NCbm3UnL/vgXP2WPMbKi/F6r1var9umCpwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5j1qAz8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso47979885e9.0;
        Tue, 12 Nov 2024 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409825; x=1732014625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12Wq6vbO+PmZNrMZHIYjaXdLl5X7Jrekdu8wXlL99nM=;
        b=J5j1qAz8dWsHagHbtRezLxOE8QJI5IO1F6onqTg3tcOs9WaVNLrBWl/W+SYGnTEbPc
         xBstKpbG/OL3DxnGAGCbGWZatHOdHvRWH6OMFB+JCwGM4ES/be7esHBH9zYfRqtHbcoN
         O0/6ZcNslZ/78UW+/80510SCvR86QzdOfUJGTB5saIq4cuGqR2YKRKmCUdxHSUKOmDIX
         vKUY2D7MuYQrUNvPchaWmPnFbFAtoDtZG1GnbosSbUTT0x65jt6rjG9l/it0tD2/TUyZ
         wFgQ9nfooVVNB9NJXyG0JWze4Ic/hLhvu7NSZiRj6WeeR81fIVAUqlFe5fZO2V8/qAae
         OnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409825; x=1732014625;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12Wq6vbO+PmZNrMZHIYjaXdLl5X7Jrekdu8wXlL99nM=;
        b=PuYwcwm8YVfnOn5jRZYLDM4Ot/Y6q8+CrJHB9302DdoTF16R7fqRwhXU5k1tpCqTsx
         KD86ZHdQAtanxGcauyhQXbGvbMQtrdI/7JgyYjpXhyB8mMJeunc5r/hES9j9yosOYnVo
         ElBvhDGLCyeat6bKN+0Dpd9ES9ydALxVndjAukhUhT0NbaBJbfWzIpWnrKdlhXwhkuMr
         DU7LCerJq3aCHB1ZAGgwEKJXqlzj8LR17QJnyE+Iq9SL4aVFigfcJ8/Ukf+ONYTGctZy
         CLNZSVhkVsDU4xhaKtru+uaTVa4CR4d6rfjJtXf2Q7+PHIXUhQmuIjj+QTDoXUqew7cw
         NihA==
X-Forwarded-Encrypted: i=1; AJvYcCX6eOLcI0TpIufl7KA07k8T3MJqZszEmrSpWQb+s1fiOoDmw61K2GDxunANeR1SCKgCphouGZIflk53hwivCPnt@vger.kernel.org, AJvYcCXPqHCZBh1paTah2kp3LaTjMgwKlqErzRcnDng1DG2YokaMDt7LtN/7H6LXBwtRSl+yg/sx2JytkUTeUUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3eq0RFjLn+xj2Si1Ummpo0S6emXQMaAkEovX1Nfs3cQqOPxw
	cEXHniHW+dXT7mtMkPptdo3GWdlaXmup6QnYioLx0mm4cTtGsuTA
X-Google-Smtp-Source: AGHT+IHRIaT0FZC5Pj0wqmsuEq+/h6AALz3VNQ6OSJ6NTKX+W8stMuUJKvex0YIQKbXLuCAFtUHcow==
X-Received: by 2002:a05:600c:46c5:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-432b7519776mr135380495e9.29.1731409824467;
        Tue, 12 Nov 2024 03:10:24 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b35c0sm249228225e9.16.2024.11.12.03.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:10:24 -0800 (PST)
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for
 ntuple rule
To: Daniel Xu <dxu@dxuuu.xyz>, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, shuah@kernel.org, andrew+netdev@lunn.ch,
 kuba@kernel.org, michael.chan@broadcom.com, martin.lau@linux.dev,
 pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <cover.1731377399.git.dxu@dxuuu.xyz>
 <dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <93831343-03c3-d540-369d-fe82eb480c58@gmail.com>
Date: Tue, 12 Nov 2024 11:10:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/11/2024 02:23, Daniel Xu wrote:
> Extend the rss_ctx test suite to test that an ntuple action that
> redirects to an RSS context contains that information in `ethtool -n`.
> Otherwise the output from ethtool is highly deceiving. This test helps
> ensure drivers are compliant with the API.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
...
> +def _ntuple_rule_check(cfg, rule_id, ctx_id):
> +    """Check that ntuple rule references RSS context ID"""
> +    text = ethtool(f"-n {cfg.ifname} rule {rule_id}").stdout
> +    pattern = f"RSS Context ID: {ctx_id}"
> +    ksft_true(re.search(pattern, text, re.IGNORECASE),

This won't match the output from your ethtool patch, because that
 removes the colon.  Probably want to wait until the patch is
 finalised and then write a regex that matches both versions.

