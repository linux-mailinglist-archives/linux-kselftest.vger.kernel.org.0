Return-Path: <linux-kselftest+bounces-34292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F5ACD9EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFC3A3418
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88D283130;
	Wed,  4 Jun 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuieYP3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3E10E9
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026087; cv=none; b=as8n4LHPKhB12U98XkO5IsXQ0Jz3nQsZIqydl1uvmf7taVnGSXGSwpfAHASVIBDiUNaNxJmrzhBMDlL3PQOsWe7ilYSyBPTze01QYEErQWXcQSGakIAl/3beCfIRyH7jrFg3m11TXDtNWxG93q70qvgeXMFjlruB26uJ0uKj/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026087; c=relaxed/simple;
	bh=hl0Rj2J5xpZh/aqleJFyDy0PR8XchJEfQlex7JrV+zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTr/MUJUuqHmtIaA2/9eNUoZb5jZnzz37KOwt+Zu0+Z5r1l0rnfPf8trQiDC1pBdpOKMoWZjrd4H+gqst8/GmsHdFPSsXzMX4tumLHF2xd+3e/cHSkz7ZrXpZO8thaHa6227gM5tblWrwctomyLbRYlZgW7TWHaZnHGoIVR+zD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuieYP3w; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so11529951a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749026083; x=1749630883; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UJzQJwl5Tm0M4b8GyIlYsK0ZwVeNhT+vH32OOjQmMg=;
        b=TuieYP3w4/PUfTx1ZU9AICUNrTduXdVUxZj+ibjRON7ZStN9ZUOYHZah5tWTlCooqS
         E6e88Cs6RNacKSE3zLpYvMvSLn1pM6sjTHjPT4blxFqfzH8ZMiyZ8b+PYrrrWN33ficg
         uoYhQmiMM2nOZcTqVYhaGLmoCWrkgPxM2GfgLRZNM47lSWjQbr5gd7MOr4k13HhtE7UH
         664y8Pebej34xqO3PZI8WKNBGB8iMy1Ia4Lsh49XgmGrzTOdeqVqoow1EqI9eJAcjVmM
         4LcR2wMSS7QJ5j2VdNF0/XsgonmqhXF8wFT+yDZbTB9MxyTO7BrPbuzFhB086ncYeA6z
         XUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749026083; x=1749630883;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UJzQJwl5Tm0M4b8GyIlYsK0ZwVeNhT+vH32OOjQmMg=;
        b=E4+Rw7hJpfm6dkAKnUmGpwrK6BECUPBaR05r3m36QlyRPjWyDC42HVGixuQHoc3JGv
         8CfozigGXTtT+8aHbSGdB513pEyBlRwqboHMGzIpt7NO8dCNQlqFq/wWP+vrY9rzBTGX
         Aw7++XSAvUmfyeQdpLZZdq+iJScM98CEFl71tAuMb/Rw6fEEPGw/DUppuYW8NJXxKazz
         Y+MwkyOgH6kdDy8th9VDJzlR5KYfxFqN1svprQG3U8XyBsn4kyc0L0FoH6ZqRwr0BMKt
         lQwOhIsiwnDCFcJntrinLGryQ30h4cjH7hnpM20gLWFVr4BwBlvWd3wsO2XW0dpe++ra
         MH/A==
X-Forwarded-Encrypted: i=1; AJvYcCUd9oro+Hqwf1+dZlpZEUSGGkMps6Y52y9gm9UcCTbh9Zu/IZFuO5aFj2bT3QJzAIoxVpVpey7lx3ZtdKcC1vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/1sMS1KgxSqfEY94wFxuc4JFvSe3punBarwL8aQlG3u7g8Pn
	+T6dh9cYUNKnUBNUcdMDQAOQWqlZQKEDGNev68YbRsCgxPu+T14KF6vB
X-Gm-Gg: ASbGncvp2P10Noa5myhhRVScU7xrhuWt89EW4XFVAPPa9Cgd4DBkIzZQCJGNdDDC3zd
	3azMgAhfZ0wqUAYym3Z4IjXAkIWee6L+ytazF/luLpSl5g0khJwVitiAOPV/rVaW2KOUEtTL0ds
	ptjbQG+zoEqMQdb6Wj3V0WLiE7QiQhWn8nTXEIfC1+rX/1XqQHu6ERrhw2vF7C6qaZipCPRVGZW
	uz+eOY44fDlq+fZayBSFjwjjBIQtpJC532297t5TlBIMZ5I+yTkpsPH0pwt36dyX4/x/jovqVFB
	lwWQqThcmuE+sC9BLG4Hu/LVA9WTF4bls5SxVXwFYVg9fizWiqQ=
X-Google-Smtp-Source: AGHT+IGQ5UdycEpF+BdSPhmaNM4DOHTAApPQYDGm004dpodmLMWAnRwP8Qti5QOJPEZfnYzBh7qgHA==
X-Received: by 2002:a17:907:9494:b0:ad8:8d89:bbfe with SMTP id a640c23a62f3a-addf8fd9862mr160386166b.60.1749026082466;
        Wed, 04 Jun 2025 01:34:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-addfae39c05sm47569066b.156.2025.06.04.01.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jun 2025 01:34:42 -0700 (PDT)
Date: Wed, 4 Jun 2025 08:34:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	harry.yoo@oracle.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC Patch 2/2] selftests/mm: assert rmap behave as expected
Message-ID: <20250604083441.hilkdzlxmxygivvt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
 <20250604082145.13800-3-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604082145.13800-3-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 04, 2025 at 08:21:45AM +0000, Wei Yang wrote:
[...]
>+int try_to_move_page(char *region)
>+{
>+	int ret;
>+	int node;
>+	int status = 0;
>+
>+	ksft_print_msg("worker %d move_pages of content: %.15s\n", getpid(), region);

One thing confused me here.

If I don't access region here, the following move_pages() would report
-ENOENT occationally. The reason is do_pages_stat_array() ->
folio_walk_start() returns NULL.

Not sure which part I missed.

>+
>+	ret = move_pages(0, 1, (void **)&region, NULL, &status, MPOL_MF_MOVE_ALL);
>+	if (ret != 0)
>+		return FAIL_ON_WORK;
>+
>+	/* Pick up a different target node */
>+	for (node = 0; node <= numa_max_node(); node++) {
>+		if (numa_bitmask_isbitset(numa_all_nodes_ptr, node) && node != status)
>+			break;
>+	}
>+
>+	if (node > numa_max_node()) {
>+		ksft_print_msg("Couldn't find available numa node for testing\n");
>+		return FAIL_ON_WORK;
>+	}
>+
>+	ret = move_pages(0, 1, (void **)&region, &node, &status, MPOL_MF_MOVE_ALL);
>+	if (ret != 0)
>+		return FAIL_ON_WORK;
>+
>+	return 0;
>+}
>+

-- 
Wei Yang
Help you, Help me

