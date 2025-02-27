Return-Path: <linux-kselftest+bounces-27733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EECA47A0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 11:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8682A16E5C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2C229B32;
	Thu, 27 Feb 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4dfJJcW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50106228CBA
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651689; cv=none; b=b1RlnJjw6SYv9+zvxbHOMiXlAvbiGbdxHXYcJFBltmSdLMqji26cvRZC+I1OvHZrdYsKS7sIVpDhzUZV/z29AAC9RuUzhNPwuycqfyMRak2tWQK0dQBU5KgVsXDXk0U1CGXitsJ2OeQn50GctYRqfJXBXvxpPt4Mp8A7wyP0j8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651689; c=relaxed/simple;
	bh=o1BZNEVFS1dVMoSsBkXWjgk8R2fxCteTGGv8kH5FZRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWnD0LTwhLRIvJwrXBWlrk8cDqibccGR1YFsYvE7T/l0eDAqfmXZ7cIwGCXy6xZPjs+XguwAw0mvP0bgIRPM+3UFLpz1+OnBsqAwUuMyyffqyt28fKx0zjwhoI4Qo/TiWojA/wOyjYeVr6K59uAXO92uDeXgQKc4IihiMN4XtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4dfJJcW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srf0UyBfsQhgWVg+kEEi5uq5c/Ijj0vigRW8E83X9mw=;
	b=H4dfJJcWWmIoWBgli8/lWuj9C5nJU0TTiwzz8hMCF8CgUOIjz7+kyWyp8XRaw0ZG0Ip18b
	nxHIYZrHpoA8VghnhNV103n9KhiCcBgBXPuhLPwV1ygmHNDSQfCfYgMvRT2NcC6GwDxkdK
	DHMdDdAkBM3s3ZvXJC0UTKiemLLM7m4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-oAWz9fx8MG-YImvEctf6gA-1; Thu, 27 Feb 2025 05:21:24 -0500
X-MC-Unique: oAWz9fx8MG-YImvEctf6gA-1
X-Mimecast-MFC-AGG-ID: oAWz9fx8MG-YImvEctf6gA_1740651684
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394040fea1so4000885e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 02:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651683; x=1741256483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srf0UyBfsQhgWVg+kEEi5uq5c/Ijj0vigRW8E83X9mw=;
        b=reXQ9nIc0Y+0yBKq+TJvM46fHArbI2c2qEhb3xS6vytaqidQoHXkNBLKNsdvuoKZiF
         XdnCgia1ZyNfUgkRSU5Qyf75Wk8SpEEmtly+d9dBkzuefgWSxuWRNmy8qkXLxP2sNe/C
         VmYJjZg6IIcTfJTS3kjgJAc4awXM1uNAuUKep23AkErj3iR7WfLLa9DJqHg/8nr8Gie+
         LQMYSuhdjavcDZVzqHv90K/NnBiL6QsjxiA3nmSttZvLRzQFJqvtqVfZEnwq+deQsp0V
         Xjc4sixr8kBEPDFmCNqC7yCA2cnqQhoHrF+qPVIE7IUeC4YGWGgfdk3XlFFoA70gSxlh
         4brw==
X-Forwarded-Encrypted: i=1; AJvYcCWx7DeRhsX01RgfX3wH9ljsdP+zhZormmAA0Bswujcx5ibVBNAZnzfOqNqhzyiQrLrNG+MJaiIcr5B8UQITHmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcNXvwi2/OwAjOeY/2898oMWdp2qQ4T8Vxg2mhDpgkDM5cTL+
	imWz2I3BGJZSGwGxSrbjZh0VOYRRxdULniH/6DiOeJCIinQVk5VQ5ACS0hHxW4ksKA3ZpCQdLUn
	qmVpT51mtY1dcRHu//1kf6uT7o7Mt+RZ0YIpf5RvSK3vb0J0yD12WhnhqHTLAo5zSVA==
X-Gm-Gg: ASbGncuuZIl5Xlvbz9EirPudCJMlL7sTEeQTEkx4Um4JCdJZPDzdclnQaNLsmkFVn7c
	QQnIOD3kh+/PjzYCtJrUAAEBGM/8d9RHjNwioHgim+5aPVrgf9jNa2dDnKg5U/4PnZhwPWqPm3K
	wqiEXyyRhUZ/Wt2XpwkRZL/kTIr+xgYl1zBzFpSxHu3sBrVlrDg7Aw+jiXZ4ZkvhpEUu39ADSeH
	A4xLIZ1pwoXSMlHBQ4lw+yar6YUFR0no4mpGAE46OzezT+ip+LaBERgSyQf39Y9s+wbfNy6tYLF
	7z5UMr6rQ6Ds6MUmlf8tfwJ0Dikb6oJ7LqwGS/TVc+HcIA==
X-Received: by 2002:a05:600c:1e12:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43b04dc34d4mr22315365e9.13.1740651683690;
        Thu, 27 Feb 2025 02:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZWDrKeECYxNJn95VcTyTz8lUpAL/ZnP6A7sgL8cGevFRSHtccOSsEA7TN+V3kF26FxGrMmg==
X-Received: by 2002:a05:600c:1e12:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43b04dc34d4mr22315175e9.13.1740651683369;
        Thu, 27 Feb 2025 02:21:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73704228sm17949285e9.15.2025.02.27.02.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:21:22 -0800 (PST)
Message-ID: <f58b63fc-43aa-47ff-8ee4-4f515f7d7a7c@redhat.com>
Date: Thu, 27 Feb 2025 11:21:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/8] selftest: net: add proc_net_pktgen
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-9-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-9-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> +TEST_F(proc_net_pktgen, dev_cmd_min_pkt_size) {
> +	ssize_t len;
> +
> +	// with trailing '\0'

... same here. Much more occurrences below.

/P


